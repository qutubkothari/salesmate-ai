-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: salesman_targets
CREATE TABLE IF NOT EXISTS salesman_targets (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  plant_id TEXT,
  period TEXT NOT NULL,
  target_visits INTEGER DEFAULT 0,
  target_orders INTEGER DEFAULT 0,
  target_revenue NUMERIC DEFAULT 0.0,
  achieved_visits INTEGER DEFAULT 0,
  achieved_orders INTEGER DEFAULT 0,
  achieved_revenue NUMERIC DEFAULT 0.0,
  target_new_customers INTEGER DEFAULT 0,
  achieved_new_customers INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: salesmen
CREATE TABLE IF NOT EXISTS salesmen (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  user_id TEXT,
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  plant_id TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  current_latitude NUMERIC,
  current_longitude NUMERIC,
  last_location_update TIMESTAMP,
  assigned_customers TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: scheduled_followups
CREATE TABLE IF NOT EXISTS scheduled_followups (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  end_user_phone TEXT NOT NULL,
  scheduled_time TEXT NOT NULL,
  description TEXT,
  original_request TEXT,
  conversation_context TEXT,
  status TEXT DEFAULT 'scheduled',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  completed_at TEXT,
  error_message TEXT,
  delivery_method TEXT,
  whatsapp_message_id TEXT
);


-- Table: sla_rules
CREATE TABLE IF NOT EXISTS sla_rules (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  trigger_condition TEXT NOT NULL,
  response_time_minutes INTEGER NOT NULL,
  escalation_time_minutes INTEGER,
  heat_level TEXT,
  channel TEXT,
  notify_roles TEXT,
  auto_reassign BOOLEAN DEFAULT FALSE,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: sla_violations
CREATE TABLE IF NOT EXISTS sla_violations (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  rule_id INTEGER NOT NULL,
  conversation_id INTEGER,
  lead_id INTEGER,
  triggered_at TIMESTAMP NOT NULL,
  due_at TIMESTAMP NOT NULL,
  responded_at TIMESTAMP,
  breach_duration_minutes INTEGER,
  escalated BOOLEAN DEFAULT FALSE,
  escalated_at TIMESTAMP,
  notifications_sent INTEGER DEFAULT 0,
  resolved BOOLEAN DEFAULT FALSE,
  resolved_at TIMESTAMP,
  resolution_notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: smart_reply_templates
CREATE TABLE IF NOT EXISTS smart_reply_templates (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  template_name TEXT NOT NULL,
  template_category TEXT NOT NULL,
  intent_triggers TEXT,
  keyword_triggers TEXT,
  sentiment_triggers TEXT,
  context_triggers TEXT,
  reply_text TEXT NOT NULL,
  reply_variants TEXT,
  supports_variables INTEGER DEFAULT 1,
  variable_schema TEXT,
  language TEXT DEFAULT 'en',
  priority INTEGER DEFAULT 50,
  is_active INTEGER DEFAULT 1,
  usage_count INTEGER DEFAULT 0,
  success_rate NUMERIC,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: success_definitions
CREATE TABLE IF NOT EXISTS success_definitions (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  weight INTEGER DEFAULT 10,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: success_events
CREATE TABLE IF NOT EXISTS success_events (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  definition_id INTEGER NOT NULL,
  lead_id INTEGER,
  conversation_id INTEGER,
  salesman_id INTEGER,
  salesman_email TEXT,
  notes TEXT,
  value NUMERIC,
  event_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  metadata TEXT
);


-- Table: sync_checkpoints
CREATE TABLE IF NOT EXISTS sync_checkpoints (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  last_sync_timestamp TEXT NOT NULL,
  last_sync_record_id TEXT,
  sync_direction TEXT NOT NULL,
  records_synced INTEGER DEFAULT 0,
  sync_duration_ms INTEGER,
  sync_status TEXT DEFAULT 'success',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: tasks
CREATE TABLE IF NOT EXISTS tasks (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  lead_id INTEGER,
  conversation_id INTEGER,
  assigned_to TEXT,
  assigned_by TEXT,
  priority TEXT DEFAULT 'MEDIUM',
  status TEXT DEFAULT 'PENDING',
  due_date TIMESTAMP,
  reminder_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP,
  cancelled_at TIMESTAMP,
  metadata TEXT
);


-- Table: team_hierarchy
CREATE TABLE IF NOT EXISTS team_hierarchy (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  manager_id TEXT NOT NULL,
  member_id TEXT NOT NULL,
  relationship_type TEXT DEFAULT 'direct_report',
  effective_from TEXT DEFAULT CURRENT_TIMESTAMP,
  effective_to TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: tenant_bots
CREATE TABLE IF NOT EXISTS tenant_bots (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  provider TEXT,
  config TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: tenant_documents
CREATE TABLE IF NOT EXISTS tenant_documents (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  filename TEXT,
  original_name TEXT,
  mime_type TEXT,
  size_bytes INTEGER,
  extracted_text TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: tenants
CREATE TABLE IF NOT EXISTS tenants (
  id TEXT PRIMARY KEY,
  business_name TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  owner_whatsapp_number TEXT,
  email TEXT,
  subscription_tier TEXT DEFAULT 'standard',
  subscription_status TEXT DEFAULT 'trial',
  trial_ends_at TEXT,
  subscription_start_date TEXT,
  subscription_end_date TEXT,
  bot_language TEXT DEFAULT 'English',
  is_active INTEGER DEFAULT 1,
  status TEXT DEFAULT 'active',
  password TEXT,
  daily_message_limit INTEGER DEFAULT 100,
  messages_sent_today INTEGER DEFAULT 0,
  last_message_reset_date TEXT DEFAULT CURRENT_DATE,
  business_address TEXT,
  business_website TEXT,
  industry_type TEXT,
  referral_code TEXT,
  bot_phone_number TEXT,
  currency_symbol TEXT DEFAULT '₹',
  default_packaging_unit TEXT DEFAULT 'piece',
  daily_summary_enabled INTEGER DEFAULT 1,
  abandoned_cart_delay_hours INTEGER DEFAULT 2,
  abandoned_cart_message TEXT,
  admin_phones TEXT,
  openai_api_key TEXT,
  openai_project TEXT,
  openai_model TEXT,
  anthropic_api_key TEXT,
  gemini_api_key TEXT,
  maytapi_product_id TEXT,
  maytapi_phone_id TEXT,
  maytapi_api_key TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  triage_sla_enabled INTEGER DEFAULT 1,
  triage_sla_minutes INTEGER DEFAULT 60,
  gst_rate NUMERIC DEFAULT 18,
  business_state TEXT DEFAULT 'maharashtra',
  free_shipping_threshold NUMERIC DEFAULT 10000,
  standard_shipping_rate NUMERIC DEFAULT 20,
  bulk_shipping_rate NUMERIC DEFAULT 15,
  bulk_threshold INTEGER DEFAULT 15,
  gstin TEXT,
  gmail_connected_email TEXT,
  gmail_refresh_token TEXT,
  gmail_access_token TEXT,
  gmail_token_expiry TEXT,
  gmail_history_id TEXT,
  gmail_watch_expiry TEXT,
  gmail_oauth_state TEXT,
  gmail_oauth_state_created_at TEXT,
  preferred_ai_provider TEXT DEFAULT 'OPENAI',
  ai_model TEXT DEFAULT 'gpt-4o-mini',
  enabled_features TEXT DEFAULT '{}',
  zoho_access_token TEXT,
  zoho_refresh_token TEXT,
  zoho_token_expires_at TEXT,
  office_hours_timezone TEXT DEFAULT 'Asia/Kolkata',
  office_hours_start TEXT DEFAULT '09:00',
  office_hours_end TEXT DEFAULT '18:00',
  zoho_organization_id TEXT,
  plant_id TEXT
);


-- Table: tracked_links
CREATE TABLE IF NOT EXISTS tracked_links (
  id TEXT PRIMARY KEY,
  tenant_id TEXT,
  campaign_id TEXT,
  original_url TEXT,
  short_code TEXT,
  click_count INTEGER DEFAULT 0,
  last_clicked_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: triage_assignment_config
CREATE TABLE IF NOT EXISTS triage_assignment_config (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  strategy TEXT DEFAULT 'LEAST_ACTIVE',
  auto_assign INTEGER DEFAULT 1,
  consider_capacity INTEGER DEFAULT 1,
  consider_score INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: triage_queue
CREATE TABLE IF NOT EXISTS triage_queue (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  conversation_id TEXT,
  end_user_phone TEXT,
  type TEXT DEFAULT 'HUMAN_ATTENTION',
  status TEXT DEFAULT 'NEW',
  assigned_to TEXT,
  message_preview TEXT,
  metadata TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  closed_at TEXT,
  closed_reason TEXT
);


-- Table: unsubscribed_users
CREATE TABLE IF NOT EXISTS unsubscribed_users (
  phone_number TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: user_roles
CREATE TABLE IF NOT EXISTS user_roles (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  role_id TEXT NOT NULL,
  assigned_by TEXT,
  assigned_at TEXT DEFAULT CURRENT_TIMESTAMP,
  expires_at TEXT,
  is_active INTEGER DEFAULT 1
);


-- Table: user_sessions
CREATE TABLE IF NOT EXISTS user_sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  session_token TEXT NOT NULL,
  device_info TEXT,
  expires_at TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  last_activity_at TEXT DEFAULT CURRENT_TIMESTAMP
);

