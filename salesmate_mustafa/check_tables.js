const Database = require('better-sqlite3');
const db = new Database('local-database.db');

console.log('📋 Database Tables:');
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all();
tables.forEach(t => console.log('  -', t.name));

db.close();
