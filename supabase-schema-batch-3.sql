-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: calls
CREATE TABLE IF NOT EXISTS calls (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  lead_id INTEGER,
  conversation_id INTEGER,
  phone_number TEXT NOT NULL,
  direction TEXT NOT NULL,
  outcome TEXT,
  duration_seconds INTEGER DEFAULT 0,
  notes TEXT,
  recording_url TEXT,
  handled_by TEXT,
  scheduled_for TIMESTAMP,
  started_at TIMESTAMP,
  ended_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  metadata TEXT
);


-- Table: categories
CREATE TABLE IF NOT EXISTS categories (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: commission_structure
CREATE TABLE IF NOT EXISTS commission_structure (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  rule_name TEXT NOT NULL,
  salesman_id TEXT,
  product_id TEXT,
  product_category TEXT,
  customer_type TEXT,
  commission_type TEXT NOT NULL,
  commission_value NUMERIC NOT NULL,
  slab_data TEXT,
  min_order_value NUMERIC,
  max_order_value NUMERIC,
  effective_from TEXT NOT NULL,
  effective_to TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: competitors
CREATE TABLE IF NOT EXISTS competitors (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: connection_pool_stats
CREATE TABLE IF NOT EXISTS connection_pool_stats (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  active_connections INTEGER DEFAULT 0,
  idle_connections INTEGER DEFAULT 0,
  waiting_requests INTEGER DEFAULT 0,
  avg_wait_time_ms NUMERIC,
  max_connections INTEGER,
  pool_status TEXT DEFAULT 'healthy',
  recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: contact_groups
CREATE TABLE IF NOT EXISTS contact_groups (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  contact_count INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  group_name TEXT,
  contacts TEXT
);


-- Table: conversation_context
CREATE TABLE IF NOT EXISTS conversation_context (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  session_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  context_key TEXT NOT NULL,
  context_value TEXT NOT NULL,
  context_type TEXT DEFAULT 'string',
  expires_at TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: conversation_learning
CREATE TABLE IF NOT EXISTS conversation_learning (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  conversation_id INTEGER,
  customer_phone TEXT,
  user_query TEXT NOT NULL,
  ai_response TEXT NOT NULL,
  outcome_type TEXT NOT NULL,
  was_successful BOOLEAN NOT NULL DEFAULT TRUE,
  context_used TEXT,
  response_time_ms INTEGER,
  customer_satisfaction_score INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: conversations_new
CREATE TABLE IF NOT EXISTS conversations_new (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  end_user_phone TEXT NOT NULL,
  end_user_name TEXT,
  salesman_id TEXT,
  auto_assigned_to_salesman INTEGER DEFAULT 0,
  business_profile TEXT,
  context TEXT,
  learning_data TEXT,
  messages_count INTEGER DEFAULT 0,
  last_message_at TEXT,
  status TEXT DEFAULT 'active',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: crawl_jobs
CREATE TABLE IF NOT EXISTS crawl_jobs (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  url TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  error_message TEXT,
  pages_crawled INTEGER DEFAULT 0,
  chunks_created INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  completed_at TEXT
);


-- Table: customer_ai_preferences
CREATE TABLE IF NOT EXISTS customer_ai_preferences (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  prefers_ai_chat INTEGER DEFAULT 1,
  prefers_human_agent INTEGER DEFAULT 0,
  preferred_language TEXT DEFAULT 'en',
  preferred_tone TEXT,
  communication_frequency TEXT,
  best_contact_hours TEXT,
  timezone TEXT,
  opted_out_broadcast INTEGER DEFAULT 0,
  opted_out_ai_chat INTEGER DEFAULT 0,
  opted_out_at TEXT,
  typical_inquiries TEXT,
  purchase_patterns TEXT,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: customer_locations
CREATE TABLE IF NOT EXISTS customer_locations (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  latitude NUMERIC NOT NULL,
  longitude NUMERIC NOT NULL,
  address TEXT,
  city TEXT,
  state TEXT,
  pincode TEXT,
  is_verified INTEGER DEFAULT 0,
  verified_by TEXT,
  verified_at TEXT,
  accuracy NUMERIC,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: customer_notes
CREATE TABLE IF NOT EXISTS customer_notes (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  note_type TEXT DEFAULT 'text',
  note_text TEXT,
  file_url TEXT,
  is_important INTEGER DEFAULT 0,
  reminder_date TEXT,
  visit_id TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: customer_profiles_new
CREATE TABLE IF NOT EXISTS customer_profiles_new (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  business_name TEXT,
  contact_person TEXT,
  phone TEXT NOT NULL,
  email TEXT,
  business_type TEXT,
  city TEXT,
  state TEXT,
  gst_number TEXT,
  status TEXT DEFAULT 'active',
  assigned_salesman_id TEXT,
  last_visit_date TEXT,
  next_follow_up_date TEXT,
  visit_frequency TEXT DEFAULT 'monthly',
  plant_id TEXT,
  source TEXT DEFAULT 'manual',
  notes TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: customer_visit_schedules
CREATE TABLE IF NOT EXISTS customer_visit_schedules (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  frequency TEXT,
  day_of_week INTEGER,
  day_of_month INTEGER,
  custom_pattern TEXT,
  next_visit_date TEXT,
  last_visit_date TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: customers_engaged_new
CREATE TABLE IF NOT EXISTS customers_engaged_new (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  salesman_id TEXT,
  auto_assigned_to_salesman INTEGER DEFAULT 0,
  source_type TEXT,
  first_engagement_date TEXT,
  last_engagement_date TEXT,
  total_messages INTEGER DEFAULT 0,
  status TEXT DEFAULT 'active',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: deal_activities
CREATE TABLE IF NOT EXISTS deal_activities (
  id TEXT PRIMARY KEY,
  deal_id TEXT NOT NULL,
  activity_type TEXT NOT NULL,
  subject TEXT NOT NULL,
  description TEXT,
  performed_by TEXT NOT NULL,
  performed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  duration_minutes INTEGER,
  outcome TEXT,
  next_action TEXT,
  attachments TEXT
);


-- Table: deal_notes
CREATE TABLE IF NOT EXISTS deal_notes (
  id TEXT PRIMARY KEY,
  deal_id TEXT NOT NULL,
  note_text TEXT NOT NULL,
  created_by TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  is_pinned INTEGER DEFAULT 0
);


-- Table: deal_outcomes
CREATE TABLE IF NOT EXISTS deal_outcomes (
  id TEXT PRIMARY KEY,
  deal_id TEXT NOT NULL,
  outcome TEXT NOT NULL,
  win_reason TEXT,
  loss_reason TEXT,
  competitor_name TEXT,
  feedback TEXT,
  lessons_learned TEXT,
  recorded_by TEXT,
  recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: deal_products
CREATE TABLE IF NOT EXISTS deal_products (
  id TEXT PRIMARY KEY,
  deal_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  unit_price NUMERIC NOT NULL,
  discount NUMERIC DEFAULT 0,
  total_price NUMERIC NOT NULL,
  description TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

