-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: deal_stage_history
CREATE TABLE IF NOT EXISTS deal_stage_history (
  id TEXT PRIMARY KEY,
  deal_id TEXT NOT NULL,
  from_stage_id TEXT,
  to_stage_id TEXT NOT NULL,
  changed_by TEXT NOT NULL,
  changed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  duration_days INTEGER,
  notes TEXT
);


-- Table: deals
CREATE TABLE IF NOT EXISTS deals (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  deal_name TEXT NOT NULL,
  customer_id TEXT,
  contact_person TEXT,
  pipeline_id TEXT NOT NULL,
  stage_id TEXT NOT NULL,
  owner_id TEXT NOT NULL,
  deal_value NUMERIC NOT NULL DEFAULT 0,
  currency TEXT DEFAULT 'INR',
  expected_revenue NUMERIC,
  discount_amount NUMERIC DEFAULT 0,
  discount_percentage NUMERIC DEFAULT 0,
  created_date TEXT DEFAULT CURRENT_TIMESTAMP,
  expected_close_date TEXT,
  actual_close_date TEXT,
  last_activity_date TEXT,
  description TEXT,
  source TEXT,
  priority TEXT DEFAULT 'medium',
  score INTEGER DEFAULT 0,
  temperature TEXT DEFAULT 'warm',
  status TEXT DEFAULT 'open',
  lost_reason TEXT,
  won_details TEXT,
  competitors TEXT,
  tags TEXT,
  custom_fields TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: discounts
CREATE TABLE IF NOT EXISTS discounts (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  code TEXT NOT NULL,
  description TEXT,
  discount_type TEXT NOT NULL,
  discount_value NUMERIC NOT NULL,
  min_order_amount NUMERIC DEFAULT 0.00,
  max_discount_amount NUMERIC,
  applicable_to TEXT DEFAULT 'all',
  valid_from TEXT DEFAULT CURRENT_TIMESTAMP,
  valid_until TEXT,
  usage_limit INTEGER,
  usage_count INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_access_logs
CREATE TABLE IF NOT EXISTS document_access_logs (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  document_id TEXT NOT NULL,
  access_type TEXT NOT NULL,
  accessed_by TEXT,
  ip_address TEXT,
  user_agent TEXT,
  access_source TEXT,
  accessed_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_approvals
CREATE TABLE IF NOT EXISTS document_approvals (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  document_id TEXT NOT NULL,
  workflow_id TEXT NOT NULL,
  current_step INTEGER DEFAULT 1,
  approval_status TEXT DEFAULT 'pending',
  steps_completed INTEGER DEFAULT 0,
  total_steps INTEGER NOT NULL,
  final_decision TEXT,
  final_decision_by TEXT,
  final_decision_at TEXT,
  decision_note TEXT,
  initiated_by TEXT,
  initiated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_branding
CREATE TABLE IF NOT EXISTS document_branding (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  company_name TEXT,
  company_logo_url TEXT,
  company_address TEXT,
  company_city TEXT,
  company_state TEXT,
  company_country TEXT,
  company_pincode TEXT,
  company_phone TEXT,
  company_email TEXT,
  company_website TEXT,
  tax_registration_number TEXT,
  business_registration TEXT,
  primary_color TEXT DEFAULT '#007bff',
  secondary_color TEXT DEFAULT '#6c757d',
  accent_color TEXT DEFAULT '#28a745',
  font_family TEXT DEFAULT 'Arial, sans-serif',
  show_watermark INTEGER DEFAULT 0,
  watermark_text TEXT,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_line_items
CREATE TABLE IF NOT EXISTS document_line_items (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  document_id TEXT NOT NULL,
  line_number INTEGER NOT NULL,
  item_type TEXT,
  product_id TEXT,
  product_name TEXT NOT NULL,
  product_description TEXT,
  quantity NUMERIC NOT NULL,
  unit_price NUMERIC NOT NULL,
  discount_percent NUMERIC DEFAULT 0,
  discount_amount NUMERIC DEFAULT 0,
  tax_percent NUMERIC DEFAULT 0,
  tax_amount NUMERIC DEFAULT 0,
  subtotal NUMERIC NOT NULL,
  total NUMERIC NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_signatures
CREATE TABLE IF NOT EXISTS document_signatures (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  document_id TEXT NOT NULL,
  signer_name TEXT NOT NULL,
  signer_role TEXT,
  signer_email TEXT,
  signature_type TEXT,
  signature_data TEXT,
  signature_ip TEXT,
  signature_device TEXT,
  signature_status TEXT DEFAULT 'pending',
  signed_at TEXT,
  rejection_reason TEXT,
  is_verified INTEGER DEFAULT 0,
  verification_token TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_template_placeholders
CREATE TABLE IF NOT EXISTS document_template_placeholders (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  template_id TEXT NOT NULL,
  placeholder_key TEXT NOT NULL,
  placeholder_label TEXT NOT NULL,
  placeholder_type TEXT NOT NULL,
  data_source TEXT,
  source_field TEXT,
  format_pattern TEXT,
  default_value TEXT,
  transform_function TEXT,
  is_required INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_templates
CREATE TABLE IF NOT EXISTS document_templates (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  template_name TEXT NOT NULL,
  template_type TEXT NOT NULL,
  description TEXT,
  template_format TEXT DEFAULT 'html',
  template_body TEXT NOT NULL,
  header_content TEXT,
  footer_content TEXT,
  css_styles TEXT,
  page_size TEXT DEFAULT 'A4',
  page_orientation TEXT DEFAULT 'portrait',
  margins TEXT,
  is_default INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  version INTEGER DEFAULT 1,
  language TEXT DEFAULT 'en',
  auto_number INTEGER DEFAULT 1,
  number_prefix TEXT,
  number_format TEXT,
  current_sequence INTEGER DEFAULT 0,
  tags TEXT,
  category TEXT,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_versions
CREATE TABLE IF NOT EXISTS document_versions (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  document_id TEXT NOT NULL,
  version_number INTEGER NOT NULL,
  version_note TEXT,
  html_snapshot TEXT NOT NULL,
  pdf_snapshot_path TEXT,
  merge_data_snapshot TEXT,
  changes_summary TEXT,
  changed_by TEXT,
  changed_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: document_workflows
CREATE TABLE IF NOT EXISTS document_workflows (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  workflow_name TEXT NOT NULL,
  document_type TEXT NOT NULL,
  workflow_steps TEXT NOT NULL,
  is_active INTEGER DEFAULT 1,
  auto_approve_threshold NUMERIC,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: drip_campaign_subscribers
CREATE TABLE IF NOT EXISTS drip_campaign_subscribers (
  id SERIAL PRIMARY KEY,
  campaign_id INTEGER NOT NULL,
  customer_id TEXT NOT NULL,
  status TEXT DEFAULT 'active',
  current_step INTEGER DEFAULT 0,
  last_message_sent_at TEXT,
  subscribed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  unsubscribed_at TEXT
);


-- Table: email_classification_cache
CREATE TABLE IF NOT EXISTS email_classification_cache (
  id TEXT PRIMARY KEY,
  email_hash TEXT NOT NULL,
  category TEXT,
  intent TEXT,
  confidence_score NUMERIC,
  extracted_keywords TEXT,
  is_relevant INTEGER,
  classified_at TEXT DEFAULT CURRENT_TIMESTAMP,
  model_version TEXT
);


-- Table: email_enquiries
CREATE TABLE IF NOT EXISTS email_enquiries (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  from_email TEXT,
  subject TEXT,
  body TEXT,
  received_at TEXT,
  raw TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  message_id TEXT,
  thread_id TEXT,
  snippet TEXT,
  is_read INTEGER DEFAULT 0,
  read_at TEXT,
  lead_conversation_id TEXT,
  lead_customer_profile_id TEXT,
  lead_created_at TEXT,
  assigned_to TEXT,
  category TEXT,
  intent TEXT,
  confidence_score NUMERIC,
  extracted_products TEXT,
  is_relevant INTEGER DEFAULT 1,
  salesman_id TEXT,
  auto_assigned INTEGER DEFAULT 0,
  assignment_reason TEXT,
  replied_at TEXT,
  reply_count INTEGER DEFAULT 0
);


-- Table: erp_connections
CREATE TABLE IF NOT EXISTS erp_connections (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  erp_system TEXT NOT NULL,
  connection_name TEXT NOT NULL,
  auth_type TEXT NOT NULL,
  auth_config TEXT,
  oauth_tokens TEXT,
  base_url TEXT,
  api_version TEXT,
  organization_id TEXT,
  company_id TEXT,
  status TEXT DEFAULT 'active',
  last_connected_at TEXT,
  last_sync_at TEXT,
  last_error TEXT,
  sync_enabled INTEGER DEFAULT 1,
  auto_sync_interval INTEGER DEFAULT 3600,
  sync_direction TEXT DEFAULT 'bidirectional',
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: erp_entity_sync_records
CREATE TABLE IF NOT EXISTS erp_entity_sync_records (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  connection_id TEXT NOT NULL,
  sync_config_id TEXT NOT NULL,
  sync_log_id TEXT,
  tenant_id TEXT NOT NULL,
  local_entity_type TEXT NOT NULL,
  local_entity_id TEXT NOT NULL,
  remote_entity_type TEXT NOT NULL,
  remote_entity_id TEXT,
  sync_status TEXT DEFAULT 'pending',
  last_sync_direction TEXT,
  last_sync_at TEXT,
  local_version TEXT,
  remote_version TEXT,
  local_updated_at TEXT,
  remote_updated_at TEXT,
  has_conflict INTEGER DEFAULT 0,
  conflict_details TEXT,
  conflict_resolved_at TEXT,
  first_synced_at TEXT DEFAULT CURRENT_TIMESTAMP,
  sync_count INTEGER DEFAULT 0,
  last_error TEXT
);


-- Table: erp_field_mappings
CREATE TABLE IF NOT EXISTS erp_field_mappings (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  sync_config_id TEXT NOT NULL,
  local_field TEXT NOT NULL,
  remote_field TEXT NOT NULL,
  field_type TEXT,
  is_required INTEGER DEFAULT 0,
  is_readonly INTEGER DEFAULT 0,
  transform_function TEXT,
  default_value TEXT,
  value_mappings TEXT,
  validation_rules TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: erp_rate_limits
CREATE TABLE IF NOT EXISTS erp_rate_limits (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  limit_type TEXT NOT NULL,
  max_requests INTEGER NOT NULL,
  current_count INTEGER DEFAULT 0,
  window_start TEXT,
  window_end TEXT,
  is_throttled INTEGER DEFAULT 0,
  throttle_until TEXT,
  last_reset_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: erp_sync_configs
CREATE TABLE IF NOT EXISTS erp_sync_configs (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  connection_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  local_table TEXT NOT NULL,
  remote_module TEXT NOT NULL,
  sync_direction TEXT DEFAULT 'bidirectional',
  auto_sync INTEGER DEFAULT 1,
  sync_frequency INTEGER DEFAULT 3600,
  conflict_resolution TEXT DEFAULT 'remote_wins',
  sync_filter TEXT,
  field_mappings TEXT,
  transform_config TEXT,
  is_active INTEGER DEFAULT 1,
  last_sync_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

