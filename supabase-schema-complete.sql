-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- Table: account_pricing
CREATE TABLE IF NOT EXISTS account_pricing (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  custom_price NUMERIC NOT NULL,
  effective_from TEXT,
  effective_to TEXT,
  contract_reference TEXT,
  approved_by TEXT,
  notes TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: activity_log
CREATE TABLE IF NOT EXISTS activity_log (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  user_id TEXT,
  action_type TEXT NOT NULL,
  resource_type TEXT,
  resource_id TEXT,
  metadata TEXT,
  ip_address TEXT,
  user_agent TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_churn_predictions
CREATE TABLE IF NOT EXISTS ai_churn_predictions (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  churn_risk_score INTEGER NOT NULL,
  churn_probability NUMERIC NOT NULL,
  risk_level TEXT DEFAULT 'low',
  inactivity_days INTEGER DEFAULT 0,
  declining_engagement INTEGER DEFAULT 0,
  support_issues_count INTEGER DEFAULT 0,
  payment_issues INTEGER DEFAULT 0,
  competitor_mentions INTEGER DEFAULT 0,
  risk_factors TEXT,
  prevention_strategy TEXT,
  predicted_churn_date TEXT,
  actual_churn_date TEXT,
  prevention_actions_taken TEXT,
  outcome TEXT DEFAULT 'pending',
  model_version TEXT DEFAULT 'v1',
  confidence_level NUMERIC DEFAULT 0.0,
  predicted_at TEXT DEFAULT CURRENT_TIMESTAMP,
  last_updated TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_conversation_messages
CREATE TABLE IF NOT EXISTS ai_conversation_messages (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  session_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  message_direction TEXT NOT NULL,
  message_type TEXT NOT NULL,
  message_content TEXT NOT NULL,
  detected_intent TEXT,
  detected_entities TEXT,
  sentiment_score NUMERIC,
  urgency_level TEXT,
  is_ai_response INTEGER DEFAULT 0,
  ai_model_used TEXT,
  ai_confidence NUMERIC,
  response_time INTEGER,
  human_reviewed INTEGER DEFAULT 0,
  human_edited INTEGER DEFAULT 0,
  review_note TEXT,
  timestamp TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_conversation_sessions
CREATE TABLE IF NOT EXISTS ai_conversation_sessions (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  customer_id TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  session_start TEXT DEFAULT CURRENT_TIMESTAMP,
  session_end TEXT,
  session_status TEXT DEFAULT 'active',
  current_intent TEXT,
  current_topic TEXT,
  conversation_stage TEXT,
  customer_sentiment TEXT,
  ai_confidence_score NUMERIC,
  human_handoff_requested INTEGER DEFAULT 0,
  human_agent_id TEXT,
  handoff_reason TEXT,
  message_count INTEGER DEFAULT 0,
  ai_response_count INTEGER DEFAULT 0,
  human_response_count INTEGER DEFAULT 0,
  avg_response_time INTEGER,
  session_duration INTEGER,
  language TEXT DEFAULT 'en',
  channel TEXT DEFAULT 'whatsapp',
  device_info TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_deal_risks
CREATE TABLE IF NOT EXISTS ai_deal_risks (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  deal_id TEXT NOT NULL,
  overall_risk_score INTEGER NOT NULL,
  risk_level TEXT DEFAULT 'low',
  timing_risk INTEGER DEFAULT 0,
  engagement_risk INTEGER DEFAULT 0,
  competition_risk INTEGER DEFAULT 0,
  budget_risk INTEGER DEFAULT 0,
  authority_risk INTEGER DEFAULT 0,
  technical_risk INTEGER DEFAULT 0,
  risk_breakdown TEXT,
  red_flags TEXT,
  warning_signs TEXT,
  recommended_actions TEXT,
  risk_trend TEXT DEFAULT 'stable',
  previous_risk_score INTEGER,
  model_version TEXT DEFAULT 'v1',
  confidence_level NUMERIC DEFAULT 0.0,
  assessed_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_lead_scores
CREATE TABLE IF NOT EXISTS ai_lead_scores (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  conversion_score INTEGER DEFAULT 0,
  engagement_score INTEGER DEFAULT 0,
  quality_score INTEGER DEFAULT 0,
  urgency_score INTEGER DEFAULT 0,
  fit_score INTEGER DEFAULT 0,
  composite_score INTEGER DEFAULT 0,
  score_tier TEXT DEFAULT 'cold',
  model_version TEXT DEFAULT 'v1',
  confidence_level NUMERIC DEFAULT 0.0,
  score_factors TEXT,
  calculated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  expires_at TEXT
);

-- Table: ai_learning_feedback
CREATE TABLE IF NOT EXISTS ai_learning_feedback (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  model_type TEXT NOT NULL,
  prediction_id TEXT,
  user_id TEXT,
  feedback_type TEXT NOT NULL,
  feedback_comment TEXT,
  predicted_value TEXT,
  actual_value TEXT,
  feature_importance_feedback TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_model_metrics
CREATE TABLE IF NOT EXISTS ai_model_metrics (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  model_type TEXT NOT NULL,
  model_version TEXT NOT NULL,
  total_predictions INTEGER DEFAULT 0,
  correct_predictions INTEGER DEFAULT 0,
  accuracy NUMERIC DEFAULT 0.0,
  precision_score NUMERIC DEFAULT 0.0,
  recall_score NUMERIC DEFAULT 0.0,
  f1_score NUMERIC DEFAULT 0.0,
  deals_influenced INTEGER DEFAULT 0,
  revenue_impacted NUMERIC DEFAULT 0.0,
  period_start TEXT NOT NULL,
  period_end TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_objection_instances
CREATE TABLE IF NOT EXISTS ai_objection_instances (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  pattern_id TEXT,
  deal_id TEXT,
  customer_id TEXT,
  raised_by_user TEXT,
  handled_by_user TEXT,
  objection_text TEXT NOT NULL,
  objection_category TEXT,
  detected_confidence NUMERIC,
  response_used TEXT,
  response_effective INTEGER,
  outcome TEXT DEFAULT 'unresolved',
  raised_at TEXT DEFAULT CURRENT_TIMESTAMP,
  resolved_at TEXT
);

-- Table: ai_objection_patterns
CREATE TABLE IF NOT EXISTS ai_objection_patterns (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  objection_category TEXT NOT NULL,
  objection_text TEXT NOT NULL,
  objection_keywords TEXT,
  recommended_response TEXT NOT NULL,
  response_script TEXT,
  handling_technique TEXT,
  times_encountered INTEGER DEFAULT 0,
  times_successful INTEGER DEFAULT 0,
  success_rate NUMERIC DEFAULT 0.0,
  typical_stage TEXT,
  customer_segment TEXT,
  is_active INTEGER DEFAULT 1,
  confidence_score NUMERIC DEFAULT 0.5,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_performance_metrics
CREATE TABLE IF NOT EXISTS ai_performance_metrics (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  metric_date TEXT NOT NULL,
  metric_hour INTEGER,
  total_sessions INTEGER DEFAULT 0,
  ai_handled_sessions INTEGER DEFAULT 0,
  human_handoff_sessions INTEGER DEFAULT 0,
  total_messages INTEGER DEFAULT 0,
  ai_responses INTEGER DEFAULT 0,
  avg_ai_confidence NUMERIC,
  avg_response_time INTEGER,
  positive_sentiment_count INTEGER DEFAULT 0,
  neutral_sentiment_count INTEGER DEFAULT 0,
  negative_sentiment_count INTEGER DEFAULT 0,
  intent_detection_accuracy NUMERIC,
  intent_counts TEXT,
  avg_session_duration INTEGER,
  avg_messages_per_session NUMERIC,
  customer_satisfaction_score NUMERIC,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_recommendations
CREATE TABLE IF NOT EXISTS ai_recommendations (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  user_id TEXT,
  recommendation_type TEXT NOT NULL,
  priority TEXT DEFAULT 'medium',
  action_title TEXT NOT NULL,
  action_description TEXT,
  reasoning TEXT,
  expected_outcome TEXT,
  success_probability NUMERIC,
  context_data TEXT,
  triggers TEXT,
  status TEXT DEFAULT 'pending',
  accepted_at TEXT,
  completed_at TEXT,
  rejected_at TEXT,
  rejection_reason TEXT,
  actual_outcome TEXT,
  outcome_success INTEGER DEFAULT 0,
  model_version TEXT DEFAULT 'v1',
  confidence_score NUMERIC DEFAULT 0.0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  expires_at TEXT
);

-- Table: ai_sentiment_analysis
CREATE TABLE IF NOT EXISTS ai_sentiment_analysis (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  customer_id TEXT,
  user_id TEXT,
  overall_sentiment INTEGER NOT NULL,
  sentiment_label TEXT NOT NULL,
  satisfaction_score INTEGER,
  urgency_score INTEGER,
  frustration_score INTEGER,
  excitement_score INTEGER,
  emotions_detected TEXT,
  positive_phrases TEXT,
  negative_phrases TEXT,
  key_topics TEXT,
  detected_intent TEXT,
  intent_confidence NUMERIC,
  analyzed_text_sample TEXT,
  model_version TEXT DEFAULT 'v1',
  confidence_score NUMERIC DEFAULT 0.0,
  analyzed_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: ai_training_data
CREATE TABLE IF NOT EXISTS ai_training_data (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  sample_type TEXT NOT NULL,
  input_text TEXT NOT NULL,
  expected_output TEXT NOT NULL,
  actual_output TEXT,
  intent TEXT,
  entities TEXT,
  sentiment TEXT,
  is_verified INTEGER DEFAULT 0,
  verified_by TEXT,
  confidence_score NUMERIC,
  source TEXT,
  language TEXT DEFAULT 'en',
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: analytics_custom_metrics
CREATE TABLE IF NOT EXISTS analytics_custom_metrics (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  metric_name TEXT NOT NULL,
  formula TEXT NOT NULL,
  data_sources TEXT,
  display_format TEXT DEFAULT 'number',
  unit TEXT,
  description TEXT,
  category TEXT,
  owner_id TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: analytics_dashboards
CREATE TABLE IF NOT EXISTS analytics_dashboards (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  dashboard_name TEXT NOT NULL,
  description TEXT,
  dashboard_type TEXT DEFAULT 'custom',
  layout_config TEXT,
  refresh_interval INTEGER DEFAULT 300,
  is_public INTEGER DEFAULT 0,
  owner_id TEXT,
  shared_with TEXT,
  date_range_default TEXT DEFAULT 'last_30_days',
  timezone TEXT DEFAULT 'Asia/Kolkata',
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: analytics_exports
CREATE TABLE IF NOT EXISTS analytics_exports (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  export_name TEXT NOT NULL,
  data_source TEXT NOT NULL,
  custom_query TEXT,
  filters TEXT,
  export_format TEXT DEFAULT 'csv',
  include_headers INTEGER DEFAULT 1,
  is_scheduled INTEGER DEFAULT 0,
  schedule_frequency TEXT,
  schedule_time TEXT,
  destination_type TEXT DEFAULT 'download',
  destination_config TEXT,
  owner_id TEXT,
  last_executed_at TEXT,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: analytics_insights
CREATE TABLE IF NOT EXISTS analytics_insights (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  insight_type TEXT NOT NULL,
  insight_title TEXT NOT NULL,
  insight_description TEXT,
  metric_name TEXT,
  metric_value NUMERIC,
  comparison_value NUMERIC,
  change_percentage NUMERIC,
  severity TEXT DEFAULT 'medium',
  confidence_score NUMERIC DEFAULT 0.0,
  recommended_action TEXT,
  period_start TEXT,
  period_end TEXT,
  is_read INTEGER DEFAULT 0,
  is_dismissed INTEGER DEFAULT 0,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: analytics_kpi_values
CREATE TABLE IF NOT EXISTS analytics_kpi_values (
  id TEXT PRIMARY KEY,
  kpi_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  calculated_value NUMERIC NOT NULL,
  target_value NUMERIC,
  achievement_percentage NUMERIC,
  status TEXT DEFAULT 'on_track',
  period_type TEXT,
  period_start TEXT NOT NULL,
  period_end TEXT NOT NULL,
  calculation_details TEXT,
  calculated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

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

-- Table: users
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  phone TEXT NOT NULL,
  name TEXT NOT NULL,
  password TEXT,
  password_hash TEXT,
  role TEXT DEFAULT 'salesman',
  email TEXT,
  assigned_plants TEXT DEFAULT '[]',
  preferred_language TEXT DEFAULT 'en',
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: visit_images
CREATE TABLE IF NOT EXISTS visit_images (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  visit_id TEXT NOT NULL,
  image_url TEXT NOT NULL,
  caption TEXT,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: visit_photos
CREATE TABLE IF NOT EXISTS visit_photos (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  visit_id TEXT NOT NULL,
  photo_url TEXT NOT NULL,
  photo_type TEXT,
  caption TEXT,
  latitude NUMERIC,
  longitude NUMERIC,
  taken_at TEXT DEFAULT CURRENT_TIMESTAMP,
  uploaded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: visits
CREATE TABLE IF NOT EXISTS visits (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  tenant_id TEXT NOT NULL,
  salesman_id TEXT NOT NULL,
  customer_id TEXT,
  plant_id TEXT,
  customer_name TEXT NOT NULL,
  contact_person TEXT,
  customer_phone TEXT,
  visit_type TEXT,
  visit_date DATE NOT NULL,
  meeting_types TEXT,
  products_discussed TEXT,
  potential TEXT,
  competitor_name TEXT,
  can_be_switched BOOLEAN,
  remarks TEXT,
  next_action TEXT,
  next_action_date TIMESTAMP,
  gps_latitude NUMERIC NOT NULL,
  gps_longitude NUMERIC NOT NULL,
  location_accuracy NUMERIC,
  time_in TIMESTAMP NOT NULL,
  time_out TIMESTAMP,
  duration_minutes INTEGER,
  order_id TEXT,
  synced BOOLEAN DEFAULT TRUE,
  offline_id TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  checkin_time TEXT,
  checkin_latitude NUMERIC,
  checkin_longitude NUMERIC,
  checkout_time TEXT,
  checkout_latitude NUMERIC,
  checkout_longitude NUMERIC,
  actual_duration INTEGER
);

-- Table: volume_discounts
CREATE TABLE IF NOT EXISTS volume_discounts (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  name TEXT NOT NULL,
  product_id TEXT,
  category TEXT,
  min_quantity INTEGER NOT NULL,
  max_quantity INTEGER,
  discount_type TEXT DEFAULT 'percentage',
  discount_value NUMERIC NOT NULL,
  priority INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Table: website_embeddings
CREATE TABLE IF NOT EXISTS website_embeddings (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  content TEXT NOT NULL,
  embedding TEXT,
  metadata TEXT DEFAULT '{}',
  source_url TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  url TEXT,
  page_title TEXT,
  content_type TEXT DEFAULT 'general',
  original_content TEXT,
  chunk_text TEXT,
  chunk_index INTEGER DEFAULT 0,
  product_codes TEXT DEFAULT '[]',
  keywords TEXT DEFAULT '[]',
  status TEXT DEFAULT 'active',
  crawl_date TEXT,
  last_updated TEXT
);

-- Table: whatsapp_connections
CREATE TABLE IF NOT EXISTS whatsapp_connections (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  session_name TEXT NOT NULL,
  phone_number TEXT,
  status TEXT DEFAULT 'disconnected',
  qr_code TEXT,
  last_connected TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  connected_at TEXT,
  last_error TEXT,
  salesman_id TEXT,
  provider TEXT DEFAULT 'whatsapp_web',
  is_primary INTEGER DEFAULT 0
);

-- ============================================
-- Indexes and Constraints
-- ============================================

CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_account_pricing_2 ON account_pricing (customer_id, product_id, effective_from);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_account_pricing_1 ON account_pricing (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_activity_log_1 ON activity_log (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_churn_predictions_1 ON ai_churn_predictions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_conversation_messages_1 ON ai_conversation_messages (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_conversation_sessions_1 ON ai_conversation_sessions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_deal_risks_1 ON ai_deal_risks (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_lead_scores_1 ON ai_lead_scores (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_learning_feedback_1 ON ai_learning_feedback (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_model_metrics_1 ON ai_model_metrics (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_objection_instances_1 ON ai_objection_instances (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_objection_patterns_1 ON ai_objection_patterns (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_performance_metrics_1 ON ai_performance_metrics (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_recommendations_1 ON ai_recommendations (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_sentiment_analysis_1 ON ai_sentiment_analysis (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_ai_training_data_1 ON ai_training_data (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_custom_metrics_1 ON analytics_custom_metrics (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_dashboards_1 ON analytics_dashboards (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_exports_1 ON analytics_exports (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_insights_1 ON analytics_insights (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_kpi_values_1 ON analytics_kpi_values (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_kpis_1 ON analytics_kpis (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_report_runs_1 ON analytics_report_runs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_reports_1 ON analytics_reports (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_saved_filters_1 ON analytics_saved_filters (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_analytics_widgets_1 ON analytics_widgets (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_api_keys_2 ON api_keys (key_hash);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_api_keys_1 ON api_keys (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_api_metrics_1 ON api_metrics (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_app_updates_2 ON app_updates (version_number);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_app_updates_1 ON app_updates (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_assignment_config_1 ON assignment_config (tenant_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_audit_logs_1 ON audit_logs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_autoscaling_events_1 ON autoscaling_events (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_background_sync_jobs_1 ON background_sync_jobs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_broadcast_batch_log_1 ON broadcast_batch_log (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_broadcast_campaigns_1 ON broadcast_campaigns (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_broadcast_queue_1 ON broadcast_queue (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_broadcast_recipients_2 ON broadcast_recipients (tenant_id, phone_number);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_broadcast_recipients_1 ON broadcast_recipients (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_bulk_schedules_1 ON bulk_schedules (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_cache_entries_2 ON cache_entries (cache_key);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_cache_entries_1 ON cache_entries (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_categories_2 ON categories (tenant_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_categories_1 ON categories (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_commission_structure_1 ON commission_structure (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_competitors_2 ON competitors (tenant_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_competitors_1 ON competitors (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_connection_pool_stats_1 ON connection_pool_stats (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_contact_groups_2 ON contact_groups (tenant_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_contact_groups_1 ON contact_groups (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_conversation_context_1 ON conversation_context (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_conversations_new_1 ON conversations_new (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_crawl_jobs_1 ON crawl_jobs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_customer_ai_preferences_1 ON customer_ai_preferences (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_customer_locations_1 ON customer_locations (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_customer_notes_1 ON customer_notes (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_customer_profiles_new_1 ON customer_profiles_new (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_customer_visit_schedules_1 ON customer_visit_schedules (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_customers_engaged_new_1 ON customers_engaged_new (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deal_activities_1 ON deal_activities (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deal_notes_1 ON deal_notes (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deal_outcomes_2 ON deal_outcomes (deal_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deal_outcomes_1 ON deal_outcomes (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deal_products_1 ON deal_products (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deal_stage_history_1 ON deal_stage_history (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_deals_1 ON deals (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_discounts_2 ON discounts (tenant_id, code);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_discounts_1 ON discounts (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_access_logs_1 ON document_access_logs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_approvals_1 ON document_approvals (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_branding_2 ON document_branding (tenant_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_branding_1 ON document_branding (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_line_items_1 ON document_line_items (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_signatures_1 ON document_signatures (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_template_placeholders_1 ON document_template_placeholders (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_templates_1 ON document_templates (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_versions_1 ON document_versions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_document_workflows_1 ON document_workflows (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_email_classification_cache_2 ON email_classification_cache (email_hash);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_email_classification_cache_1 ON email_classification_cache (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_email_enquiries_1 ON email_enquiries (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_connections_1 ON erp_connections (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_entity_sync_records_1 ON erp_entity_sync_records (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_field_mappings_1 ON erp_field_mappings (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_rate_limits_1 ON erp_rate_limits (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_sync_configs_1 ON erp_sync_configs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_sync_logs_1 ON erp_sync_logs (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_transform_templates_1 ON erp_transform_templates (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_webhook_events_1 ON erp_webhook_events (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_erp_webhooks_1 ON erp_webhooks (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_field_activity_log_1 ON field_activity_log (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_forecast_snapshots_1 ON forecast_snapshots (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_generated_documents_2 ON generated_documents (document_number);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_generated_documents_1 ON generated_documents (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_geo_pricing_1 ON geo_pricing (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_health_checks_1 ON health_checks (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_inbound_messages_1 ON inbound_messages (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_lead_pipeline_items_1 ON lead_pipeline_items (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_lead_pipeline_stages_1 ON lead_pipeline_stages (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_load_balancer_metrics_1 ON load_balancer_metrics (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_message_templates_2 ON message_templates (tenant_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_message_templates_1 ON message_templates (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_messages_1 ON messages (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_mobile_analytics_events_1 ON mobile_analytics_events (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_mobile_devices_2 ON mobile_devices (device_uuid);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_mobile_devices_1 ON mobile_devices (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_mobile_feature_flags_2 ON mobile_feature_flags (feature_key);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_mobile_feature_flags_1 ON mobile_feature_flags (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_mobile_sessions_1 ON mobile_sessions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_notification_queue_1 ON notification_queue (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_notifications_1 ON notifications (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_offline_cache_manifest_2 ON offline_cache_manifest (device_id, entity_type, entity_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_offline_cache_manifest_1 ON offline_cache_manifest (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_offline_queue_1 ON offline_queue (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_offline_sync_queue_1 ON offline_sync_queue (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_order_items_1 ON order_items (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_orders_new_2 ON orders_new (order_number);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_orders_new_1 ON orders_new (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_performance_alerts_1 ON performance_alerts (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_permission_audit_log_1 ON permission_audit_log (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_permissions_2 ON permissions (permission_code);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_permissions_1 ON permissions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_pipeline_stages_2 ON pipeline_stages (pipeline_id, stage_order);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_pipeline_stages_1 ON pipeline_stages (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_pipelines_1 ON pipelines (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_plants_2 ON plants (tenant_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_plants_1 ON plants (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_price_history_1 ON price_history (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_price_lists_1 ON price_lists (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_pricing_tiers_2 ON pricing_tiers (tier_code);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_pricing_tiers_1 ON pricing_tiers (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_product_categories_2 ON product_categories (tenant_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_product_categories_1 ON product_categories (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_product_expertise_2 ON product_expertise (tenant_id, salesman_id, product_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_product_expertise_1 ON product_expertise (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_product_prices_2 ON product_prices (price_list_id, product_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_product_prices_1 ON product_prices (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_products_1 ON products (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_promotions_2 ON promotions (code);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_promotions_1 ON promotions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_push_notification_deliveries_1 ON push_notification_deliveries (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_push_notifications_1 ON push_notifications (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_query_optimizations_1 ON query_optimizations (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_query_performance_1 ON query_performance (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_rate_limits_2 ON rate_limits (limit_type, limit_key);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_rate_limits_1 ON rate_limits (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_resource_permissions_2 ON resource_permissions (user_id, resource_type, resource_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_resource_permissions_1 ON resource_permissions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_role_permissions_2 ON role_permissions (role_id, permission_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_role_permissions_1 ON role_permissions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_roles_2 ON roles (tenant_id, role_code);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_roles_1 ON roles (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_route_plans_1 ON route_plans (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_sales_users_1 ON sales_users (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_attendance_2 ON salesman_attendance (tenant_id, salesman_id, attendance_date);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_attendance_1 ON salesman_attendance (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_commissions_1 ON salesman_commissions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_expenses_1 ON salesman_expenses (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_sessions_1 ON salesman_sessions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_targets_2 ON salesman_targets (tenant_id, salesman_id, period);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesman_targets_1 ON salesman_targets (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesmen_2 ON salesmen (tenant_id, phone);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_salesmen_1 ON salesmen (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_scheduled_followups_1 ON scheduled_followups (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_smart_reply_templates_1 ON smart_reply_templates (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_success_definitions_1 ON success_definitions (tenant_id, event_type);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_sync_checkpoints_2 ON sync_checkpoints (device_id, entity_type, sync_direction);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_sync_checkpoints_1 ON sync_checkpoints (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_team_hierarchy_2 ON team_hierarchy (manager_id, member_id, relationship_type);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_team_hierarchy_1 ON team_hierarchy (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_tenant_bots_1 ON tenant_bots (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_tenant_documents_1 ON tenant_documents (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_tenants_2 ON tenants (phone_number);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_tenants_1 ON tenants (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_tracked_links_2 ON tracked_links (short_code);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_tracked_links_1 ON tracked_links (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_triage_assignment_config_2 ON triage_assignment_config (tenant_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_triage_assignment_config_1 ON triage_assignment_config (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_triage_queue_1 ON triage_queue (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_unsubscribed_users_1 ON unsubscribed_users (phone_number);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_user_roles_2 ON user_roles (user_id, role_id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_user_roles_1 ON user_roles (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_user_sessions_2 ON user_sessions (session_token);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_user_sessions_1 ON user_sessions (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_users_2 ON users (tenant_id, phone);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_users_1 ON users (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_visit_images_1 ON visit_images (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_visit_photos_1 ON visit_photos (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_visits_1 ON visits (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_volume_discounts_1 ON volume_discounts (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_website_embeddings_1 ON website_embeddings (id);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_whatsapp_connections_2 ON whatsapp_connections (tenant_id, session_name);
CREATE UNIQUE INDEX IF NOT EXISTS sqlite_autoindex_whatsapp_connections_1 ON whatsapp_connections (id);
