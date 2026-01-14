-- =========================================
-- FSM Integration - Unified Database Schema
-- Merges FSM field service tables into Salesmate SQLite
-- =========================================

-- 1. PLANTS TABLE (Branches/Locations)
CREATE TABLE IF NOT EXISTS plants (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    location TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    timezone TEXT DEFAULT 'UTC',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    UNIQUE(tenant_id, name)
);

CREATE INDEX IF NOT EXISTS idx_plants_tenant ON plants(tenant_id);
CREATE INDEX IF NOT EXISTS idx_plants_city ON plants(city);

-- 2. SALESMEN TABLE (Field staff - integrated with users)
CREATE TABLE IF NOT EXISTS salesmen (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    user_id TEXT,  -- Link to users table (same person can be user + salesman)
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    plant_id TEXT,  -- Which branch they belong to
    is_active BOOLEAN DEFAULT 1,
    
    -- GPS Tracking
    current_latitude REAL,
    current_longitude REAL,
    last_location_update DATETIME,
    
    -- Performance tracking
    assigned_customers TEXT,  -- JSON array of customer IDs
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE SET NULL,
    UNIQUE(tenant_id, phone)
);

CREATE INDEX IF NOT EXISTS idx_salesmen_tenant ON salesmen(tenant_id);
CREATE INDEX IF NOT EXISTS idx_salesmen_plant ON salesmen(plant_id);
CREATE INDEX IF NOT EXISTS idx_salesmen_active ON salesmen(is_active);
CREATE INDEX IF NOT EXISTS idx_salesmen_user ON salesmen(user_id);

-- 3. SALESMAN TARGETS TABLE
CREATE TABLE IF NOT EXISTS salesman_targets (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    salesman_id TEXT NOT NULL,
    plant_id TEXT,
    
    -- Target period (Month-Year format: "2024-01", "2024-02", etc.)
    period TEXT NOT NULL,  
    
    -- Target metrics
    target_visits INTEGER DEFAULT 0,
    target_orders INTEGER DEFAULT 0,
    target_revenue REAL DEFAULT 0.0,
    
    -- Achievement metrics (updated throughout month)
    achieved_visits INTEGER DEFAULT 0,
    achieved_orders INTEGER DEFAULT 0,
    achieved_revenue REAL DEFAULT 0.0,
    
    -- Additional metrics
    target_new_customers INTEGER DEFAULT 0,
    achieved_new_customers INTEGER DEFAULT 0,
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (salesman_id) REFERENCES salesmen(id) ON DELETE CASCADE,
    FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE SET NULL,
    UNIQUE(tenant_id, salesman_id, period)
);

CREATE INDEX IF NOT EXISTS idx_targets_tenant ON salesman_targets(tenant_id);
CREATE INDEX IF NOT EXISTS idx_targets_salesman ON salesman_targets(salesman_id);
CREATE INDEX IF NOT EXISTS idx_targets_period ON salesman_targets(period);
CREATE INDEX IF NOT EXISTS idx_targets_plant ON salesman_targets(plant_id);

-- 4. VISITS TABLE (Field visit records)
CREATE TABLE IF NOT EXISTS visits (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    salesman_id TEXT NOT NULL,
    customer_id TEXT,
    plant_id TEXT,
    
    -- Customer Info at time of visit
    customer_name TEXT NOT NULL,
    contact_person TEXT,
    customer_phone TEXT,
    
    -- Visit Details
    visit_type TEXT,  -- 'Regular', 'Follow-up', 'New', 'Problem-solving', etc.
    visit_date DATE NOT NULL,
    
    -- Meeting Information
    meeting_types TEXT,  -- JSON array: ['Product Discussion', 'Price Negotiation', 'Order Placement']
    products_discussed TEXT,  -- JSON array of product IDs
    
    -- Outcomes & Next Steps
    potential TEXT CHECK (potential IN ('High', 'Medium', 'Low')),
    competitor_name TEXT,
    can_be_switched BOOLEAN,
    remarks TEXT,
    next_action TEXT,  -- JSON array of action items
    next_action_date DATETIME,
    
    -- Location Data
    gps_latitude REAL NOT NULL,
    gps_longitude REAL NOT NULL,
    location_accuracy REAL,  -- GPS accuracy in meters
    
    -- Time Tracking
    time_in DATETIME NOT NULL,
    time_out DATETIME,
    duration_minutes INTEGER,  -- Auto-calculated
    
    -- Order Information (link to Salesmate orders if created)
    order_id TEXT,  -- FK to orders table if order was created from visit
    
    -- Sync Status
    synced BOOLEAN DEFAULT 1,
    offline_id TEXT,  -- For offline-first mobile app
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (salesman_id) REFERENCES salesmen(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer_profiles(id) ON DELETE SET NULL,
    FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE SET NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_visits_tenant ON visits(tenant_id);
CREATE INDEX IF NOT EXISTS idx_visits_salesman ON visits(salesman_id);
CREATE INDEX IF NOT EXISTS idx_visits_customer ON visits(customer_id);
CREATE INDEX IF NOT EXISTS idx_visits_date ON visits(visit_date);
CREATE INDEX IF NOT EXISTS idx_visits_plant ON visits(plant_id);
CREATE INDEX IF NOT EXISTS idx_visits_order ON visits(order_id);
CREATE INDEX IF NOT EXISTS idx_visits_created ON visits(created_at);

-- 5. VISIT IMAGES TABLE (For field photos)
CREATE TABLE IF NOT EXISTS visit_images (
    id TEXT PRIMARY KEY,
    visit_id TEXT NOT NULL,
    image_url TEXT NOT NULL,
    caption TEXT,
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_visit_images_visit ON visit_images(visit_id);

-- 6. COMPETITOR TRACKING TABLE
CREATE TABLE IF NOT EXISTS competitors (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    UNIQUE(tenant_id, name)
);

CREATE INDEX IF NOT EXISTS idx_competitors_tenant ON competitors(tenant_id);

-- 7. ALTER EXISTING TABLES TO ADD FSM LINKAGE

-- Add plant_id to tenants (link tenant to specific branch)
ALTER TABLE tenants ADD COLUMN plant_id TEXT REFERENCES plants(id);
CREATE INDEX IF NOT EXISTS idx_tenants_plant ON tenants(plant_id);

-- Add visit tracking to customer_profiles
ALTER TABLE customer_profiles ADD COLUMN assigned_salesman_id TEXT REFERENCES salesmen(id);
ALTER TABLE customer_profiles ADD COLUMN last_visit_date DATE;
ALTER TABLE customer_profiles ADD COLUMN next_follow_up_date DATE;
ALTER TABLE customer_profiles ADD COLUMN visit_frequency TEXT;  -- 'Weekly', 'Bi-weekly', 'Monthly'
CREATE INDEX IF NOT EXISTS idx_customers_salesman ON customer_profiles(assigned_salesman_id);

-- Add salesman info to orders (link sales orders to field visits)
ALTER TABLE orders ADD COLUMN salesman_id TEXT REFERENCES salesmen(id);
ALTER TABLE orders ADD COLUMN visit_id TEXT REFERENCES visits(id);
ALTER TABLE orders ADD COLUMN source_type TEXT DEFAULT 'web';  -- 'web', 'whatsapp', 'field_visit'
CREATE INDEX IF NOT EXISTS idx_orders_salesman ON orders(salesman_id);
CREATE INDEX IF NOT EXISTS idx_orders_visit ON orders(visit_id);

-- 8. EXTENDED USERS TABLE FOR FSM ROLES
-- (No schema change needed - use existing role-based system)
-- Users can have roles: 'salesman', 'team_lead', 'admin', 'super_admin'
-- Salesman users will have corresponding salesmen record

-- 9. AUDIT TABLE FOR FIELD ACTIVITIES (Optional but recommended)
CREATE TABLE IF NOT EXISTS field_activity_log (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    salesman_id TEXT NOT NULL,
    activity_type TEXT NOT NULL,  -- 'visit_start', 'visit_end', 'photo_upload', 'location_update'
    activity_data TEXT,  -- JSON with activity details
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id),
    FOREIGN KEY (salesman_id) REFERENCES salesmen(id)
);

CREATE INDEX IF NOT EXISTS idx_field_log_tenant ON field_activity_log(tenant_id);
CREATE INDEX IF NOT EXISTS idx_field_log_salesman ON field_activity_log(salesman_id);
CREATE INDEX IF NOT EXISTS idx_field_log_type ON field_activity_log(activity_type);

-- =========================================
-- VIEWS FOR COMMON QUERIES
-- =========================================

-- Salesman with target progress view
CREATE VIEW IF NOT EXISTS salesman_performance AS
SELECT 
    s.id,
    s.name,
    s.phone,
    s.tenant_id,
    p.name as plant_name,
    st.period,
    st.target_visits,
    st.achieved_visits,
    ROUND(CAST(st.achieved_visits AS FLOAT) / NULLIF(st.target_visits, 0) * 100, 2) as visits_achievement_percent,
    st.target_revenue,
    st.achieved_revenue,
    ROUND(CAST(st.achieved_revenue AS FLOAT) / NULLIF(st.target_revenue, 0) * 100, 2) as revenue_achievement_percent
FROM salesmen s
LEFT JOIN plants p ON s.plant_id = p.id
LEFT JOIN salesman_targets st ON s.id = st.salesman_id AND st.period = strftime('%Y-%m', 'now')
WHERE s.is_active = 1;

-- Daily visits summary view
CREATE VIEW IF NOT EXISTS daily_visit_summary AS
SELECT 
    DATE(v.visit_date) as visit_date,
    v.salesman_id,
    s.name as salesman_name,
    COUNT(*) as total_visits,
    SUM(CASE WHEN v.time_out IS NOT NULL THEN v.duration_minutes ELSE 0 END) as total_field_minutes,
    COUNT(DISTINCT v.customer_id) as unique_customers,
    COUNT(DISTINCT v.order_id) as orders_created,
    GROUP_CONCAT(DISTINCT v.product_id) as products_discussed
FROM visits v
LEFT JOIN salesmen s ON v.salesman_id = s.id
GROUP BY DATE(v.visit_date), v.salesman_id;

-- =========================================
-- MIGRATION COMPLETE
-- =========================================
-- This migration adds full FSM (Field Service Management) support to Salesmate
-- Key tables:
-- - plants: Branch/location management
-- - salesmen: Field staff profiles with GPS tracking
-- - salesman_targets: Monthly targets and achievement tracking
-- - visits: Individual field visit records with location, time, outcomes
-- - visit_images: Photos from field visits
-- - competitors: Competitor tracking at field level
--
-- Connections to existing Salesmate tables:
-- - customer_profiles: Now tracks assigned salesman and visit history
-- - orders: Now tracks source (field visit) and salesman
-- - users: Salesmen are users with 'salesman' role
--
-- Views for reporting:
-- - salesman_performance: Targets vs achievement
-- - daily_visit_summary: Daily field activity overview
-- =========================================
