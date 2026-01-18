-- ERP Integrations Schema
-- Supports Zoho, Tally, QuickBooks, SAP integrations
-- Handles connections, sync configurations, field mappings, and data sync

-- ERP Connection Configurations
CREATE TABLE IF NOT EXISTS erp_connections (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  erp_system TEXT NOT NULL, -- zoho, tally, quickbooks, sap, custom
  connection_name TEXT NOT NULL,
  
  -- Authentication
  auth_type TEXT NOT NULL, -- oauth2, api_key, username_password, certificate
  auth_config TEXT, -- JSON: credentials, tokens, refresh tokens
  oauth_tokens TEXT, -- JSON: access_token, refresh_token, expires_at
  
  -- Connection details
  base_url TEXT,
  api_version TEXT,
  organization_id TEXT,
  company_id TEXT,
  
  -- Status
  status TEXT DEFAULT 'active', -- active, inactive, error, expired
  last_connected_at TEXT,
  last_sync_at TEXT,
  last_error TEXT,
  
  -- Settings
  sync_enabled INTEGER DEFAULT 1,
  auto_sync_interval INTEGER DEFAULT 3600, -- seconds
  sync_direction TEXT DEFAULT 'bidirectional', -- push, pull, bidirectional
  
  -- Metadata
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Sync Configuration per entity type
CREATE TABLE IF NOT EXISTS erp_sync_configs (
  id TEXT PRIMARY KEY,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Entity mapping
  entity_type TEXT NOT NULL, -- customer, product, order, invoice, payment, deal, contact
  local_table TEXT NOT NULL, -- customers, products, orders, etc.
  remote_module TEXT NOT NULL, -- Contacts, Products, Sales Orders, etc.
  
  -- Sync settings
  sync_direction TEXT DEFAULT 'bidirectional', -- push, pull, bidirectional
  auto_sync INTEGER DEFAULT 1,
  sync_frequency INTEGER DEFAULT 3600, -- seconds
  
  -- Conflict resolution
  conflict_resolution TEXT DEFAULT 'remote_wins', -- local_wins, remote_wins, manual, newest_wins
  
  -- Filters
  sync_filter TEXT, -- JSON: conditions for selective sync
  field_mappings TEXT, -- JSON: local_field -> remote_field mappings
  
  -- Transformation
  transform_config TEXT, -- JSON: data transformation rules
  
  -- Status
  is_active INTEGER DEFAULT 1,
  last_sync_at TEXT,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (connection_id) REFERENCES erp_connections(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Field Mappings (detailed)
CREATE TABLE IF NOT EXISTS erp_field_mappings (
  id TEXT PRIMARY KEY,
  sync_config_id TEXT NOT NULL,
  
  -- Field details
  local_field TEXT NOT NULL,
  remote_field TEXT NOT NULL,
  
  -- Mapping config
  field_type TEXT, -- text, number, date, boolean, lookup, picklist
  is_required INTEGER DEFAULT 0,
  is_readonly INTEGER DEFAULT 0,
  
  -- Transformation
  transform_function TEXT, -- JSON: transformation logic
  default_value TEXT,
  value_mappings TEXT, -- JSON: for picklist/enum conversions
  
  -- Validation
  validation_rules TEXT, -- JSON: validation constraints
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (sync_config_id) REFERENCES erp_sync_configs(id)
);

-- Sync History/Logs
CREATE TABLE IF NOT EXISTS erp_sync_logs (
  id TEXT PRIMARY KEY,
  connection_id TEXT NOT NULL,
  sync_config_id TEXT,
  tenant_id TEXT NOT NULL,
  
  -- Sync details
  sync_type TEXT NOT NULL, -- full, incremental, manual, webhook
  sync_direction TEXT NOT NULL, -- push, pull
  entity_type TEXT,
  
  -- Execution
  status TEXT NOT NULL, -- pending, running, completed, failed, partial
  started_at TEXT DEFAULT CURRENT_TIMESTAMP,
  completed_at TEXT,
  
  -- Results
  records_processed INTEGER DEFAULT 0,
  records_success INTEGER DEFAULT 0,
  records_failed INTEGER DEFAULT 0,
  records_skipped INTEGER DEFAULT 0,
  
  -- Details
  error_message TEXT,
  error_details TEXT, -- JSON: detailed error info
  sync_summary TEXT, -- JSON: summary of changes
  
  -- Metadata
  triggered_by TEXT, -- user_id, system, webhook
  trigger_source TEXT, -- manual, scheduled, webhook, realtime
  
  FOREIGN KEY (connection_id) REFERENCES erp_connections(id),
  FOREIGN KEY (sync_config_id) REFERENCES erp_sync_configs(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Entity Sync Records (track individual record sync)
CREATE TABLE IF NOT EXISTS erp_entity_sync_records (
  id TEXT PRIMARY KEY,
  connection_id TEXT NOT NULL,
  sync_config_id TEXT NOT NULL,
  sync_log_id TEXT,
  tenant_id TEXT NOT NULL,
  
  -- Record identification
  local_entity_type TEXT NOT NULL,
  local_entity_id TEXT NOT NULL,
  remote_entity_type TEXT NOT NULL,
  remote_entity_id TEXT,
  
  -- Sync status
  sync_status TEXT DEFAULT 'pending', -- pending, synced, failed, conflict
  last_sync_direction TEXT, -- push, pull
  last_sync_at TEXT,
  
  -- Data tracking
  local_version TEXT, -- JSON hash or version number
  remote_version TEXT,
  local_updated_at TEXT,
  remote_updated_at TEXT,
  
  -- Conflict handling
  has_conflict INTEGER DEFAULT 0,
  conflict_details TEXT, -- JSON: conflict information
  conflict_resolved_at TEXT,
  
  -- Metadata
  first_synced_at TEXT DEFAULT CURRENT_TIMESTAMP,
  sync_count INTEGER DEFAULT 0,
  last_error TEXT,
  
  FOREIGN KEY (connection_id) REFERENCES erp_connections(id),
  FOREIGN KEY (sync_config_id) REFERENCES erp_sync_configs(id),
  FOREIGN KEY (sync_log_id) REFERENCES erp_sync_logs(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Webhook Configurations
CREATE TABLE IF NOT EXISTS erp_webhooks (
  id TEXT PRIMARY KEY,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Webhook details
  webhook_url TEXT NOT NULL,
  webhook_secret TEXT,
  
  -- Events
  subscribed_events TEXT, -- JSON: array of event types
  entity_types TEXT, -- JSON: array of entity types to monitor
  
  -- Status
  is_active INTEGER DEFAULT 1,
  last_received_at TEXT,
  
  -- Verification
  verification_token TEXT,
  is_verified INTEGER DEFAULT 0,
  verified_at TEXT,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (connection_id) REFERENCES erp_connections(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Webhook Events (incoming webhooks)
CREATE TABLE IF NOT EXISTS erp_webhook_events (
  id TEXT PRIMARY KEY,
  webhook_id TEXT NOT NULL,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Event details
  event_type TEXT NOT NULL,
  event_source TEXT NOT NULL, -- zoho, tally, quickbooks, sap
  entity_type TEXT,
  entity_id TEXT,
  
  -- Payload
  payload TEXT, -- JSON: full webhook payload
  headers TEXT, -- JSON: request headers
  
  -- Processing
  status TEXT DEFAULT 'pending', -- pending, processing, processed, failed, ignored
  processed_at TEXT,
  error_message TEXT,
  
  -- Result
  action_taken TEXT, -- created, updated, deleted, ignored
  local_entity_id TEXT,
  
  received_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (webhook_id) REFERENCES erp_webhooks(id),
  FOREIGN KEY (connection_id) REFERENCES erp_connections(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Data Transformation Templates
CREATE TABLE IF NOT EXISTS erp_transform_templates (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  
  -- Template details
  template_name TEXT NOT NULL,
  template_type TEXT NOT NULL, -- field, record, batch
  erp_system TEXT, -- applicable ERP system or 'all'
  entity_type TEXT,
  
  -- Transformation logic
  transform_function TEXT NOT NULL, -- JSON: transformation rules
  
  -- Usage
  is_active INTEGER DEFAULT 1,
  usage_count INTEGER DEFAULT 0,
  
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- ERP API Rate Limits (track and manage rate limits)
CREATE TABLE IF NOT EXISTS erp_rate_limits (
  id TEXT PRIMARY KEY,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Rate limit config
  limit_type TEXT NOT NULL, -- per_minute, per_hour, per_day, concurrent
  max_requests INTEGER NOT NULL,
  
  -- Current usage
  current_count INTEGER DEFAULT 0,
  window_start TEXT,
  window_end TEXT,
  
  -- Status
  is_throttled INTEGER DEFAULT 0,
  throttle_until TEXT,
  
  last_reset_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (connection_id) REFERENCES erp_connections(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_erp_connections_tenant ON erp_connections(tenant_id, erp_system);
CREATE INDEX IF NOT EXISTS idx_erp_connections_status ON erp_connections(status, sync_enabled);
CREATE INDEX IF NOT EXISTS idx_erp_sync_configs_connection ON erp_sync_configs(connection_id, entity_type);
CREATE INDEX IF NOT EXISTS idx_erp_sync_configs_active ON erp_sync_configs(is_active, auto_sync);
CREATE INDEX IF NOT EXISTS idx_erp_field_mappings_config ON erp_field_mappings(sync_config_id);
CREATE INDEX IF NOT EXISTS idx_erp_sync_logs_connection ON erp_sync_logs(connection_id, started_at DESC);
CREATE INDEX IF NOT EXISTS idx_erp_sync_logs_status ON erp_sync_logs(status, sync_type);
CREATE INDEX IF NOT EXISTS idx_erp_entity_sync_local ON erp_entity_sync_records(local_entity_type, local_entity_id);
CREATE INDEX IF NOT EXISTS idx_erp_entity_sync_remote ON erp_entity_sync_records(remote_entity_type, remote_entity_id);
CREATE INDEX IF NOT EXISTS idx_erp_entity_sync_status ON erp_entity_sync_records(sync_status, has_conflict);
CREATE INDEX IF NOT EXISTS idx_erp_webhooks_connection ON erp_webhooks(connection_id, is_active);
CREATE INDEX IF NOT EXISTS idx_erp_webhook_events_status ON erp_webhook_events(status, received_at);
CREATE INDEX IF NOT EXISTS idx_erp_webhook_events_entity ON erp_webhook_events(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_erp_transform_templates_tenant ON erp_transform_templates(tenant_id, erp_system);
CREATE INDEX IF NOT EXISTS idx_erp_rate_limits_connection ON erp_rate_limits(connection_id, limit_type);
