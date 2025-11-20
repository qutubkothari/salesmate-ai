# Hybrid Architecture Setup Guide

## Quick Start

### 1. Desktop Agent Setup (Your PC)

```powershell
# Navigate to desktop agent folder
cd desktop-agent

# Install dependencies
npm install

# Create .env file
copy .env.example .env

# Edit .env with your settings
notepad .env
```

**Configure .env:**
```env
CLOUD_SERVER_URL=http://13.62.57.240:8080
TENANT_ID=your-tenant-id
API_KEY=your-api-key
LOCAL_PORT=3001
```

**Run the agent:**
```powershell
npm start
```

**What happens:**
1. Opens WhatsApp Web connection (Puppeteer)
2. Shows QR code in terminal
3. Scan with your phone
4. Agent connects and registers with cloud
5. Starts processing messages

### 2. Cloud Server Modifications

**Add to your main index.js:**
```javascript
const desktopAgentRoutes = require('./cloud-server/desktopAgentRoutes');
app.use('/api/desktop-agent', desktopAgentRoutes);
```

**Database Migration (add columns to tenants table):**
```sql
ALTER TABLE tenants ADD COLUMN IF NOT EXISTS desktop_agent_status TEXT;
ALTER TABLE tenants ADD COLUMN IF NOT EXISTS desktop_agent_phone TEXT;
ALTER TABLE tenants ADD COLUMN IF NOT EXISTS desktop_agent_device TEXT;
ALTER TABLE tenants ADD COLUMN IF NOT EXISTS desktop_agent_last_seen TIMESTAMP;
```

**Remove Puppeteer from cloud server:**
```powershell
# In cloud-server directory
npm uninstall puppeteer whatsapp-web.js
```

### 3. Deploy Cloud Server

The cloud server is now lightweight (no Puppeteer):

```powershell
# Deploy to EC2 (can use smaller instance now)
# t3.micro (512MB RAM) is sufficient instead of t3.small (2GB RAM)
```

## Architecture Flow

```
┌─────────────────┐
│   Your PC       │
│                 │
│  Desktop Agent  │ ← Runs Puppeteer locally
│  (Node.js App)  │ ← Connects to WhatsApp Web
└────────┬────────┘
         │ HTTP/HTTPS
         │ (Only sends message text + metadata)
         ↓
┌─────────────────┐
│  Cloud Server   │
│   (EC2/VPS)     │
│                 │
│  - AI Logic     │ ← OpenAI processing
│  - Database     │ ← Customer data
│  - Business     │ ← Orders, products
│    Logic        │
└─────────────────┘
```

## Message Flow Example

**Customer sends:** "I want to order 10 boxes"

1. **Desktop Agent receives** → Message from WhatsApp Web
2. **Desktop Agent sends to cloud:**
   ```json
   POST /api/desktop-agent/process-message
   {
     "tenantId": "abc123",
     "from": "919876543210@c.us",
     "message": "I want to order 10 boxes",
     "timestamp": "2025-11-20T10:30:00Z"
   }
   ```
3. **Cloud processes:**
   - Retrieves customer profile from database
   - Gets product catalog
   - Calls OpenAI for response
   - Returns: "Great! We have boxes available. Which size do you need?"
4. **Desktop Agent sends reply** → Via WhatsApp Web

## Benefits Achieved

✅ **Server resources saved:**
- Before: 2GB RAM (t3.small) = $15-30/month
- After: 512MB RAM (t3.micro) = $3-8/month
- **Savings: ~70%**

✅ **No more server crashes:**
- Puppeteer runs on your PC (with better resources)
- Server only does lightweight AI/database work

✅ **Better performance:**
- Local WhatsApp connection = faster message handling
- No network latency for WhatsApp operations

✅ **Offline capability:**
- If server is down, agent can queue messages
- PC handles WhatsApp independently

## Running Desktop Agent as Windows Service

To run 24/7 in background:

### Option 1: PM2 (Recommended)
```powershell
npm install -g pm2
pm2 start index.js --name whatsapp-agent
pm2 startup
pm2 save
```

### Option 2: Windows Task Scheduler
1. Open Task Scheduler
2. Create Task → "Start a program"
3. Program: `node.exe`
4. Arguments: `C:\path\to\desktop-agent\index.js`
5. Trigger: At system startup
6. Run whether user is logged on or not

## Monitoring

### Desktop Agent Status
```powershell
# Visit local health endpoint
curl http://localhost:3001/health
```

### Cloud Server Status
```powershell
# Check agent status via API
curl http://13.62.57.240:8080/api/desktop-agent/status/your-tenant-id
```

## Troubleshooting

### Agent won't connect to WhatsApp
- Check if QR code is displayed
- Scan within 60 seconds
- Ensure phone has internet connection

### Agent can't reach cloud server
- Check CLOUD_SERVER_URL in .env
- Verify API_KEY is correct
- Check server is running: `curl http://13.62.57.240:8080/health`

### Messages not being processed
- Check cloud server logs
- Verify tenant_id exists in database
- Check API authentication

## Multi-Tenant Support

Run multiple agents on different PCs:

```
PC 1 (Business A) → Desktop Agent → Cloud Server (Tenant A data)
PC 2 (Business B) → Desktop Agent → Cloud Server (Tenant B data)
PC 3 (Business C) → Desktop Agent → Cloud Server (Tenant C data)
```

Each PC connects its own WhatsApp number, cloud handles all businesses' AI logic centrally.

## Next Steps

1. ✅ Set up desktop agent on your PC
2. ✅ Migrate database (add agent columns)
3. ✅ Deploy lightweight cloud server
4. ✅ Test message flow
5. ✅ Setup as Windows service for 24/7 operation
6. ✅ Monitor and optimize
