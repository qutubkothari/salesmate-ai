# FSM-Salesmate Integration Plan

**Goal:** Merge Field Service Management (FSM) app with Salesmate to create a unified **FSM-Salesmate** platform

---

## 1. CURRENT STATE ANALYSIS

### FSM App (React Native + Express + Supabase PostgreSQL)
- **Purpose:** Field sales force management with visit tracking, targets, reporting
- **Tech Stack:**
  - Frontend: React Native (Expo) for mobile
  - Backend: Express.js (Node.js) with cron jobs
  - Database: Supabase PostgreSQL
  - Real-time: WhatsApp integration via external API
  - State: Zustand

**Key Features:**
- Salesman management & GPS tracking
- Visit scheduling & tracking (location, time, outcomes)
- Customer management with product discussions
- Sales targets by salesman
- Daily WhatsApp summaries to management
- Multi-tenant support
- Offline sync capability
- Bilingual support (Arabic/English)
- Visit type breakdown & reporting

**Database Tables (FSM):**
- `salesmen` - Field staff profiles
- `customers` - Client database
- `products` - Product catalog  
- `competitors` - Competitor tracking
- `visits` - Visit records with GPS/timing
- `salesman_targets` - Sales targets
- `plants` - Branch/location management
- `users` - Admin/super-admin management
- `report_send_log` - WhatsApp report history

---

### Salesmate (Node.js + SQLite + WhatsApp)
- **Purpose:** WhatsApp-based sales automation with AI
- **Tech Stack:**
  - Frontend: Web (React/Vue)
  - Backend: Express.js + PM2 + Scheduler
  - Database: SQLite (local) + Website embeddings
  - AI: OpenAI integration
  - WhatsApp: Multiple APIs (Maytapi, WAHA, Zoho)

**Key Features:**
- Customer WhatsApp conversations
- AI-powered product Q&A
- Order management & carts
- Broadcast campaigns
- Lead scoring
- Discount management
- Zoho integration
- Document upload & processing
- Multi-user RBAC
- Desktop agent support

**Database Tables (Salesmate):**
- `tenants` - Business accounts
- `conversations` - WhatsApp chat records
- `messages` - Individual messages
- `customer_profiles` - Lead/customer data
- `products` - Product catalog
- `orders` - Order records
- `broadcasts` - Campaign messages
- `users` - Team members
- `website_embeddings` - AI context

---

## 2. OVERLAP & DUPLICATION ANALYSIS

### EXACT DUPLICATES (Need to Merge)
| Entity | FSM Table | Salesmate Table | Recommendation |
|--------|-----------|-----------------|----------------|
| **Sales Staff** | `salesmen` | `users` (with role filter) | Merge into unified user system |
| **Customers** | `customers` | `customer_profiles` | Unify customer schema |
| **Products** | `products` | `products` | Single product catalog |
| **Targets/KPIs** | `salesman_targets` | (None in Salesmate) | Extend Salesmate with FSM targets |
| **Business Units** | `plants` | (None - uses `tenants`) | Map plants to multi-tenant structure |

### COMPLEMENTARY (Extend Each Other)
| FSM Capability | Salesmate Capability | Integration Point |
|---|---|---|
| Visit GPS tracking | Customer conversations | **Attach visit location to WhatsApp leads** |
| Sales targets | Order tracking | **Auto-create orders from visit outcomes** |
| Competitor tracking | AI context | **AI suggests alternatives when competitor mentioned** |
| Daily reports | Broadcasts | **Auto-generate visit summaries as WhatsApp broadcasts** |
| Offline sync | Message queuing | **Sync offline visits when back online** |

### UNIQUE TO FSM (Needed in Combined System)
- Field staff GPS tracking & geofencing
- Visit scheduling with actual on-ground timing
- Competitor intelligence tracking
- Sales target management & achievement %
- Field-specific reporting (visits/day, time in field)
- Offline-first mobile app

### UNIQUE TO SALESMATE (Needed in Combined System)
- AI-powered customer engagement
- Automated order processing via chat
- Document/knowledge base integration
- Real-time broadcast campaigns
- Advanced CRM lead scoring
- Multi-channel communication (WhatsApp, Email, SMS)

---

## 3. PROPOSED ARCHITECTURE

```
FSM-Salesmate (Unified Platform)
├── Backend (Node.js + Express)
│   ├── Core Services
│   │   ├── Auth Service (JWT + RBAC)
│   │   ├── User Service (Salesmen + Team)
│   │   ├── Customer Service (Unified profiles)
│   │   ├── Product Service
│   │   ├── Order Service
│   │   ├── Visit Service (NEW - FSM)
│   │   ├── Target Service (NEW - FSM)
│   │   ├── AI Service (Salesmate)
│   │   ├── Broadcast Service (Salesmate)
│   │   └── Reporting Service
│   ├── Database Layer
│   │   ├── SQLite (primary) + Supabase (optional backup)
│   │   ├── Unified schema with FSM tables
│   │   └── Website embeddings for AI
│   ├── Integrations
│   │   ├── WhatsApp (Multiple APIs)
│   │   ├── Zoho (Orders/Customers/Invoices)
│   │   ├── OpenAI (AI Responses)
│   │   └── Google Maps (GPS tracking)
│   └── Schedulers
│       ├── Cron jobs (daily summaries)
│       ├── Message queue processor
│       └── Report generator
│
├── Frontend - Mobile (React Native/Expo) - FSM
│   ├── Field Staff App
│   │   ├── Visit Management
│   │   ├── GPS Tracking
│   │   ├── Customer Profile
│   │   ├── Products & Competitors
│   │   ├── Offline Sync
│   │   └── Report View
│   └── Management Dashboard
│       ├── Team Performance
│       ├── Sales Targets
│       ├── Daily Reports
│       └── Analytics
│
├── Frontend - Web (React) - Salesmate + FSM
│   ├── Admin Dashboard
│   │   ├── Conversations View
│   │   ├── Orders & Carts
│   │   ├── Customer Profiles
│   │   ├── Broadcast Campaigns
│   │   ├── Products & Inventory
│   │   ├── Team Management
│   │   ├── Visit Insights
│   │   ├── Sales Targets
│   │   └── Reports
│   ├── Salesman Dashboard
│   │   ├── Today's Visits
│   │   ├── Customer Interactions
│   │   ├── Orders Received
│   │   ├── Target Progress
│   │   └── Reports
│   └── Customer Portal
│       ├── Order History
│       ├── Account Info
│       └── Chat Support
│
└── Infrastructure
    ├── Hostinger VPS (Primary)
    ├── PM2 Process Manager
    ├── SQLite Database
    ├── Website Embeddings
    └── Backup & Replication
```

---

## 4. DETAILED INTEGRATION STEPS

### **PHASE 1: Database Consolidation (Week 1)**

#### Step 1.1: Extend SQLite with FSM Tables
```sql
-- Create FSM tables in Salesmate SQLite (migrations/008_fsm_integration.sql)
CREATE TABLE IF NOT EXISTS salesmen (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    is_active BOOLEAN DEFAULT 1,
    location_longitude REAL,
    location_latitude REAL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

CREATE TABLE IF NOT EXISTS visits (
    id TEXT PRIMARY KEY,
    salesman_id TEXT NOT NULL,
    customer_id TEXT,
    customer_name TEXT,
    products_discussed TEXT, -- JSON array
    next_action TEXT,
    next_action_date DATETIME,
    potential TEXT CHECK (potential IN ('High', 'Medium', 'Low')),
    competitor_name TEXT,
    remarks TEXT,
    gps_latitude REAL,
    gps_longitude REAL,
    time_in DATETIME,
    time_out DATETIME,
    visit_type TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (salesman_id) REFERENCES salesmen(id),
    FOREIGN KEY (customer_id) REFERENCES customer_profiles(id)
);

CREATE TABLE IF NOT EXISTS salesman_targets (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    salesman_id TEXT NOT NULL,
    month TEXT,
    target_value REAL,
    achieved_value REAL,
    created_at DATETIME,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id),
    FOREIGN KEY (salesman_id) REFERENCES salesmen(id)
);

CREATE TABLE IF NOT EXISTS plants (
    id TEXT PRIMARY KEY,
    tenant_id TEXT NOT NULL,
    name TEXT NOT NULL,
    location TEXT,
    created_at DATETIME,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);
```

#### Step 1.2: Unify Customer Schema
```javascript
// Merge FSM customers + Salesmate customer_profiles
const unifiedCustomerSchema = {
    id: TEXT PRIMARY KEY,
    tenant_id: TEXT,
    phone_number: TEXT,
    name: TEXT,
    email: TEXT,
    contact_person: TEXT,
    address: TEXT,
    city: TEXT,
    state: TEXT,
    pincode: TEXT,
    gst_number: TEXT,
    
    // From customer_profiles (Salesmate)
    lead_score: INTEGER,
    customer_type: TEXT,
    total_orders: INTEGER,
    total_spent: REAL,
    heat: TEXT,
    
    // From customers (FSM)
    // All merged above
    
    created_at: DATETIME,
    updated_at: DATETIME
};
```

#### Step 1.3: Map Plants to Multi-Tenant
- FSM `plants` = Physical branches/locations
- Salesmate `tenants` = Business entities (can be same company's different locations)
- **Solution:** Add `plant_id` FK to `tenants` table
  ```sql
  ALTER TABLE tenants ADD COLUMN plant_id TEXT REFERENCES plants(id);
  ```

---

### **PHASE 2: API Integration (Week 2)**

#### Step 2.1: Create Unified API Endpoints
```
SALESMEN/USERS:
POST   /api/salesmen              - Create salesman/user
GET    /api/salesmen/:id          - Get salesman details
PATCH  /api/salesmen/:id/location - Update GPS location
GET    /api/salesmen/:id/targets  - Get monthly targets
GET    /api/salesmen/:id/visits   - Get visit history

VISITS:
POST   /api/visits                - Create visit record
GET    /api/visits/:salesman_id   - Get salesman's visits
GET    /api/visits/summary        - Daily visit summary
PUT    /api/visits/:id/complete   - Mark visit as completed

TARGETS:
POST   /api/targets               - Set monthly target
GET    /api/targets/:id           - Get target progress
PATCH  /api/targets/:id/achieved  - Update achieved value

CUSTOMERS (UNIFIED):
GET    /api/customers             - Search across FSM + Salesmate
POST   /api/customers             - Create new customer
PATCH  /api/customers/:id         - Update customer
GET    /api/customers/:id/visits  - Link visit history
GET    /api/customers/:id/orders  - Link order history
```

#### Step 2.2: Merge User/Salesman Service
**New file:** `services/unifiedUserService.js`
```javascript
const unifiedUserService = {
  // Create salesman (FSM staff) and auto-create user (Salesmate team)
  createSalesman: async (tenantId, data) => {
    // 1. Create in salesmen table
    // 2. Create in users table with role='salesman'
    // 3. Link both records
    // 4. Return unified user object
  },
  
  // Get user with both FSM + Salesmate context
  getUserWithContext: async (userId) => {
    // Fetch from users table
    // If salesman, also fetch salesmen, targets, visits
    // Return unified profile
  },
  
  // Sync location (for GPS tracking)
  updateLocation: async (salesmanId, lat, lng) => {
    // Update salesmen.location_*
    // Log to visit if currently "on visit"
  }
};
```

#### Step 2.3: Link Visits to WhatsApp Conversations
```javascript
// When salesman completes visit -> trigger WhatsApp summary
// Link visit to existing customer conversation
const linkVisitToConversation = async (visitId) => {
  const visit = await getVisit(visitId);
  const customer = await getCustomer(visit.customer_id);
  
  // Find or create conversation
  let conversation = await dbClient
    .from('conversations')
    .select('*')
    .eq('end_user_phone', customer.phone_number)
    .eq('tenant_id', visit.tenant_id)
    .single();
  
  if (!conversation) {
    conversation = await createConversation({
      tenant_id: visit.tenant_id,
      end_user_phone: customer.phone_number,
      metadata: { visit_id: visitId }
    });
  } else {
    // Add visit to conversation metadata
    await updateConversation(conversation.id, {
      metadata: { ...conversation.metadata, visit_id: visitId }
    });
  }
  
  // Store visit message in messages table
  await createMessage({
    conversation_id: conversation.id,
    sender: 'system',
    message_body: `Visit Summary:\n${formatVisitSummary(visit)}`,
    message_type: 'visit_summary'
  });
};
```

---

### **PHASE 3: Frontend Integration (Week 3)**

#### Step 3.1: Consolidate Navigation
**Salesmate Web Dashboard** (existing):
- Add new "Field Management" section
  - Team Visits (map view)
  - Salesman Performance
  - Daily Reports
  - Target Management

**FSM Mobile App** (existing):
- Keep as-is, but add AI chat from Salesmate
  - Quick WhatsApp template suggestions
  - Customer AI assistant in visit flow

#### Step 3.2: Unified Customer View
```javascript
// New component: CustomerUnifiedProfile
const CustomerProfile = ({ customerId }) => {
  const customer = getUnifiedCustomer(customerId);
  
  return (
    <div>
      {/* Salesmate section */}
      <OrderHistory orders={customer.orders} />
      <ConversationHistory conversations={customer.conversations} />
      <AIChatWidget conversation={customer.activeConversation} />
      
      {/* FSM section */}
      <VisitHistory visits={customer.visits} />
      <VisitMap visits={customer.visits} />
      <SalesmanAssignment salesman={customer.assignedSalesman} />
      <TargetProgress salesman={customer.assignedSalesman} />
    </div>
  );
};
```

#### Step 3.3: Add Visit Widget to Salesmate Web
```javascript
// New widget: TodayVisits
const TodayVisits = ({ tenantId }) => {
  const visits = getTodayVisits(tenantId);
  
  return (
    <Card title="Field Team Activity">
      <Map visits={visits} />
      <SalesmanList 
        salesmen={visits.map(v => v.salesman)}
        onViewDetails={openVisitDetail}
      />
    </Card>
  );
};
```

---

### **PHASE 4: Business Logic Integration (Week 4)**

#### Step 4.1: Auto-Generate Orders from Visits
```javascript
// When visit completed with "products_discussed"
const onVisitCompleted = async (visitId) => {
  const visit = await getVisit(visitId);
  const customer = await getCustomer(visit.customer_id);
  
  if (visit.products_discussed?.length > 0) {
    // Create order draft in Salesmate
    const order = await createOrder({
      tenant_id: visit.tenant_id,
      customer_id: customer.id,
      items: visit.products_discussed.map(productId => ({
        product_id: productId,
        quantity: 1  // Default, customer can adjust
      })),
      source: 'field_visit',
      metadata: { visit_id: visitId }
    });
    
    // Send WhatsApp to customer with order preview
    const message = formatOrderPreview(order);
    await sendWhatsAppMessage(customer.phone_number, message);
  }
};
```

#### Step 4.2: Sync Targets to AI Knowledge
```javascript
// When salesman asks AI about targets/performance
const getAIContextWithTargets = async (tenantId, salesmanId) => {
  const salesman = await getSalesman(salesmanId);
  const currentTarget = await getCurrentTarget(salesmanId);
  const monthlyVisits = await getMonthlyVisits(salesmanId);
  
  return {
    // ... existing context
    salesman_context: {
      name: salesman.name,
      monthly_target: currentTarget.target_value,
      achieved_so_far: currentTarget.achieved_value,
      visits_completed: monthlyVisits.completed,
      visits_pending: monthlyVisits.pending,
      performance_percentage: (currentTarget.achieved_value / currentTarget.target_value * 100).toFixed(0)
    }
  };
};
```

#### Step 4.3: Auto-Generate Daily Reports
```javascript
// Cron job: Daily summary at 6 PM (existing from FSM)
const sendDailySummary = async (tenantId) => {
  // Fetch all salesmen for tenant
  const salesmen = await getSalesmen(tenantId);
  
  for (const salesman of salesmen) {
    const summary = {
      visits_today: await countVisits(salesman.id, 'today'),
      customers_met: await countUniqueCustomers(salesman.id, 'today'),
      products_discussed: await aggregateProducts(salesman.id, 'today'),
      orders_created: await countOrders(salesman.id, 'today'),
      next_actions: await getNextActions(salesman.id, 'today')
    };
    
    // Get admin phone
    const admin = await getAdminUser(tenantId);
    
    // Send WhatsApp summary (existing FSM code)
    await sendWhatsAppMessage(
      admin.phone_number,
      formatDailySummary(salesman, summary)
    );
  }
};
```

---

## 5. DUPLICATION ELIMINATION CHECKLIST

### Backend Services
- [ ] Merge `userService.js` + FSM user service into `unifiedUserService.js`
- [ ] Merge product services (single source)
- [ ] Consolidate customer APIs
- [ ] Unify authentication (both use JWT)
- [ ] Merge error handling & logging

### Database
- [ ] Create migration to add FSM tables to Salesmate SQLite
- [ ] Map FSM customers → Salesmate customer_profiles
- [ ] Synchronize product catalogs
- [ ] Consolidate user management
- [ ] Add indexes for performance

### APIs & Routes
- [ ] Merge `/api/users` and `/api/salesmen` 
- [ ] Merge `/api/customers` endpoints
- [ ] Merge `/api/products` endpoints
- [ ] Create new `/api/visits` endpoints
- [ ] Create new `/api/targets` endpoints

### Frontend
- [ ] Consolidate navigation components
- [ ] Create unified customer view
- [ ] Add field management dashboard
- [ ] Merge authentication flows
- [ ] Unify styling/theming

### Configuration
- [ ] Single `.env` file for both systems
- [ ] Unified database config
- [ ] Merged package.json (de-duplicate deps)
- [ ] Single PM2 config

---

## 6. STEP-BY-STEP IMPLEMENTATION ROADMAP

### **Week 1: Database & Core Services**
1. Create migration file: `migrations/008_fsm_integration.sql`
2. Add FSM tables to SQLite
3. Create `services/unifiedUserService.js`
4. Create `services/visitService.js`
5. Create `services/targetService.js`
6. Update `package.json` (merge dependencies)

### **Week 2: API Integration**
1. Create `routes/api/visits.js`
2. Create `routes/api/salesmen.js` (merge with users)
3. Create `routes/api/targets.js`
4. Create `routes/api/plants.js`
5. Update `routes/api/customers.js` to include visit history
6. Test all endpoints

### **Week 3: Frontend Changes**
1. Add "Field Team" section to Salesmate dashboard
2. Create visits map component
3. Create salesman performance widget
4. Add visit detail view
5. Create target progress widget
6. Test mobile/web navigation

### **Week 4: Business Logic & Testing**
1. Implement auto-order creation from visits
2. Implement daily report generation
3. Implement visit-to-conversation linking
4. Integration testing
5. UAT with sample data
6. Production deployment

---

## 7. DATA MIGRATION STRATEGY

### **For Existing FSM Data:**
```bash
# Export FSM PostgreSQL data
pg_dump -h [supabase-host] -U postgres [fsm_db] > fsm_data.sql

# Transform & import to Salesmate SQLite
# 1. Map FSM tenants to Salesmate tenants
# 2. Import salesmen as users
# 3. Merge customers
# 4. Import visits with proper FKs
# 5. Import targets
```

### **For Existing Salesmate Data:**
```bash
# Keep as-is in SQLite
# Add tenant_id references to FSM tables
# Link existing customers to salesmen
```

---

## 8. RISK MITIGATION

| Risk | Mitigation |
|------|-----------|
| Data loss during migration | Full backup before migration, test in staging |
| Breaking existing Salesmate features | Feature-flag FSM features, gradual rollout |
| Database performance with more tables | Add proper indexes, monitor query times |
| Mobile app compatibility | Test on multiple devices, maintain Expo build |
| Multi-tenant isolation | Ensure all queries filter by tenant_id |

---

## 9. ESTIMATED EFFORT & TIMELINE

| Phase | Duration | Resources |
|-------|----------|-----------|
| DB Consolidation | 3-4 days | 1 Backend Dev |
| API Integration | 5-6 days | 1 Backend Dev |
| Frontend | 5-7 days | 1 Full-Stack Dev |
| Testing & Deployment | 3-4 days | 1-2 QA + 1 DevOps |
| **Total** | **3-4 weeks** | **2-3 Developers** |

---

## 10. SUCCESS CRITERIA

- ✅ Single codebase for both FSM + Salesmate
- ✅ Unified customer view across both systems
- ✅ Automatic order creation from field visits
- ✅ Daily summaries integrate visit + order data
- ✅ No data duplication (customers, products, users)
- ✅ Performance: <200ms API response times
- ✅ Zero data loss during migration
- ✅ Both mobile & web apps functional post-merge

---

## Next Steps

1. **Review this plan** with stakeholders
2. **Backup all data** (FSM PostgreSQL + Salesmate SQLite)
3. **Start Phase 1** - Database migration
4. **Deploy to staging** for testing before production

Would you like me to start implementing **Phase 1 (Database Consolidation)** now?

