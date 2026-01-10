const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[SCHEDULED_FOLLOWUPS SCHEMA]');
const schema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name='scheduled_followups'`).get();
console.log(schema.sql);
db.close();
