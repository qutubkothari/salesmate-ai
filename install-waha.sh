#!/bin/bash
# Waha Installation Script for EC2
# Runs WhatsApp HTTP API in Docker for 24/7 bot support

echo "=========================================="
echo "   WAHA INSTALLATION ON EC2"
echo "=========================================="
echo ""

# Check if Docker is installed
echo "Step 1: Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ubuntu
    echo "??? Docker installed successfully"
else
    echo "??? Docker already installed: $(docker --version)"
fi

# Check if Docker Compose is installed (optional but helpful)
echo ""
echo "Step 2: Checking Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "??? Docker Compose installed"
else
    echo "??? Docker Compose already installed"
fi

# Pull Waha Docker image
echo ""
echo "Step 3: Pulling Waha Docker image..."
sudo docker pull devlikeapro/waha:latest
echo "??? Waha image downloaded"

# Stop existing Waha container if running
echo ""
echo "Step 4: Stopping any existing Waha container..."
sudo docker stop waha 2>/dev/null || echo "No existing container to stop"
sudo docker rm waha 2>/dev/null || echo "No existing container to remove"

# Create data directory for session persistence
echo ""
echo "Step 5: Creating data directory..."
mkdir -p ~/waha-data
sudo chown -R $USER:$USER ~/waha-data
echo "✓ Data directory created at ~/waha-data"

# Start Waha container
echo ""
echo "Step 6: Starting Waha container..."
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

# Wait for container to start
echo ""
echo "Waiting for Waha to start..."
sleep 5

# Check if container is running
if sudo docker ps | grep -q waha; then
    echo ""
    echo "✅ WAHA INSTALLED SUCCESSFULLY!"
    echo ""
    echo "Container Status:"
    sudo docker ps | grep waha
    echo ""
    echo "WAHA API: http://localhost:3001"
    echo "API Key: waha_salesmate_2024"
    echo "Webhook: http://host.docker.internal:8057/api/waha/webhook"
    echo ""
    echo "⚠️  IMPORTANT: Scan QR code at http://<SERVER_IP>:3001/api/default/auth/qr"
    echo ""
else
    echo ""
    echo "❌ Waha failed to start. Checking logs..."
    sudo docker logs waha
    exit 1
fi

echo "=========================================="
echo "   INSTALLATION COMPLETE!"
echo "=========================================="
