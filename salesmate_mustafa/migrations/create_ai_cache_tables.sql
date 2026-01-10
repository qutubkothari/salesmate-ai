-- AI Response Cache and Learning Tables
-- These tables enable cost savings and intelligent learning

-- AI Response Cache
CREATE TABLE IF NOT EXISTS ai_response_cache (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    query_hash TEXT NOT NULL,
    query_text TEXT NOT NULL,
    query_embedding TEXT,
    query_language TEXT DEFAULT 'en',
    response TEXT NOT NULL,
    response_tokens INTEGER DEFAULT 0,
    customer_context TEXT DEFAULT '{}',
    intent TEXT,
    original_cost REAL DEFAULT 0.0,
    hit_count INTEGER DEFAULT 1,
    led_to_order INTEGER DEFAULT 0,
    expires_at TEXT,
    created_at TEXT DEFAULT (DATETIME('now')),
    updated_at TEXT DEFAULT (DATETIME('now')),
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_ai_cache_tenant ON ai_response_cache(tenant_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_ai_cache_hash ON ai_response_cache(query_hash);
CREATE INDEX IF NOT EXISTS idx_ai_cache_expires ON ai_response_cache(expires_at);

-- AI Usage Tracking
CREATE TABLE IF NOT EXISTS ai_usage_tracking (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    query_text TEXT,
    response_source TEXT DEFAULT 'ai',
    cache_id TEXT,
    tokens_used INTEGER DEFAULT 0,
    cost REAL DEFAULT 0.0,
    cost_saved REAL DEFAULT 0.0,
    cache_similarity_score REAL,
    created_at TEXT DEFAULT (DATETIME('now')),
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_ai_usage_tenant ON ai_usage_tracking(tenant_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_ai_usage_date ON ai_usage_tracking(DATE(created_at), tenant_id);

-- Response Effectiveness Tracking
CREATE TABLE IF NOT EXISTS response_effectiveness (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    cache_query_hash TEXT NOT NULL,
    customer_profile_id TEXT,
    led_to_order INTEGER DEFAULT 0,
    order_id TEXT,
    created_at TEXT DEFAULT (DATETIME('now'))
);

CREATE INDEX IF NOT EXISTS idx_effectiveness_hash ON response_effectiveness(cache_query_hash);
