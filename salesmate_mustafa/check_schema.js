const db = require('better-sqlite3')('./local-database.db', {readonly: true});

console.log('📋 Messages table schema:');
const schema = db.prepare('PRAGMA table_info(messages)').all();
schema.forEach(col => console.log(`  - ${col.name} (${col.type})`));

console.log('\n📋 Conversations table schema:');
const convSchema = db.prepare('PRAGMA table_info(conversations)').all();
convSchema.forEach(col => console.log(`  - ${col.name} (${col.type})`));

console.log('\n📊 Message count by conversation:');
const counts = db.prepare(`
    SELECT c.id, c.phone_number, COUNT(m.id) as msg_count, MAX(m.created_at) as latest
    FROM conversations c
    LEFT JOIN messages m ON m.conversation_id = c.id
    GROUP BY c.id
    ORDER BY latest DESC
    LIMIT 10
`).all();

counts.forEach(row => {
    console.log(`  ${row.phone_number}: ${row.msg_count} messages (last: ${row.latest || 'none'})`);
});

db.close();
