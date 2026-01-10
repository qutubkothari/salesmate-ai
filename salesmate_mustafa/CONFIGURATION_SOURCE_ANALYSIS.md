# 🔍 Configuration Source Analysis

**Analysis Date:** December 28, 2025  
**Status:** ✅ Complete

---

## 🎯 **KEY FINDINGS:**

### **1. Your SalesMate App is NOT Currently Running**
- ❌ No SalesMate process found
- ❌ Expected port 8081 not listening
- ❌ No `.env` file in the salesmate directory

### **2. What IS Running (Different Apps):**

**Port 3000:** Manufacturing ERP (Next.js)
- Process: Next.js dev server
- Location: `C:\Users\musta\OneDrive\Documents\GitHub\Manufacturing ERP`
- This is a DIFFERENT project, NOT your SalesMate bot

**Port 4000:** Manufacturing ERP API (NestJS/similar)
- Process: Node.js API server
- Location: `C:\Users\musta\OneDrive\Documents\GitHub\Manufacturing ERP\apps\api`
- Also a DIFFERENT project

### **3. SalesMate Configuration Status:**

#### **Files Found:**
```
✓ .env.oracle-template  (Template only)
✓ desktop-agent/.env.example (Example only)
✗ .env (MISSING - This is what you need!)
✗ local-database.db (MISSING - No SQLite database)
```

#### **How Config.js Loads Settings:**
From [services/config.js](services/config.js):

```javascript
// Line 8: Loads .env file
require('dotenv').config();

// Line 18: Checks database mode
const USE_LOCAL_DB = process.env.USE_LOCAL_DB === 'true';

// Lines 45-56: If NOT using local DB, requires Supabase credentials
if (!USE_LOCAL_DB) {
  const supabaseUrl = process.env.SUPABASE_URL;
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 
                      process.env.SUPABASE_ANON_KEY;
  
  if (!supabaseUrl || !supabaseKey) {
    throw new Error('Supabase URL and Key must be provided...');
  }
}
```

**Priority Order:**
1. `.env` file in root directory (via `dotenv`)
2. System environment variables (Windows User/System level)
3. Process environment variables (passed when starting)

---

## 📋 **WHERE TO ADD YOUR CREDENTIALS:**

### **Option 1: Create `.env` File (RECOMMENDED)**

Create this file in the root directory:
```
c:\Users\musta\OneDrive\Documents\QK-Onedrive\OneDrive\QK-PC\QK Codes\salesmate\.env
```

**Required Variables:**

```bash
# Database Mode
USE_LOCAL_DB=false
# Set to true if using SQLite, false for Supabase

# Supabase (if USE_LOCAL_DB=false)
SUPABASE_URL=https://upswoeziirmshuzelizz.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here

# OpenAI
OPENAI_API_KEY=sk-proj-your-key-here
OPENAI_PROJECT_ID=proj_your-project-id
AI_MODEL_FAST=gpt-4o-mini
AI_MODEL_SMART=gpt-4o
EMBEDDING_MODEL=text-embedding-3-small

# Google Cloud (if using GCS for media)
GOOGLE_CLOUD_PROJECT=sak-whatsapp-ai-sales-assist
GCS_BUCKET=sak-whatsapp-ai-sales-assist-assets

# Server Config
PORT=8081
NODE_ENV=development

# Admin
ADMIN_TOKEN=your-random-admin-token
```

### **Option 2: System Environment Variables**

Set via Windows:
```powershell
# User-level (current user only)
[System.Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "sk-proj-...", "User")
[System.Environment]::SetEnvironmentVariable("SUPABASE_URL", "https://...", "User")

# System-level (all users - requires admin)
[System.Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "sk-proj-...", "Machine")
```

### **Option 3: Pass on Command Line**
```powershell
$env:OPENAI_API_KEY="sk-proj-..."; $env:SUPABASE_URL="https://..."; npm start
```

---

## 🔐 **Configuration Loading Flow:**

```
1. App Starts (npm start / node index.js)
   ↓
2. services/config.js loads
   ↓
3. require('dotenv').config()
   - Looks for .env file in root
   - Loads variables into process.env
   ↓
4. Check USE_LOCAL_DB
   - If 'true' → Use SQLite (local-database.db)
   - If 'false' → Use Supabase
   ↓
5. For Supabase mode:
   - Reads SUPABASE_URL
   - Reads SUPABASE_SERVICE_ROLE_KEY or SUPABASE_ANON_KEY
   - Creates Supabase client
   ↓
6. OpenAI Configuration:
   - Multiple parts of app read OPENAI_API_KEY
   - services/aiService.js
   - services/ai/intentClassifier.js
   - services/ai/responseGenerator.js
   - services/smartResponseRouter.js
   ↓
7. App Ready ✅
```

---

## 🚨 **WHY YOUR APP ISN'T RUNNING:**

1. **No `.env` file** → Config can't load credentials
2. **No local database** → Can't use USE_LOCAL_DB=true mode
3. **Missing Supabase creds** → Can't connect to remote DB
4. **Not started** → No process running the SalesMate code

---

## ✅ **TO START YOUR BOT:**

### **Step 1: Create `.env` file**
```powershell
cd "c:\Users\musta\OneDrive\Documents\QK-Onedrive\OneDrive\QK-PC\QK Codes\salesmate"

# Copy template
Copy-Item .env.oracle-template .env

# Edit with your actual credentials
notepad .env
```

### **Step 2: Add your actual keys**
Replace these placeholders in `.env`:
- `OPENAI_API_KEY=your-key-here` → Your actual OpenAI key
- `SUPABASE_URL=https://...` → Your Supabase project URL
- `SUPABASE_ANON_KEY=...` → Your Supabase anon key
- `SUPABASE_SERVICE_ROLE_KEY=...` → Your Supabase service role key

### **Step 3: Start the app**
```powershell
npm start
```

Expected output:
```
[CONFIG] Supabase: using SERVICE_ROLE_KEY
Server running on port 8081
✓ WhatsApp service initialized
✓ Broadcast queue processor started
```

### **Step 4: Verify it's running**
```powershell
# Test health endpoint
Invoke-WebRequest http://localhost:8081/_ah/health

# Should return: "ok"
```

---

## 🔍 **WHERE KEYS ARE READ (Code References):**

### **OPENAI_API_KEY Used In:**

1. **services/config.js** (Line ~150)
   ```javascript
   const openai = new OpenAI({
     apiKey: process.env.OPENAI_API_KEY,
     project: process.env.OPENAI_PROJECT || undefined
   });
   ```

2. **services/ai/intentClassifier.js** (Line ~9)
   ```javascript
   const apiKey = process.env.OPENAI_API_KEY || 
                  process.env.OPENAI_API_KEY_OCR || null;
   this.openai = new OpenAI({ apiKey });
   ```

3. **services/ai/responseGenerator.js** (Line ~4)
   ```javascript
   const openai = new OpenAI({
     apiKey: process.env.OPENAI_API_KEY,
     project: process.env.OPENAI_PROJECT_ID
   });
   ```

4. **services/aiIntegrationService.js** (Line ~62)
   ```javascript
   const openai = new OpenAI({ 
     apiKey: process.env.OPENAI_API_KEY 
   });
   ```

5. **services/smartResponseRouter.js** (Multiple places)
   - Uses the shared openai instance from config.js

### **SUPABASE Credentials Used In:**

1. **services/config.js** (Lines 45-59)
   ```javascript
   const supabaseUrl = process.env.SUPABASE_URL;
   const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 
                       process.env.SUPABASE_ANON_KEY;
   
   supabase = createClient(supabaseUrl, supabaseKey);
   ```

2. **All services that import from config.js:**
   - services/aiService.js
   - services/productService.js
   - services/orderService.js
   - services/customerService.js
   - routes/api/dashboard.js
   - And 50+ other files

---

## 📊 **CURRENT STATUS SUMMARY:**

| Component | Status | Location |
|-----------|--------|----------|
| `.env` file | ❌ Missing | Need to create |
| OpenAI Key | ❌ Not configured | Add to `.env` |
| Supabase URL | ❌ Not configured | Add to `.env` |
| Supabase Keys | ❌ Not configured | Add to `.env` |
| App Running | ❌ Not started | Run `npm start` |
| Port 8081 | ❌ Not listening | App not running |
| Dependencies | ✅ Installed | npm packages OK |

**Other Running Apps:**
- ✅ Manufacturing ERP on port 3000 (different project)
- ✅ Manufacturing ERP API on port 4000 (different project)

---

## 🎯 **NEXT ACTIONS:**

1. **Create `.env` file** with your actual API keys
2. **Start the SalesMate app:** `npm start`
3. **Verify it's working:** Check http://localhost:8081/_ah/health
4. **Then test the bot:** Use scenarios from BOT_TEST_SCENARIOS.md

---

## 🔒 **SECURITY NOTES:**

- ✅ `.env` is in `.gitignore` (won't be committed to git)
- ⚠️ Never commit API keys to repository
- ⚠️ Use service role key only on backend (never client-side)
- ✅ Desktop agent has separate `.env` in `desktop-agent/` folder

---

**Conclusion:** Your SalesMate bot is NOT currently running because:
1. No `.env` file exists
2. No credentials configured
3. App hasn't been started

The running node processes on ports 3000/4000 are from a DIFFERENT project (Manufacturing ERP).

Once you create the `.env` file with your credentials and run `npm start`, the bot will start on port 8081 and be ready for testing! 🚀
