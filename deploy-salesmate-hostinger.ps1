## Deploy using the currently open file
# Automated Salesmate Deployment to Hostinger VPS
param(
    [string]$Message = "Deploy Salesmate"
)

$ErrorActionPreference = "Stop"

Write-Host "`n===================================================" -ForegroundColor Cyan
Write-Host "   SALESMATE TO HOSTINGER DEPLOYMENT" -ForegroundColor Green
Write-Host "===================================================`n" -ForegroundColor Cyan

# ====== CONFIG ======
$HOSTINGER_IP = "72.62.192.228"
$HOSTINGER_USER = "qutubk"
$KEY_PATH = "$env:USERPROFILE\.ssh\hostinger_ed25519"
$REMOTE_PATH = "/var/www/salesmate-ai"
$PM2_PROCESS = "salesmate-ai"

# ====== Helper Functions ======
function Test-SshKey {
    if (-not (Test-Path $KEY_PATH)) {
        Write-Host "ERROR: SSH key not found at: $KEY_PATH" -ForegroundColor Red
        throw "SSH key missing"
    }
    Write-Host "SSH key found" -ForegroundColor Green
}

function Invoke-RemoteCommand {
    param([string]$Command)
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $KEY_PATH "$HOSTINGER_USER@$HOSTINGER_IP" $Command
    if ($LASTEXITCODE -ne 0) {
        throw "Remote command failed"
    }
}

# ====== STEP 1: Pre-deployment Checks ======
Write-Host "[1/6] Pre-deployment Checks" -ForegroundColor Yellow
Test-SshKey
git status --short

# ====== STEP 2: Commit and Push ======
Write-Host "`n[2/6] Git Commit and Push" -ForegroundColor Yellow
git add .
git commit -m "$Message"
if ($LASTEXITCODE -ne 0) {
    Write-Host "No changes to commit" -ForegroundColor Yellow
}

git push
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Git push failed!" -ForegroundColor Red
    exit 1
}
Write-Host "Code pushed to GitHub" -ForegroundColor Green

# ====== STEP 3: Test Connection ======
Write-Host "`n[3/6] Testing Connection" -ForegroundColor Yellow
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=10 -i $KEY_PATH "$HOSTINGER_USER@$HOSTINGER_IP" "echo 'Connected'; node -v; pm2 -v"
Write-Host "Connection OK" -ForegroundColor Green

# ====== STEP 4: Pull Latest Code ======
Write-Host "`n[4/6] Pulling Latest Code" -ForegroundColor Yellow
Invoke-RemoteCommand "cd $REMOTE_PATH; git pull origin main"
Write-Host "Code updated on server" -ForegroundColor Green

# ====== STEP 5: Install Dependencies ======
Write-Host "`n[5/6] Installing Dependencies" -ForegroundColor Yellow
Invoke-RemoteCommand "cd $REMOTE_PATH; npm install --production"
Write-Host "Dependencies updated" -ForegroundColor Green

# ====== STEP 6: Restart PM2 ======
Write-Host "`n[6/6] Restarting Application" -ForegroundColor Yellow
Invoke-RemoteCommand "cd $REMOTE_PATH; pm2 restart $PM2_PROCESS; sleep 2; pm2 list"
Write-Host "Application restarted" -ForegroundColor Green

# ====== COMPLETE ======
Write-Host "`n===================================================" -ForegroundColor Cyan
Write-Host "   DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
Write-Host "===================================================`n" -ForegroundColor Cyan
Write-Host "Live at: https://salesmate.saksolution.com" -ForegroundColor Cyan
Write-Host "Check logs: pm2 logs $PM2_PROCESS" -ForegroundColor Gray
Write-Host ""
