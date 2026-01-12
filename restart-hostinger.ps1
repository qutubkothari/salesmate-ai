# Quick Restart Hostinger PM2
$ErrorActionPreference = "Stop"

$HOSTINGER_IP = "72.62.192.228"
$HOSTINGER_USER = "qutubk"
$KEY_PATH = "$env:USERPROFILE\.ssh\hostinger_ed25519"
$PM2_PROCESS = "salesmate-ai"

Write-Host "`nRestarting PM2 on Hostinger..." -ForegroundColor Cyan

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $KEY_PATH "$HOSTINGER_USER@$HOSTINGER_IP" "cd /var/www/salesmate-ai && pm2 restart $PM2_PROCESS && pm2 logs $PM2_PROCESS --lines 20"

Write-Host "`nPM2 restarted successfully!" -ForegroundColor Green
Write-Host "Check: http://web.saksolution.com:8080/dashboard.html" -ForegroundColor Yellow
