const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[BROADCAST TABLES]');
const tables = db.prepare(`SELECT name FROM sqlite_master WHERE type='table' AND name LIKE '%broadcast%' ORDER BY name`).all();
console.log('Tables:', tables.map(t => t.name).join(', '));

for (const table of tables) {
    console.log(`\n[${table.name.toUpperCase()} SCHEMA]`);
    const schema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name=?`).get(table.name);
    console.log(schema.sql);
}

db.close();
