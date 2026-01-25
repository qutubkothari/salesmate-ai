# Quick Setup Script for sak-ai.saksolution.com

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "   SAK-AI DOMAIN NGINX SETUP" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

# SSH into server and create nginx config
$sshCommand = @"
# Create nginx configuration for sak-ai.saksolution.com
sudo tee /etc/nginx/sites-available/sak-ai.saksolution.com << 'EOF'
server {
    listen 80;
    server_name sak-ai.saksolution.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade `$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host `$host;
        proxy_cache_bypass `$http_upgrade;
        proxy_set_header X-Real-IP `$remote_addr;
        proxy_set_header X-Forwarded-For `$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto `$scheme;
        
        # Increased timeouts
        proxy_connect_timeout 600;
        proxy_send_timeout 600;
        proxy_read_timeout 600;
        send_timeout 600;
    }

    # WebSocket support
    location /socket.io/ {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade `$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host `$host;
        proxy_set_header X-Real-IP `$remote_addr;
        proxy_set_header X-Forwarded-For `$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto `$scheme;
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Max upload size
    client_max_body_size 50M;
}
EOF

# Enable the site
sudo ln -sf /etc/nginx/sites-available/sak-ai.saksolution.com /etc/nginx/sites-enabled/

# Test nginx configuration
echo ""
echo "Testing nginx configuration..."
sudo nginx -t

# Reload nginx
echo ""
echo "Reloading nginx..."
sudo systemctl reload nginx

echo ""
echo "✅ Nginx configured for sak-ai.saksolution.com"
echo ""
echo "Now installing SSL certificate..."
echo ""

# Install SSL certificate
sudo certbot --nginx -d sak-ai.saksolution.com --non-interactive --agree-tos --email qutubkothari@gmail.com --redirect

echo ""
echo "✅ SSL certificate installed!"
echo ""
echo "Testing HTTPS..."
curl -I https://sak-ai.saksolution.com 2>&1 | grep -E 'HTTP|Location'
"@

Write-Host "Connecting to server: root@72.62.192.228" -ForegroundColor Yellow
Write-Host ""

# Execute on server
ssh root@72.62.192.228 $sshCommand

Write-Host ""
Write-Host "=================================================" -ForegroundColor Green
Write-Host "   SETUP COMPLETE!" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your site is now available at:" -ForegroundColor Cyan
Write-Host "  http://sak-ai.saksolution.com  (redirects to HTTPS)" -ForegroundColor White
Write-Host "  https://sak-ai.saksolution.com (secure)" -ForegroundColor Green
Write-Host ""
