#!/bin/bash
# Restart Waha with security disabled for testing

echo "Stopping existing Waha container..."
sudo docker stop waha 2>/dev/null
sudo docker rm waha 2>/dev/null

echo "Starting Waha with security disabled..."
sudo docker run -d \
  --name waha \
  --restart unless-stopped \
  -p 3000:3000 \
  -v ~/waha-data:/app/.sessions \
  -e WHATSAPP_HOOK_URL=http://localhost:8080/api/waha/webhook \
  -e WHATSAPP_API_KEY=your-secret-key \
  -e WHATSAPP_API_KEY_IN=header \
  devlikeapro/waha:latest

sleep 3

echo ""
echo "✅ Waha restarted successfully!"
echo ""
echo "Container status:"
sudo docker ps | grep waha
echo ""
echo "Waha API: http://13.235.18.119:3000"
echo "API Key: your-secret-key"
echo ""
