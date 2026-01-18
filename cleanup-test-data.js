const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('🧹 CLEANING TEST DATA FROM DATABASE...\n');

// Disable foreign keys temporarily for cleanup
db.exec('PRAGMA foreign_keys = OFF');

// Start transaction for safety
db.exec('BEGIN TRANSACTION');

try {
  // 1. DELETE TEST USERS
  console.log('📋 Step 1: Identifying test users...');
  
  const testUsers = db.prepare(`
    SELECT id, name, phone FROM users 
    WHERE 
      name LIKE '%Demo%' 
      OR name LIKE '%Test%' 
      OR name LIKE '%Alok%'
      OR phone LIKE '%12345%'
      OR phone LIKE '%67890%'
      OR (phone LIKE '%8484830022%' AND name LIKE '%Demo%')
  `).all();
  
  console.log(`   Found ${testUsers.length} test users:`);
  testUsers.forEach(u => console.log(`   - ${u.name} (${u.phone})`));
  
  if (testUsers.length > 0) {
    const userIds = testUsers.map(u => u.id);
    const placeholders = userIds.map(() => '?').join(',');
    
    // Delete related data first (check if tables exist)
    try {
      const deleteRelated = db.prepare(`DELETE FROM visits WHERE salesman_id IN (${placeholders})`);
      const visitCount = deleteRelated.run(...userIds).changes;
      console.log(`   ✅ Deleted ${visitCount} visits by test users`);
    } catch (e) {
      console.log(`   ⚠️  Skipped visits (table may not exist)`);
    }
    
    try {
      const deleteUserRoles = db.prepare(`DELETE FROM user_roles WHERE user_id IN (${placeholders})`);
      const roleCount = deleteUserRoles.run(...userIds).changes;
      console.log(`   ✅ Deleted ${roleCount} user role assignments`);
    } catch (e) {
      console.log(`   ⚠️  Skipped user_roles (table may not exist)`);
    }
    
    try {
      const deleteSessions = db.prepare(`DELETE FROM user_sessions WHERE user_id IN (${placeholders})`);
      const sessionCount = deleteSessions.run(...userIds).changes;
      console.log(`   ✅ Deleted ${sessionCount} user sessions`);
    } catch (e) {
      console.log(`   ⚠️  Skipped user_sessions (table may not exist)`);
    }
    
    // Now delete the users
    const deleteUsers = db.prepare(`DELETE FROM users WHERE id IN (${placeholders})`);
    const userCount = deleteUsers.run(...userIds).changes;
    console.log(`   ✅ Deleted ${userCount} test users\n`);
  }
  
  // 2. DELETE TEST VISITS
  console.log('📋 Step 2: Identifying test visits...');
  
  const testVisits = db.prepare(`
    SELECT id, customer_name FROM visits 
    WHERE 
      customer_name LIKE '%Test%' 
      OR customer_name LIKE '%Demo%'
      OR customer_name LIKE '%After All Fix%'
  `).all();
  
  console.log(`   Found ${testVisits.length} test visits:`);
  testVisits.forEach(v => console.log(`   - ${v.customer_name}`));
  
  if (testVisits.length > 0) {
    const visitIds = testVisits.map(v => v.id);
    const placeholders = visitIds.map(() => '?').join(',');
    
    try {
      const deletePhotos = db.prepare(`DELETE FROM visit_photos WHERE visit_id IN (${placeholders})`);
      const photoCount = deletePhotos.run(...visitIds).changes;
      console.log(`   ✅ Deleted ${photoCount} visit photos`);
    } catch (e) {
      console.log(`   ⚠️  Skipped visit_photos (table may not exist)`);
    }
    
    const deleteTestVisits = db.prepare(`DELETE FROM visits WHERE id IN (${placeholders})`);
    const testVisitCount = deleteTestVisits.run(...visitIds).changes;
    console.log(`   ✅ Deleted ${testVisitCount} test visits\n`);
  }
  
  // 3. DELETE TEST CACHE ENTRIES
  console.log('📋 Step 3: Cleaning test cache entries...');
  
  const deleteTestCache = db.prepare(`DELETE FROM cache_entries WHERE cache_key LIKE 'test:%'`);
  const cacheCount = deleteTestCache.run().changes;
  console.log(`   ✅ Deleted ${cacheCount} test cache entries\n`);
  
  // 4. DELETE TEST AI SESSIONS
  console.log('📋 Step 4: Cleaning test AI conversation sessions...');
  
  const deleteTestAI = db.prepare(`
    DELETE FROM ai_conversation_sessions 
    WHERE phone_number LIKE '%99999%' OR phone_number LIKE '%12345%'
  `);
  const aiCount = deleteTestAI.run().changes;
  console.log(`   ✅ Deleted ${aiCount} test AI sessions\n`);
  
  // 5. DELETE TEST CUSTOMERS (if any)
  console.log('📋 Step 5: Cleaning test customers...');
  
  try {
    const deleteTestCustomers = db.prepare(`
      DELETE FROM customer_profiles 
      WHERE name LIKE '%Test%' OR name LIKE '%Demo%' OR phone LIKE '%99999%'
    `);
    const customerCount = deleteTestCustomers.run().changes;
    console.log(`   ✅ Deleted ${customerCount} test customers\n`);
  } catch (e) {
    console.log(`   ⚠️  Skipped customer_profiles (table may not exist)\n`);
  }
  
  // Commit the transaction
  db.exec('COMMIT');
  
  // Re-enable foreign keys
  db.exec('PRAGMA foreign_keys = ON');
  
  console.log('✅ CLEANUP COMPLETE!\n');
  
  // Show summary of real data
  console.log('📊 REMAINING DATA SUMMARY:\n');
  
  const userStats = db.prepare('SELECT COUNT(*) as count FROM users').get();
  console.log(`   Users: ${userStats.count}`);
  
  const visitStats = db.prepare('SELECT COUNT(*) as count FROM visits').get();
  console.log(`   Visits: ${visitStats.count}`);
  
  const messageStats = db.prepare('SELECT COUNT(*) as count FROM messages').get();
  console.log(`   Messages: ${messageStats.count}`);
  
  const dealStats = db.prepare('SELECT COUNT(*) as count FROM deals').get();
  console.log(`   Deals: ${dealStats.count}`);
  
  console.log('\n📋 RECENT REAL USERS (Top 10):\n');
  const realUsers = db.prepare(`
    SELECT name, phone, role, created_at 
    FROM users 
    ORDER BY created_at DESC 
    LIMIT 10
  `).all();
  
  realUsers.forEach(u => {
    console.log(`   ${u.name.padEnd(25)} | ${u.phone.padEnd(12)} | ${u.role.padEnd(12)} | ${u.created_at.substring(0, 10)}`);
  });
  
  console.log('\n📋 RECENT REAL VISITS (Top 10):\n');
  const realVisits = db.prepare(`
    SELECT customer_name, visit_type, created_at 
    FROM visits 
    ORDER BY created_at DESC 
    LIMIT 10
  `).all();
  
  realVisits.forEach(v => {
    console.log(`   ${v.customer_name.padEnd(30)} | ${v.visit_type.padEnd(15)} | ${v.created_at.substring(0, 10)}`);
  });
  
  console.log('\n✅ Database is now clean with only real FSM data!');
  
} catch (error) {
  console.error('❌ ERROR during cleanup:', error.message);
  db.exec('ROLLBACK');
  console.log('⚠️  Changes rolled back - database unchanged');
  process.exit(1);
}

db.close();
