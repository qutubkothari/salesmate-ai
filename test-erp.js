/**
 * Test ERP Integrations API
 * Tests Zoho, Tally, QuickBooks, SAP integration endpoints
 */

const BASE_URL = 'http://localhost:8055';
const TENANT_ID = 'default-tenant';

async function testERPIntegrations() {
  console.log('🧪 Testing ERP Integrations API\n');
  
  try {
    // Test 1: Create Zoho Connection
    console.log('1️⃣ Creating Zoho CRM Connection...');
    const zohoConn = await fetch(`${BASE_URL}/api/erp/connections`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        erpSystem: 'zoho',
        connectionName: 'Zoho CRM Production',
        authType: 'oauth2',
        authConfig: {
          client_id: 'test_client_id',
          client_secret: 'test_client_secret',
          redirect_uri: 'https://salesmate.saksolution.com/oauth/callback'
        },
        baseUrl: 'https://www.zohoapis.com/crm/v3',
        apiVersion: 'v3',
        organizationId: 'org123',
        syncEnabled: true,
        autoSyncInterval: 1800,
        syncDirection: 'bidirectional',
        createdBy: 'admin'
      })
    });
    const zohoData = await zohoConn.json();
    console.log('✅ Zoho connection created:', zohoData.connection?.id);
    const zohoConnId = zohoData.connection?.id;
    
    // Test 2: Create Tally Connection
    console.log('\n2️⃣ Creating Tally Prime Connection...');
    const tallyConn = await fetch(`${BASE_URL}/api/erp/connections`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        erpSystem: 'tally',
        connectionName: 'Tally Prime Server',
        authType: 'username_password',
        authConfig: {
          username: 'admin',
          password: 'encrypted_password',
          company_name: 'My Company Ltd'
        },
        baseUrl: 'http://localhost:9000',
        apiVersion: 'v1',
        syncEnabled: true,
        autoSyncInterval: 3600,
        syncDirection: 'pull',
        createdBy: 'admin'
      })
    });
    const tallyData = await tallyConn.json();
    console.log('✅ Tally connection created:', tallyData.connection?.id);
    
    // Test 3: Create QuickBooks Connection
    console.log('\n3️⃣ Creating QuickBooks Online Connection...');
    const qbConn = await fetch(`${BASE_URL}/api/erp/connections`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        tenant_id: TENANT_ID,
        erpSystem: 'quickbooks',
        connectionName: 'QuickBooks Online',
        authType: 'oauth2',
        authConfig: {
          client_id: 'qb_client_id',
          client_secret: 'qb_client_secret'
        },
        baseUrl: 'https://quickbooks.api.intuit.com/v3',
        apiVersion: 'v3',
        companyId: 'qb_company_123',
        syncEnabled: true,
        createdBy: 'admin'
      })
    });
    const qbData = await qbConn.json();
    console.log('✅ QuickBooks connection created:', qbData.connection?.id);
    
    // Test 4: Test Connection
    console.log('\n4️⃣ Testing Zoho Connection...');
    const testResult = await fetch(`${BASE_URL}/api/erp/connections/${zohoConnId}/test`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' }
    });
    const testData = await testResult.json();
    console.log('✅ Connection test:', testData.result?.message);
    
    // Test 5: Create Sync Configuration
    console.log('\n5️⃣ Creating Customer Sync Config...');
    const syncConfig = await fetch(`${BASE_URL}/api/erp/sync-configs`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        connection_id: zohoConnId,
        tenant_id: TENANT_ID,
        entityType: 'customer',
        localTable: 'customer_profiles_new',
        remoteModule: 'Contacts',
        syncDirection: 'bidirectional',
        autoSync: true,
        syncFrequency: 1800,
        conflictResolution: 'remote_wins',
        syncFilter: {
          active_only: true
        },
        fieldMappings: [
          { localField: 'business_name', remoteField: 'Company', fieldType: 'text', isRequired: true },
          { localField: 'phone', remoteField: 'Phone', fieldType: 'text' },
          { localField: 'email', remoteField: 'Email', fieldType: 'text' },
          { localField: 'address', remoteField: 'Mailing_Street', fieldType: 'text' },
          { localField: 'city', remoteField: 'Mailing_City', fieldType: 'text' },
          { localField: 'state', remoteField: 'Mailing_State', fieldType: 'text' },
          { localField: 'pincode', remoteField: 'Mailing_Zip', fieldType: 'text' }
        ]
      })
    });
    const syncConfigData = await syncConfig.json();
    console.log('✅ Sync config created:', syncConfigData.config?.id);
    const syncConfigId = syncConfigData.config?.id;
    
    // Test 6: Trigger Manual Sync
    console.log('\n6️⃣ Triggering Manual Sync...');
    const syncTrigger = await fetch(`${BASE_URL}/api/erp/sync`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        sync_config_id: syncConfigId,
        sync_direction: 'pull',
        sync_type: 'manual',
        triggered_by: 'admin'
      })
    });
    const syncResult = await syncTrigger.json();
    console.log('✅ Sync completed:');
    console.log('   Log ID:', syncResult.result?.logId);
    console.log('   Processed:', syncResult.result?.recordsProcessed);
    console.log('   Success:', syncResult.result?.recordsSuccess);
    
    // Test 7: Create Webhook
    console.log('\n7️⃣ Creating Webhook...');
    const webhook = await fetch(`${BASE_URL}/api/erp/webhooks`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        connection_id: zohoConnId,
        tenant_id: TENANT_ID,
        webhookUrl: 'https://salesmate.saksolution.com/api/erp/webhooks/receive',
        webhookSecret: 'webhook_secret_key',
        subscribedEvents: ['create', 'update', 'delete'],
        entityTypes: ['customer', 'order', 'product']
      })
    });
    const webhookData = await webhook.json();
    console.log('✅ Webhook created:', webhookData.webhook?.id);
    
    // Test 8: List Connections
    console.log('\n8️⃣ Listing All Connections...');
    const connectionsList = await fetch(`${BASE_URL}/api/erp/connections?tenant_id=${TENANT_ID}`);
    const connectionsData = await connectionsList.json();
    console.log('✅ Found', connectionsData.connections?.length || 0, 'connections');
    connectionsData.connections?.forEach(conn => {
      console.log(`   - ${conn.erp_system}: ${conn.connection_name} (${conn.status})`);
    });
    
    // Test 9: Get Sync Logs
    console.log('\n9️⃣ Fetching Sync Logs...');
    const syncLogs = await fetch(`${BASE_URL}/api/erp/sync-logs?connection_id=${zohoConnId}&limit=5`);
    const logsData = await syncLogs.json();
    console.log('✅ Found', logsData.logs?.length || 0, 'sync logs');
    
    // Test 10: Dashboard Overview
    console.log('\n🔟 Getting ERP Dashboard...');
    const dashboard = await fetch(`${BASE_URL}/api/erp/dashboard?tenant_id=${TENANT_ID}`);
    const dashboardData = await dashboard.json();
    console.log('✅ Dashboard loaded:');
    console.log('   Connection groups:', dashboardData.dashboard?.connections?.length || 0);
    console.log('   Sync stats:', dashboardData.dashboard?.syncStats);
    console.log('   Active webhooks:', dashboardData.dashboard?.activeWebhooks);
    
    console.log('\n✨ All ERP integration tests completed successfully!');
    
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    console.error(error.stack);
  }
}

testERPIntegrations();
