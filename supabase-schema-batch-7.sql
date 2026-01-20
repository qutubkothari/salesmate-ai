-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: product_categories
CREATE TABLE IF NOT EXISTS product_categories (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  parent_category_id TEXT,
  display_order INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: product_expertise
CREATE TABLE IF NOT EXISTS product_expertise (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  expertise_level TEXT DEFAULT 'basic',
  assigned_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: product_prices
CREATE TABLE IF NOT EXISTS product_prices (
  id TEXT PRIMARY KEY,
  price_list_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  base_price NUMERIC NOT NULL,
  cost_price NUMERIC,
  min_price NUMERIC,
  max_price NUMERIC,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: products
CREATE TABLE IF NOT EXISTS products (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  category_id TEXT,
  category TEXT,
  brand TEXT,
  sku TEXT,
  model_number TEXT,
  price NUMERIC DEFAULT 0.00,
  stock_quantity INTEGER DEFAULT 0,
  image_url TEXT,
  packaging_unit TEXT,
  units_per_carton INTEGER DEFAULT 1,
  carton_price NUMERIC,
  is_active INTEGER DEFAULT 1,
  zoho_item_id TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  description_generated_by_ai INTEGER DEFAULT 0
);


-- Table: promotions
CREATE TABLE IF NOT EXISTS promotions (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  code TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  discount_type TEXT DEFAULT 'percentage',
  discount_value NUMERIC NOT NULL,
  min_order_value NUMERIC,
  max_discount_amount NUMERIC,
  applicable_products TEXT,
  applicable_categories TEXT,
  applicable_tiers TEXT,
  start_date TEXT NOT NULL,
  end_date TEXT NOT NULL,
  usage_limit INTEGER,
  usage_count INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: push_notification_deliveries
CREATE TABLE IF NOT EXISTS push_notification_deliveries (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  notification_id TEXT NOT NULL,
  device_id TEXT NOT NULL,
  delivery_status TEXT DEFAULT 'pending',
  sent_at TEXT,
  delivered_at TEXT,
  clicked_at TEXT,
  failed_at TEXT,
  error_code TEXT,
  error_message TEXT,
  time_to_click INTEGER,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: push_notifications
CREATE TABLE IF NOT EXISTS push_notifications (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  target_type TEXT NOT NULL,
  target_id TEXT,
  notification_title TEXT NOT NULL,
  notification_body TEXT NOT NULL,
  notification_icon TEXT,
  notification_image TEXT,
  action_type TEXT,
  action_data TEXT,
  deep_link TEXT,
  delivery_status TEXT DEFAULT 'pending',
  sent_at TEXT,
  delivered_at TEXT,
  clicked_at TEXT,
  priority TEXT DEFAULT 'normal',
  scheduled_for TEXT,
  expires_at TEXT,
  data_payload TEXT,
  is_silent INTEGER DEFAULT 0,
  notification_channel TEXT,
  collapse_key TEXT,
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: query_optimizations
CREATE TABLE IF NOT EXISTS query_optimizations (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  query_signature TEXT NOT NULL,
  table_name TEXT,
  issue_type TEXT NOT NULL,
  severity TEXT NOT NULL,
  suggestion TEXT NOT NULL,
  estimated_improvement_percent NUMERIC,
  implementation_sql TEXT,
  is_implemented INTEGER DEFAULT 0,
  implemented_at TEXT,
  affected_endpoints TEXT,
  avg_execution_time_before_ms NUMERIC,
  avg_execution_time_after_ms NUMERIC,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: query_performance
CREATE TABLE IF NOT EXISTS query_performance (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT,
  query_type TEXT NOT NULL,
  query_signature TEXT NOT NULL,
  table_name TEXT,
  execution_time_ms NUMERIC NOT NULL,
  rows_affected INTEGER,
  rows_scanned INTEGER,
  used_index INTEGER DEFAULT 0,
  is_slow_query INTEGER DEFAULT 0,
  needs_optimization INTEGER DEFAULT 0,
  endpoint TEXT,
  user_id TEXT,
  executed_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: rate_limits
CREATE TABLE IF NOT EXISTS rate_limits (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT,
  limit_type TEXT NOT NULL,
  limit_key TEXT NOT NULL,
  max_requests INTEGER NOT NULL,
  window_seconds INTEGER NOT NULL,
  current_count INTEGER DEFAULT 0,
  window_start TEXT DEFAULT CURRENT_TIMESTAMP,
  is_blocked INTEGER DEFAULT 0,
  blocked_until TEXT,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: resource_permissions
CREATE TABLE IF NOT EXISTS resource_permissions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  resource_type TEXT NOT NULL,
  resource_id TEXT NOT NULL,
  permission_level TEXT NOT NULL,
  granted_by TEXT,
  granted_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: role_permissions
CREATE TABLE IF NOT EXISTS role_permissions (
  id TEXT PRIMARY KEY,
  role_id TEXT NOT NULL,
  permission_id TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: roles
CREATE TABLE IF NOT EXISTS roles (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  role_name TEXT NOT NULL,
  role_code TEXT NOT NULL,
  description TEXT,
  is_system_role INTEGER DEFAULT 0,
  hierarchy_level INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: route_plans
CREATE TABLE IF NOT EXISTS route_plans (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  plan_date TEXT NOT NULL,
  plan_name TEXT,
  customer_sequence TEXT NOT NULL,
  total_distance NUMERIC,
  estimated_duration INTEGER,
  actual_distance NUMERIC,
  actual_duration INTEGER,
  start_time TEXT,
  end_time TEXT,
  status TEXT DEFAULT 'planned',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: sales_users
CREATE TABLE IF NOT EXISTS sales_users (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  phone TEXT,
  role TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  capacity INTEGER DEFAULT 0,
  score INTEGER DEFAULT 0,
  email TEXT,
  password_hash TEXT,
  last_login_at TEXT,
  invitation_token TEXT,
  invitation_sent_at TEXT,
  invitation_accepted_at TEXT,
  invited_by TEXT,
  gmail_connected_email TEXT,
  gmail_refresh_token TEXT,
  gmail_access_token TEXT,
  gmail_token_expiry TEXT,
  gmail_history_id TEXT,
  gmail_watch_expiry TEXT,
  status TEXT DEFAULT 'active',
  avatar_url TEXT,
  timezone TEXT DEFAULT 'Asia/Kolkata',
  language TEXT DEFAULT 'en'
);


-- Table: salesman
CREATE TABLE IF NOT EXISTS salesman (
  id SERIAL PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  user_id TEXT,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  capacity INTEGER DEFAULT 0,
  min_leads_per_month INTEGER DEFAULT 0,
  max_leads_per_month INTEGER DEFAULT 50,
  use_intelligent_override BOOLEAN DEFAULT TRUE,
  score NUMERIC DEFAULT 0.0,
  total_success_events INTEGER DEFAULT 0,
  total_leads_handled INTEGER DEFAULT 0,
  avg_response_time_minutes NUMERIC DEFAULT 0.0,
  product_skills TEXT,
  language_skills TEXT,
  geographic_zone TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: salesman_attendance
CREATE TABLE IF NOT EXISTS salesman_attendance (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  attendance_date TEXT NOT NULL,
  checkin_time TEXT,
  checkin_latitude NUMERIC,
  checkin_longitude NUMERIC,
  checkin_address TEXT,
  checkout_time TEXT,
  checkout_latitude NUMERIC,
  checkout_longitude NUMERIC,
  checkout_address TEXT,
  total_visits INTEGER DEFAULT 0,
  total_orders INTEGER DEFAULT 0,
  total_revenue NUMERIC DEFAULT 0,
  distance_travelled NUMERIC,
  status TEXT DEFAULT 'present',
  leave_type TEXT,
  leave_reason TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: salesman_commissions
CREATE TABLE IF NOT EXISTS salesman_commissions (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  order_id TEXT NOT NULL,
  commission_rule_id TEXT,
  order_amount NUMERIC NOT NULL,
  commission_amount NUMERIC NOT NULL,
  commission_percentage NUMERIC,
  status TEXT DEFAULT 'pending',
  approved_by TEXT,
  approved_at TEXT,
  paid_at TEXT,
  payment_reference TEXT,
  notes TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: salesman_expenses
CREATE TABLE IF NOT EXISTS salesman_expenses (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  expense_date TEXT NOT NULL,
  expense_type TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  description TEXT,
  receipt_url TEXT,
  visit_id TEXT,
  route_plan_id TEXT,
  status TEXT DEFAULT 'pending',
  approved_by TEXT,
  approved_at TEXT,
  rejection_reason TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);


-- Table: salesman_sessions
CREATE TABLE IF NOT EXISTS salesman_sessions (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  device_type TEXT NOT NULL,
  device_id TEXT NOT NULL,
  device_name TEXT,
  last_sync_at TEXT,
  app_version TEXT,
  platform TEXT,
  is_online INTEGER DEFAULT 1,
  fcm_token TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  session_token_hash TEXT,
  session_expires_at TEXT,
  last_seen_at TEXT,
  revoked_at TEXT
);

