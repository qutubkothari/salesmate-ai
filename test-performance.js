/**
 * Performance & Scale Test Script
 * Tests caching, query tracking, rate limiting, health checks, metrics
 */

const axios = require('axios');

const API_URL = process.env.API_URL || 'http://localhost:8055';
const BASE_URL = `${API_URL}/api/performance`;

const tests = [
  {
    name: 'Set Cache Value',
    method: 'POST',
    url: `${BASE_URL}/cache`,
    data: {
      key: 'test:products:all',
      value: { products: [{id: 1, name: 'Product A', price: 99.99}] },
      ttl: 3600,
      type: 'query_result',
      priority: 'high',
      canEvict: false
    }
  },
  {
    name: 'Get Cache Value',
    method: 'GET',
    url: `${BASE_URL}/cache/test:products:all`,
    data: null
  },
  {
    name: 'Get Cache Statistics',
    method: 'GET',
    url: `${BASE_URL}/cache/stats`,
    data: null
  },
  {
    name: 'Track Query Performance (Fast Query)',
    method: 'POST',
    url: `${BASE_URL}/query/track`,
    data: {
      tenantId: 'tenant-1',
      queryType: 'SELECT',
      querySignature: 'SELECT * FROM products WHERE id = ?',
      tableName: 'products',
      executionTimeMs: 25,
      rowsAffected: 1,
      rowsScanned: 1,
      usedIndex: true,
      endpoint: '/api/products/:id',
      userId: 'user-1'
    }
  },
  {
    name: 'Track Query Performance (Slow Query)',
    method: 'POST',
    url: `${BASE_URL}/query/track`,
    data: {
      tenantId: 'tenant-1',
      queryType: 'SELECT',
      querySignature: 'SELECT * FROM orders WHERE created_at > ?',
      tableName: 'orders',
      executionTimeMs: 1850,
      rowsAffected: 500,
      rowsScanned: 5000,
      usedIndex: false,
      endpoint: '/api/orders',
      userId: 'user-1'
    }
  },
  {
    name: 'Get Slow Queries Report',
    method: 'GET',
    url: `${BASE_URL}/query/slow?limit=10`,
    data: null
  },
  {
    name: 'Suggest Query Optimization',
    method: 'POST',
    url: `${BASE_URL}/query/optimize`,
    data: {
      querySignature: 'SELECT * FROM orders WHERE created_at > ?',
      tableName: 'orders',
      issueType: 'missing_index',
      severity: 'high',
      suggestion: 'Add index on orders(created_at) to speed up date range queries',
      estimatedImprovement: 85,
      implementationSql: 'CREATE INDEX idx_orders_created_at ON orders(created_at);',
      affectedEndpoints: ['/api/orders', '/api/reports/sales']
    }
  },
  {
    name: 'Check Rate Limit (Within Limit)',
    method: 'POST',
    url: `${BASE_URL}/rate-limit/check`,
    data: {
      limitType: 'ip',
      limitKey: '192.168.1.100',
      maxRequests: 100,
      windowSeconds: 60
    }
  },
  {
    name: 'Track API Request (Success)',
    method: 'POST',
    url: `${BASE_URL}/metrics/track`,
    data: {
      tenantId: 'tenant-1',
      endpoint: '/api/orders',
      httpMethod: 'GET',
      responseTimeMs: 125,
      statusCode: 200,
      requestSizeBytes: 512,
      responseSizeBytes: 4096,
      userId: 'user-1',
      ipAddress: '192.168.1.100',
      userAgent: 'Mozilla/5.0',
      hasError: false
    }
  },
  {
    name: 'Track API Request (Slow)',
    method: 'POST',
    url: `${BASE_URL}/metrics/track`,
    data: {
      tenantId: 'tenant-1',
      endpoint: '/api/reports/analytics',
      httpMethod: 'POST',
      responseTimeMs: 3250,
      statusCode: 200,
      requestSizeBytes: 1024,
      responseSizeBytes: 15360,
      userId: 'user-1',
      ipAddress: '192.168.1.100',
      hasError: false
    }
  },
  {
    name: 'Get API Metrics',
    method: 'GET',
    url: `${BASE_URL}/metrics/api?startDate=2024-01-01&endDate=2026-12-31`,
    data: null
  },
  {
    name: 'Run Health Check (Database)',
    method: 'POST',
    url: `${BASE_URL}/health/check`,
    data: {
      checkType: 'database',
      checkName: 'SQLite Connection',
      status: 'healthy',
      responseTimeMs: 5,
      metricValue: 45,
      metricUnit: 'active_connections',
      warningThreshold: 80,
      criticalThreshold: 95,
      statusMessage: 'Database is responding normally'
    }
  },
  {
    name: 'Run Health Check (Memory)',
    method: 'POST',
    url: `${BASE_URL}/health/check`,
    data: {
      checkType: 'memory',
      checkName: 'Memory Usage',
      status: 'degraded',
      metricValue: 85,
      metricUnit: 'percent',
      warningThreshold: 80,
      criticalThreshold: 95,
      statusMessage: 'Memory usage approaching warning threshold'
    }
  },
  {
    name: 'Get System Health Status',
    method: 'GET',
    url: `${BASE_URL}/health/status`,
    data: null
  },
  {
    name: 'Create Performance Alert',
    method: 'POST',
    url: `${BASE_URL}/alerts`,
    data: {
      alertType: 'high_error_rate',
      severity: 'warning',
      metricName: 'error_rate',
      metricValue: 12.5,
      thresholdValue: 10,
      alertTitle: 'Elevated Error Rate',
      alertMessage: 'API error rate is 12.5%, above threshold of 10%'
    }
  },
  {
    name: 'Get Active Alerts',
    method: 'GET',
    url: `${BASE_URL}/alerts`,
    data: null
  },
  {
    name: 'Invalidate Cache Pattern',
    method: 'DELETE',
    url: `${BASE_URL}/cache/test:*`,
    data: null
  },
  {
    name: 'Trigger Cache Eviction',
    method: 'POST',
    url: `${BASE_URL}/cache/evict`,
    data: null
  }
];

async function runTests() {
  console.log('🧪 Performance & Scale Test Suite\n');
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
      } else if (test.method === 'DELETE') {
        response = await axios.delete(test.url);
      }
      
      if (response.data.success || response.data.success === undefined) {
        console.log(`✅ PASS: ${test.name}`);
        if (response.data.data) {
          const preview = JSON.stringify(response.data.data, null, 2).substring(0, 150);
          console.log(`   Data: ${preview}${preview.length >= 150 ? '...' : ''}`);
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
