-- AI Intelligence Layer
-- Predictive scoring, churn detection, recommendations, objection handling, risk analysis

-- Lead/Deal Scoring Models (AI-powered)
CREATE TABLE IF NOT EXISTS ai_lead_scores (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    entity_type TEXT CHECK (entity_type IN ('lead', 'deal', 'customer')) NOT NULL,
    entity_id TEXT NOT NULL, -- lead_id, deal_id, or customer_id
    
    -- Scores (0-100)
    conversion_score INTEGER DEFAULT 0, -- Likelihood to convert
    engagement_score INTEGER DEFAULT 0, -- Level of engagement
    quality_score INTEGER DEFAULT 0, -- Lead quality
    urgency_score INTEGER DEFAULT 0, -- Time sensitivity
    fit_score INTEGER DEFAULT 0, -- Product-market fit
    
    -- Overall composite score
    composite_score INTEGER DEFAULT 0, -- Weighted average
    score_tier TEXT CHECK (score_tier IN ('hot', 'warm', 'cold', 'dead')) DEFAULT 'cold',
    
    -- Model metadata
    model_version TEXT DEFAULT 'v1',
    confidence_level REAL DEFAULT 0.0, -- 0.0 to 1.0
    
    -- Contributing factors (JSON)
    score_factors TEXT, -- {activity: 20, deal_size: 15, response_time: 10, ...}
    
    -- Timestamps
    calculated_at TEXT DEFAULT (DATETIME('now')),
    expires_at TEXT, -- Scores can expire and need recalculation
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

-- Churn Prediction & Prevention
CREATE TABLE IF NOT EXISTS ai_churn_predictions (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    customer_id TEXT NOT NULL,
    
    -- Churn risk (0-100)
    churn_risk_score INTEGER NOT NULL,
    churn_probability REAL NOT NULL, -- 0.0 to 1.0
    risk_level TEXT CHECK (risk_level IN ('critical', 'high', 'medium', 'low')) DEFAULT 'low',
    
    -- Risk factors
    inactivity_days INTEGER DEFAULT 0,
    declining_engagement INTEGER DEFAULT 0, -- Boolean as int
    support_issues_count INTEGER DEFAULT 0,
    payment_issues INTEGER DEFAULT 0,
    competitor_mentions INTEGER DEFAULT 0,
    
    -- Churn indicators (JSON)
    risk_factors TEXT, -- {inactivity: 25, support_issues: 15, payment: 10, ...}
    
    -- Recommended actions
    prevention_strategy TEXT, -- JSON array of recommended actions
    
    -- Outcome tracking
    predicted_churn_date TEXT,
    actual_churn_date TEXT,
    prevention_actions_taken TEXT, -- JSON array
    outcome TEXT CHECK (outcome IN ('retained', 'churned', 'pending')) DEFAULT 'pending',
    
    -- Model metadata
    model_version TEXT DEFAULT 'v1',
    confidence_level REAL DEFAULT 0.0,
    
    -- Timestamps
    predicted_at TEXT DEFAULT (DATETIME('now')),
    last_updated TEXT DEFAULT (DATETIME('now')),
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer_profiles_new(id) ON DELETE CASCADE
);

-- Next Best Action Recommendations
CREATE TABLE IF NOT EXISTS ai_recommendations (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    entity_type TEXT CHECK (entity_type IN ('lead', 'deal', 'customer')) NOT NULL,
    entity_id TEXT NOT NULL,
    user_id TEXT, -- Recommended to which user
    
    -- Recommendation details
    recommendation_type TEXT CHECK (recommendation_type IN (
        'follow_up', 'send_proposal', 'schedule_demo', 'offer_discount', 
        'escalate', 'cross_sell', 'upsell', 'retention_action', 'nurture'
    )) NOT NULL,
    
    priority TEXT CHECK (priority IN ('critical', 'high', 'medium', 'low')) DEFAULT 'medium',
    action_title TEXT NOT NULL,
    action_description TEXT,
    
    -- AI rationale
    reasoning TEXT, -- Why this action is recommended
    expected_outcome TEXT, -- What result is expected
    success_probability REAL, -- 0.0 to 1.0
    
    -- Context
    context_data TEXT, -- JSON with relevant context
    triggers TEXT, -- JSON array of what triggered this recommendation
    
    -- Execution tracking
    status TEXT CHECK (status IN ('pending', 'accepted', 'rejected', 'completed', 'expired')) DEFAULT 'pending',
    accepted_at TEXT,
    completed_at TEXT,
    rejected_at TEXT,
    rejection_reason TEXT,
    
    -- Outcome measurement
    actual_outcome TEXT,
    outcome_success INTEGER DEFAULT 0, -- Boolean: did it work?
    
    -- Model metadata
    model_version TEXT DEFAULT 'v1',
    confidence_score REAL DEFAULT 0.0,
    
    -- Timestamps
    created_at TEXT DEFAULT (DATETIME('now')),
    expires_at TEXT, -- Recommendations can expire
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Objection Handling Knowledge Base
CREATE TABLE IF NOT EXISTS ai_objection_patterns (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    
    -- Objection details
    objection_category TEXT CHECK (objection_category IN (
        'price', 'timing', 'competition', 'authority', 'need', 'trust', 'product_fit'
    )) NOT NULL,
    objection_text TEXT NOT NULL,
    objection_keywords TEXT, -- JSON array of keywords
    
    -- Response strategy
    recommended_response TEXT NOT NULL,
    response_script TEXT, -- Detailed script
    handling_technique TEXT, -- 'acknowledge_empathize_resolve', etc.
    
    -- Effectiveness tracking
    times_encountered INTEGER DEFAULT 0,
    times_successful INTEGER DEFAULT 0,
    success_rate REAL DEFAULT 0.0,
    
    -- Context
    typical_stage TEXT, -- Which pipeline stage this appears in
    customer_segment TEXT, -- Which customer types raise this
    
    -- Learning
    is_active INTEGER DEFAULT 1,
    confidence_score REAL DEFAULT 0.5,
    
    created_at TEXT DEFAULT (DATETIME('now')),
    updated_at TEXT DEFAULT (DATETIME('now')),
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

-- Objection Instances (when objections actually occur)
CREATE TABLE IF NOT EXISTS ai_objection_instances (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    pattern_id TEXT, -- Link to pattern if recognized
    deal_id TEXT,
    customer_id TEXT,
    raised_by_user TEXT, -- Who raised the objection
    handled_by_user TEXT, -- Who handled it
    
    -- Objection details
    objection_text TEXT NOT NULL,
    objection_category TEXT,
    detected_confidence REAL, -- How confident AI is in categorization
    
    -- Response
    response_used TEXT,
    response_effective INTEGER, -- Boolean: was it effective?
    
    -- Outcome
    outcome TEXT CHECK (outcome IN ('overcome', 'partially_overcome', 'unresolved', 'deal_lost')) DEFAULT 'unresolved',
    
    -- Timestamps
    raised_at TEXT DEFAULT (DATETIME('now')),
    resolved_at TEXT,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (pattern_id) REFERENCES ai_objection_patterns(id),
    FOREIGN KEY (deal_id) REFERENCES deals(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer_profiles_new(id) ON DELETE CASCADE,
    FOREIGN KEY (raised_by_user) REFERENCES users(id),
    FOREIGN KEY (handled_by_user) REFERENCES users(id)
);

-- Deal Risk Analysis
CREATE TABLE IF NOT EXISTS ai_deal_risks (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    deal_id TEXT NOT NULL,
    
    -- Risk scores
    overall_risk_score INTEGER NOT NULL, -- 0-100
    risk_level TEXT CHECK (risk_level IN ('critical', 'high', 'medium', 'low')) DEFAULT 'low',
    
    -- Risk dimensions
    timing_risk INTEGER DEFAULT 0, -- Deal taking too long
    engagement_risk INTEGER DEFAULT 0, -- Low engagement
    competition_risk INTEGER DEFAULT 0, -- Competitive pressure
    budget_risk INTEGER DEFAULT 0, -- Budget concerns
    authority_risk INTEGER DEFAULT 0, -- Not speaking to decision maker
    technical_risk INTEGER DEFAULT 0, -- Technical fit issues
    
    -- Risk factors (JSON)
    risk_breakdown TEXT, -- Detailed breakdown of risk contributors
    
    -- Warnings
    red_flags TEXT, -- JSON array of specific red flags
    warning_signs TEXT, -- JSON array of warning indicators
    
    -- Mitigation
    recommended_actions TEXT, -- JSON array of risk mitigation steps
    
    -- Tracking
    risk_trend TEXT CHECK (risk_trend IN ('increasing', 'stable', 'decreasing')) DEFAULT 'stable',
    previous_risk_score INTEGER,
    
    -- Model metadata
    model_version TEXT DEFAULT 'v1',
    confidence_level REAL DEFAULT 0.0,
    
    -- Timestamps
    assessed_at TEXT DEFAULT (DATETIME('now')),
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (deal_id) REFERENCES deals(id) ON DELETE CASCADE
);

-- Sentiment Analysis (from conversations)
CREATE TABLE IF NOT EXISTS ai_sentiment_analysis (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    entity_type TEXT CHECK (entity_type IN ('conversation', 'message', 'call', 'email')) NOT NULL,
    entity_id TEXT NOT NULL,
    customer_id TEXT,
    user_id TEXT,
    
    -- Sentiment scores (-100 to +100)
    overall_sentiment INTEGER NOT NULL,
    sentiment_label TEXT CHECK (sentiment_label IN ('very_positive', 'positive', 'neutral', 'negative', 'very_negative')) NOT NULL,
    
    -- Emotional dimensions
    satisfaction_score INTEGER, -- Customer satisfaction
    urgency_score INTEGER, -- How urgent is the need
    frustration_score INTEGER, -- Level of frustration
    excitement_score INTEGER, -- Level of excitement
    
    -- Detected emotions (JSON)
    emotions_detected TEXT, -- {joy: 0.8, anger: 0.1, ...}
    
    -- Key phrases
    positive_phrases TEXT, -- JSON array
    negative_phrases TEXT, -- JSON array
    key_topics TEXT, -- JSON array
    
    -- Intent detection
    detected_intent TEXT, -- 'purchase', 'inquiry', 'complaint', 'support', etc.
    intent_confidence REAL,
    
    -- Text analyzed
    analyzed_text_sample TEXT, -- First 500 chars
    
    -- Model metadata
    model_version TEXT DEFAULT 'v1',
    confidence_score REAL DEFAULT 0.0,
    
    -- Timestamps
    analyzed_at TEXT DEFAULT (DATETIME('now')),
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer_profiles_new(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- AI Model Performance Tracking
CREATE TABLE IF NOT EXISTS ai_model_metrics (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    model_type TEXT CHECK (model_type IN (
        'lead_scoring', 'churn_prediction', 'recommendation', 'objection_handling', 
        'risk_analysis', 'sentiment_analysis'
    )) NOT NULL,
    model_version TEXT NOT NULL,
    
    -- Performance metrics
    total_predictions INTEGER DEFAULT 0,
    correct_predictions INTEGER DEFAULT 0,
    accuracy REAL DEFAULT 0.0,
    precision_score REAL DEFAULT 0.0,
    recall_score REAL DEFAULT 0.0,
    f1_score REAL DEFAULT 0.0,
    
    -- Business impact
    deals_influenced INTEGER DEFAULT 0,
    revenue_impacted REAL DEFAULT 0.0,
    
    -- Period
    period_start TEXT NOT NULL,
    period_end TEXT NOT NULL,
    
    created_at TEXT DEFAULT (DATETIME('now')),
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
);

-- Learning Feedback Loop
CREATE TABLE IF NOT EXISTS ai_learning_feedback (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    model_type TEXT NOT NULL,
    prediction_id TEXT, -- ID from respective prediction table
    
    -- User feedback
    user_id TEXT,
    feedback_type TEXT CHECK (feedback_type IN ('correct', 'incorrect', 'partially_correct', 'not_applicable')) NOT NULL,
    feedback_comment TEXT,
    
    -- Prediction vs Reality
    predicted_value TEXT,
    actual_value TEXT,
    
    -- For model improvement
    feature_importance_feedback TEXT, -- JSON: which factors were most relevant
    
    created_at TEXT DEFAULT (DATETIME('now')),
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_lead_scores_entity ON ai_lead_scores(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_lead_scores_tenant ON ai_lead_scores(tenant_id, composite_score DESC);
CREATE INDEX IF NOT EXISTS idx_churn_predictions_customer ON ai_churn_predictions(customer_id);
CREATE INDEX IF NOT EXISTS idx_churn_predictions_risk ON ai_churn_predictions(tenant_id, risk_level, churn_risk_score DESC);
CREATE INDEX IF NOT EXISTS idx_recommendations_entity ON ai_recommendations(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_recommendations_user ON ai_recommendations(user_id, status);
CREATE INDEX IF NOT EXISTS idx_recommendations_expires ON ai_recommendations(expires_at);
CREATE INDEX IF NOT EXISTS idx_objection_instances_deal ON ai_objection_instances(deal_id);
CREATE INDEX IF NOT EXISTS idx_deal_risks_deal ON ai_deal_risks(deal_id);
CREATE INDEX IF NOT EXISTS idx_deal_risks_tenant ON ai_deal_risks(tenant_id, risk_level);
CREATE INDEX IF NOT EXISTS idx_sentiment_customer ON ai_sentiment_analysis(customer_id, analyzed_at DESC);
CREATE INDEX IF NOT EXISTS idx_sentiment_tenant ON ai_sentiment_analysis(tenant_id, overall_sentiment);
