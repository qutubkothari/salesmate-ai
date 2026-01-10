const path = require('path');
const Database = require('better-sqlite3');

const dbPath = path.join(__dirname, '..', 'local-database.db');
const db = new Database(dbPath);

// First, check all tenants to see what phone numbers exist
const allTenants = db.prepare('SELECT phone_number, business_name, password FROM tenants').all();

console.log('All tenants in database:');
console.log(allTenants);

// Try updating with the phone number
const result = db.prepare('UPDATE tenants SET password = ? WHERE phone_number = ?')
    .run('515253', '918484862949');

console.log('\nPassword update attempt 1 (918484862949). Rows changed:', result.changes);

// Try with @c.us suffix
const result2 = db.prepare('UPDATE tenants SET password = ? WHERE phone_number = ?')
    .run('515253', '918484862949@c.us');

console.log('Password update attempt 2 (918484862949@c.us). Rows changed:', result2.changes);

// Check final state
const tenant = db.prepare('SELECT phone_number, business_name, password FROM tenants WHERE phone_number LIKE ?')
    .get('%918484862949%');

console.log('\nFinal tenant state:', tenant);
