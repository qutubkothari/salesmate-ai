const path = require('path');
const Database = require('better-sqlite3');

const dbPath = path.join(__dirname, '..', 'local-database.db');
const db = new Database(dbPath);

const result = db.prepare('UPDATE tenants SET password = ? WHERE phone_number = ?')
    .run('515253', '918484862949');

console.log('Password updated. Rows changed:', result.changes);

const tenant = db.prepare('SELECT phone_number, business_name, password FROM tenants WHERE phone_number = ?')
    .get('918484862949');

console.log('Tenant:', tenant);
