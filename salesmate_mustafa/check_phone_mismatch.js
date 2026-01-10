const db = require('better-sqlite3')('./local-database.db', {readonly: true});

const conv = db.prepare(`
    SELECT phone_number, end_user_phone, tenant_id, id 
    FROM conversations 
    WHERE phone_number LIKE '%971507055253%' 
    LIMIT 1
`).get();

console.log('📞 Conversation phone fields:');
console.log('  phone_number:', conv.phone_number);
console.log('  end_user_phone:', conv.end_user_phone);
console.log('  tenant_id:', conv.tenant_id);
console.log('  id:', conv.id);

// Test what ConversationMemory.getMemory() is looking for
const phoneUtils = require('./utils/phoneUtils');
const whatsappFormatted = phoneUtils.toWhatsAppFormat('971507055253');
console.log('\n🔄 toWhatsAppFormat result:', whatsappFormatted);

// Check if end_user_phone matches
const matchesEndUser = conv.end_user_phone === whatsappFormatted;
const matchesPhoneNumber = conv.phone_number === whatsappFormatted;

console.log('\n✅ Matches:');
console.log('  end_user_phone matches?', matchesEndUser);
console.log('  phone_number matches?', matchesPhoneNumber);

// Check messages for this conversation
const msgCount = db.prepare('SELECT COUNT(*) as count FROM messages WHERE conversation_id = ?')
    .get(conv.id);
console.log('\n📊 Messages in this conversation:', msgCount.count);

db.close();
