# Fresh Deployment Script - Complete reinstall on EC2
param(
    [string]$Message = "Fresh deployment - Clean install"
)

Write-Host "================================" -ForegroundColor Cyan
Write-Host "  FRESH EC2 DEPLOYMENT" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$EC2_IP = "43.205.192.171"
$EC2_USER = "ubuntu"
$EC2_KEY = "$HOME\Downloads\whatsapp-ai-key.pem"
$EC2_APP_DIR = "/home/ubuntu/SAK-Whatsapp-AI-Hybrid"
$GITHUB_REPO = "https://github.com/qutubkothari/SAK-Whatsapp-AI-Hybrid.git"

# Step 1: Push latest code to GitHub
Write-Host "[1/6] Pushing latest code to GitHub..." -ForegroundColor Yellow
git add .
git commit -m "$Message" -a
git push origin main

if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 1) {
    Write-Host "Warning: Git operations had issues, but continuing..." -ForegroundColor Yellow
}

Write-Host "Code pushed to GitHub!" -ForegroundColor Green

# Step 2: Connect to EC2 and perform fresh installation
Write-Host ""
Write-Host "[2/6] Connecting to EC2..." -ForegroundColor Yellow

$DEPLOY_SCRIPT = @"
echo '=== Fresh Deployment Started ==='
cd /home/ubuntu

echo '[1/5] Stopping all PM2 processes...'
pm2 stop all
pm2 delete all

echo '[2/5] Removing old installation...'
rm -rf SAK-Whatsapp-AI-Hybrid
rm -rf whatsapp-ai

echo '[3/5] Cloning fresh code from GitHub...'
git clone $GITHUB_REPO
cd SAK-Whatsapp-AI-Hybrid

echo '[4/5] Installing dependencies...'
npm install --production

echo '[5/5] Starting application with PM2...'
pm2 start index.js --name whatsapp-ai --node-args="--max-old-space-size=2048"
pm2 save
pm2 startup

echo ''
echo '=== Deployment Complete ==='
echo ''
pm2 status
echo ''
echo 'Application URL: http://$EC2_IP:8080'
echo 'Login URL: http://$EC2_IP:8080/login.html'
echo ''
"@

ssh -i $EC2_KEY -o StrictHostKeyChecking=no $EC2_USER@$EC2_IP $DEPLOY_SCRIPT

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================" -ForegroundColor Green
    Write-Host "  FRESH DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Application URL: http://$EC2_IP`:8080" -ForegroundColor Cyan
    Write-Host "Login URL: http://$EC2_IP`:8080/login.html" -ForegroundColor Cyan
    Write-Host "Dashboard URL: http://$EC2_IP`:8080/dashboard.html" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Status: Fresh installation complete!" -ForegroundColor Green
    Write-Host ""
}
else {
    Write-Host ""
    Write-Host "================================" -ForegroundColor Red
    Write-Host "  DEPLOYMENT FAILED!" -ForegroundColor Red
    Write-Host "================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Check SSH connection and EC2 service status" -ForegroundColor Yellow
}
