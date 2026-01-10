# Deploy SalesMate WhatsApp AI Bot to EC2 (alongside existing app)
param(
    [string]$Message = "Deploy SalesMate Bot to EC2"
)

Write-Host "================================" -ForegroundColor Cyan
Write-Host "  SalesMate EC2 Deployment" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$EC2_IP = "13.126.234.92"
$EC2_USER = "ubuntu"
$EC2_KEY = "$HOME\Downloads\whatsapp-ai-key.pem"
$EC2_APP_DIR = "/home/ubuntu/salesmate"
$GITHUB_REPO = "mustafaqk53-create/salesmate"

Write-Host "Target: $EC2_IP" -ForegroundColor Yellow
Write-Host "Directory: $EC2_APP_DIR" -ForegroundColor Yellow
Write-Host "Port: 8081 (different from existing app on 8080)" -ForegroundColor Yellow
Write-Host ""

# Check SSH Key
if (-not (Test-Path $EC2_KEY)) {
    Write-Host "ERROR: SSH key not found at: $EC2_KEY" -ForegroundColor Red
    Write-Host "Please place your whatsapp-ai-key.pem in Downloads folder" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ SSH key found" -ForegroundColor Green
Write-Host ""

# Step 1: Git Status
Write-Host "[1/6] Checking Git status..." -ForegroundColor Yellow
git status --short

# Step 2: Add all changes
Write-Host ""
Write-Host "[2/6] Adding changes to Git..." -ForegroundColor Yellow
git add .

# Step 3: Commit changes
Write-Host ""
Write-Host "[3/6] Committing changes..." -ForegroundColor Yellow
git commit -m "$Message"

if ($LASTEXITCODE -ne 0) {
    Write-Host "No new changes to commit - this is fine" -ForegroundColor Yellow
}

# Step 4: Push to GitHub
Write-Host ""
Write-Host "[4/6] Pushing to GitHub..." -ForegroundColor Yellow
git push

if ($LASTEXITCODE -ne 0) {
    Write-Host "Git push failed! Check your GitHub remote configuration" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Code pushed to GitHub successfully!" -ForegroundColor Green
Write-Host ""

# Step 5: Setup on EC2 (first time or update)
Write-Host "[5/6] Setting up on EC2..." -ForegroundColor Yellow
Write-Host ""

$SETUP_SCRIPT = @"
#!/bin/bash
set -e

echo "================================"
echo "  SalesMate Setup on EC2"
echo "================================"
echo ""

# Create directory if not exists
if [ ! -d "$EC2_APP_DIR" ]; then
    echo "[1/7] Creating new app directory..."
    mkdir -p $EC2_APP_DIR
    cd $EC2_APP_DIR
    
    echo "[2/7] Cloning repository..."
    git clone https://github.com/$GITHUB_REPO.git .
else
    echo "[1/7] App directory exists, updating..."
    cd $EC2_APP_DIR
    
    echo "[2/7] Pulling latest code..."
    git pull
fi

echo "[3/7] Installing dependencies..."
npm install

echo "[4/7] Setting up .env file..."
if [ ! -f .env ]; then
    cat > .env << 'EOF'
# Local SQLite Database
USE_LOCAL_DB=true

# OpenAI Configuration
OPENAI_API_KEY=YOUR_OPENAI_API_KEY

# Google Cloud Storage (Local Mode)
GCS_BUCKET=local-storage
GOOGLE_CLOUD_PROJECT=local-dev

# Server Port (different from existing app)
PORT=8081
EOF
    echo "✓ Created .env file"
else
    echo "✓ .env file already exists"
fi

echo "[5/7] Setting up SQLite database..."
if [ ! -f local-database.db ]; then
    node setup-sqlite-db.js
    echo "✓ Database created"
else
    echo "✓ Database already exists"
fi

echo "[6/7] Creating systemd service..."
sudo tee /etc/systemd/system/salesmate-bot.service > /dev/null << 'SEOF'
[Unit]
Description=SalesMate WhatsApp AI Bot
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=$EC2_APP_DIR
ExecStart=/usr/bin/node index.js
Restart=always
RestartSec=10
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
SEOF

echo "[7/7] Enabling and starting service..."
sudo systemctl daemon-reload
sudo systemctl enable salesmate-bot
sudo systemctl restart salesmate-bot

echo ""
echo "================================"
echo "  Setup Complete!"
echo "================================"
echo ""
echo "Service Status:"
sudo systemctl status salesmate-bot --no-pager -l | head -20
echo ""
echo "Listening on: http://13.126.234.92:8081"
echo ""
echo "Fresh installation on new EC2 instance!"
"@

# Save script to temp file and execute on EC2
$TEMP_SCRIPT = [System.IO.Path]::GetTempFileName() + ".sh"
$SETUP_SCRIPT | Out-File -FilePath $TEMP_SCRIPT -Encoding UTF8 -NoNewline

scp -i $EC2_KEY -o StrictHostKeyChecking=no $TEMP_SCRIPT ${EC2_USER}@${EC2_IP}:/tmp/setup-salesmate.sh
ssh -i $EC2_KEY -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} "dos2unix /tmp/setup-salesmate.sh 2>/dev/null || sed -i 's/\r$//' /tmp/setup-salesmate.sh; chmod +x /tmp/setup-salesmate.sh && bash /tmp/setup-salesmate.sh"

Remove-Item $TEMP_SCRIPT

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================" -ForegroundColor Green
    Write-Host "  DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "SalesMate Bot Deployed:" -ForegroundColor Cyan
    Write-Host "   Dashboard: http://${EC2_IP}:8081/dashboard" -ForegroundColor White
    Write-Host "   Health: http://${EC2_IP}:8081/health" -ForegroundColor White
    Write-Host "   Service: salesmate-bot" -ForegroundColor White
    Write-Host ""
    Write-Host "Manage Service:" -ForegroundColor Cyan
    Write-Host "   Start: sudo systemctl start salesmate-bot" -ForegroundColor White
    Write-Host "   Stop: sudo systemctl stop salesmate-bot" -ForegroundColor White
    Write-Host "   Restart: sudo systemctl restart salesmate-bot" -ForegroundColor White
    Write-Host "   Logs: sudo journalctl -u salesmate-bot -f" -ForegroundColor White
    Write-Host ""
}
else {
    Write-Host ""
    Write-Host "================================" -ForegroundColor Red
    Write-Host "  DEPLOYMENT FAILED!" -ForegroundColor Red
    Write-Host "================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Check SSH connection and EC2 access" -ForegroundColor Yellow
}
