# Running Multiple Apps on Same EC2 Instance

## 📋 Current Setup

Your EC2 instance **43.205.192.171** can host multiple Node.js apps:

| App | Directory | Port | Service | Status |
|-----|-----------|------|---------|--------|
| **Existing WhatsApp AI** | `/home/ubuntu/whatsapp-ai` | 8080 | `whatsapp-ai` | Can be dormant |
| **SalesMate Bot** | `/home/ubuntu/salesmate` | 8081 | `salesmate-bot` | New active app |

## 🚀 Deployment Options

### Option A: Keep Both Apps (Recommended)
Both apps installed, you can switch between them:

```bash
# Stop old app
sudo systemctl stop whatsapp-ai

# Start new app
sudo systemctl start salesmate-bot

# Check status
sudo systemctl status salesmate-bot
```

**Benefits:**
- ✅ Old app preserved (can reactivate anytime)
- ✅ Different ports (no conflict)
- ✅ Independent databases
- ✅ Easy to switch back

### Option B: Replace Completely
Remove old app entirely:

```bash
# Stop and disable old service
sudo systemctl stop whatsapp-ai
sudo systemctl disable whatsapp-ai

# Remove old files (optional backup first)
cp -r /home/ubuntu/whatsapp-ai /home/ubuntu/whatsapp-ai.backup
rm -rf /home/ubuntu/whatsapp-ai
```

## 📦 Deploy SalesMate Bot

### Step 1: Update GitHub Remote

First, make sure your local repo is connected to GitHub:

```powershell
# Check current remote
git remote -v

# If no remote exists, add one
git remote add origin https://github.com/YOUR_USERNAME/salesmate.git

# Or update existing remote
git remote set-url origin https://github.com/YOUR_USERNAME/salesmate.git
```

### Step 2: Update Deployment Script

Edit `deploy-salesmate-to-ec2.ps1` line 14:
```powershell
$GITHUB_REPO = "YOUR_USERNAME/salesmate"  # Change to your actual GitHub repo
```

### Step 3: Run Deployment

```powershell
.\deploy-salesmate-to-ec2.ps1
```

## 🔧 Managing Apps on EC2

### Start/Stop Services

```bash
# SalesMate Bot
sudo systemctl start salesmate-bot
sudo systemctl stop salesmate-bot
sudo systemctl restart salesmate-bot
sudo systemctl status salesmate-bot

# Old WhatsApp AI
sudo systemctl start whatsapp-ai
sudo systemctl stop whatsapp-ai
sudo systemctl status whatsapp-ai
```

### View Logs

```bash
# SalesMate Bot logs
sudo journalctl -u salesmate-bot -f

# Old app logs
sudo journalctl -u whatsapp-ai -f
```

### Check Which Apps Are Running

```bash
# List all Node processes with ports
sudo netstat -tlnp | grep node

# Check specific ports
sudo lsof -i :8080  # Old app
sudo lsof -i :8081  # SalesMate bot
```

## 🌐 Access URLs

After deployment:

| Service | URL | Purpose |
|---------|-----|---------|
| **SalesMate Dashboard** | http://43.205.192.171:8081/dashboard | Active bot control |
| **SalesMate Health** | http://43.205.192.171:8081/health | Health check |
| **Old App Dashboard** | http://43.205.192.171:8080/dashboard | Dormant (can reactivate) |

## 🔥 Firewall Configuration

Make sure both ports are open on EC2:

```bash
# Check current rules
sudo ufw status

# Open ports if needed
sudo ufw allow 8080
sudo ufw allow 8081
```

Also check **AWS Security Group**:
- Allow inbound TCP 8080
- Allow inbound TCP 8081

## 💾 Database Considerations

Each app has its own database:

```
/home/ubuntu/whatsapp-ai/local-database.db     # Old app data
/home/ubuntu/salesmate/local-database.db        # New app data
```

They won't interfere with each other.

## ⚡ Quick Commands Reference

```bash
# SSH into EC2
ssh -i ~/Downloads/whatsapp-ai-key.pem ubuntu@43.205.192.171

# List all apps
ls -la /home/ubuntu/

# Check running services
systemctl list-units --type=service --state=running | grep -E 'whatsapp|salesmate'

# System resources
free -h           # Memory usage
df -h            # Disk usage
htop             # Process monitor
```

## 🔄 Switching Between Apps

To switch from old app to new app:

```bash
# Stop old
sudo systemctl stop whatsapp-ai

# Start new
sudo systemctl start salesmate-bot

# Verify
curl http://localhost:8081/health
```

To switch back to old app:

```bash
# Stop new
sudo systemctl stop salesmate-bot

# Start old
sudo systemctl start whatsapp-ai

# Verify
curl http://localhost:8080/health
```

## 📊 Resource Monitoring

Both apps running simultaneously:

```bash
# Check memory
free -m

# Check CPU
top

# Check which app uses more resources
sudo systemctl status whatsapp-ai
sudo systemctl status salesmate-bot
```

**Recommendation:** Keep only one active at a time to conserve EC2 resources.

## 🎯 Best Practice

1. **Keep old app dormant** (stopped but installed)
2. **Run SalesMate bot active**
3. **Can switch back anytime in 30 seconds**
4. **Both apps preserved, zero data loss**

This gives you flexibility without losing your previous work!
