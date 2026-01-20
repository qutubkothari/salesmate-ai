-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: erp_sync_logs
CREATE TABLE IF NOT EXISTS erp_sync_logs (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  connection_id TEXT NOT NULL,
  sync_config_id TEXT,
  tenant_id TEXT NOT NULL,
  sync_type TEXT NOT NULL,
  sync_direction TEXT NOT NULL,
  entity_type TEXT,
  status TEXT NOT NULL,
  started_at TEXT DEFAULT CURRENT_TIMESTAMP,
  completed_at TEXT,
  records_processed INTEGER DEFAULT 0,
  records_success INTEGER DEFAULT 0,
  records_failed INTEGER DEFAULT 0,
  records_skipped INTEGER DEFAULT 0,
  error_message TEXT,
  error_details TEXT,
  sync_summary TEXT,
  triggered_by TEXT,
  trigger_source TEXT
);


-- Table: erp_transform_templates
CREATE TABLE IF NOT EXISTS erp_transform_templates (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  template_name TEXT NOT NULL,
  template_type TEXT NOT NULL,
  erp_system TEXT,
  entity_type TEXT,
  transform_function TEXT NOT NULL,
  is_active INTEGER DEFAULT 1,
  usage_count INTEGER DEFAULT 0,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: erp_webhook_events
CREATE TABLE IF NOT EXISTS erp_webhook_events (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  webhook_id TEXT NOT NULL,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  event_source TEXT NOT NULL,
  entity_type TEXT,
  entity_id TEXT,
  payload TEXT,
  headers TEXT,
  status TEXT DEFAULT 'pending',
  processed_at TEXT,
  error_message TEXT,
  action_taken TEXT,
  local_entity_id TEXT,
  received_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: erp_webhooks
CREATE TABLE IF NOT EXISTS erp_webhooks (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  webhook_url TEXT NOT NULL,
  webhook_secret TEXT,
  subscribed_events TEXT,
  entity_types TEXT,
  is_active INTEGER DEFAULT 1,
  last_received_at TEXT,
  verification_token TEXT,
  is_verified INTEGER DEFAULT 0,
  verified_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: field_activity_log
CREATE TABLE IF NOT EXISTS field_activity_log (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  activity_type TEXT NOT NULL,
  activity_data TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: follow_ups
CREATE TABLE IF NOT EXISTS follow_ups (
  id SERIAL PRIMARY KEY,
  customer_id TEXT NOT NULL,
  message TEXT NOT NULL,
  scheduled_date TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  scheduled_time TEXT
);


-- Table: forecast_snapshots
CREATE TABLE IF NOT EXISTS forecast_snapshots (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  forecast_period TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  created_by TEXT,
  total_pipeline_value NUMERIC DEFAULT 0,
  weighted_pipeline_value NUMERIC DEFAULT 0,
  expected_closures INTEGER DEFAULT 0,
  expected_revenue NUMERIC DEFAULT 0,
  stage_breakdown TEXT,
  confidence_level TEXT DEFAULT 'medium'
);


-- Table: generated_documents
CREATE TABLE IF NOT EXISTS generated_documents (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  template_id TEXT NOT NULL,
  document_number TEXT NOT NULL,
  document_type TEXT NOT NULL,
  document_title TEXT,
  entity_type TEXT,
  entity_id TEXT,
  generated_html TEXT NOT NULL,
  generated_pdf_path TEXT,
  generated_pdf_url TEXT,
  generation_status TEXT DEFAULT 'draft',
  file_size INTEGER,
  page_count INTEGER,
  merge_data TEXT,
  version INTEGER DEFAULT 1,
  parent_document_id TEXT,
  is_latest_version INTEGER DEFAULT 1,
  sent_at TEXT,
  sent_to TEXT,
  sent_method TEXT,
  total_amount NUMERIC,
  currency TEXT DEFAULT 'INR',
  due_date TEXT,
  payment_status TEXT,
  generated_by TEXT,
  generated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  finalized_at TEXT,
  finalized_by TEXT
);


-- Table: geo_pricing
CREATE TABLE IF NOT EXISTS geo_pricing (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  region_name TEXT NOT NULL,
  state TEXT,
  city TEXT,
  pincode TEXT,
  price_adjustment_type TEXT DEFAULT 'percentage',
  price_adjustment NUMERIC DEFAULT 0,
  shipping_charges NUMERIC DEFAULT 0,
  tax_rate NUMERIC DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: health_checks
CREATE TABLE IF NOT EXISTS health_checks (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  check_type TEXT NOT NULL,
  check_name TEXT NOT NULL,
  status TEXT NOT NULL,
  response_time_ms NUMERIC,
  metric_value NUMERIC,
  metric_unit TEXT,
  warning_threshold NUMERIC,
  critical_threshold NUMERIC,
  status_message TEXT,
  error_details TEXT,
  checked_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: inbound_messages
CREATE TABLE IF NOT EXISTS inbound_messages (
  id TEXT PRIMARY KEY,
  tenant_id TEXT,
  from_phone TEXT,
  body TEXT,
  received_at TEXT DEFAULT CURRENT_TIMESTAMP,
  message_id TEXT
);


-- Table: interactive_messages
CREATE TABLE IF NOT EXISTS interactive_messages (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER,
  customer_phone TEXT,
  message_type TEXT,
  payload TEXT,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  type TEXT DEFAULT 'buttons',
  body TEXT,
  options TEXT,
  recipient_count INTEGER DEFAULT 0,
  response_count INTEGER DEFAULT 0,
  status TEXT DEFAULT 'pending',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: lead_events
CREATE TABLE IF NOT EXISTS lead_events (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  lead_id TEXT,
  conversation_id TEXT,
  triggered_by TEXT,
  payload TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: lead_pipeline_items
CREATE TABLE IF NOT EXISTS lead_pipeline_items (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  conversation_id TEXT NOT NULL,
  stage_id TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: lead_pipeline_stages
CREATE TABLE IF NOT EXISTS lead_pipeline_stages (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  position INTEGER DEFAULT 0,
  is_won INTEGER DEFAULT 0,
  is_lost INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: load_balancer_metrics
CREATE TABLE IF NOT EXISTS load_balancer_metrics (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  server_id TEXT NOT NULL,
  server_ip TEXT,
  active_requests INTEGER DEFAULT 0,
  requests_per_second NUMERIC,
  cpu_usage_percent NUMERIC,
  memory_usage_mb NUMERIC,
  is_healthy INTEGER DEFAULT 1,
  last_health_check TEXT DEFAULT CURRENT_TIMESTAMP,
  recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: message_templates
CREATE TABLE IF NOT EXISTS message_templates (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  template_text TEXT NOT NULL,
  category TEXT,
  variables TEXT DEFAULT '[]',
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  usage_count INTEGER DEFAULT 0,
  message_type TEXT DEFAULT 'text',
  image_url TEXT,
  interactive_payload TEXT
);


-- Table: messages
CREATE TABLE IF NOT EXISTS messages (
  id TEXT PRIMARY KEY,
  tenant_id TEXT,
  conversation_id TEXT,
  sender TEXT,
  message_body TEXT,
  message_type TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  whatsapp_message_id TEXT
);


-- Table: mobile_analytics_events
CREATE TABLE IF NOT EXISTS mobile_analytics_events (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  event_name TEXT NOT NULL,
  event_category TEXT,
  event_properties TEXT,
  screen_name TEXT,
  network_type TEXT,
  is_offline INTEGER DEFAULT 0,
  event_duration_ms INTEGER,
  session_id TEXT,
  timestamp TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: mobile_devices
CREATE TABLE IF NOT EXISTS mobile_devices (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  device_uuid TEXT NOT NULL,
  device_name TEXT,
  device_model TEXT,
  device_platform TEXT NOT NULL,
  platform_version TEXT,
  app_version TEXT,
  app_build_number TEXT,
  push_token TEXT,
  push_enabled INTEGER DEFAULT 1,
  last_location TEXT,
  timezone TEXT,
  network_type TEXT,
  supports_offline INTEGER DEFAULT 1,
  supports_background_sync INTEGER DEFAULT 1,
  storage_available_mb INTEGER,
  is_active INTEGER DEFAULT 1,
  last_sync_at TEXT,
  last_online_at TEXT,
  registered_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

