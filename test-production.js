#!/usr/bin/env node

/**
 * PRODUCTION SMOKE TEST
 * 
 * Tests live production server at https://salesmate.saksolution.com
 * Unlike local tests, this validates the ACTUAL production environment
 * 
 * Run this AFTER every deployment to verify production is working
 */

const https = require('https');

const BASE_URL = 'https://salesmate.saksolution.com';
const TENANT_ID = 'sak-multi-tenant';
const DEMO_TOKEN = 'demo';

// ANSI color codes
const GREEN = '\x1b[32m';
const RED = '\x1b[31m';
const YELLOW = '\x1b[33m';
const BLUE = '\x1b[36m';
const RESET = '\x1b[0m';

let passedTests = 0;
let failedTests = 0;
const results = [];

function makeRequest(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        resolve({
          statusCode: res.statusCode,
          body: data,
          headers: res.headers
        });
      });
    }).on('error', reject);
  });
}

async function test(name, testFn) {
  try {
    await testFn();
    console.log(`${GREEN}✓${RESET} ${name}`);
    results.push({ name, status: 'PASS' });
    passedTests++;
    return true;
  } catch (error) {
    console.log(`${RED}✗${RESET} ${name}`);
    console.log(`  ${RED}Error: ${error.message}${RESET}`);
    results.push({ name, status: 'FAIL', error: error.message });
    failedTests++;
    return false;
  }
}

async function runTests() {
  console.log(`\n${BLUE}═══════════════════════════════════════════════════${RESET}`);
  console.log(`${BLUE}   PRODUCTION SMOKE TEST - LIVE SERVER${RESET}`);
  console.log(`${BLUE}═══════════════════════════════════════════════════${RESET}`);
  console.log(`\n${YELLOW}Testing: ${BASE_URL}${RESET}\n`);

  // ================================
  // SECTION 1: Server Health
  // ================================
  console.log(`\n${BLUE}[1/5] Server Health Checks${RESET}`);
  
  await test('Server is responding', async () => {
    const res = await makeRequest(BASE_URL);
    if (res.statusCode !== 200 && res.statusCode !== 301 && res.statusCode !== 302) {
      throw new Error(`Server returned ${res.statusCode}`);
    }
  });

  await test('Server returns HTML homepage', async () => {
    const res = await makeRequest(BASE_URL);
    if (!res.headers['content-type']?.includes('text/html')) {
      throw new Error(`Expected HTML, got ${res.headers['content-type']}`);
    }
  });

  // ================================
  // SECTION 2: Dashboard Authentication
  // ================================
  console.log(`\n${BLUE}[2/5] Dashboard Authentication${RESET}`);

  await test('Dashboard verify-token endpoint works', async () => {
    const res = await makeRequest(`${BASE_URL}/api/dashboard/verify-token?token=${DEMO_TOKEN}`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('Authentication failed');
    }
    if (!data.tenant || !data.tenant.id) {
      throw new Error('No tenant data returned');
    }
  });

  // ================================
  // SECTION 3: Core Dashboard APIs
  // ================================
  console.log(`\n${BLUE}[3/5] Core Dashboard APIs${RESET}`);

  await test('Orders API (orders_new table)', async () => {
    const res = await makeRequest(`${BASE_URL}/api/dashboard/orders/${TENANT_ID}`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode} - Body: ${res.body}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.orders)) {
      throw new Error('orders field is not an array');
    }
  });

  await test('Conversations API (conversations_new table)', async () => {
    const res = await makeRequest(`${BASE_URL}/api/dashboard/conversations/${TENANT_ID}`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode} - Body: ${res.body}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.conversations)) {
      throw new Error('conversations field is not an array');
    }
  });

  await test('Customers API (customer_profiles_new table)', async () => {
    const res = await makeRequest(`${BASE_URL}/api/dashboard/customers/${TENANT_ID}`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode} - Body: ${res.body}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.customers)) {
      throw new Error('customers field is not an array');
    }
  });

  await test('Products API', async () => {
    const res = await makeRequest(`${BASE_URL}/api/dashboard/products/${TENANT_ID}`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.products)) {
      throw new Error('products field is not an array');
    }
  });

  // ================================
  // SECTION 4: FSM Module APIs
  // ================================
  console.log(`\n${BLUE}[4/5] FSM Module APIs${RESET}`);

  await test('FSM Visits Stats', async () => {
    const res = await makeRequest(`${BASE_URL}/api/fsm/visits/stats`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!data.stats || typeof data.stats.total === 'undefined') {
      throw new Error('Missing stats.total field');
    }
  });

  await test('FSM Visits List', async () => {
    const res = await makeRequest(`${BASE_URL}/api/fsm/visits`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.data)) {
      throw new Error('data field is not an array');
    }
  });

  await test('FSM Salesmen Stats', async () => {
    const res = await makeRequest(`${BASE_URL}/api/fsm/salesmen/stats`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!data.stats || typeof data.stats.total === 'undefined') {
      throw new Error('Missing stats.total field');
    }
  });

  await test('FSM Salesmen List', async () => {
    const res = await makeRequest(`${BASE_URL}/api/fsm/salesmen`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.data)) {
      throw new Error('data field is not an array');
    }
  });

  await test('FSM Targets Stats', async () => {
    const res = await makeRequest(`${BASE_URL}/api/fsm/targets/stats`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!data.stats || typeof data.stats.total === 'undefined') {
      throw new Error('Missing stats.total field');
    }
  });

  await test('FSM Targets List', async () => {
    const res = await makeRequest(`${BASE_URL}/api/fsm/targets`);
    if (res.statusCode !== 200) {
      throw new Error(`Expected 200, got ${res.statusCode}`);
    }
    const data = JSON.parse(res.body);
    if (!data.success) {
      throw new Error('API returned success:false');
    }
    if (!Array.isArray(data.data)) {
      throw new Error('data field is not an array');
    }
  });

  // ================================
  // SECTION 5: Response Structure Validation
  // ================================
  console.log(`\n${BLUE}[5/5] Response Structure Validation${RESET}`);

  await test('All APIs return valid JSON', async () => {
    const endpoints = [
      `/api/dashboard/orders/${TENANT_ID}`,
      `/api/dashboard/conversations/${TENANT_ID}`,
      `/api/fsm/visits`,
      `/api/fsm/salesmen`,
      `/api/fsm/targets`
    ];

    for (const endpoint of endpoints) {
      const res = await makeRequest(`${BASE_URL}${endpoint}`);
      try {
        JSON.parse(res.body);
      } catch (e) {
        throw new Error(`Invalid JSON from ${endpoint}: ${e.message}`);
      }
    }
  });

  await test('All APIs use consistent response format', async () => {
    const endpoints = [
      { url: `/api/dashboard/orders/${TENANT_ID}`, field: 'orders' },
      { url: `/api/dashboard/conversations/${TENANT_ID}`, field: 'conversations' },
      { url: `/api/fsm/visits`, field: 'data' },
      { url: `/api/fsm/salesmen`, field: 'data' },
      { url: `/api/fsm/targets`, field: 'data' }
    ];

    for (const { url, field } of endpoints) {
      const res = await makeRequest(`${BASE_URL}${url}`);
      const data = JSON.parse(res.body);
      
      if (!data.success) {
        throw new Error(`${url} missing success:true`);
      }
      
      if (!data[field]) {
        throw new Error(`${url} missing ${field} field`);
      }
    }
  });

  // ================================
  // FINAL SUMMARY
  // ================================
  console.log(`\n${BLUE}═══════════════════════════════════════════════════${RESET}`);
  console.log(`${BLUE}   TEST SUMMARY${RESET}`);
  console.log(`${BLUE}═══════════════════════════════════════════════════${RESET}\n`);

  console.log(`Total Tests: ${passedTests + failedTests}`);
  console.log(`${GREEN}Passed: ${passedTests}${RESET}`);
  console.log(`${RED}Failed: ${failedTests}${RESET}`);
  console.log(`Success Rate: ${((passedTests / (passedTests + failedTests)) * 100).toFixed(1)}%`);

  if (failedTests === 0) {
    console.log(`\n${GREEN}✓ ALL TESTS PASSED - PRODUCTION IS HEALTHY${RESET}\n`);
    process.exit(0);
  } else {
    console.log(`\n${RED}✗ SOME TESTS FAILED - PRODUCTION HAS ISSUES${RESET}\n`);
    console.log(`${YELLOW}Failed Tests:${RESET}`);
    results.filter(r => r.status === 'FAIL').forEach(r => {
      console.log(`  - ${r.name}: ${r.error}`);
    });
    console.log();
    process.exit(1);
  }
}

// Run tests
runTests().catch(error => {
  console.error(`\n${RED}Fatal error:${RESET}`, error);
  process.exit(1);
});
