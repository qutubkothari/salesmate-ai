/**
 * Mobile App Features Test Script
 * Tests offline sync, push notifications, device management, cache, analytics
 */

const axios = require('axios');

const API_URL = process.env.API_URL || 'http://localhost:8055';
const BASE_URL = `${API_URL}/api/mobile-app`;

// Test data
const testDeviceId = 'test-device-' + Date.now();
const testUserId = 'user-1';
const testTenantId = 'tenant-1';

const tests = [
  {
    name: 'Register Mobile Device',
    method: 'POST',
    url: `${BASE_URL}/devices/register`,
    data: {
      tenantId: testTenantId,
      userId: testUserId,
      deviceUuid: testDeviceId,
      deviceName: 'iPhone 14 Pro',
      deviceModel: 'iPhone15,2',
      devicePlatform: 'ios',
      platformVersion: '17.2.1',
      appVersion: '1.0.0',
      appBuildNumber: '100',
      pushToken: 'fcm-token-abc123',
      timezone: 'America/New_York',
      supportsOffline: true,
      supportsBackgroundSync: true
    }
  },
  {
    name: 'Update Device Status',
    method: 'PUT',
    url: `${BASE_URL}/devices/${testDeviceId}/status`,
    data: {
      pushToken: 'fcm-token-xyz789',
      networkType: 'wifi',
      lastLocation: { lat: 40.7128, lng: -74.0060, city: 'New York' },
      storageAvailableMb: 5000,
      isActive: true
    }
  },
  {
    name: 'Start Mobile Session',
    method: 'POST',
    url: `${BASE_URL}/session/start`,
    data: {
      deviceId: testDeviceId,
      tenantId: testTenantId,
      userId: testUserId,
      networkType: 'wifi',
      batteryLevel: 85,
      appVersion: '1.0.0'
    }
  },
  {
    name: 'Queue Offline Operation (Create Order)',
    method: 'POST',
    url: `${BASE_URL}/sync/queue`,
    data: {
      deviceId: testDeviceId,
      tenantId: testTenantId,
      userId: testUserId,
      operationType: 'create',
      entityType: 'orders',
      data: {
        customer_id: 'cust-123',
        items: [
          { product_id: 'prod-1', quantity: 2, price: 99.99 }
        ],
        total: 199.98
      },
      priority: 8
    }
  },
  {
    name: 'Get Pending Sync Operations',
    method: 'GET',
    url: `${BASE_URL}/sync/pending/${testDeviceId}?limit=10`,
    data: null
  },
  {
    name: 'Update Sync Checkpoint',
    method: 'POST',
    url: `${BASE_URL}/sync/checkpoint`,
    data: {
      deviceId: testDeviceId,
      tenantId: testTenantId,
      entityType: 'orders',
      lastSyncTimestamp: new Date().toISOString(),
      lastSyncRecordId: 'order-123',
      syncDirection: 'pull',
      recordsSynced: 15,
      syncDurationMs: 2340
    }
  },
  {
    name: 'Get Sync Checkpoint',
    method: 'GET',
    url: `${BASE_URL}/sync/checkpoint/${testDeviceId}/orders/pull`,
    data: null
  },
  {
    name: 'Send Push Notification',
    method: 'POST',
    url: `${BASE_URL}/push/send`,
    data: {
      tenantId: testTenantId,
      targetType: 'user',
      targetId: testUserId,
      title: 'New Order Received',
      body: 'Customer John Doe placed an order for $199.98',
      icon: 'order-icon.png',
      actionType: 'deep_link',
      deepLink: 'salesmate://orders/123',
      priority: 'high',
      createdBy: 'system'
    }
  },
  {
    name: 'Cache Entity (Product Catalog)',
    method: 'POST',
    url: `${BASE_URL}/cache`,
    data: {
      deviceId: testDeviceId,
      tenantId: testTenantId,
      entityType: 'products',
      entityId: 'all',
      cacheVersion: '1.0.5',
      cacheSizeKb: 1250,
      expiresAt: new Date(Date.now() + 24*60*60*1000).toISOString(),
      cachePriority: 'high',
      autoRefresh: true
    }
  },
  {
    name: 'Get Stale Cache Entries',
    method: 'GET',
    url: `${BASE_URL}/cache/stale/${testDeviceId}`,
    data: null
  },
  {
    name: 'Check for App Updates',
    method: 'GET',
    url: `${BASE_URL}/updates/check?platform=ios&currentVersion=1.0.0`,
    data: null
  },
  {
    name: 'Get Feature Flags',
    method: 'GET',
    url: `${BASE_URL}/feature-flags?platform=ios&appVersion=1.0.0`,
    data: null
  },
  {
    name: 'Track Analytics Event',
    method: 'POST',
    url: `${BASE_URL}/analytics/track`,
    data: {
      deviceId: testDeviceId,
      tenantId: testTenantId,
      userId: testUserId,
      eventName: 'order_created',
      eventCategory: 'transactions',
      eventProperties: {
        order_id: 'order-123',
        order_total: 199.98,
        payment_method: 'credit_card'
      },
      screenName: 'OrderConfirmation',
      networkType: 'wifi',
      isOffline: false,
      eventDurationMs: 1250
    }
  },
  {
    name: 'Get Mobile Analytics',
    method: 'GET',
    url: `${BASE_URL}/analytics?tenantId=${testTenantId}&startDate=2024-01-01&endDate=2024-12-31`,
    data: null
  }
];

async function runTests() {
  console.log('🧪 Mobile App Features Test Suite\n');
  console.log(`Testing against: ${API_URL}\n`);
  
  let passed = 0;
  let failed = 0;
  
  for (const test of tests) {
    try {
      console.log(`Testing: ${test.name}...`);
      
      let response;
      if (test.method === 'GET') {
        response = await axios.get(test.url);
      } else if (test.method === 'POST') {
        response = await axios.post(test.url, test.data);
      } else if (test.method === 'PUT') {
        response = await axios.put(test.url, test.data);
      }
      
      if (response.data.success) {
        console.log(`✅ PASS: ${test.name}`);
        if (response.data.data) {
          console.log(`   Data:`, JSON.stringify(response.data.data, null, 2).substring(0, 200));
        }
        if (response.data.count !== undefined) {
          console.log(`   Count: ${response.data.count}`);
        }
        passed++;
      } else {
        console.log(`❌ FAIL: ${test.name}`);
        console.log(`   Error: ${response.data.error}`);
        failed++;
      }
    } catch (error) {
      console.log(`❌ FAIL: ${test.name}`);
      console.log(`   Error: ${error.response?.data?.error || error.message}`);
      failed++;
    }
    console.log('');
  }
  
  console.log('📊 Test Summary:');
  console.log(`   Total: ${tests.length}`);
  console.log(`   Passed: ${passed}`);
  console.log(`   Failed: ${failed}`);
  console.log(`   Success Rate: ${(passed/tests.length*100).toFixed(1)}%\n`);
}

runTests().catch(console.error);
