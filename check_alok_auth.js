const Database = require('better-sqlite3');
const bcrypt = require('bcryptjs');

const db = new Database('local-database.db');

const phone = '8600259300';
const password = '8600259300';
const tenantId = '112f12b8-55e9-4de8-9fda-d58e37c75796';

console.log('\n=== Checking Alok Authentication ===\n');

// Check user record
const user = db.prepare(`
  SELECT id, tenant_id, phone, role, is_active, password_hash
  FROM users 
  WHERE phone = ? AND tenant_id = ?
`).get(phone, tenantId);

if (!user) {
  console.log('❌ User not found with phone:', phone);
  
  // Try to find similar phones
  const similar = db.prepare(`
    SELECT phone, role, tenant_id FROM users 
    WHERE phone LIKE ?
  `).all(`%${phone.slice(-5)}%`);
  
  console.log('\nSimilar phone numbers found:', similar);
  process.exit(1);
}

console.log('✅ User found:');
console.log('  ID:', user.id);
console.log('  Phone:', user.phone);
console.log('  Role:', user.role);
console.log('  Active:', user.is_active);
console.log('  Has password_hash:', user.password_hash ? 'Yes' : 'No');
console.log('  Password hash length:', user.password_hash?.length || 0);

// Check password
if (user.password_hash) {
  const match = bcrypt.compareSync(password, user.password_hash);
  console.log('  Password match:', match ? '✅ YES' : '❌ NO');
  
  if (!match) {
    // Try testing with the hash directly
    console.log('\n  Testing if hash is bcrypt format...');
    console.log('  Hash starts with $2:', user.password_hash.startsWith('$2'));
    
    // Test common passwords
    const testPasswords = ['8600259300', '515253', 'Sales@1234', 'password'];
    console.log('\n  Testing common passwords:');
    for (const pwd of testPasswords) {
      const testMatch = bcrypt.compareSync(pwd, user.password_hash);
      if (testMatch) {
        console.log(`  ✅ MATCH FOUND: "${pwd}"`);
      }
    }
  }
} else {
  console.log('  ⚠️ No password hash set!');
}

// Check salesman record
const salesman = db.prepare(`
  SELECT id, user_id, name, phone, email, is_active
  FROM salesmen
  WHERE user_id = ? AND tenant_id = ?
`).get(user.id, tenantId);

console.log('\n✅ Salesman record:');
if (salesman) {
  console.log('  ID:', salesman.id);
  console.log('  Name:', salesman.name);
  console.log('  Phone:', salesman.phone);
  console.log('  Active:', salesman.is_active);
} else {
  console.log('  ❌ No salesman record found for this user!');
}

console.log('\n');
db.close();
