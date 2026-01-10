const Database = require('better-sqlite3');
const db = new Database('local-database.db');

console.log('📋 Conversations table structure:');
const columns = db.prepare('PRAGMA table_info(conversations)').all();
columns.forEach(col => {
    console.log(`  - ${col.name}: ${col.type}`);
});

console.log('\n📝 Sample conversation:');
const sample = db.prepare('SELECT * FROM conversations LIMIT 1').get();
if (sample) {
    Object.entries(sample).forEach(([key, value]) => {
        if (value) {
            const display = typeof value === 'string' && value.length > 50 
                ? value.substring(0, 50) + '...' 
                : value;
            console.log(`  ${key}: ${display}`);
        }
    });
}

db.close();
