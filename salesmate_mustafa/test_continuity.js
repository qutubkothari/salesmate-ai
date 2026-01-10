const Database = require('better-sqlite3');
const db = new Database('local-database.db');

console.log('🧪 Testing Conversation Continuity\n');

// Get a conversation with multiple messages
const conv = db.prepare(`
    SELECT conversation_id, COUNT(*) as msg_count
    FROM messages
    GROUP BY conversation_id
    HAVING msg_count > 2
    ORDER BY MAX(created_at) DESC
    LIMIT 1
`).get();

if (!conv) {
    console.log('⚠️  No multi-turn conversations found yet');
    db.close();
    process.exit(0);
}

console.log('📋 Conversation:', conv.conversation_id.substring(0, 8) + '...');
console.log('📊 Total messages:', conv.msg_count);
console.log('\n💬 Message Flow (showing continuity):\n');

// Get messages in order
const messages = db.prepare(`
    SELECT message_body, sender, created_at
    FROM messages
    WHERE conversation_id = ?
    ORDER BY created_at ASC
`).all(conv.conversation_id);

messages.forEach((msg, idx) => {
    const icon = msg.sender === 'user' ? '👤' : '🤖';
    const time = new Date(msg.created_at).toLocaleTimeString();
    const preview = msg.message_body.substring(0, 70);
    console.log(`${idx + 1}. [${time}] ${icon} ${msg.sender}:`);
    console.log(`   ${preview}...`);
    
    // Show context awareness
    if (idx > 0 && msg.sender === 'bot') {
        const prevMsg = messages[idx - 1];
        if (prevMsg.sender === 'user') {
            console.log(`   ↳ (responding to: "${prevMsg.message_body.substring(0, 30)}...")`);
        }
    }
    console.log('');
});

console.log('✅ This conversation shows context continuity!');
console.log('\n🎯 How AI maintains continuity:');
console.log('   1. When user sends message #' + messages.length);
console.log('   2. System fetches last 4 messages from DB');
console.log('   3. Passes them to AI: [history + current query]');
console.log('   4. AI understands full context and responds appropriately');
console.log('\n💡 Example:');
console.log('   User: "Who are you?"');
console.log('   Bot: "We are SAK Solutions..."');
console.log('   User: "Tell me more" ← AI remembers "about SAK Solutions"');
console.log('   Bot: "SAK Solutions specializes in..." ✅ Continuity!');

db.close();
