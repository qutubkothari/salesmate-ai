#!/bin/bash
# Restart WAHA WhatsApp Bot Container
# Updated: Jan 27, 2026 - Fixed webhook URL for Docker networking

echo "Stopping existing Waha container..."
sudo docker stop waha 2>/dev/null
sudo docker rm waha 2>/dev/null

echo "Starting Waha with proper webhook configuration..."
sudo docker run -d \
  --name waha \
  --restart unless-stopped \
  -p 3001:3000 \
  --add-host=host.docker.internal:host-gateway \
  -v ~/waha-data:/app/.sessions \
  -e WHATSAPP_DEFAULT_ENGINE=GOWS \
  -e WHATSAPP_HOOK_URL=http://host.docker.internal:8057/api/waha/webhook \
  -e WHATSAPP_HOOK_EVENTS=message.any,message,session.status \
  -e WHATSAPP_API_KEY=waha_salesmate_2024 \
  devlikeapro/waha:latest

sleep 5

echo ""
echo "✅ WAHA restarted successfully!"
echo ""
echo "Container status:"
sudo docker ps | grep waha
echo ""
echo "WAHA API: http://localhost:3001"
echo "API Key: waha_salesmate_2024"
echo "Webhook: http://host.docker.internal:8057/api/waha/webhook"
echo ""
echo "⚠️  If session shows SCAN_QR_CODE, scan QR at:"
echo "   http://72.62.192.228:3001/api/default/auth/qr"
echo ""
