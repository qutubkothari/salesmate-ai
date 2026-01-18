/**
 * ERP Integrations API Routes
 * Zoho, Tally, QuickBooks, SAP integration endpoints
 */

const express = require('express');
const router = express.Router();
const { db } = require('../../services/config');
const ERPIntegrationService = require('../../services/erp-integration-service');

// ===== CONNECTIONS =====

/**
 * GET /api/erp/connections
 * List all ERP connections
 */
router.get('/connections', (req, res) => {
  try {
    const tenantId = req.query.tenant_id || 'default-tenant';
    const { erp_system, status } = req.query;
    
    let query = 'SELECT * FROM erp_connections WHERE tenant_id = ?';
    const params = [tenantId];
    
    if (erp_system) {
      query += ' AND erp_system = ?';
      params.push(erp_system);
    }
    
    if (status) {
      query += ' AND status = ?';
      params.push(status);
    }
    
    query += ' ORDER BY created_at DESC';
    
    const connections = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      connections: connections.map(conn => ({
        ...conn,
        auth_config: conn.auth_config ? JSON.parse(conn.auth_config) : null,
        oauth_tokens: conn.oauth_tokens ? JSON.parse(conn.oauth_tokens) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching connections:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/erp/connections
 * Create new ERP connection
 */
router.post('/connections', async (req, res) => {
  try {
    const tenantId = req.body.tenant_id || 'default-tenant';
    
    const connection = ERPIntegrationService.createConnection(tenantId, req.body);
    
    res.json({
      success: true,
      connection
    });
  } catch (error) {
    console.error('Error creating connection:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/erp/connections/:id
 * Get connection details
 */
router.get('/connections/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    const connection = db.prepare('SELECT * FROM erp_connections WHERE id = ?').get(id);
    
    if (!connection) {
      return res.status(404).json({ success: false, error: 'Connection not found' });
    }
    
    res.json({
      success: true,
      connection: {
        ...connection,
        auth_config: connection.auth_config ? JSON.parse(connection.auth_config) : null,
        oauth_tokens: connection.oauth_tokens ? JSON.parse(connection.oauth_tokens) : null
      }
    });
  } catch (error) {
    console.error('Error fetching connection:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/erp/connections/:id/test
 * Test ERP connection
 */
router.post('/connections/:id/test', async (req, res) => {
  try {
    const { id } = req.params;
    
    const result = await ERPIntegrationService.testConnection(id);
    
    res.json({
      success: result.success,
      result
    });
  } catch (error) {
    console.error('Error testing connection:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/erp/connections/:id
 * Update connection
 */
router.put('/connections/:id', (req, res) => {
  try {
    const { id } = req.params;
    const { connection_name, sync_enabled, auto_sync_interval, status } = req.body;
    
    const updates = [];
    const values = [];
    
    if (connection_name) {
      updates.push('connection_name = ?');
      values.push(connection_name);
    }
    if (sync_enabled !== undefined) {
      updates.push('sync_enabled = ?');
      values.push(sync_enabled ? 1 : 0);
    }
    if (auto_sync_interval) {
      updates.push('auto_sync_interval = ?');
      values.push(auto_sync_interval);
    }
    if (status) {
      updates.push('status = ?');
      values.push(status);
    }
    
    if (updates.length > 0) {
      updates.push('updated_at = CURRENT_TIMESTAMP');
      values.push(id);
      
      db.prepare(`UPDATE erp_connections SET ${updates.join(', ')} WHERE id = ?`)
        .run(...values);
    }
    
    res.json({ success: true, message: 'Connection updated' });
  } catch (error) {
    console.error('Error updating connection:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * DELETE /api/erp/connections/:id
 * Delete connection
 */
router.delete('/connections/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    db.prepare('DELETE FROM erp_connections WHERE id = ?').run(id);
    
    res.json({ success: true, message: 'Connection deleted' });
  } catch (error) {
    console.error('Error deleting connection:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== SYNC CONFIGURATIONS =====

/**
 * GET /api/erp/sync-configs
 * List sync configurations
 */
router.get('/sync-configs', (req, res) => {
  try {
    const { connection_id, entity_type } = req.query;
    
    let query = 'SELECT * FROM erp_sync_configs WHERE 1=1';
    const params = [];
    
    if (connection_id) {
      query += ' AND connection_id = ?';
      params.push(connection_id);
    }
    
    if (entity_type) {
      query += ' AND entity_type = ?';
      params.push(entity_type);
    }
    
    query += ' ORDER BY created_at DESC';
    
    const configs = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      configs: configs.map(c => ({
        ...c,
        sync_filter: c.sync_filter ? JSON.parse(c.sync_filter) : null,
        field_mappings: c.field_mappings ? JSON.parse(c.field_mappings) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching sync configs:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/erp/sync-configs
 * Create sync configuration
 */
router.post('/sync-configs', (req, res) => {
  try {
    const { connection_id, tenant_id = 'default-tenant' } = req.body;
    
    const config = ERPIntegrationService.createSyncConfig(connection_id, tenant_id, req.body);
    
    res.json({
      success: true,
      config
    });
  } catch (error) {
    console.error('Error creating sync config:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/erp/sync-configs/:id
 * Get sync configuration with field mappings
 */
router.get('/sync-configs/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    const config = db.prepare('SELECT * FROM erp_sync_configs WHERE id = ?').get(id);
    
    if (!config) {
      return res.status(404).json({ success: false, error: 'Sync config not found' });
    }
    
    const fieldMappings = db.prepare('SELECT * FROM erp_field_mappings WHERE sync_config_id = ?').all(id);
    
    res.json({
      success: true,
      config: {
        ...config,
        sync_filter: config.sync_filter ? JSON.parse(config.sync_filter) : null,
        field_mappings: config.field_mappings ? JSON.parse(config.field_mappings) : null,
        detailed_field_mappings: fieldMappings.map(fm => ({
          ...fm,
          transform_function: fm.transform_function ? JSON.parse(fm.transform_function) : null,
          value_mappings: fm.value_mappings ? JSON.parse(fm.value_mappings) : null
        }))
      }
    });
  } catch (error) {
    console.error('Error fetching sync config:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/erp/sync-configs/:id
 * Update sync configuration
 */
router.put('/sync-configs/:id', (req, res) => {
  try {
    const { id } = req.params;
    const { sync_direction, auto_sync, sync_frequency, is_active } = req.body;
    
    const updates = [];
    const values = [];
    
    if (sync_direction) {
      updates.push('sync_direction = ?');
      values.push(sync_direction);
    }
    if (auto_sync !== undefined) {
      updates.push('auto_sync = ?');
      values.push(auto_sync ? 1 : 0);
    }
    if (sync_frequency) {
      updates.push('sync_frequency = ?');
      values.push(sync_frequency);
    }
    if (is_active !== undefined) {
      updates.push('is_active = ?');
      values.push(is_active ? 1 : 0);
    }
    
    if (updates.length > 0) {
      updates.push('updated_at = CURRENT_TIMESTAMP');
      values.push(id);
      
      db.prepare(`UPDATE erp_sync_configs SET ${updates.join(', ')} WHERE id = ?`)
        .run(...values);
    }
    
    res.json({ success: true, message: 'Sync config updated' });
  } catch (error) {
    console.error('Error updating sync config:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== SYNCHRONIZATION =====

/**
 * POST /api/erp/sync
 * Trigger manual sync
 */
router.post('/sync', async (req, res) => {
  try {
    const { sync_config_id, sync_direction, sync_type = 'manual', triggered_by } = req.body;
    
    const result = await ERPIntegrationService.syncEntity(sync_config_id, {
      syncDirection: sync_direction,
      syncType: sync_type,
      triggeredBy: triggered_by,
      triggerSource: 'manual'
    });
    
    res.json({
      success: true,
      result
    });
  } catch (error) {
    console.error('Error triggering sync:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/erp/sync-logs
 * Get sync history
 */
router.get('/sync-logs', (req, res) => {
  try {
    const { connection_id, sync_config_id, status, limit = 50 } = req.query;
    
    let query = 'SELECT * FROM erp_sync_logs WHERE 1=1';
    const params = [];
    
    if (connection_id) {
      query += ' AND connection_id = ?';
      params.push(connection_id);
    }
    
    if (sync_config_id) {
      query += ' AND sync_config_id = ?';
      params.push(sync_config_id);
    }
    
    if (status) {
      query += ' AND status = ?';
      params.push(status);
    }
    
    query += ' ORDER BY started_at DESC LIMIT ?';
    params.push(parseInt(limit));
    
    const logs = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      logs: logs.map(log => ({
        ...log,
        error_details: log.error_details ? JSON.parse(log.error_details) : null,
        sync_summary: log.sync_summary ? JSON.parse(log.sync_summary) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching sync logs:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/erp/sync-logs/:id
 * Get sync log details
 */
router.get('/sync-logs/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    const log = db.prepare('SELECT * FROM erp_sync_logs WHERE id = ?').get(id);
    
    if (!log) {
      return res.status(404).json({ success: false, error: 'Sync log not found' });
    }
    
    res.json({
      success: true,
      log: {
        ...log,
        error_details: log.error_details ? JSON.parse(log.error_details) : null,
        sync_summary: log.sync_summary ? JSON.parse(log.sync_summary) : null
      }
    });
  } catch (error) {
    console.error('Error fetching sync log:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/erp/sync-records
 * Get entity sync records
 */
router.get('/sync-records', (req, res) => {
  try {
    const { local_entity_type, local_entity_id, sync_status, limit = 100 } = req.query;
    
    let query = 'SELECT * FROM erp_entity_sync_records WHERE 1=1';
    const params = [];
    
    if (local_entity_type) {
      query += ' AND local_entity_type = ?';
      params.push(local_entity_type);
    }
    
    if (local_entity_id) {
      query += ' AND local_entity_id = ?';
      params.push(local_entity_id);
    }
    
    if (sync_status) {
      query += ' AND sync_status = ?';
      params.push(sync_status);
    }
    
    query += ' ORDER BY last_sync_at DESC LIMIT ?';
    params.push(parseInt(limit));
    
    const records = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      records: records.map(rec => ({
        ...rec,
        conflict_details: rec.conflict_details ? JSON.parse(rec.conflict_details) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching sync records:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== WEBHOOKS =====

/**
 * GET /api/erp/webhooks
 * List webhooks
 */
router.get('/webhooks', (req, res) => {
  try {
    const { connection_id } = req.query;
    
    let query = 'SELECT * FROM erp_webhooks WHERE 1=1';
    const params = [];
    
    if (connection_id) {
      query += ' AND connection_id = ?';
      params.push(connection_id);
    }
    
    query += ' ORDER BY created_at DESC';
    
    const webhooks = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      webhooks: webhooks.map(wh => ({
        ...wh,
        subscribed_events: wh.subscribed_events ? JSON.parse(wh.subscribed_events) : null,
        entity_types: wh.entity_types ? JSON.parse(wh.entity_types) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching webhooks:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/erp/webhooks
 * Register webhook
 */
router.post('/webhooks', (req, res) => {
  try {
    const { connection_id, tenant_id = 'default-tenant' } = req.body;
    
    const webhook = ERPIntegrationService.createWebhook(connection_id, tenant_id, req.body);
    
    res.json({
      success: true,
      webhook
    });
  } catch (error) {
    console.error('Error creating webhook:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/erp/webhooks/:id/receive
 * Receive webhook event
 */
router.post('/webhooks/:id/receive', async (req, res) => {
  try {
    const { id } = req.params;
    
    const result = await ERPIntegrationService.processWebhook(id, req.body, req.headers);
    
    res.json({
      success: true,
      result
    });
  } catch (error) {
    console.error('Error processing webhook:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/erp/webhook-events
 * List webhook events
 */
router.get('/webhook-events', (req, res) => {
  try {
    const { webhook_id, status, limit = 50 } = req.query;
    
    let query = 'SELECT * FROM erp_webhook_events WHERE 1=1';
    const params = [];
    
    if (webhook_id) {
      query += ' AND webhook_id = ?';
      params.push(webhook_id);
    }
    
    if (status) {
      query += ' AND status = ?';
      params.push(status);
    }
    
    query += ' ORDER BY received_at DESC LIMIT ?';
    params.push(parseInt(limit));
    
    const events = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      events: events.map(evt => ({
        ...evt,
        payload: evt.payload ? JSON.parse(evt.payload) : null,
        headers: evt.headers ? JSON.parse(evt.headers) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching webhook events:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== DASHBOARD/OVERVIEW =====

/**
 * GET /api/erp/dashboard
 * Get ERP integration dashboard
 */
router.get('/dashboard', (req, res) => {
  try {
    const tenantId = req.query.tenant_id || 'default-tenant';
    
    // Connection summary
    const connections = db.prepare(`
      SELECT erp_system, status, COUNT(*) as count
      FROM erp_connections
      WHERE tenant_id = ?
      GROUP BY erp_system, status
    `).all(tenantId);
    
    // Sync stats
    const syncStats = db.prepare(`
      SELECT 
        COUNT(*) as total_syncs,
        SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed,
        SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END) as failed,
        SUM(records_processed) as total_records,
        SUM(records_success) as successful_records
      FROM erp_sync_logs
      WHERE tenant_id = ? AND started_at > datetime('now', '-7 days')
    `).get(tenantId);
    
    // Recent syncs
    const recentSyncs = db.prepare(`
      SELECT * FROM erp_sync_logs
      WHERE tenant_id = ?
      ORDER BY started_at DESC
      LIMIT 10
    `).all(tenantId);
    
    // Active webhooks
    const webhookCount = db.prepare(`
      SELECT COUNT(*) as count FROM erp_webhooks
      WHERE tenant_id = ? AND is_active = 1
    `).get(tenantId);
    
    res.json({
      success: true,
      dashboard: {
        connections,
        syncStats,
        recentSyncs,
        activeWebhooks: webhookCount?.count || 0
      }
    });
  } catch (error) {
    console.error('Error fetching dashboard:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
