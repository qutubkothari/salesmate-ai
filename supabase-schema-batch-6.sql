-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: mobile_feature_flags
CREATE TABLE IF NOT EXISTS mobile_feature_flags (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  feature_key TEXT NOT NULL,
  feature_name TEXT NOT NULL,
  feature_description TEXT,
  is_enabled INTEGER DEFAULT 0,
  platform TEXT,
  min_app_version TEXT,
  rollout_percentage INTEGER DEFAULT 0,
  target_user_segments TEXT,
  feature_config TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  expires_at TEXT
);


-- Table: mobile_sessions
CREATE TABLE IF NOT EXISTS mobile_sessions (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  session_start TEXT DEFAULT CURRENT_TIMESTAMP,
  session_end TEXT,
  session_duration INTEGER,
  network_type TEXT,
  battery_level INTEGER,
  app_version TEXT,
  is_background INTEGER DEFAULT 0,
  screens_viewed TEXT,
  actions_performed TEXT,
  data_synced_kb INTEGER DEFAULT 0,
  data_downloaded_kb INTEGER DEFAULT 0,
  data_uploaded_kb INTEGER DEFAULT 0,
  crash_occurred INTEGER DEFAULT 0,
  crash_log TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: notes
CREATE TABLE IF NOT EXISTS notes (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  content TEXT NOT NULL,
  lead_id INTEGER,
  conversation_id INTEGER,
  task_id INTEGER,
  created_by TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: notification_queue
CREATE TABLE IF NOT EXISTS notification_queue (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  notification_type TEXT NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  data TEXT,
  priority TEXT DEFAULT 'normal',
  scheduled_for TEXT,
  sent_at TEXT,
  delivered_at TEXT,
  read_at TEXT,
  status TEXT DEFAULT 'pending',
  error TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: notifications
CREATE TABLE IF NOT EXISTS notifications (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  title TEXT,
  body TEXT,
  type TEXT,
  is_read INTEGER DEFAULT 0,
  read_at TEXT,
  metadata TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: offline_cache_manifest
CREATE TABLE IF NOT EXISTS offline_cache_manifest (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  cached_at TEXT DEFAULT CURRENT_TIMESTAMP,
  cache_version TEXT,
  cache_size_kb INTEGER,
  expires_at TEXT,
  is_stale INTEGER DEFAULT 0,
  last_accessed_at TEXT,
  access_count INTEGER DEFAULT 0,
  cache_priority TEXT DEFAULT 'normal',
  auto_refresh INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: offline_queue
CREATE TABLE IF NOT EXISTS offline_queue (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  device_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT,
  action TEXT NOT NULL,
  data TEXT NOT NULL,
  client_timestamp TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  synced INTEGER DEFAULT 0,
  synced_at TEXT,
  sync_attempts INTEGER DEFAULT 0,
  error TEXT
);


-- Table: offline_sync_queue
CREATE TABLE IF NOT EXISTS offline_sync_queue (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  operation_type TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT,
  operation_data TEXT NOT NULL,
  sync_status TEXT DEFAULT 'pending',
  sync_priority INTEGER DEFAULT 5,
  conflict_detected INTEGER DEFAULT 0,
  conflict_reason TEXT,
  server_version TEXT,
  retry_count INTEGER DEFAULT 0,
  max_retries INTEGER DEFAULT 3,
  last_retry_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  synced_at TEXT
);


-- Table: onboarding_messages
CREATE TABLE IF NOT EXISTS onboarding_messages (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  step_number INTEGER NOT NULL,
  message TEXT NOT NULL,
  scheduled_date TEXT NOT NULL,
  sent_at TEXT,
  status TEXT DEFAULT 'pending',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  delay_hours INTEGER DEFAULT 0
);


-- Table: order_items
CREATE TABLE IF NOT EXISTS order_items (
  id TEXT PRIMARY KEY,
  order_id TEXT NOT NULL,
  product_id TEXT,
  product_name TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC NOT NULL,
  total_price NUMERIC NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: orders_new
CREATE TABLE IF NOT EXISTS orders_new (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  salesman_id TEXT,
  visit_id TEXT,
  order_number TEXT,
  status TEXT DEFAULT 'draft',
  product_list TEXT,
  quantities TEXT,
  notes TEXT,
  estimated_amount NUMERIC DEFAULT 0,
  actual_amount NUMERIC DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: performance_alerts
CREATE TABLE IF NOT EXISTS performance_alerts (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  alert_type TEXT NOT NULL,
  severity TEXT NOT NULL,
  metric_name TEXT,
  metric_value NUMERIC,
  threshold_value NUMERIC,
  alert_title TEXT NOT NULL,
  alert_message TEXT NOT NULL,
  status TEXT DEFAULT 'active',
  acknowledged_by TEXT,
  acknowledged_at TEXT,
  resolved_at TEXT,
  resolution_notes TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: permission_audit_log
CREATE TABLE IF NOT EXISTS permission_audit_log (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  action TEXT NOT NULL,
  target_user_id TEXT,
  role_id TEXT,
  permission_id TEXT,
  resource_type TEXT,
  resource_id TEXT,
  details TEXT,
  ip_address TEXT,
  user_agent TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: permissions
CREATE TABLE IF NOT EXISTS permissions (
  id TEXT PRIMARY KEY,
  permission_code TEXT NOT NULL,
  permission_name TEXT NOT NULL,
  resource TEXT NOT NULL,
  action TEXT NOT NULL,
  description TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: pipeline_stages
CREATE TABLE IF NOT EXISTS pipeline_stages (
  id TEXT PRIMARY KEY,
  pipeline_id TEXT NOT NULL,
  stage_name TEXT NOT NULL,
  stage_order INTEGER NOT NULL,
  stage_type TEXT DEFAULT 'open',
  probability INTEGER DEFAULT 50,
  expected_duration_days INTEGER,
  color_code TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: pipelines
CREATE TABLE IF NOT EXISTS pipelines (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  pipeline_name TEXT NOT NULL,
  description TEXT,
  is_default INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: plants
CREATE TABLE IF NOT EXISTS plants (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  location TEXT,
  city TEXT,
  state TEXT,
  country TEXT,
  timezone TEXT DEFAULT 'UTC',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: price_history
CREATE TABLE IF NOT EXISTS price_history (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  old_price NUMERIC,
  new_price NUMERIC,
  changed_by TEXT,
  reason TEXT,
  changed_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: price_lists
CREATE TABLE IF NOT EXISTS price_lists (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  currency TEXT DEFAULT 'INR',
  effective_from TEXT,
  effective_to TEXT,
  is_default INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: pricing_tiers
CREATE TABLE IF NOT EXISTS pricing_tiers (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  tier_code TEXT NOT NULL,
  tier_name TEXT NOT NULL,
  description TEXT,
  discount_percentage NUMERIC DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

