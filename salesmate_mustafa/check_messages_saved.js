const Database = require('better-sqlite3');
const db = new Database('./local-database.db', { readonly: true });

const phone = '971507055253';

console.log('🔍 Checking messages for phone:', phone);

// Check messages table
const messages = db.prepare(`
    SELECT COUNT(*) as total 
    FROM messages 
    WHERE phone_number LIKE ?
`).get(`%${phone}%`);

console.log('📊 Messages saved:', messages.total);

// Check recent messages
const recentMessages = db.prepare(`
    SELECT message_body, sender, created_at 
    FROM messages 
    WHERE phone_number LIKE ?
    ORDER BY created_at DESC 
    LIMIT 10
`).all(`%${phone}%`);

console.log('\n📝 Recent messages:');
recentMessages.forEach((msg, i) => {
    console.log(`${i+1}. [${msg.sender}] ${msg.message_body.substring(0, 50)}...`);
});

// Check conversations table
const conversations = db.prepare(`
    SELECT id, state, metadata, last_message_at 
    FROM conversations 
    WHERE phone_number LIKE ?
`).all(`%${phone}%`);

console.log('\n💬 Conversations:', conversations.length);
conversations.forEach(conv => {
    console.log('  ID:', conv.id);
    console.log('  State:', conv.state);
    console.log('  Last message:', conv.last_message_at);
});

db.close();
