const Database = require('better-sqlite3');
const fs = require('fs');
const path = require('path');

const db = new Database(path.join(__dirname, '../local-database.db'));

console.log('[MIGRATION] Creating AI cache tables...');

const sql = fs.readFileSync(path.join(__dirname, 'create_ai_cache_tables.sql'), 'utf8');
db.exec(sql);

console.log('✅ AI cache tables created successfully');

// Verify tables
const tables = db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'ai_%'").all();
console.log('✅ Created tables:', tables.map(t => t.name).join(', '));

db.close();
