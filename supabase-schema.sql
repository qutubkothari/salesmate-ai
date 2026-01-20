-- Supabase Schema
-- Generated from local SQLite database

CREATE TABLE users (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
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
      created_at TEXT DEFAULT (TIMESTAMP('now')),
      updated_at TEXT DEFAULT (TIMESTAMP('now')),
      FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
      UNIQUE(tenant_id, phone)
    );

CREATE TABLE whatsapp_connections (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    session_name TEXT NOT NULL,
    phone_number TEXT,
    status TEXT DEFAULT 'disconnected',
    qr_code TEXT,
    last_connected TEXT,
    created_at TEXT DEFAULT (TIMESTAMP('now')),
    updated_at TEXT DEFAULT (TIMESTAMP('now')), connected_at TEXT, last_error TEXT, salesman_id TEXT, provider TEXT DEFAULT 'whatsapp_web', is_primary INTEGER DEFAULT 0,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    UNIQUE(tenant_id, session_name)
);

CREATE TABLE conversations_new (
  id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  tenant_id TEXT NOT NULL,
  end_user_phone TEXT NOT NULL,
  end_user_name TEXT,
  salesman_id TEXT,
  auto_assigned_to_salesman INTEGER DEFAULT 0,
  business_profile TEXT, -- JSON
  context TEXT, -- JSON with visit context, target context
  learning_data TEXT, -- JSON
  messages_count INTEGER DEFAULT 0,
  last_message_at TEXT,
  status TEXT DEFAULT 'active', -- active, archived, resolved
  created_at TEXT DEFAULT (TIMESTAMP('now')),
  updated_at TEXT DEFAULT (TIMESTAMP('now')),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  FOREIGN KEY (salesman_id) REFERENCES sales_users(id)
);

CREATE TABLE messages (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      tenant_id TEXT,
      conversation_id TEXT,
      sender TEXT,
      message_body TEXT,
      message_type TEXT,
      created_at TEXT DEFAULT (TIMESTAMP('now'))
    , whatsapp_message_id TEXT);

CREATE TABLE inbound_messages (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      tenant_id TEXT,
      from_phone TEXT,
      body TEXT,
      received_at TEXT DEFAULT (TIMESTAMP('now')),
      message_id TEXT
    );

CREATE TABLE categories (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    created_at TEXT DEFAULT (TIMESTAMP('now')),
    updated_at TEXT DEFAULT (TIMESTAMP('now')),
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    UNIQUE(tenant_id, name)
);

CREATE TABLE salesmen (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    user_id TEXT,  -- Link to users table (same person can be user + salesman)
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    plant_id TEXT,  -- Which branch they belong to
    is_active BOOLEAN DEFAULT 1,
    
    -- GPS Tracking
    current_latitude NUMERIC,
    current_longitude NUMERIC,
    last_location_update TIMESTAMP,
    
    -- Performance tracking
    assigned_customers TEXT,  -- JSON array of customer IDs
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE SET NULL,
    UNIQUE(tenant_id, phone)
);

CREATE TABLE plants (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    location TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    timezone TEXT DEFAULT 'UTC',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    UNIQUE(tenant_id, name)
);

CREATE TABLE visits (
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
    next_action_date TIMESTAMP,
    
    -- Location Data
    gps_latitude NUMERIC NOT NULL,
    gps_longitude NUMERIC NOT NULL,
    location_accuracy NUMERIC,  -- GPS accuracy in meters
    
    -- Time Tracking
    time_in TIMESTAMP NOT NULL,
    time_out TIMESTAMP,
    duration_minutes INTEGER,  -- Auto-calculated
    
    -- Order Information (link to Salesmate orders if created)
    order_id TEXT,  -- FK to orders table if order was created from visit
    
    -- Sync Status
    synced BOOLEAN DEFAULT 1,
    offline_id TEXT,  -- For offline-first mobile app
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, checkin_time TEXT, checkin_latitude NUMERIC, checkin_longitude NUMERIC, checkout_time TEXT, checkout_latitude NUMERIC, checkout_longitude NUMERIC, actual_duration INTEGER,
    
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (salesman_id) REFERENCES salesmen(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer_profiles(id) ON DELETE SET NULL,
    FOREIGN KEY (plant_id) REFERENCES plants(id) ON DELETE SET NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL
);

