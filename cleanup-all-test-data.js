const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('🧹 CLEANING ALL TEST COMPANY DATA...\n');

// Disable foreign keys
db.exec('PRAGMA foreign_keys = OFF');
db.exec('BEGIN TRANSACTION');

try {
  // Test company names to remove
  const testCompanies = [
    'ABC Industries',
    'XYZ Trading', 
    'Global Traders',
    'Test Customer',
    'Demo Company',
    'Sample Corp',
    'Example Inc'
  ];
  
  console.log('📋 Searching for test companies in all tables...\n');
  
  // 1. Clean visits table
  console.log('1️⃣ Cleaning visits table...');
  const visitPattern = testCompanies.map(c => `customer_name LIKE '%${c}%'`).join(' OR ');
  const visits = db.prepare(`SELECT id, customer_name FROM visits WHERE ${visitPattern}`).all();
  
  console.log(`   Found ${visits.length} test visits`);
  visits.forEach(v => console.log(`   - ${v.customer_name}`));
  
  if (visits.length > 0) {
    const visitIds = visits.map(v => v.id);
    const placeholders = visitIds.map(() => '?').join(',');
    
    // Delete visit photos first
    try {
      const photoCount = db.prepare(`DELETE FROM visit_photos WHERE visit_id IN (${placeholders})`).run(...visitIds).changes;
      console.log(`   ✅ Deleted ${photoCount} visit photos`);
    } catch (e) {
      console.log(`   ⚠️  No visit_photos to delete`);
    }
    
    // Delete visit images
    try {
      const imageCount = db.prepare(`DELETE FROM visit_images WHERE visit_id IN (${placeholders})`).run(...visitIds).changes;
      console.log(`   ✅ Deleted ${imageCount} visit images`);
    } catch (e) {
      console.log(`   ⚠️  No visit_images to delete`);
    }
    
    // Delete visits
    const visitCount = db.prepare(`DELETE FROM visits WHERE ${visitPattern}`).run().changes;
    console.log(`   ✅ Deleted ${visitCount} test visits\n`);
  } else {
    console.log(`   ✅ No test visits found\n`);
  }
  
  // 2. Clean customers/leads tables
  console.log('2️⃣ Cleaning customer/lead tables...');
  
  const customerTables = ['customers_engaged_new', 'customer_profiles_new', 'crm_leads'];
  let totalCustomers = 0;
  
  customerTables.forEach(table => {
    try {
      const checkTable = db.prepare(`SELECT name FROM sqlite_master WHERE type='table' AND name=?`).get(table);
      if (checkTable) {
        const pattern = testCompanies.map(c => `name LIKE '%${c}%'`).join(' OR ');
        const count = db.prepare(`DELETE FROM ${table} WHERE ${pattern}`).run().changes;
        if (count > 0) {
          console.log(`   ✅ Deleted ${count} from ${table}`);
          totalCustomers += count;
        }
      }
    } catch (e) {
      // Table doesn't exist or no name column
    }
  });
  
  if (totalCustomers === 0) {
    console.log(`   ✅ No test customers found\n`);
  } else {
    console.log(`   ✅ Total customers cleaned: ${totalCustomers}\n`);
  }
  
  // 3. Clean orders
  console.log('3️⃣ Cleaning orders...');
  try {
    const orderPattern = testCompanies.map(c => `customer_name LIKE '%${c}%'`).join(' OR ');
    const orderCount = db.prepare(`DELETE FROM orders WHERE ${orderPattern}`).run().changes;
    console.log(`   ✅ Deleted ${orderCount} test orders\n`);
  } catch (e) {
    console.log(`   ⚠️  No orders table or no matches\n`);
  }
  
  // 4. Clean deals
  console.log('4️⃣ Cleaning deals...');
  try {
    const dealPattern = testCompanies.map(c => `title LIKE '%${c}%' OR customer_name LIKE '%${c}%'`).join(' OR ');
    
    // Get deal IDs first
    const deals = db.prepare(`SELECT id FROM deals WHERE ${dealPattern}`).all();
    
    if (deals.length > 0) {
      const dealIds = deals.map(d => d.id);
      const placeholders = dealIds.map(() => '?').join(',');
      
      // Delete related records
      try {
        db.prepare(`DELETE FROM deal_products WHERE deal_id IN (${placeholders})`).run(...dealIds);
        db.prepare(`DELETE FROM deal_activities WHERE deal_id IN (${placeholders})`).run(...dealIds);
        db.prepare(`DELETE FROM deal_notes WHERE deal_id IN (${placeholders})`).run(...dealIds);
        db.prepare(`DELETE FROM deal_stage_history WHERE deal_id IN (${placeholders})`).run(...dealIds);
      } catch (e) {
        // Tables might not exist
      }
      
      const dealCount = db.prepare(`DELETE FROM deals WHERE ${dealPattern}`).run().changes;
      console.log(`   ✅ Deleted ${dealCount} test deals\n`);
    } else {
      console.log(`   ✅ No test deals found\n`);
    }
  } catch (e) {
    console.log(`   ⚠️  No deals table or no matches\n`);
  }
  
  // 5. Clean messages
  console.log('5️⃣ Cleaning WhatsApp messages...');
  try {
    const messagePattern = testCompanies.map(c => `customer_name LIKE '%${c}%'`).join(' OR ');
    const msgCount = db.prepare(`DELETE FROM messages WHERE ${messagePattern}`).run().changes;
    console.log(`   ✅ Deleted ${msgCount} test messages\n`);
  } catch (e) {
    console.log(`   ⚠️  No messages to clean\n`);
  }
  
  // 6. Clean AI sessions
  console.log('6️⃣ Cleaning AI conversation sessions...');
  try {
    // Clean sessions with test phone numbers
    const aiCount = db.prepare(`
      DELETE FROM ai_conversation_sessions 
      WHERE phone_number LIKE '%99999%' 
         OR phone_number LIKE '%12345%'
         OR phone_number LIKE '%00000%'
    `).run().changes;
    console.log(`   ✅ Deleted ${aiCount} test AI sessions\n`);
  } catch (e) {
    console.log(`   ⚠️  No AI sessions to clean\n`);
  }
  
  // 7. Also check for test user "Alok"
  console.log('7️⃣ Checking for recreated test users...');
  const testUsers = db.prepare(`
    SELECT id, name, phone FROM users 
    WHERE name LIKE '%Test%' 
       OR name LIKE '%Demo%'
       OR name LIKE '%Sample%'
       OR (name = 'Alok' AND phone LIKE '%12345%')
       OR (name = 'Alok' AND phone LIKE '%8600259300%')
  `).all();
  
  if (testUsers.length > 0) {
    console.log(`   Found ${testUsers.length} test users:`);
    testUsers.forEach(u => console.log(`   - ${u.name} (${u.phone})`));
    
    const userIds = testUsers.map(u => u.id);
    const placeholders = userIds.map(() => '?').join(',');
    
    // Delete user-related data
    try {
      db.prepare(`DELETE FROM visits WHERE salesman_id IN (${placeholders})`).run(...userIds);
      db.prepare(`DELETE FROM user_roles WHERE user_id IN (${placeholders})`).run(...userIds);
      db.prepare(`DELETE FROM user_sessions WHERE user_id IN (${placeholders})`).run(...userIds);
    } catch (e) {
      // Tables might not exist
    }
    
    const userCount = db.prepare(`DELETE FROM users WHERE id IN (${placeholders})`).run(...userIds).changes;
    console.log(`   ✅ Deleted ${userCount} test users\n`);
  } else {
    console.log(`   ✅ No test users found\n`);
  }
  
  // Commit
  db.exec('COMMIT');
  db.exec('PRAGMA foreign_keys = ON');
  
  console.log('✅ CLEANUP COMPLETE!\n');
  
  // Show summary
  console.log('📊 REMAINING DATA SUMMARY:\n');
  
  const stats = {
    users: db.prepare('SELECT COUNT(*) as count FROM users').get().count,
    visits: db.prepare('SELECT COUNT(*) as count FROM visits').get().count,
    messages: db.prepare('SELECT COUNT(*) as count FROM messages').get().count,
  };
  
  console.log(`   Users: ${stats.users}`);
  console.log(`   Visits: ${stats.visits}`);
  console.log(`   Messages: ${stats.messages}`);
  
  console.log('\n📋 RECENT REAL VISITS (Sample):\n');
  const recentVisits = db.prepare(`
    SELECT customer_name, visit_type, created_at 
    FROM visits 
    ORDER BY created_at DESC 
    LIMIT 10
  `).all();
  
  recentVisits.forEach(v => {
    const date = v.created_at.substring(0, 10);
    console.log(`   ${v.customer_name.padEnd(30)} | ${v.visit_type.padEnd(15)} | ${date}`);
  });
  
  console.log('\n✅ Database cleaned - only real FSM data remains!');
  
} catch (error) {
  console.error('❌ ERROR:', error.message);
  db.exec('ROLLBACK');
  db.exec('PRAGMA foreign_keys = ON');
  process.exit(1);
}

db.close();
