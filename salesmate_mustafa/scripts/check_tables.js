const Database = require('better-sqlite3');
const db = new Database('local-database.db');

console.log('=== TABLE LIST ===');
const tables = db.prepare(`SELECT name FROM sqlite_master WHERE type='table' ORDER BY name`).all();
tables.forEach(t => console.log(t.name));

console.log('\n=== MESSAGES TABLE ===');
try {
    const msgCols = db.prepare('PRAGMA table_info(messages)').all();
    console.log(msgCols.map(c => c.name).join(', '));
} catch(e) {
    console.log('Table does not exist');
}

console.log('\n=== BROADCASTS TABLE ===');
try {
    const bcCols = db.prepare('PRAGMA table_info(broadcasts)').all();
    console.log(bcCols.map(c => c.name).join(', '));
} catch(e) {
    console.log('Table does not exist');
}

console.log('\n=== CAMPAIGNS TABLE ===');
try {
    const campCols = db.prepare('PRAGMA table_info(campaigns)').all();
    console.log(campCols.map(c => c.name).join(', '));
} catch(e) {
    console.log('Table does not exist');
}

db.close();
