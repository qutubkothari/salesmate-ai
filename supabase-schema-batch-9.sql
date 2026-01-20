-- ============================================
-- Supabase Schema - Complete Export
-- Generated: 2026-01-20T02:40:52.000Z
-- Total Tables: 167
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


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
