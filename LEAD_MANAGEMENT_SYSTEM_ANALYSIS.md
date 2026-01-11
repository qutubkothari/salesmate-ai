# Lead Management System - Complete Analysis

**Date:** January 11, 2026  
**Purpose:** Smart Lead Assignment System integrating multiple lead sources

---

## 🎯 BUSINESS OBJECTIVE

Create a **unified lead management system** that:
1. **Captures leads** from 5 different sources
2. **Intelligently assigns** them to salespeople
3. **Tracks engagement** and conversion
4. **Provides analytics** and reporting

---

## 📊 LEAD SOURCES (5 Channels)

### 1. **WhatsApp** ✅ (Currently Working)
- **Status:** IMPLEMENTED in current Salesmate
- **Source:** WhatsApp Web API via WAHA/Baileys
- **Data Captured:** 
  - Phone number
  - Messages
  - Customer name (from WhatsApp profile)
  - Conversation history
- **Current Implementation:** `services/conversationService.js`, `routes/api/wa.js`

### 2. **Email (Gmail)** ✅ (Just Implemented)
- **Status:** BACKEND COMPLETE, UI PENDING
- **Source:** Gmail API with OAuth2 + Pub/Sub
- **Data Captured:**
  - Email address (`from_email`)
  - Subject
  - Full email body (HTML)
  - Received timestamp
  - Message ID (for deduplication)
- **Current Implementation:** 
  - Backend: `routes/api/email.js`, `services/gmailService.js`
  - Database: `email_enquiries` table
  - **Missing:** Dashboard UI to view emails

### 3. **IndiaMart API** ⏳ (Needs Implementation)
- **Status:** NOT IMPLEMENTED
- **What It Is:** B2B marketplace lead generation platform
- **Typical Data:**
  - Buyer name
  - Phone/email
  - Product interest
  - Quantity required
  - Message/requirements
- **Integration Needed:**
  - IndiaMart webhook receiver endpoint
  - Lead capture and storage
  - Deduplication by IndiaMart lead ID

### 4. **GEM (Government e-Marketplace)** ⏳ (Needs Implementation)
- **Status:** NOT IMPLEMENTED
- **What It Is:** Indian government procurement portal
- **Typical Data:**
  - Tender details
  - Department/organization name
  - Contact person
  - Product/service requirements
  - Quantity & specifications
- **Integration Needed:**
  - Manual entry form OR
  - Email parsing (GEM sends tender alerts via email) OR
  - API if available

### 5. **Telephone Calls** ⏳ (Needs Implementation)
- **Status:** PARTIALLY EXISTS in SAK-SMS
- **Data to Capture:**
  - Caller phone number
  - Call duration
  - Call outcome (answered, voicemail, etc.)
  - Notes from conversation
  - Recording link (optional)
- **SAK-SMS has:** `Call` model with fields:
  ```prisma
  model Call {
    id            String        @id @default(cuid())
    leadId        String
    direction     CallDirection // INBOUND | OUTBOUND
    outcome       CallOutcome   // ANSWERED | NO_ANSWER | BUSY | VOICEMAIL
    duration      Int?          // seconds
    notes         String?
    recordingUrl  String?
    calledAt      DateTime
  }
  ```
- **Integration Needed:** Call logging UI in dashboard

---

## 🏗️ SAK-SMS SYSTEM ARCHITECTURE (The "Smart Brain")

### **What SAK-SMS Provides:**

#### 1. **Advanced Lead Scoring & Intelligence**
```typescript
// Lead heat levels
enum LeadHeat {
  COLD        // Low priority
  WARM        // Some interest
  HOT         // High intent
  VERY_HOT    // Ready to buy
  ON_FIRE     // Urgent/immediate
}

// AI-powered analysis
- Language detection
- Urgency detection
- Product interest extraction
- Intent classification
```

#### 2. **Smart Assignment System**
```typescript
enum AssignmentStrategy {
  ROUND_ROBIN       // Equal distribution
  LEAST_ACTIVE      // Assign to salesman with fewest active leads
  SKILLS_BASED      // Match product expertise
  GEOGRAPHIC        // Location-based routing
  CUSTOM            // Business rules
}

model Salesman {
  capacity              Int     // Max concurrent leads
  minLeadsPerMonth      Int     // Performance targets
  maxLeadsPerMonth      Int
  useIntelligentOverride Boolean // AI can override rules
  score                 Float   // Performance score
}
```

#### 3. **Triage Queue System**
```typescript
model TriageQueueItem {
  leadId       String
  priority     TaskPriority  // LOW | MEDIUM | HIGH | URGENT
  reason       String?       // Why it needs triage
  confidence   Float?        // AI confidence score
  suggestedAction String?    // AI recommendation
  status       String        // PENDING | ASSIGNED | CLOSED
}
```

#### 4. **Success Tracking & Analytics**
```typescript
model SuccessEvent {
  type   SuccessEventType  // DEMO_BOOKED | PAYMENT_RECEIVED | ORDER_RECEIVED
  weight Float             // Contribution to salesman score
  salesmanId String        // Who closed the deal
}

model SuccessDefinition {
  name   String            // e.g., "First Order", "Repeat Purchase"
  weight Float             // Point value
}
```

#### 5. **SLA Monitoring**
```typescript
model SlaViolation {
  leadId       String
  violationType String      // e.g., "RESPONSE_TIMEOUT"
  detectedAt   DateTime
  resolvedAt   DateTime?
}
```

#### 6. **Multi-Channel Support**
```typescript
enum LeadChannel {
  WHATSAPP
  EMAIL
  INDIAMART
  JUSTDIAL
  GEM
  PHONE
  FACEBOOK
  INSTAGRAM
  PERSONAL_VISIT
  MANUAL
  OTHER
}
```

---

## 🔄 INTEGRATION ARCHITECTURE

### **Current State:**
- **Salesmate (this repo):** UI + WhatsApp integration + Products/Orders/Customers
- **SAK-SMS (separate repo):** Smart lead management backend with AI + assignment logic

### **Recommended Integration Pattern:**

```
┌─────────────────────────────────────────────────┐
│         SALESMATE (Frontend Dashboard)          │
│  - User authentication                          │
│  - Products/Orders/Customers UI                 │
│  - WhatsApp conversations                       │
│  - Reports & Analytics                          │
└─────────────────┬───────────────────────────────┘
                  │
                  │ REST API calls
                  ↓
┌─────────────────────────────────────────────────┐
│      SAK-SMS (Smart Lead Management API)        │
│  - Lead capture from all 5 sources             │
│  - AI-powered triage & scoring                 │
│  - Smart assignment logic                      │
│  - SLA monitoring                              │
│  - Success tracking                            │
└─────────────────┬───────────────────────────────┘
                  │
                  │ Webhook callbacks
                  ↓
┌─────────────────────────────────────────────────┐
│     External Lead Sources (Webhooks)            │
│  - IndiaMart API                               │
│  - Gmail Pub/Sub                               │
│  - GEM Portal (email/manual)                   │
│  - Call logging system                         │
└─────────────────────────────────────────────────┘
```

### **Integration Endpoint (Already Exists):**
```
POST https://sms.saksolution.com/api/integrations/salesmate/message

Headers:
  x-salesmate-secret: <SECRET>

Body:
{
  "tenantId": "101f04af63cbefc2bf8f0a98b9ae1205",
  "phone": "+971500000999",
  "email": "customer@example.com",
  "fullName": "Test Customer",
  "message": "Need price for 100 units",
  "channel": "EMAIL",  // or WHATSAPP, INDIAMART, GEM, PHONE
  "externalId": "gmail-msg-123",
  "metadata": {
    "source": "gmail",
    "subject": "Product Enquiry",
    "gmailMessageId": "abc123"
  }
}

Response:
{
  "leadId": "clx123abc",
  "triage": {
    "heat": "HOT",
    "language": "en",
    "reason": "Product enquiry with quantity",
    "confidence": 0.89
  },
  "draft": "Thank you for your enquiry. We can offer..."
}
```

---

## 🎯 WHAT NEEDS TO BE DONE

### **Phase 1: Email Integration UI** (IMMEDIATE)
✅ Backend complete  
❌ **Dashboard UI missing**

**Action Items:**
1. Add "Email Enquiries" tab to dashboard sidebar
2. Create email list view with:
   - Sender email
   - Subject line
   - Email preview (first 200 chars)
   - Timestamp
   - Mark as read/unread
   - "Create Lead" button → sends to SAK-SMS
3. Detail view to read full email
4. Integration with SAK-SMS:
   - When user clicks "Create Lead", call SAK-SMS webhook
   - Show lead ID and assignment info

### **Phase 2: IndiaMart Integration**
**Action Items:**
1. Register for IndiaMart CRM API
2. Create webhook receiver: `POST /api/leads/indiamart`
3. Parse IndiaMart lead data format
4. Forward to SAK-SMS with channel="INDIAMART"
5. Store IndiaMart lead ID in `externalId` for deduplication
6. Dashboard UI to view IndiaMart leads

### **Phase 3: GEM Portal Integration**
**Action Items:**
1. Decide on approach:
   - **Option A:** Manual entry form (simplest)
   - **Option B:** Parse GEM tender alert emails
   - **Option C:** Web scraping (if no API)
2. Create "GEM Leads" entry form with fields:
   - Tender number
   - Department/organization
   - Product/service required
   - Quantity
   - Deadline
   - Contact person
3. Forward to SAK-SMS with channel="GEM"

### **Phase 4: Call Logging**
**Action Items:**
1. Add "Log Call" button in dashboard
2. Create call logging form:
   - Customer phone (auto-fill if from lead)
   - Direction (inbound/outbound)
   - Outcome (answered, voicemail, etc.)
   - Duration
   - Notes
   - Recording link (optional)
3. If call is for existing lead, link to it
4. If new caller, create new lead in SAK-SMS with channel="PHONE"

### **Phase 5: Unified Lead Dashboard**
**Action Items:**
1. Create "All Leads" view showing leads from all 5 sources
2. Filters:
   - By channel (WhatsApp/Email/IndiaMart/GEM/Phone)
   - By heat (Cold/Warm/Hot/Very Hot/On Fire)
   - By status (New/Contacted/Qualified/Quoted/Won/Lost)
   - By assignment (Unassigned/Assigned to me/Assigned to others)
3. Columns:
   - Lead source icon
   - Customer name
   - Contact (phone/email)
   - Heat indicator (color-coded)
   - Last activity
   - Assigned to
   - Status
   - Actions (view/assign/update)

### **Phase 6: Assignment Management UI**
**Action Items:**
1. "Triage Queue" view for managers
2. Bulk assignment actions
3. Assignment rules configuration UI
4. Salesman performance dashboard showing:
   - Active leads count
   - Response time average
   - Conversion rate
   - Success events

---

## 📋 CURRENT SALESMATE TABLES TO EXTEND

### **Extend `tenants` table:**
```sql
ALTER TABLE tenants ADD COLUMN indiamart_api_key TEXT;
ALTER TABLE tenants ADD COLUMN indiamart_last_sync DATETIME;
ALTER TABLE tenants ADD COLUMN gem_email TEXT;
ALTER TABLE tenants ADD COLUMN sak_sms_tenant_id TEXT; -- Link to SAK-SMS
```

### **Create `leads` table:**
```sql
CREATE TABLE leads (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  sak_sms_lead_id TEXT, -- Link to SAK-SMS lead
  source TEXT NOT NULL, -- whatsapp, email, indiamart, gem, phone
  external_id TEXT, -- Source-specific ID
  customer_name TEXT,
  customer_phone TEXT,
  customer_email TEXT,
  message TEXT,
  heat TEXT, -- cold, warm, hot, very_hot, on_fire
  status TEXT, -- new, contacted, qualified, quoted, won, lost
  assigned_to_user_id TEXT,
  created_at TEXT DEFAULT (DATETIME('now')),
  updated_at TEXT DEFAULT (DATETIME('now')),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  UNIQUE (tenant_id, external_id)
);

CREATE INDEX idx_leads_tenant ON leads(tenant_id);
CREATE INDEX idx_leads_source ON leads(tenant_id, source);
CREATE INDEX idx_leads_status ON leads(tenant_id, status);
CREATE INDEX idx_leads_assigned ON leads(tenant_id, assigned_to_user_id);
```

### **Create `call_logs` table:**
```sql
CREATE TABLE call_logs (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  lead_id TEXT,
  phone TEXT NOT NULL,
  direction TEXT, -- inbound, outbound
  outcome TEXT, -- answered, no_answer, busy, voicemail
  duration INTEGER, -- seconds
  notes TEXT,
  recording_url TEXT,
  created_at TEXT DEFAULT (DATETIME('now')),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  FOREIGN KEY (lead_id) REFERENCES leads(id)
);

CREATE INDEX idx_calls_tenant ON call_logs(tenant_id);
CREATE INDEX idx_calls_lead ON call_logs(lead_id);
```

---

## 🔐 SECURITY & CONFIGURATION

### **Environment Variables Needed:**
```bash
# SAK-SMS Integration
SAK_SMS_API_URL=https://sms.saksolution.com/api
SAK_SMS_WEBHOOK_SECRET=<generate-strong-secret>
SAK_SMS_DEFAULT_TENANT_ID=<your-sak-sms-tenant-id>

# IndiaMart
INDIAMART_API_KEY=<from-indiamart-portal>
INDIAMART_WEBHOOK_SECRET=<generate-strong-secret>

# GEM Portal
GEM_EMAIL=<email-for-tender-alerts>
```

---

## 📊 ANALYTICS & REPORTING

### **Metrics to Track:**
1. **Lead Volume by Source**
   - Daily/weekly/monthly breakdown
   - Which channel generates most leads?

2. **Response Time by Channel**
   - How quickly are leads responded to?
   - SLA compliance %

3. **Conversion Rate by Source**
   - Which channel has highest win rate?

4. **Salesman Performance**
   - Leads handled
   - Average response time
   - Conversion rate
   - Revenue generated

5. **Lead Quality Score**
   - Heat distribution
   - Time to qualification
   - Drop-off points

---

## 🚀 ROLLOUT PLAN

### **Week 1: Email UI**
- [ ] Add Email Enquiries tab to dashboard
- [ ] Email list view with basic operations
- [ ] Integration with SAK-SMS (create lead from email)
- [ ] Test with existing 10 synced emails

### **Week 2: IndiaMart**
- [ ] Register IndiaMart CRM API
- [ ] Create webhook endpoint
- [ ] Test with sample leads
- [ ] Dashboard UI for IndiaMart leads

### **Week 3: Call Logging**
- [ ] Call logging form UI
- [ ] Integration with existing leads
- [ ] Auto-create lead for new callers

### **Week 4: GEM Portal**
- [ ] Decide approach (manual/email/scraping)
- [ ] Implement chosen method
- [ ] Testing with real GEM tenders

### **Week 5: Unified Dashboard**
- [ ] All Leads view
- [ ] Filtering & search
- [ ] Assignment management
- [ ] Triage queue

### **Week 6: Analytics**
- [ ] Lead source reports
- [ ] Salesman performance dashboard
- [ ] Conversion funnel analysis

---

## ✅ SUMMARY

**What We Have:**
- ✅ WhatsApp lead capture (working)
- ✅ Email backend (Gmail OAuth + sync working)
- ✅ SAK-SMS backend with advanced lead management
- ✅ Products, orders, customers in Salesmate

**What's Missing:**
- ❌ Email UI in dashboard
- ❌ IndiaMart integration
- ❌ GEM portal integration
- ❌ Call logging UI
- ❌ Unified lead management dashboard
- ❌ Connection between Salesmate <-> SAK-SMS

**Next Immediate Step:**
Build the Email Enquiries UI to display the 10 emails already synced, with ability to create leads from them.
