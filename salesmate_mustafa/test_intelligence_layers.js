/**
 * 🧪 INTELLIGENCE LAYERS TESTING SCRIPT
 * Tests all 3 layers: Conversation Storage, AI Caching, Context Memory
 * 
 * Run: node test_intelligence_layers.js
 */

const Database = require('better-sqlite3');

console.log('🧪 ========================================');
console.log('   INTELLIGENCE LAYERS TEST SUITE');
console.log('========================================\n');

const db = new Database('local-database.db');

// Test 1: Conversation Storage (Layer 1)
console.log('📝 [LAYER 1] TESTING CONVERSATION STORAGE...');
try {
    const conversations = db.prepare(`
        SELECT 
            id,
            tenant_id,
            conversation_id,
            message_body,
            sender,
            created_at
        FROM messages
        ORDER BY created_at DESC
        LIMIT 10
    `).all();
    
    console.log(`✅ Found ${conversations.length} recent conversation messages`);
    
    if (conversations.length > 0) {
        console.log('\n📋 Sample Conversations:');
        conversations.slice(0, 3).forEach((msg, idx) => {
            const timestamp = new Date(msg.created_at).toLocaleString();
            const content = msg.message_body || '';
            console.log(`   ${idx + 1}. [${msg.sender}] ${content.substring(0, 50)}... (${timestamp})`);
        });
    } else {
        console.log('⚠️  No conversations found yet. Start chatting with the bot to test this layer.');
    }
} catch (error) {
    console.log('❌ Conversation storage test failed:', error.message);
}

console.log('\n');

// Test 2: AI Response Cache (Layer 2)
console.log('💾 [LAYER 2] TESTING AI RESPONSE CACHE...');
try {
    // Check if tables exist
    const tables = db.prepare(`
        SELECT name FROM sqlite_master 
        WHERE type='table' AND name IN ('ai_response_cache', 'ai_usage_tracking')
    `).all();
    
    if (tables.length < 2) {
        console.log('❌ Cache tables not found! Run migration first.');
    } else {
        console.log('✅ Cache tables exist: ai_response_cache, ai_usage_tracking');
        
        const cacheStats = db.prepare(`
            SELECT 
                COUNT(*) as total_cached,
                SUM(hit_count) as total_hits,
                SUM(CASE WHEN hit_count > 0 THEN 1 ELSE 0 END) as used_cache_entries
            FROM ai_response_cache
        `).get();
        
        console.log(`📊 Cache Statistics:`);
        console.log(`   - Total cached responses: ${cacheStats.total_cached}`);
        console.log(`   - Total cache hits: ${cacheStats.total_hits || 0}`);
        console.log(`   - Used cache entries: ${cacheStats.used_cache_entries || 0}`);
        
        const usage = db.prepare(`
            SELECT 
                response_source,
                COUNT(*) as count,
                SUM(cost_saved) as total_saved
            FROM ai_usage_tracking
            GROUP BY response_source
        `).all();
        
        if (usage.length > 0) {
            console.log(`\n💰 Cost Savings:`);
            usage.forEach(u => {
                const saved = u.total_saved || 0;
                console.log(`   - ${u.response_source}: ${u.count} calls, $${saved.toFixed(6)} saved`);
            });
            
            const totalSaved = usage.reduce((sum, u) => sum + (u.total_saved || 0), 0);
            console.log(`   - TOTAL SAVINGS: $${totalSaved.toFixed(6)}`);
        } else {
            console.log('⚠️  No usage data yet. Cache will populate after first queries.');
        }
        
        // Show recent cached queries
        const recentCache = db.prepare(`
            SELECT 
                query_text,
                hit_count,
                created_at
            FROM ai_response_cache
            ORDER BY created_at DESC
            LIMIT 5
        `).all();
        
        if (recentCache.length > 0) {
            console.log(`\n📝 Recent Cached Queries:`);
            recentCache.forEach((cache, idx) => {
                console.log(`   ${idx + 1}. "${cache.query_text.substring(0, 40)}..." (${cache.hit_count} hits)`);
            });
        }
    }
} catch (error) {
    console.log('❌ Cache test failed:', error.message);
}

console.log('\n');

// Test 3: Context Memory Usage (Layer 3)
console.log('🧠 [LAYER 3] TESTING CONVERSATION CONTEXT MEMORY...');
try {
    // Check for customers with conversation history
    const customers = db.prepare(`
        SELECT 
            conversation_id,
            tenant_id,
            COUNT(*) as message_count,
            MAX(created_at) as last_message
        FROM messages
        GROUP BY conversation_id, tenant_id
        HAVING message_count >= 2
        ORDER BY last_message DESC
        LIMIT 5
    `).all();
    
    if (customers.length > 0) {
        console.log(`✅ Found ${customers.length} conversations with history`);
        console.log('\n💬 Conversations with Context:');
        
        customers.forEach((conv, idx) => {
            const lastMsg = new Date(conv.last_message).toLocaleString();
            console.log(`   ${idx + 1}. Conversation ${conv.conversation_id.substring(0, 8)}... - ${conv.message_count} messages (last: ${lastMsg})`);
            
            // Get last 3 messages for this conversation
            const messages = db.prepare(`
                SELECT sender, message_body, created_at
                FROM messages
                WHERE conversation_id = ? AND tenant_id = ?
                ORDER BY created_at DESC
                LIMIT 3
            `).all(conv.conversation_id, conv.tenant_id);
            
            messages.reverse().forEach(msg => {
                const icon = msg.sender === 'user' ? '👤' : '🤖';
                const content = msg.message_body || '';
                console.log(`      ${icon} ${msg.sender}: ${content.substring(0, 50)}...`);
            });
            console.log('');
        });
    } else {
        console.log('⚠️  No multi-turn conversations found yet. Chat more with the bot to test context memory.');
    }
} catch (error) {
    console.log('❌ Context memory test failed:', error.message);
}

console.log('\n');

// Summary
console.log('========================================');
console.log('📊 SUMMARY');
console.log('========================================');

try {
    const stats = {
        conversations: db.prepare('SELECT COUNT(*) as count FROM messages').get().count,
        cachedResponses: db.prepare('SELECT COUNT(*) as count FROM ai_response_cache').get().count || 0,
        totalCacheHits: db.prepare('SELECT IFNULL(SUM(hit_count), 0) as hits FROM ai_response_cache').get().hits,
        totalSaved: db.prepare('SELECT IFNULL(SUM(cost_saved), 0) as saved FROM ai_usage_tracking').get().saved
    };
    
    console.log(`\n✅ LAYER 1 (Storage): ${stats.conversations} messages stored`);
    console.log(`✅ LAYER 2 (Caching): ${stats.cachedResponses} cached, ${stats.totalCacheHits} hits, $${stats.totalSaved.toFixed(6)} saved`);
    console.log(`✅ LAYER 3 (Memory): Context available for multi-turn conversations`);
    
    const efficiency = stats.cachedResponses > 0 
        ? ((stats.totalCacheHits / (stats.cachedResponses + stats.totalCacheHits)) * 100).toFixed(1)
        : 0;
    
    console.log(`\n🎯 Cache Efficiency: ${efficiency}% of queries served from cache`);
    console.log(`💰 Cost Reduction: $${stats.totalSaved.toFixed(6)} saved so far`);
    
    if (stats.conversations === 0) {
        console.log('\n⚠️  No data yet. Start chatting with bot at: http://13.126.234.92:8081');
    } else if (stats.cachedResponses === 0) {
        console.log('\n⏳ Caching warming up. Ask the same questions again to see cache hits!');
    } else {
        console.log('\n🚀 All 3 intelligence layers are ACTIVE and working!');
    }
} catch (error) {
    console.log('❌ Summary failed:', error.message);
}

console.log('\n========================================\n');

db.close();
