/**
 * Test ConversationMemory with actual messages table
 */

const ConversationMemory = require('./services/core/ConversationMemory');

(async () => {
    console.log('🧪 Testing ConversationMemory with messages table...\n');
    
    const tenantId = '41c8c2802c8accc7199747a0953c7075';
    const phoneNumber = '96567709452'; // Bot's own number for testing
    
    try {
        console.log('1️⃣ Fetching conversation memory...');
        const memory = await ConversationMemory.getMemory(tenantId, phoneNumber);
        
        console.log('✅ Memory retrieved successfully!');
        console.log('\n📋 Memory Contents:');
        console.log('   - Recent Messages:', memory.recentMessages?.length || 0);
        console.log('   - Last Intent:', memory.lastIntent || 'none');
        console.log('   - Products:', memory.products?.length || 0);
        console.log('   - Cart Active:', memory.cartActive || false);
        
        if (memory.recentMessages && memory.recentMessages.length > 0) {
            console.log('\n💬 Recent Messages:');
            memory.recentMessages.slice(0, 3).forEach((msg, idx) => {
                const icon = msg.sender === 'user' ? '👤' : '🤖';
                console.log(`   ${icon} ${msg.sender}: ${msg.content.substring(0, 60)}...`);
            });
        }
        
        console.log('\n✅ ConversationMemory is working correctly with messages table!');
        
    } catch (error) {
        console.error('❌ Test failed:', error.message);
        console.error(error.stack);
    }
})();
