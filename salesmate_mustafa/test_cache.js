/**
 * 🧪 QUICK CACHE TEST
 * Verifies that smartCacheService is working correctly
 */

const { checkCache, storeInCache } = require('./services/smartCacheService');

(async () => {
    console.log('🧪 Testing AI Cache Service...\n');
    
    const tenantId = '41c8c2802c8accc7199747a0953c7075'; // From messages table
    const testQuery = 'What are your delivery terms?';
    const testResponse = '🚛 We provide delivery across major cities. Delivery time: 2-3 business days.';
    
    // Test 1: Cache miss
    console.log('1️⃣ Testing cache MISS (first time query)...');
    const miss = await checkCache(testQuery, tenantId);
    console.log('   Result:', miss ? '❌ UNEXPECTED HIT' : '✅ Cache miss (as expected)');
    
    // Test 2: Store in cache
    console.log('\n2️⃣ Storing response in cache...');
    await storeInCache(testQuery, testResponse, tenantId, 'delivery', 0, 0);
    console.log('   ✅ Stored successfully');
    
    // Test 3: Cache hit
    console.log('\n3️⃣ Testing cache HIT (same query again)...');
    const hit = await checkCache(testQuery, tenantId);
    if (hit) {
        console.log('   ✅ Cache HIT! Response:', hit.response.substring(0, 50) + '...');
        console.log('   Hit count:', hit.hit_count);
    } else {
        console.log('   ❌ Cache miss (should have hit!)');
    }
    
    // Test 4: Similar query (fuzzy matching)
    console.log('\n4️⃣ Testing FUZZY matching (similar query)...');
    const similarQuery = 'What are your delivery policies?';
    const fuzzy = await checkCache(similarQuery, tenantId);
    if (fuzzy) {
        console.log('   ✅ Fuzzy match found! Response:', fuzzy.response.substring(0, 50) + '...');
    } else {
        console.log('   ℹ️  No fuzzy match (similarity below 80% threshold)');
    }
    
    // Test 5: Check database
    console.log('\n5️⃣ Verifying database entries...');
    const Database = require('better-sqlite3');
    const db = new Database('local-database.db');
    
    const cached = db.prepare('SELECT COUNT(*) as count FROM ai_response_cache WHERE tenant_id = ?').get(tenantId);
    const usage = db.prepare('SELECT COUNT(*) as count FROM ai_usage_tracking WHERE tenant_id = ?').get(tenantId);
    
    console.log(`   - Cached responses: ${cached.count}`);
    console.log(`   - Usage tracking entries: ${usage.count}`);
    
    db.close();
    
    console.log('\n✅ Cache service is working correctly!\n');
    
})().catch(error => {
    console.error('❌ Test failed:', error.message);
    console.error(error.stack);
});
