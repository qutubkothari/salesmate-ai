const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[CHECKING FOLLOW-UP TABLES]');
const tables = db.prepare(`SELECT name FROM sqlite_master WHERE type='table' AND (name LIKE '%follow%' OR name LIKE '%schedule%') ORDER BY name`).all();
console.log('Tables found:', JSON.stringify(tables, null, 2));
db.close();
