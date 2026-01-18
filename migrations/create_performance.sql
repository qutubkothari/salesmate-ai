-- Performance & Scale Schema
-- Caching, query optimization, rate limiting, health monitoring, system metrics
-- Supports: In-memory cache, query performance tracking, auto-scaling

-- Cache Entries (In-memory cache simulation in SQLite)
CREATE TABLE IF NOT EXISTS cache_entries (
  id TEXT PRIMARY KEY,
  cache_key TEXT UNIQUE NOT NULL,
  cache_value TEXT NOT NULL, -- JSON serialized value
  cache_type TEXT NOT NULL, -- query_result, api_response, computed_data, session_data
  
  -- TTL & Expiration
  ttl_seconds INTEGER DEFAULT 3600, -- 1 hour default
  expires_at TEXT NOT NULL,
  
  -- Cache metadata
  size_bytes INTEGER,
  hit_count INTEGER DEFAULT 0,
  last_accessed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  -- Eviction
  cache_priority TEXT DEFAULT 'normal', -- critical, high, normal, low
  can_evict INTEGER DEFAULT 1,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Query Performance Tracking
CREATE TABLE IF NOT EXISTS query_performance (
  id TEXT PRIMARY KEY,
  tenant_id TEXT,
  
  -- Query details
  query_type TEXT NOT NULL, -- SELECT, INSERT, UPDATE, DELETE
  query_signature TEXT NOT NULL, -- Normalized query (without values)
  table_name TEXT,
  
  -- Performance metrics
  execution_time_ms REAL NOT NULL,
  rows_affected INTEGER,
  rows_scanned INTEGER,
  
  -- Optimization flags
  used_index INTEGER DEFAULT 0,
  is_slow_query INTEGER DEFAULT 0, -- Threshold: >1000ms
  needs_optimization INTEGER DEFAULT 0,
  
  -- Context
  endpoint TEXT, -- API endpoint that triggered the query
  user_id TEXT,
  
  executed_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Rate Limiting
CREATE TABLE IF NOT EXISTS rate_limits (
  id TEXT PRIMARY KEY,
  tenant_id TEXT,
  
  -- Rate limit target
  limit_type TEXT NOT NULL, -- ip, user, tenant, api_key, endpoint
  limit_key TEXT NOT NULL, -- IP address, user ID, tenant ID, etc.
  
  -- Limit configuration
  max_requests INTEGER NOT NULL,
  window_seconds INTEGER NOT NULL, -- Time window (e.g., 60 for per-minute)
  
  -- Current state
  current_count INTEGER DEFAULT 0,
  window_start TEXT DEFAULT CURRENT_TIMESTAMP,
  
  -- Actions on limit
  is_blocked INTEGER DEFAULT 0,
  blocked_until TEXT,
  
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(limit_type, limit_key)
);

-- API Performance Metrics
CREATE TABLE IF NOT EXISTS api_metrics (
  id TEXT PRIMARY KEY,
  tenant_id TEXT,
  
  -- Endpoint details
  endpoint TEXT NOT NULL,
  http_method TEXT NOT NULL,
  
  -- Performance
  response_time_ms REAL NOT NULL,
  status_code INTEGER NOT NULL,
  
  -- Request details
  request_size_bytes INTEGER,
  response_size_bytes INTEGER,
  
  -- User context
  user_id TEXT,
  ip_address TEXT,
  user_agent TEXT,
  
  -- Error tracking
  has_error INTEGER DEFAULT 0,
  error_type TEXT,
  error_message TEXT,
  
  timestamp TEXT DEFAULT CURRENT_TIMESTAMP
);

-- System Health Checks
CREATE TABLE IF NOT EXISTS health_checks (
  id TEXT PRIMARY KEY,
  
  -- Check details
  check_type TEXT NOT NULL, -- database, api, external_service, disk_space, memory
  check_name TEXT NOT NULL,
  
  -- Status
  status TEXT NOT NULL, -- healthy, degraded, unhealthy
  
  -- Metrics
  response_time_ms REAL,
  metric_value REAL, -- Generic metric (e.g., CPU%, memory MB, disk GB)
  metric_unit TEXT,
  
  -- Thresholds
  warning_threshold REAL,
  critical_threshold REAL,
  
  -- Details
  status_message TEXT,
  error_details TEXT,
  
  checked_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Database Connection Pool Stats
CREATE TABLE IF NOT EXISTS connection_pool_stats (
  id TEXT PRIMARY KEY,
  
  -- Pool metrics
  active_connections INTEGER DEFAULT 0,
  idle_connections INTEGER DEFAULT 0,
  waiting_requests INTEGER DEFAULT 0,
  
  -- Performance
  avg_wait_time_ms REAL,
  max_connections INTEGER,
  
  -- Status
  pool_status TEXT DEFAULT 'healthy', -- healthy, warning, critical
  
  recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Query Optimization Suggestions
CREATE TABLE IF NOT EXISTS query_optimizations (
  id TEXT PRIMARY KEY,
  
  -- Query details
  query_signature TEXT NOT NULL,
  table_name TEXT,
  
  -- Problem
  issue_type TEXT NOT NULL, -- missing_index, full_table_scan, n_plus_one, inefficient_join
  severity TEXT NOT NULL, -- low, medium, high, critical
  
  -- Suggestion
  suggestion TEXT NOT NULL,
  estimated_improvement_percent REAL,
  
  -- Implementation
  implementation_sql TEXT,
  is_implemented INTEGER DEFAULT 0,
  implemented_at TEXT,
  
  -- Impact
  affected_endpoints TEXT, -- JSON array of endpoints
  avg_execution_time_before_ms REAL,
  avg_execution_time_after_ms REAL,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Load Balancer Metrics
CREATE TABLE IF NOT EXISTS load_balancer_metrics (
  id TEXT PRIMARY KEY,
  
  -- Server instance
  server_id TEXT NOT NULL,
  server_ip TEXT,
  
  -- Load metrics
  active_requests INTEGER DEFAULT 0,
  requests_per_second REAL,
  cpu_usage_percent REAL,
  memory_usage_mb REAL,
  
  -- Health
  is_healthy INTEGER DEFAULT 1,
  last_health_check TEXT DEFAULT CURRENT_TIMESTAMP,
  
  recorded_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Auto-scaling Events
CREATE TABLE IF NOT EXISTS autoscaling_events (
  id TEXT PRIMARY KEY,
  
  -- Trigger
  trigger_type TEXT NOT NULL, -- cpu_high, memory_high, request_spike, scheduled
  trigger_metric TEXT,
  trigger_value REAL,
  trigger_threshold REAL,
  
  -- Action
  action TEXT NOT NULL, -- scale_up, scale_down
  instances_before INTEGER,
  instances_after INTEGER,
  
  -- Result
  status TEXT DEFAULT 'pending', -- pending, in_progress, completed, failed
  result_message TEXT,
  
  -- Timing
  triggered_at TEXT DEFAULT CURRENT_TIMESTAMP,
  completed_at TEXT
);

-- Performance Alerts
CREATE TABLE IF NOT EXISTS performance_alerts (
  id TEXT PRIMARY KEY,
  
  -- Alert details
  alert_type TEXT NOT NULL, -- slow_query, high_error_rate, high_latency, resource_limit
  severity TEXT NOT NULL, -- info, warning, error, critical
  
  -- Alert data
  metric_name TEXT,
  metric_value REAL,
  threshold_value REAL,
  
  -- Message
  alert_title TEXT NOT NULL,
  alert_message TEXT NOT NULL,
  
  -- Resolution
  status TEXT DEFAULT 'active', -- active, acknowledged, resolved
  acknowledged_by TEXT,
  acknowledged_at TEXT,
  resolved_at TEXT,
  resolution_notes TEXT,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_cache_entries_key ON cache_entries(cache_key);
CREATE INDEX IF NOT EXISTS idx_cache_entries_expires ON cache_entries(expires_at, can_evict);
CREATE INDEX IF NOT EXISTS idx_cache_entries_priority ON cache_entries(cache_priority, hit_count DESC);

CREATE INDEX IF NOT EXISTS idx_query_perf_slow ON query_performance(is_slow_query, execution_time_ms DESC);
CREATE INDEX IF NOT EXISTS idx_query_perf_table ON query_performance(table_name, executed_at);
CREATE INDEX IF NOT EXISTS idx_query_perf_signature ON query_performance(query_signature);

CREATE INDEX IF NOT EXISTS idx_rate_limits_key ON rate_limits(limit_type, limit_key);
CREATE INDEX IF NOT EXISTS idx_rate_limits_blocked ON rate_limits(is_blocked, blocked_until);

CREATE INDEX IF NOT EXISTS idx_api_metrics_endpoint ON api_metrics(endpoint, timestamp);
CREATE INDEX IF NOT EXISTS idx_api_metrics_errors ON api_metrics(has_error, timestamp);
CREATE INDEX IF NOT EXISTS idx_api_metrics_tenant ON api_metrics(tenant_id, timestamp);

CREATE INDEX IF NOT EXISTS idx_health_checks_status ON health_checks(status, checked_at);
CREATE INDEX IF NOT EXISTS idx_health_checks_type ON health_checks(check_type, checked_at);

CREATE INDEX IF NOT EXISTS idx_query_opt_severity ON query_optimizations(severity, is_implemented);

CREATE INDEX IF NOT EXISTS idx_alerts_status ON performance_alerts(status, severity, created_at);
CREATE INDEX IF NOT EXISTS idx_alerts_type ON performance_alerts(alert_type, created_at);
