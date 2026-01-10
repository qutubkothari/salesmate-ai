# SAK WhatsApp AI Sales Assistant - Hybrid Architecture

## 🚀 Overview

This is a **hybrid architecture** version that splits the WhatsApp connection between:
- **Desktop Agent (Your PC)**: Handles WhatsApp Web connection via Puppeteer
- **Cloud Server**: Handles AI processing, database, and business logic only

## 🎯 Why Hybrid?

### Problems Solved:
- ❌ **Server Crashes**: Cloud servers struggle with Puppeteer's heavy resource usage
- ❌ **High Costs**: Need expensive instances (2GB+ RAM) to run Puppeteer
- ❌ **Performance Issues**: Network latency for WhatsApp operations

### Benefits:
- ✅ **70% Cost Reduction**: t3.micro (512MB) instead of t3.small (2GB)
- ✅ **No Server Crashes**: Puppeteer runs on your PC
- ✅ **Faster Performance**: Local WhatsApp connection
- ✅ **Offline Capable**: Works even if cloud is down temporarily
- ✅ **Better Control**: See WhatsApp status on your PC

## 📁 Project Structure

```
SAK-Whatsapp-AI-Hybrid/
├── desktop-agent/              # Runs on your PC
│   ├── index.js               # Main agent application
│   ├── package.json           # Dependencies (whatsapp-web.js, puppeteer)
│   └── .env.example           # Configuration template
│
├── cloud-server/               # Deploy to AWS/VPS
│   ├── desktopAgentRoutes.js  # API endpoints for agent communication
│   └── (reuse existing server code without Puppeteer)
│
├── migrations/
│   └── 20251120_desktop_agent_support.sql
│
├── HYBRID_ARCHITECTURE.md      # Architecture explanation
├── SETUP_GUIDE.md             # Step-by-step setup
└── README.md                  # This file
```

## 🚀 Quick Start

### 1️⃣ Desktop Agent (Your PC)

```powershell
cd desktop-agent
npm install
copy .env.example .env
# Edit .env with your settings
npm start
```

Scan the QR code with WhatsApp, and you're connected!

### 2️⃣ Cloud Server

```powershell
# Run database migration
psql -h your-supabase-host -d your-database -f migrations/20251120_desktop_agent_support.sql

# Deploy lightweight server (no Puppeteer)
# Can use t3.micro (512MB RAM) - saves $10-20/month!
```

## 💬 How It Works

```
Customer → WhatsApp → [Desktop Agent on PC]
                            ↓
                    HTTP POST /api/desktop-agent/process-message
                            ↓
                    [Cloud Server - AI Processing]
                            ↓
                    Returns AI response
                            ↓
                    [Desktop Agent] → WhatsApp → Customer
```

## 🔧 Configuration

### Desktop Agent (.env)
```env
CLOUD_SERVER_URL=http://13.62.57.240:8080
TENANT_ID=your-tenant-id
API_KEY=your-secure-api-key
LOCAL_PORT=3001
```

### Cloud Server
- Add route: `app.use('/api/desktop-agent', require('./cloud-server/desktopAgentRoutes'));`
- Remove Puppeteer dependency
- Deploy to smaller instance

## 📊 Cost Comparison

| Architecture | Instance | RAM | Monthly Cost |
|--------------|----------|-----|--------------|
| **Full Cloud** (EC2) | t3.small | 2GB | $15-30 |
| **Hybrid** (This) | t3.micro | 512MB | $3-8 |
| **Savings** | - | - | **~70%** 🎉 |

## 🔄 Deployment Comparison

### Original EC2 Version
- ✅ **Kept as-is** in `SAK-Whatsapp-AI-EC2` repository
- Full Puppeteer on cloud
- Use if you need 24/7 cloud-only operation

### This Hybrid Version
- ✅ **New architecture** for cost savings
- Puppeteer on PC, AI on cloud
- Use for most efficient operation

## 📱 Multi-Tenant Support

Each business can run their own desktop agent:

```
Business A (PC 1) → Agent A → Cloud (Tenant A data)
Business B (PC 2) → Agent B → Cloud (Tenant B data)
Business C (PC 3) → Agent C → Cloud (Tenant C data)
```

## 🛠️ Running 24/7

### PM2 (Recommended)
```powershell
npm install -g pm2
pm2 start index.js --name whatsapp-agent
pm2 startup
pm2 save
```

### Windows Task Scheduler
- Create task → Run at startup
- Program: `node.exe`
- Arguments: `path\to\desktop-agent\index.js`

## 📋 Documentation

- [HYBRID_ARCHITECTURE.md](./HYBRID_ARCHITECTURE.md) - Detailed architecture
- [SETUP_GUIDE.md](./SETUP_GUIDE.md) - Step-by-step setup
- [migrations/](./migrations/) - Database changes

## 🆚 When to Use Each Version

### Use **Hybrid** (This) When:
- ✅ You want to save costs (~70% reduction)
- ✅ You have a PC/laptop that can run 24/7
- ✅ You want better performance (local WhatsApp)
- ✅ You want more control over WhatsApp connection

### Use **Full Cloud** (EC2) When:
- ✅ You need truly serverless operation
- ✅ You don't have a reliable PC
- ✅ You need geographic redundancy
- ✅ Cost is not a concern

## 🔐 Security

- API Key authentication between agent and server
- Environment variables for sensitive data
- Local session storage (never transmitted to cloud)
- Minimal data sent to cloud (only message text + metadata)

## 🐛 Troubleshooting

See [SETUP_GUIDE.md](./SETUP_GUIDE.md#troubleshooting) for common issues and solutions.

## 📞 Support

This is the hybrid version. For the original EC2 version, see `SAK-Whatsapp-AI-EC2` repository.

## 🎉 Credits

Built on top of the original SAK WhatsApp AI Sales Assistant.
Hybrid architecture designed to solve cloud resource and cost issues.

---

**Start Saving Money and Resources Today!** 🚀💰
