const Database = require('better-sqlite3');
const db = new Database('local-database.db');

console.log('📋 Messages table structure:');
const columns = db.prepare('PRAGMA table_info(messages)').all();
columns.forEach(col => {
    console.log(`  - ${col.name}: ${col.type}${col.notnull ? ' NOT NULL' : ''}`);
});

console.log('\n📝 Sample messages:');
const samples = db.prepare('SELECT * FROM messages ORDER BY created_at DESC LIMIT 3').all();
samples.forEach((msg, idx) => {
    console.log(`\n  Message ${idx + 1}:`);
    Object.entries(msg).forEach(([key, value]) => {
        if (value && key !== 'id') {
            const display = typeof value === 'string' && value.length > 50 
                ? value.substring(0, 50) + '...' 
                : value;
            console.log(`    ${key}: ${display}`);
        }
    });
});

db.close();
