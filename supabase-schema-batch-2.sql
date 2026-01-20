-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: analytics_kpis
CREATE TABLE IF NOT EXISTS analytics_kpis (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  kpi_name TEXT NOT NULL,
  kpi_category TEXT NOT NULL,
  calculation_type TEXT NOT NULL,
  calculation_config TEXT,
  target_value NUMERIC,
  target_period TEXT,
  display_format TEXT DEFAULT 'number',
  currency_symbol TEXT DEFAULT '₹',
  decimal_places INTEGER DEFAULT 0,
  critical_threshold NUMERIC,
  warning_threshold NUMERIC,
  good_threshold NUMERIC,
  description TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: analytics_report_runs
CREATE TABLE IF NOT EXISTS analytics_report_runs (
  id TEXT PRIMARY KEY,
  report_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  triggered_by TEXT,
  triggered_by_user TEXT,
  status TEXT DEFAULT 'pending',
  rows_generated INTEGER DEFAULT 0,
  execution_time_ms INTEGER,
  output_format TEXT,
  output_path TEXT,
  output_size_bytes INTEGER,
  error_message TEXT,
  started_at TEXT,
  completed_at TEXT
);


-- Table: analytics_reports
CREATE TABLE IF NOT EXISTS analytics_reports (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  report_name TEXT NOT NULL,
  report_type TEXT NOT NULL,
  data_sources TEXT,
  filters TEXT,
  columns TEXT,
  grouping TEXT,
  sorting TEXT,
  aggregations TEXT,
  display_config TEXT,
  owner_id TEXT,
  is_public INTEGER DEFAULT 0,
  shared_with TEXT,
  is_scheduled INTEGER DEFAULT 0,
  schedule_frequency TEXT,
  schedule_time TEXT,
  schedule_recipients TEXT,
  description TEXT,
  is_active INTEGER DEFAULT 1,
  last_generated_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: analytics_saved_filters
CREATE TABLE IF NOT EXISTS analytics_saved_filters (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  filter_name TEXT NOT NULL,
  filter_config TEXT NOT NULL,
  applies_to TEXT,
  owner_id TEXT,
  is_public INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: analytics_widgets
CREATE TABLE IF NOT EXISTS analytics_widgets (
  id TEXT PRIMARY KEY,
  dashboard_id TEXT NOT NULL,
  widget_name TEXT NOT NULL,
  widget_type TEXT NOT NULL,
  data_source TEXT NOT NULL,
  query_config TEXT,
  chart_config TEXT,
  position_x INTEGER DEFAULT 0,
  position_y INTEGER DEFAULT 0,
  width INTEGER DEFAULT 4,
  height INTEGER DEFAULT 3,
  auto_refresh INTEGER DEFAULT 1,
  cache_duration INTEGER DEFAULT 60,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: api_keys
CREATE TABLE IF NOT EXISTS api_keys (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT,
  key_hash TEXT NOT NULL,
  key_prefix TEXT,
  last_used_at TEXT,
  revoked_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: api_metrics
CREATE TABLE IF NOT EXISTS api_metrics (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT,
  endpoint TEXT NOT NULL,
  http_method TEXT NOT NULL,
  response_time_ms NUMERIC NOT NULL,
  status_code INTEGER NOT NULL,
  request_size_bytes INTEGER,
  response_size_bytes INTEGER,
  user_id TEXT,
  ip_address TEXT,
  user_agent TEXT,
  has_error INTEGER DEFAULT 0,
  error_type TEXT,
  error_message TEXT,
  timestamp TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: app_updates
CREATE TABLE IF NOT EXISTS app_updates (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  version_number TEXT NOT NULL,
  build_number TEXT NOT NULL,
  platform TEXT NOT NULL,
  update_type TEXT NOT NULL,
  is_mandatory INTEGER DEFAULT 0,
  release_title TEXT,
  release_notes TEXT,
  download_url TEXT,
  file_size_mb INTEGER,
  rollout_percentage INTEGER DEFAULT 100,
  target_segments TEXT,
  release_status TEXT DEFAULT 'draft',
  released_at TEXT,
  deprecated_at TEXT,
  min_supported_version TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: assignment_config
CREATE TABLE IF NOT EXISTS assignment_config (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  strategy TEXT DEFAULT 'ROUND_ROBIN',
  auto_assign BOOLEAN DEFAULT TRUE,
  consider_capacity BOOLEAN DEFAULT TRUE,
  consider_score BOOLEAN DEFAULT FALSE,
  consider_skills BOOLEAN DEFAULT FALSE,
  custom_rules TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: audit_logs
CREATE TABLE IF NOT EXISTS audit_logs (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  actor_type TEXT,
  actor_id TEXT,
  actor_name TEXT,
  action TEXT NOT NULL,
  entity_type TEXT,
  entity_id TEXT,
  summary TEXT,
  metadata TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: autoscaling_events
CREATE TABLE IF NOT EXISTS autoscaling_events (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  trigger_type TEXT NOT NULL,
  trigger_metric TEXT,
  trigger_value NUMERIC,
  trigger_threshold NUMERIC,
  action TEXT NOT NULL,
  instances_before INTEGER,
  instances_after INTEGER,
  status TEXT DEFAULT 'pending',
  result_message TEXT,
  triggered_at TEXT DEFAULT CURRENT_TIMESTAMP,
  completed_at TEXT
);


-- Table: background_sync_jobs
CREATE TABLE IF NOT EXISTS background_sync_jobs (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  job_type TEXT NOT NULL,
  job_status TEXT DEFAULT 'pending',
  scheduled_for TEXT,
  started_at TEXT,
  completed_at TEXT,
  total_items INTEGER DEFAULT 0,
  processed_items INTEGER DEFAULT 0,
  failed_items INTEGER DEFAULT 0,
  sync_result TEXT,
  error_message TEXT,
  requires_wifi INTEGER DEFAULT 0,
  requires_charging INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: broadcast_batch_log
CREATE TABLE IF NOT EXISTS broadcast_batch_log (
  id TEXT PRIMARY KEY,
  process_id TEXT,
  started_at TEXT,
  completed_at TEXT,
  status TEXT,
  batch_size INTEGER DEFAULT 0,
  messages_sent INTEGER DEFAULT 0,
  messages_failed INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: broadcast_campaign_recipients
CREATE TABLE IF NOT EXISTS broadcast_campaign_recipients (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT,
  campaign_id TEXT NOT NULL,
  phone TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  sent_at TEXT,
  error_message TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: broadcast_campaigns
CREATE TABLE IF NOT EXISTS broadcast_campaigns (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  campaign_name TEXT NOT NULL,
  campaign_type TEXT NOT NULL,
  campaign_status TEXT DEFAULT 'draft',
  target_segment TEXT,
  target_criteria TEXT,
  target_count INTEGER,
  message_template TEXT NOT NULL,
  message_variables TEXT,
  media_url TEXT,
  media_type TEXT,
  scheduled_start TEXT,
  scheduled_end TEXT,
  send_interval INTEGER DEFAULT 1000,
  sent_count INTEGER DEFAULT 0,
  delivered_count INTEGER DEFAULT 0,
  read_count INTEGER DEFAULT 0,
  replied_count INTEGER DEFAULT 0,
  failed_count INTEGER DEFAULT 0,
  ai_optimization_enabled INTEGER DEFAULT 0,
  ai_send_time_optimization INTEGER DEFAULT 0,
  ai_content_variants INTEGER DEFAULT 0,
  click_through_rate NUMERIC,
  conversion_rate NUMERIC,
  revenue_generated NUMERIC,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: broadcast_processing_lock
CREATE TABLE IF NOT EXISTS broadcast_processing_lock (
  id SERIAL PRIMARY KEY,
  is_processing INTEGER DEFAULT 0,
  process_id TEXT,
  started_at TEXT,
  last_heartbeat TEXT
);


-- Table: broadcast_queue
CREATE TABLE IF NOT EXISTS broadcast_queue (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  recipient_phone TEXT NOT NULL,
  message_text TEXT NOT NULL,
  media_url TEXT,
  scheduled_at TEXT DEFAULT CURRENT_TIMESTAMP,
  status TEXT DEFAULT 'pending',
  sent_at TEXT,
  error_message TEXT,
  retry_count INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: broadcast_recipients
CREATE TABLE IF NOT EXISTS broadcast_recipients (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  name TEXT,
  tags TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  campaign_id TEXT,
  phone TEXT,
  status TEXT DEFAULT 'pending',
  sent_at TEXT,
  error_message TEXT
);


-- Table: bulk_schedules
CREATE TABLE IF NOT EXISTS bulk_schedules (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  to_phone_number TEXT,
  phone_number TEXT,
  campaign_id TEXT,
  campaign_name TEXT,
  message_text TEXT,
  message_body TEXT,
  image_url TEXT,
  media_url TEXT,
  scheduled_at TEXT,
  status TEXT DEFAULT 'pending',
  retry_count INTEGER DEFAULT 0,
  sequence_number INTEGER DEFAULT 0,
  delivery_status TEXT DEFAULT 'pending',
  error_message TEXT,
  processed_at TEXT,
  delivered_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  parent_campaign_id TEXT,
  day_number INTEGER DEFAULT 1,
  total_days INTEGER DEFAULT 1,
  auto_scheduled INTEGER DEFAULT 0,
  greeting_template TEXT,
  random_delay_ms INTEGER DEFAULT 0,
  humanized INTEGER DEFAULT 0,
  name TEXT
);


-- Table: cache_entries
CREATE TABLE IF NOT EXISTS cache_entries (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  cache_key TEXT NOT NULL,
  cache_value TEXT NOT NULL,
  cache_type TEXT NOT NULL,
  ttl_seconds INTEGER DEFAULT 3600,
  expires_at TEXT NOT NULL,
  size_bytes INTEGER,
  hit_count INTEGER DEFAULT 0,
  last_accessed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  cache_priority TEXT DEFAULT 'normal',
  can_evict INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

