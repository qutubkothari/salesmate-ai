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

