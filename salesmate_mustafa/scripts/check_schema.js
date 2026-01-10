const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[ORDERS TABLE SCHEMA]');
const schema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name='orders'`).get();
console.log(schema.sql);

console.log('\n[CUSTOMER_PROFILES TABLE SCHEMA]');
const cpSchema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name='customer_profiles'`).get();
console.log(cpSchema.sql);

db.close();
