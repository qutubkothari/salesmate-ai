# Hybrid Architecture - PC + Cloud

## Overview
Split WhatsApp connection (heavy) to run on PC, while cloud server handles only AI/business logic (light).

## Components

### 1. Desktop Agent (PC - Windows/Mac/Linux)
**Location:** Runs on your local computer  
**Responsibilities:**
- Connect to WhatsApp Web via Puppeteer
- Handle all WhatsApp messages (send/receive)
- Local session persistence
- Forward messages to cloud for AI processing
- Display local UI/logs

**Resources:** Uses your PC's CPU/RAM (only when you're working)

### 2. Cloud Server (EC2/Minimal)
**Location:** AWS EC2 (or any cloud)  
**Responsibilities:**
- AI response generation (OpenAI)
- Product catalog management
- Order processing
- Customer data storage
- Business logic only

**Resources:** Minimal (no Puppeteer/browser)

## Communication Flow

```
Customer WhatsApp Message
    ↓
[PC Desktop Agent] ← WhatsApp Web Connection (Puppeteer)
    ↓
    POST /api/process-message
    ↓
[Cloud Server] → AI Processing → Database
    ↓
    Return AI Response
    ↓
[PC Desktop Agent] → Send via WhatsApp Web
    ↓
Customer receives reply
```

## Benefits

✅ **No Server Crashes** - Cloud server doesn't run Puppeteer  
✅ **Lower Cloud Costs** - Minimal CPU/RAM usage  
✅ **Faster Responses** - Local WhatsApp connection  
✅ **Offline Capable** - Can queue messages when server is down  
✅ **Better Control** - See WhatsApp connection status on your PC  
✅ **Multi-Tenant** - Different PCs for different businesses  

## Setup Instructions

### Desktop Agent Setup
1. Install Node.js on your PC
2. Clone desktop agent code
3. Run `npm install`
4. Configure `.env` with cloud server URL
5. Run `npm start` - Opens WhatsApp Web QR
6. Scan QR code
7. Agent runs in background (system tray)

### Cloud Server Setup
1. Deploy lightweight API (no Puppeteer dependencies)
2. Configure database, OpenAI, business logic
3. Minimal resources (512MB RAM sufficient)

## File Structure

```
SAK-Whatsapp-AI-Hybrid/
├── desktop-agent/          # PC application
│   ├── index.js           # Main agent
│   ├── whatsapp.js        # WhatsApp Web connection
│   ├── api-client.js      # Cloud API communication
│   └── package.json       # Desktop dependencies
├── cloud-server/           # Lightweight server
│   ├── routes/            # API endpoints
│   ├── services/          # AI, database logic
│   └── package.json       # Server dependencies (no Puppeteer)
└── shared/                 # Common code
```

## Deployment

- **Desktop Agent:** Run on your PC (Windows service or startup app)
- **Cloud Server:** Deploy to EC2 t3.micro (512MB RAM is enough)

## Cost Comparison

| Architecture | Monthly Cost |
|--------------|--------------|
| Full Cloud (Current EC2) | $15-30 (t3.small - 2GB RAM) |
| Hybrid (This) | $3-8 (t3.micro - 512MB RAM) |
| **Savings** | **~70% reduction** |
