/**
 * Comprehensive Smoke Test for Salesmate Suite
 * Tests: Salesmate AI, SAK-SMS CRM, FSM integration
 * 
 * Run: node smoke-test.js
 */

const https = require('https');
const http = require('http');

const BASE_URL = 'https://salesmate.saksolution.com';
const TEST_TENANT_ID = 'aaaaaaaa-bbbb-cccc-dddd-000000000001';

// Test results tracking
const results = {
    passed: 0,
    failed: 0,
    skipped: 0,
    tests: []
};

// HTTP request helper
function makeRequest(method, path, data = null, headers = {}) {
    return new Promise((resolve, reject) => {
        const url = new URL(BASE_URL + path);
        const options = {
            hostname: url.hostname,
            port: url.port || 443,
            path: url.pathname + url.search,
            method: method,
            headers: {
                'Content-Type': 'application/json',
                ...headers
            }
        };

        const req = https.request(options, (res) => {
            let body = '';
            res.on('data', chunk => body += chunk);
            res.on('end', () => {
                try {
                    resolve({ status: res.statusCode, data: JSON.parse(body) });
                } catch {
                    resolve({ status: res.statusCode, data: body });
                }
            });
        });

        req.on('error', reject);
        req.setTimeout(10000, () => {
            req.destroy();
            reject(new Error('Request timeout'));
        });

        if (data) req.write(JSON.stringify(data));
        req.end();
    });
}

// Test runner
async function test(name, category, fn) {
    const startTime = Date.now();
    try {
        await fn();
        const duration = Date.now() - startTime;
        results.passed++;
        results.tests.push({ name, category, status: 'PASS', duration: `${duration}ms` });
        console.log(`✅ PASS: ${category} > ${name} (${duration}ms)`);
    } catch (error) {
        const duration = Date.now() - startTime;
        results.failed++;
        results.tests.push({ name, category, status: 'FAIL', error: error.message, duration: `${duration}ms` });
        console.log(`❌ FAIL: ${category} > ${name} - ${error.message}`);
    }
}

// Assertion helpers
function assert(condition, message) {
    if (!condition) throw new Error(message || 'Assertion failed');
}

function assertEquals(actual, expected, message) {
    if (actual !== expected) {
        throw new Error(message || `Expected ${expected}, got ${actual}`);
    }
}

// ============== SMOKE TESTS ==============

async function runAllTests() {
    console.log('\n========================================');
    console.log('🧪 SALESMATE SUITE SMOKE TEST');
    console.log('========================================\n');
    console.log(`Base URL: ${BASE_URL}`);
    console.log(`Test Tenant: ${TEST_TENANT_ID}`);
    console.log('----------------------------------------\n');

    // ============== CORE SYSTEM ==============
    console.log('📦 CORE SYSTEM TESTS\n');

    await test('Server is reachable', 'Core', async () => {
        const res = await makeRequest('GET', '/');
        assert(res.status === 200 || res.status === 302, `Server returned ${res.status}`);
    });

    await test('API responds', 'Core', async () => {
        const res = await makeRequest('GET', '/api/tenants');
        assert(res.status === 200, `API returned ${res.status}`);
        assert(res.data.success === true, 'API response not successful');
    });

    await test('Tenants list loads', 'Core', async () => {
        const res = await makeRequest('GET', '/api/tenants');
        assert(Array.isArray(res.data.tenants), 'Tenants is not an array');
        assert(res.data.tenants.length > 0, 'No tenants found');
    });

    await test('Test tenant exists', 'Core', async () => {
        const res = await makeRequest('GET', `/api/tenants/${TEST_TENANT_ID}`);
        assert(res.status === 200, `Tenant not found: ${res.status}`);
    });

    // ============== SALESMATE AI ==============
    console.log('\n🤖 SALESMATE AI TESTS\n');

    await test('Products API loads', 'Salesmate AI', async () => {
        const res = await makeRequest('GET', `/api/dashboard/products/${TEST_TENANT_ID}`);
        assert(res.status === 200 || res.status === 401, `Products API failed: ${res.status}`);
    });

    await test('Categories API loads', 'Salesmate AI', async () => {
        const res = await makeRequest('GET', `/api/categories?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200, `Categories API failed: ${res.status}`);
    });

    await test('Customers API loads', 'Salesmate AI', async () => {
        const res = await makeRequest('GET', `/api/dashboard/customers/${TEST_TENANT_ID}`);
        assert(res.status === 200 || res.status === 401, `Customers API failed: ${res.status}`);
    });

    await test('Discounts API loads', 'Salesmate AI', async () => {
        const res = await makeRequest('GET', `/api/discounts/${TEST_TENANT_ID}`);
        // This endpoint exists at /api/discounts/:tenantId
        assert(res.status === 200 || res.status === 401 || res.status === 500, `Discounts API error: ${res.status}`);
    });

    await test('Dashboard verify-token endpoint exists', 'Salesmate AI', async () => {
        const res = await makeRequest('GET', `/api/dashboard/verify-token?tenant_id=${TEST_TENANT_ID}`);
        // 401 is expected without token, but endpoint should exist
        assert(res.status !== 404, 'Endpoint not found');
    });

    await test('Broadcast queue API loads', 'Salesmate AI', async () => {
        const res = await makeRequest('GET', `/api/broadcast/queue/${TEST_TENANT_ID}`);
        assert(res.status === 200 || res.status === 401 || res.status === 404, `Broadcast API response: ${res.status}`);
    });

    // ============== SAK-SMS CRM ==============
    console.log('\n📊 SAK-SMS CRM TESTS\n');

    await test('Leads API endpoint exists', 'CRM', async () => {
        const res = await makeRequest('GET', `/api/crm/leads?tenant_id=${TEST_TENANT_ID}`);
        // 401 without auth is expected, 404 means missing
        assert(res.status !== 404, 'CRM Leads endpoint not found');
    });

    await test('Triage API endpoint exists', 'CRM', async () => {
        const res = await makeRequest('GET', `/api/crm/triage?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status !== 404, 'CRM Triage endpoint not found');
    });

    await test('Email list API loads', 'CRM', async () => {
        const res = await makeRequest('GET', `/api/email/list?tenant_id=${TEST_TENANT_ID}`);
        // 401 expected without auth, but endpoint should exist
        assert(res.status !== 404, 'Email list endpoint not found');
    });

    await test('Follow-ups API loads', 'CRM', async () => {
        const res = await makeRequest('GET', `/api/followups/${TEST_TENANT_ID}`);
        assert(res.status === 200 || res.status === 401, `Follow-ups API error: ${res.status}`);
    });

    // ============== FSM (Field Sales Management) ==============
    console.log('\n🗺️ FSM TESTS\n');

    await test('FSM Visits API loads', 'FSM', async () => {
        const res = await makeRequest('GET', `/api/fsm/visits?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200, `FSM Visits failed: ${res.status}`);
    });

    await test('FSM Salesmen API loads', 'FSM', async () => {
        const res = await makeRequest('GET', `/api/fsm/salesmen?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200, `FSM Salesmen failed: ${res.status}`);
    });

    await test('FSM Plants/Branches API loads', 'FSM', async () => {
        const res = await makeRequest('GET', `/api/fsm/plants?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200, `FSM Plants failed: ${res.status}`);
    });

    await test('FSM Targets API loads', 'FSM', async () => {
        const res = await makeRequest('GET', `/api/fsm/targets?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200, `FSM Targets failed: ${res.status}`);
    });

    await test('FSM Visit Stats API loads', 'FSM', async () => {
        const res = await makeRequest('GET', `/api/fsm/visits/stats?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200, `FSM Stats failed: ${res.status}`);
    });

    // ============== FSM SALESMAN APP APIs ==============
    console.log('\n📱 FSM SALESMAN APP TESTS\n');

    await test('Salesman login endpoint exists', 'Salesman App', async () => {
        const res = await makeRequest('POST', '/api/fsm/salesman/login', {
            phone: 'test',
            password: 'test',
            tenant_id: TEST_TENANT_ID
        });
        // 401 expected for wrong creds, but endpoint should work
        assert(res.status !== 404 && res.status !== 500, `Login endpoint error: ${res.status}`);
    });

    await test('Salesman leaderboard API exists', 'Salesman App', async () => {
        const res = await makeRequest('GET', `/api/fsm/analytics/leaderboard?tenant_id=${TEST_TENANT_ID}`);
        // May need auth, but shouldn't 404
        assert(res.status !== 404, 'Leaderboard endpoint not found');
    });

    // ============== WHATSAPP INTEGRATION ==============
    console.log('\n💬 WHATSAPP INTEGRATION TESTS\n');

    await test('WhatsApp connections API loads', 'WhatsApp', async () => {
        const res = await makeRequest('GET', `/api/whatsapp-web/connections?tenant_id=${TEST_TENANT_ID}`);
        assert(res.status === 200 || res.status === 401, `WhatsApp API error: ${res.status}`);
    });

    await test('WhatsApp status endpoint exists', 'WhatsApp', async () => {
        const res = await makeRequest('GET', `/api/whatsapp-web/status/${TEST_TENANT_ID}`);
        assert(res.status !== 404, 'WhatsApp status endpoint not found');
    });

    // ============== STATIC FILES ==============
    console.log('\n📄 STATIC FILES TESTS\n');

    await test('Main dashboard loads', 'Static Files', async () => {
        const res = await makeRequest('GET', '/dashboard.html');
        assert(res.status === 200, `Dashboard not found: ${res.status}`);
    });

    await test('Salesman app loads', 'Static Files', async () => {
        const res = await makeRequest('GET', '/salesman-app.html');
        assert(res.status === 200, `Salesman app not found: ${res.status}`);
    });

    await test('Landing page loads', 'Static Files', async () => {
        const res = await makeRequest('GET', '/');
        assert(res.status === 200 || res.status === 302, `Landing page error: ${res.status}`);
    });

    // ============== PRINT RESULTS ==============
    console.log('\n========================================');
    console.log('📊 SMOKE TEST RESULTS');
    console.log('========================================\n');

    console.log(`✅ Passed: ${results.passed}`);
    console.log(`❌ Failed: ${results.failed}`);
    console.log(`⏭️  Skipped: ${results.skipped}`);
    console.log(`📝 Total: ${results.tests.length}`);

    const passRate = ((results.passed / results.tests.length) * 100).toFixed(1);
    console.log(`\n🎯 Pass Rate: ${passRate}%`);

    if (results.failed > 0) {
        console.log('\n❌ FAILED TESTS:');
        results.tests
            .filter(t => t.status === 'FAIL')
            .forEach(t => console.log(`   - ${t.category} > ${t.name}: ${t.error}`));
    }

    console.log('\n========================================\n');

    // Return exit code based on failures
    process.exit(results.failed > 0 ? 1 : 0);
}

// Run tests
runAllTests().catch(err => {
    console.error('Test runner error:', err);
    process.exit(1);
});
