# Emergency fix - Pull latest code and restart Hostinger
$HOSTINGER_IP = "72.62.192.228"
$HOSTINGER_USER = "qutubk"
$KEY_PATH = "$env:USERPROFILE\.ssh\hostinger_ed25519"

Write-Host "`nEmergency Fix: Pulling latest code and restarting..." -ForegroundColor Yellow

# Execute commands directly
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $KEY_PATH "${HOSTINGER_USER}@${HOSTINGER_IP}" "cd /var/www/salesmate-ai && git pull origin main && pm2 restart salesmate-ai && pm2 logs salesmate-ai --lines 20"

Write-Host "`nDone! Test: http://web.saksolution.com:8080/dashboard.html" -ForegroundColor Green
Write-Host "Press Ctrl+Shift+R to hard refresh in browser" -ForegroundColor Cyan
