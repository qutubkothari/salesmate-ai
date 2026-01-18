/**
 * ERP Integration Service
 * Manages connections and data sync for Zoho, Tally, QuickBooks, SAP
 */

const { db } = require('./config');
const crypto = require('crypto');

class ERPIntegrationService {
  
  // ===== CONNECTION MANAGEMENT =====
  
  /**
   * Create ERP connection
   */
  static createConnection(tenantId, connectionData) {
    const {
      erpSystem,
      connectionName,
      authType,
      authConfig,
      baseUrl,
      apiVersion,
      organizationId,
      companyId,
      syncEnabled = true,
      autoSyncInterval = 3600,
      syncDirection = 'bidirectional',
      createdBy
    } = connectionData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO erp_connections (
        id, tenant_id, erp_system, connection_name, auth_type, auth_config,
        base_url, api_version, organization_id, company_id,
        sync_enabled, auto_sync_interval, sync_direction, created_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, tenantId, erpSystem, connectionName, authType, JSON.stringify(authConfig),
      baseUrl, apiVersion, organizationId, companyId,
      syncEnabled ? 1 : 0, autoSyncInterval, syncDirection, createdBy || null
    );
    
    return { id, connectionName, erpSystem, status: 'active' };
  }
  
  /**
   * Test ERP connection
   */
  static async testConnection(connectionId) {
    const connection = db.prepare('SELECT * FROM erp_connections WHERE id = ?').get(connectionId);
    if (!connection) return { success: false, error: 'Connection not found' };
    
    // Simulate connection test based on ERP system
    let testResult = { success: true, message: 'Connection successful', latency: 0 };
    
    try {
      const startTime = Date.now();
      
      switch (connection.erp_system) {
        case 'zoho':
          testResult = await this._testZohoConnection(connection);
          break;
        case 'tally':
          testResult = await this._testTallyConnection(connection);
          break;
        case 'quickbooks':
          testResult = await this._testQuickBooksConnection(connection);
          break;
        case 'sap':
          testResult = await this._testSAPConnection(connection);
          break;
        default:
          testResult = { success: false, message: 'Unsupported ERP system' };
      }
      
      testResult.latency = Date.now() - startTime;
      
      // Update connection status
      db.prepare(`
        UPDATE erp_connections 
        SET status = ?, last_connected_at = CURRENT_TIMESTAMP, last_error = ?
        WHERE id = ?
      `).run(
        testResult.success ? 'active' : 'error',
        testResult.success ? null : testResult.message,
        connectionId
      );
      
    } catch (error) {
      testResult = { success: false, message: error.message, latency: 0 };
    }
    
    return testResult;
  }
  
  static async _testZohoConnection(connection) {
    // Placeholder for Zoho API test
    // In production: fetch('/api/auth/validate', { headers: { 'Authorization': 'Bearer ...' } })
    return { success: true, message: 'Zoho connection verified' };
  }
  
  static async _testTallyConnection(connection) {
    // Placeholder for Tally Prime API test
    // In production: XML-RPC or REST API call to Tally server
    return { success: true, message: 'Tally connection verified' };
  }
  
  static async _testQuickBooksConnection(connection) {
    // Placeholder for QuickBooks API test
    // In production: OAuth2 token validation
    return { success: true, message: 'QuickBooks connection verified' };
  }
  
  static async _testSAPConnection(connection) {
    // Placeholder for SAP API test
    // In production: SAP OData or RFC call
    return { success: true, message: 'SAP connection verified' };
  }
  
  /**
   * Update OAuth tokens
   */
  static updateOAuthTokens(connectionId, tokens) {
    db.prepare(`
      UPDATE erp_connections 
      SET oauth_tokens = ?, last_connected_at = CURRENT_TIMESTAMP, status = 'active'
      WHERE id = ?
    `).run(JSON.stringify(tokens), connectionId);
  }
  
  // ===== SYNC CONFIGURATION =====
  
  /**
   * Create sync configuration
   */
  static createSyncConfig(connectionId, tenantId, configData) {
    const {
      entityType,
      localTable,
      remoteModule,
      syncDirection = 'bidirectional',
      autoSync = true,
      syncFrequency = 3600,
      conflictResolution = 'remote_wins',
      syncFilter = {},
      fieldMappings = []
    } = configData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO erp_sync_configs (
        id, connection_id, tenant_id, entity_type, local_table, remote_module,
        sync_direction, auto_sync, sync_frequency, conflict_resolution,
        sync_filter, field_mappings
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, connectionId, tenantId, entityType, localTable, remoteModule,
      syncDirection, autoSync ? 1 : 0, syncFrequency, conflictResolution,
      JSON.stringify(syncFilter), JSON.stringify(fieldMappings)
    );
    
    // Create detailed field mappings
    fieldMappings.forEach(mapping => {
      this.createFieldMapping(id, mapping);
    });
    
    return { id, entityType, syncDirection };
  }
  
  /**
   * Create field mapping
   */
  static createFieldMapping(syncConfigId, mappingData) {
    const {
      localField,
      remoteField,
      fieldType,
      isRequired = false,
      isReadonly = false,
      transformFunction = null,
      defaultValue = null,
      valueMappings = null
    } = mappingData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO erp_field_mappings (
        id, sync_config_id, local_field, remote_field, field_type,
        is_required, is_readonly, transform_function, default_value, value_mappings
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, syncConfigId, localField, remoteField, fieldType,
      isRequired ? 1 : 0, isReadonly ? 1 : 0,
      transformFunction ? JSON.stringify(transformFunction) : null,
      defaultValue, valueMappings ? JSON.stringify(valueMappings) : null
    );
    
    return id;
  }
  
  // ===== DATA SYNCHRONIZATION =====
  
  /**
   * Sync data for specific entity
   */
  static async syncEntity(syncConfigId, options = {}) {
    const config = db.prepare(`
      SELECT sc.*, ec.erp_system, ec.auth_config, ec.oauth_tokens, ec.base_url
      FROM erp_sync_configs sc
      JOIN erp_connections ec ON sc.connection_id = ec.id
      WHERE sc.id = ?
    `).get(syncConfigId);
    
    if (!config) throw new Error('Sync config not found');
    
    const {
      syncDirection = config.sync_direction,
      syncType = 'incremental',
      triggeredBy = 'system',
      triggerSource = 'manual'
    } = options;
    
    // Create sync log
    const logId = crypto.randomBytes(16).toString('hex');
    db.prepare(`
      INSERT INTO erp_sync_logs (
        id, connection_id, sync_config_id, tenant_id, sync_type,
        sync_direction, entity_type, status, triggered_by, trigger_source
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      logId, config.connection_id, syncConfigId, config.tenant_id,
      syncType, syncDirection, config.entity_type, 'running',
      triggeredBy, triggerSource
    );
    
    let result = {
      logId,
      recordsProcessed: 0,
      recordsSuccess: 0,
      recordsFailed: 0,
      recordsSkipped: 0
    };
    
    try {
      // Perform sync based on direction
      if (syncDirection === 'pull' || syncDirection === 'bidirectional') {
        const pullResult = await this._pullFromERP(config);
        result.recordsProcessed += pullResult.processed;
        result.recordsSuccess += pullResult.success;
        result.recordsFailed += pullResult.failed;
      }
      
      if (syncDirection === 'push' || syncDirection === 'bidirectional') {
        const pushResult = await this._pushToERP(config);
        result.recordsProcessed += pushResult.processed;
        result.recordsSuccess += pushResult.success;
        result.recordsFailed += pushResult.failed;
      }
      
      // Update sync log
      db.prepare(`
        UPDATE erp_sync_logs 
        SET status = 'completed', completed_at = CURRENT_TIMESTAMP,
            records_processed = ?, records_success = ?, records_failed = ?, records_skipped = ?
        WHERE id = ?
      `).run(
        result.recordsProcessed, result.recordsSuccess,
        result.recordsFailed, result.recordsSkipped, logId
      );
      
      // Update sync config last sync time
      db.prepare('UPDATE erp_sync_configs SET last_sync_at = CURRENT_TIMESTAMP WHERE id = ?')
        .run(syncConfigId);
      
    } catch (error) {
      db.prepare(`
        UPDATE erp_sync_logs 
        SET status = 'failed', completed_at = CURRENT_TIMESTAMP, error_message = ?
        WHERE id = ?
      `).run(error.message, logId);
      
      throw error;
    }
    
    return result;
  }
  
  /**
   * Pull data from ERP
   */
  static async _pullFromERP(config) {
    let processed = 0, success = 0, failed = 0;
    
    // Fetch data from ERP system
    const remoteRecords = await this._fetchRemoteRecords(config);
    
    for (const remoteRecord of remoteRecords) {
      processed++;
      
      try {
        // Transform remote data to local format
        const localData = this._transformRemoteToLocal(remoteRecord, config);
        
        // Check if record exists
        const existingSync = db.prepare(`
          SELECT * FROM erp_entity_sync_records
          WHERE remote_entity_id = ? AND sync_config_id = ?
        `).get(remoteRecord.id, config.id);
        
        if (existingSync) {
          // Update existing record
          this._updateLocalRecord(config.local_table, existingSync.local_entity_id, localData);
        } else {
          // Create new record
          const localId = this._createLocalRecord(config.local_table, localData);
          
          // Track sync
          this._createSyncRecord({
            connectionId: config.connection_id,
            syncConfigId: config.id,
            tenantId: config.tenant_id,
            localEntityType: config.entity_type,
            localEntityId: localId,
            remoteEntityType: config.remote_module,
            remoteEntityId: remoteRecord.id,
            syncDirection: 'pull'
          });
        }
        
        success++;
      } catch (error) {
        failed++;
        console.error(`Failed to sync record ${remoteRecord.id}:`, error.message);
      }
    }
    
    return { processed, success, failed };
  }
  
  /**
   * Push data to ERP
   */
  static async _pushToERP(config) {
    let processed = 0, success = 0, failed = 0;
    
    // Get local records that need sync
    const localRecords = this._getLocalRecordsForSync(config);
    
    for (const localRecord of localRecords) {
      processed++;
      
      try {
        // Transform local data to remote format
        const remoteData = this._transformLocalToRemote(localRecord, config);
        
        // Push to ERP
        const remoteId = await this._pushRecordToERP(config, remoteData);
        
        // Track sync
        this._updateOrCreateSyncRecord({
          connectionId: config.connection_id,
          syncConfigId: config.id,
          tenantId: config.tenant_id,
          localEntityType: config.entity_type,
          localEntityId: localRecord.id,
          remoteEntityType: config.remote_module,
          remoteEntityId: remoteId,
          syncDirection: 'push'
        });
        
        success++;
      } catch (error) {
        failed++;
        console.error(`Failed to push record ${localRecord.id}:`, error.message);
      }
    }
    
    return { processed, success, failed };
  }
  
  /**
   * Fetch records from remote ERP
   */
  static async _fetchRemoteRecords(config) {
    // Placeholder - in production this would make actual API calls
    // Based on config.erp_system: zoho, tally, quickbooks, sap
    return []; // Return array of records from ERP
  }
  
  /**
   * Push record to remote ERP
   */
  static async _pushRecordToERP(config, data) {
    // Placeholder - in production this would make actual API calls
    return crypto.randomBytes(16).toString('hex'); // Return remote ID
  }
  
  /**
   * Get local records needing sync
   */
  static _getLocalRecordsForSync(config) {
    // Simplified - get records modified since last sync
    const query = `
      SELECT * FROM ${config.local_table}
      WHERE tenant_id = ? AND updated_at > ?
      LIMIT 100
    `;
    
    const lastSync = config.last_sync_at || '1970-01-01T00:00:00';
    
    try {
      return db.prepare(query).all(config.tenant_id, lastSync);
    } catch (error) {
      return [];
    }
  }
  
  /**
   * Transform remote data to local format
   */
  static _transformRemoteToLocal(remoteRecord, config) {
    const mappings = JSON.parse(config.field_mappings || '[]');
    const localData = {};
    
    mappings.forEach(mapping => {
      if (mapping.remoteField && remoteRecord[mapping.remoteField] !== undefined) {
        localData[mapping.localField] = remoteRecord[mapping.remoteField];
      }
    });
    
    return localData;
  }
  
  /**
   * Transform local data to remote format
   */
  static _transformLocalToRemote(localRecord, config) {
    const mappings = JSON.parse(config.field_mappings || '[]');
    const remoteData = {};
    
    mappings.forEach(mapping => {
      if (mapping.localField && localRecord[mapping.localField] !== undefined) {
        remoteData[mapping.remoteField] = localRecord[mapping.localField];
      }
    });
    
    return remoteData;
  }
  
  /**
   * Create local record
   */
  static _createLocalRecord(tableName, data) {
    // Simplified insert - in production would handle different table schemas
    const id = crypto.randomBytes(16).toString('hex');
    return id;
  }
  
  /**
   * Update local record
   */
  static _updateLocalRecord(tableName, recordId, data) {
    // Simplified update
    return true;
  }
  
  /**
   * Create sync tracking record
   */
  static _createSyncRecord(data) {
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO erp_entity_sync_records (
        id, connection_id, sync_config_id, tenant_id,
        local_entity_type, local_entity_id, remote_entity_type, remote_entity_id,
        sync_status, last_sync_direction, last_sync_at, sync_count
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 1)
    `).run(
      id, data.connectionId, data.syncConfigId, data.tenantId,
      data.localEntityType, data.localEntityId, data.remoteEntityType, data.remoteEntityId,
      'synced', data.syncDirection
    );
    
    return id;
  }
  
  /**
   * Update or create sync record
   */
  static _updateOrCreateSyncRecord(data) {
    const existing = db.prepare(`
      SELECT id FROM erp_entity_sync_records
      WHERE local_entity_id = ? AND sync_config_id = ?
    `).get(data.localEntityId, data.syncConfigId);
    
    if (existing) {
      db.prepare(`
        UPDATE erp_entity_sync_records
        SET remote_entity_id = ?, sync_status = 'synced',
            last_sync_direction = ?, last_sync_at = CURRENT_TIMESTAMP,
            sync_count = sync_count + 1
        WHERE id = ?
      `).run(data.remoteEntityId, data.syncDirection, existing.id);
    } else {
      this._createSyncRecord(data);
    }
  }
  
  // ===== WEBHOOK HANDLING =====
  
  /**
   * Register webhook
   */
  static createWebhook(connectionId, tenantId, webhookData) {
    const {
      webhookUrl,
      webhookSecret,
      subscribedEvents = [],
      entityTypes = []
    } = webhookData;
    
    const id = crypto.randomBytes(16).toString('hex');
    const verificationToken = crypto.randomBytes(32).toString('hex');
    
    db.prepare(`
      INSERT INTO erp_webhooks (
        id, connection_id, tenant_id, webhook_url, webhook_secret,
        subscribed_events, entity_types, verification_token
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, connectionId, tenantId, webhookUrl, webhookSecret,
      JSON.stringify(subscribedEvents), JSON.stringify(entityTypes), verificationToken
    );
    
    return { id, webhookUrl, verificationToken };
  }
  
  /**
   * Process incoming webhook
   */
  static async processWebhook(webhookId, payload, headers) {
    const webhook = db.prepare('SELECT * FROM erp_webhooks WHERE id = ?').get(webhookId);
    if (!webhook) throw new Error('Webhook not found');
    
    // Create webhook event record
    const eventId = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO erp_webhook_events (
        id, webhook_id, connection_id, tenant_id, event_type, event_source,
        entity_type, entity_id, payload, headers, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')
    `).run(
      eventId, webhookId, webhook.connection_id, webhook.tenant_id,
      payload.event_type || 'unknown',
      payload.source || 'unknown',
      payload.entity_type || null,
      payload.entity_id || null,
      JSON.stringify(payload),
      JSON.stringify(headers)
    );
    
    // Process event asynchronously
    setImmediate(() => this._processWebhookEvent(eventId));
    
    return { eventId, status: 'received' };
  }
  
  /**
   * Process webhook event
   */
  static async _processWebhookEvent(eventId) {
    const event = db.prepare('SELECT * FROM erp_webhook_events WHERE id = ?').get(eventId);
    if (!event) return;
    
    try {
      db.prepare('UPDATE erp_webhook_events SET status = ? WHERE id = ?')
        .run('processing', eventId);
      
      const payload = JSON.parse(event.payload);
      
      // Handle based on event type
      let actionTaken = 'ignored';
      let localEntityId = null;
      
      if (payload.event_type === 'create' || payload.event_type === 'update') {
        // Trigger sync for this entity
        localEntityId = await this._syncWebhookEntity(event, payload);
        actionTaken = payload.event_type === 'create' ? 'created' : 'updated';
      }
      
      db.prepare(`
        UPDATE erp_webhook_events 
        SET status = 'processed', processed_at = CURRENT_TIMESTAMP,
            action_taken = ?, local_entity_id = ?
        WHERE id = ?
      `).run(actionTaken, localEntityId, eventId);
      
    } catch (error) {
      db.prepare(`
        UPDATE erp_webhook_events 
        SET status = 'failed', processed_at = CURRENT_TIMESTAMP, error_message = ?
        WHERE id = ?
      `).run(error.message, eventId);
    }
  }
  
  static async _syncWebhookEntity(event, payload) {
    // Find appropriate sync config
    const syncConfig = db.prepare(`
      SELECT * FROM erp_sync_configs
      WHERE connection_id = ? AND entity_type = ? AND is_active = 1
    `).get(event.connection_id, payload.entity_type);
    
    if (syncConfig) {
      // Trigger entity sync
      await this.syncEntity(syncConfig.id, {
        syncDirection: 'pull',
        syncType: 'webhook',
        triggeredBy: 'webhook',
        triggerSource: 'realtime'
      });
    }
    
    return null;
  }
}

module.exports = ERPIntegrationService;
