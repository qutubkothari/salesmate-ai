-- Mobile App Features Schema
-- Offline sync, push notifications, mobile sessions, data optimization
-- Supports: iOS, Android, Progressive Web Apps

-- Mobile Device Registration
CREATE TABLE IF NOT EXISTS mobile_devices (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  
  -- Device details
  device_uuid TEXT UNIQUE NOT NULL, -- Unique device identifier
  device_name TEXT, -- iPhone 13, Samsung Galaxy S21
  device_model TEXT,
  device_platform TEXT NOT NULL, -- ios, android, web
  platform_version TEXT, -- iOS 16.2, Android 13
  
  -- App details
  app_version TEXT,
  app_build_number TEXT,
  
  -- Push notification tokens
  push_token TEXT, -- FCM/APNS token
  push_enabled INTEGER DEFAULT 1,
  
  -- Location & Network
  last_location TEXT, -- JSON: {lat, lng, accuracy, timestamp}
  timezone TEXT,
  network_type TEXT, -- wifi, 4g, 5g, offline
  
  -- Device capabilities
  supports_offline INTEGER DEFAULT 1,
  supports_background_sync INTEGER DEFAULT 1,
  storage_available_mb INTEGER,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  last_sync_at TEXT,
  last_online_at TEXT,
  
  registered_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Offline Data Queue (sync queue for offline operations)
CREATE TABLE IF NOT EXISTS offline_sync_queue (
  id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  
  -- Operation details
  operation_type TEXT NOT NULL, -- create, update, delete, bulk_update
  entity_type TEXT NOT NULL, -- order, customer, visit, product, etc.
  entity_id TEXT,
  
  -- Data payload
  operation_data TEXT NOT NULL, -- JSON: full data for operation
  
  -- Sync status
  sync_status TEXT DEFAULT 'pending', -- pending, syncing, completed, failed, conflict
  sync_priority INTEGER DEFAULT 5, -- 1-10, higher = more urgent
  
  -- Conflict resolution
  conflict_detected INTEGER DEFAULT 0,
  conflict_reason TEXT,
  server_version TEXT, -- Server data version for conflict detection
  
  -- Retry handling
  retry_count INTEGER DEFAULT 0,
  max_retries INTEGER DEFAULT 3,
  last_retry_at TEXT,
  
  -- Timestamps
  created_at TEXT DEFAULT CURRENT_TIMESTAMP, -- When operation was queued
  synced_at TEXT, -- When successfully synced
  
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id)
);

-- Sync Checkpoints (track last successful sync per entity)
CREATE TABLE IF NOT EXISTS sync_checkpoints (
  id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Entity tracking
  entity_type TEXT NOT NULL, -- orders, customers, products, visits
  
  -- Checkpoint data
  last_sync_timestamp TEXT NOT NULL,
  last_sync_record_id TEXT, -- Last record ID synced
  sync_direction TEXT NOT NULL, -- pull (server->device), push (device->server), bidirectional
  
  -- Metadata
  records_synced INTEGER DEFAULT 0,
  sync_duration_ms INTEGER,
  sync_status TEXT DEFAULT 'success', -- success, partial, failed
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id),
  UNIQUE(device_id, entity_type, sync_direction)
);

-- Push Notifications
CREATE TABLE IF NOT EXISTS push_notifications (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  
  -- Target
  target_type TEXT NOT NULL, -- user, device, segment, broadcast
  target_id TEXT, -- user_id or device_id
  
  -- Notification content
  notification_title TEXT NOT NULL,
  notification_body TEXT NOT NULL,
  notification_icon TEXT, -- Icon URL
  notification_image TEXT, -- Large image URL
  
  -- Action
  action_type TEXT, -- open_app, open_url, deep_link, custom
  action_data TEXT, -- JSON: action payload
  deep_link TEXT, -- salesmate://orders/123
  
  -- Delivery
  delivery_status TEXT DEFAULT 'pending', -- pending, sent, delivered, failed, clicked
  sent_at TEXT,
  delivered_at TEXT,
  clicked_at TEXT,
  
  -- Priority & Scheduling
  priority TEXT DEFAULT 'normal', -- low, normal, high, urgent
  scheduled_for TEXT, -- NULL = send immediately
  expires_at TEXT, -- Auto-delete if not delivered by this time
  
  -- Data payload (silent/data-only notifications)
  data_payload TEXT, -- JSON: background data update
  is_silent INTEGER DEFAULT 0, -- No UI notification, just data
  
  -- Grouping
  notification_channel TEXT, -- orders, visits, messages, alerts
  collapse_key TEXT, -- Group similar notifications
  
  -- Metadata
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Push Notification Deliveries (per-device tracking)
CREATE TABLE IF NOT EXISTS push_notification_deliveries (
  id TEXT PRIMARY KEY,
  notification_id TEXT NOT NULL,
  device_id TEXT NOT NULL,
  
  -- Delivery tracking
  delivery_status TEXT DEFAULT 'pending', -- pending, sent, delivered, failed, clicked
  sent_at TEXT,
  delivered_at TEXT,
  clicked_at TEXT,
  failed_at TEXT,
  
  -- Error tracking
  error_code TEXT,
  error_message TEXT,
  
  -- Engagement
  time_to_click INTEGER, -- Milliseconds from delivery to click
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (notification_id) REFERENCES push_notifications(id),
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id)
);

-- Mobile Sessions (app usage tracking)
CREATE TABLE IF NOT EXISTS mobile_sessions (
  id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  
  -- Session details
  session_start TEXT DEFAULT CURRENT_TIMESTAMP,
  session_end TEXT,
  session_duration INTEGER, -- Seconds
  
  -- Network & Performance
  network_type TEXT, -- wifi, 4g, 5g, offline
  battery_level INTEGER, -- 0-100
  
  -- App state
  app_version TEXT,
  is_background INTEGER DEFAULT 0,
  
  -- Activity
  screens_viewed TEXT, -- JSON: [{screen, timestamp, duration}]
  actions_performed TEXT, -- JSON: [{action, entity, timestamp}]
  
  -- Sync activity
  data_synced_kb INTEGER DEFAULT 0,
  data_downloaded_kb INTEGER DEFAULT 0,
  data_uploaded_kb INTEGER DEFAULT 0,
  
  -- Crashes
  crash_occurred INTEGER DEFAULT 0,
  crash_log TEXT,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id)
);

-- Offline Cache Manifest (track what data is cached)
CREATE TABLE IF NOT EXISTS offline_cache_manifest (
  id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Cache entry
  entity_type TEXT NOT NULL, -- products, customers, orders
  entity_id TEXT NOT NULL,
  
  -- Cache metadata
  cached_at TEXT DEFAULT CURRENT_TIMESTAMP,
  cache_version TEXT, -- Data version for staleness check
  cache_size_kb INTEGER,
  
  -- Expiry
  expires_at TEXT, -- NULL = no expiry
  is_stale INTEGER DEFAULT 0, -- Marked for refresh
  
  -- Access tracking
  last_accessed_at TEXT,
  access_count INTEGER DEFAULT 0,
  
  -- Priority
  cache_priority TEXT DEFAULT 'normal', -- critical, high, normal, low
  auto_refresh INTEGER DEFAULT 1, -- Auto-refresh when online
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id),
  UNIQUE(device_id, entity_type, entity_id)
);

-- App Updates & Feature Flags
CREATE TABLE IF NOT EXISTS app_updates (
  id TEXT PRIMARY KEY,
  
  -- Version info
  version_number TEXT NOT NULL UNIQUE,
  build_number TEXT NOT NULL,
  platform TEXT NOT NULL, -- ios, android, web, all
  
  -- Update details
  update_type TEXT NOT NULL, -- major, minor, patch, hotfix
  is_mandatory INTEGER DEFAULT 0,
  
  -- Release notes
  release_title TEXT,
  release_notes TEXT, -- Markdown format
  
  -- Download
  download_url TEXT, -- App store URL or APK URL
  file_size_mb INTEGER,
  
  -- Rollout strategy
  rollout_percentage INTEGER DEFAULT 100, -- 0-100, gradual rollout
  target_segments TEXT, -- JSON: which user segments get this update
  
  -- Status
  release_status TEXT DEFAULT 'draft', -- draft, testing, released, deprecated
  released_at TEXT,
  deprecated_at TEXT,
  
  -- Minimum version (force update if below this)
  min_supported_version TEXT,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Feature Flags (mobile-specific features)
CREATE TABLE IF NOT EXISTS mobile_feature_flags (
  id TEXT PRIMARY KEY,
  
  -- Feature details
  feature_key TEXT UNIQUE NOT NULL, -- offline_mode, background_sync, camera_upload
  feature_name TEXT NOT NULL,
  feature_description TEXT,
  
  -- Targeting
  is_enabled INTEGER DEFAULT 0,
  platform TEXT, -- ios, android, web, all
  min_app_version TEXT, -- Minimum version required
  
  -- Rollout
  rollout_percentage INTEGER DEFAULT 0, -- 0-100
  target_user_segments TEXT, -- JSON: beta_users, premium_users
  
  -- Configuration
  feature_config TEXT, -- JSON: feature-specific settings
  
  -- Lifecycle
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  expires_at TEXT -- Auto-disable after this date
);

-- Mobile Analytics Events
CREATE TABLE IF NOT EXISTS mobile_analytics_events (
  id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  
  -- Event details
  event_name TEXT NOT NULL, -- app_opened, order_created, sync_completed
  event_category TEXT, -- engagement, commerce, sync, error
  
  -- Event data
  event_properties TEXT, -- JSON: custom properties
  
  -- Context
  screen_name TEXT,
  network_type TEXT,
  is_offline INTEGER DEFAULT 0,
  
  -- Performance
  event_duration_ms INTEGER,
  
  -- Session
  session_id TEXT,
  
  timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id)
);

-- Background Sync Jobs
CREATE TABLE IF NOT EXISTS background_sync_jobs (
  id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  
  -- Job details
  job_type TEXT NOT NULL, -- full_sync, incremental_sync, media_upload, cache_refresh
  job_status TEXT DEFAULT 'pending', -- pending, running, completed, failed, cancelled
  
  -- Scheduling
  scheduled_for TEXT,
  started_at TEXT,
  completed_at TEXT,
  
  -- Progress
  total_items INTEGER DEFAULT 0,
  processed_items INTEGER DEFAULT 0,
  failed_items INTEGER DEFAULT 0,
  
  -- Results
  sync_result TEXT, -- JSON: detailed results
  error_message TEXT,
  
  -- Network constraints
  requires_wifi INTEGER DEFAULT 0,
  requires_charging INTEGER DEFAULT 0,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (device_id) REFERENCES mobile_devices(id)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_mobile_devices_user ON mobile_devices(user_id, tenant_id);
CREATE INDEX IF NOT EXISTS idx_mobile_devices_uuid ON mobile_devices(device_uuid);
CREATE INDEX IF NOT EXISTS idx_offline_queue_device ON offline_sync_queue(device_id, sync_status);
CREATE INDEX IF NOT EXISTS idx_offline_queue_priority ON offline_sync_queue(sync_priority DESC, created_at);
CREATE INDEX IF NOT EXISTS idx_sync_checkpoints_device ON sync_checkpoints(device_id, entity_type);
CREATE INDEX IF NOT EXISTS idx_push_notifications_target ON push_notifications(target_type, target_id, delivery_status);
CREATE INDEX IF NOT EXISTS idx_push_deliveries_notification ON push_notification_deliveries(notification_id, delivery_status);
CREATE INDEX IF NOT EXISTS idx_push_deliveries_device ON push_notification_deliveries(device_id, delivery_status);
CREATE INDEX IF NOT EXISTS idx_mobile_sessions_device ON mobile_sessions(device_id, session_start);
CREATE INDEX IF NOT EXISTS idx_offline_cache_device ON offline_cache_manifest(device_id, entity_type);
CREATE INDEX IF NOT EXISTS idx_mobile_analytics_device ON mobile_analytics_events(device_id, timestamp);
CREATE INDEX IF NOT EXISTS idx_mobile_analytics_event ON mobile_analytics_events(event_name, timestamp);
CREATE INDEX IF NOT EXISTS idx_background_jobs_device ON background_sync_jobs(device_id, job_status);
