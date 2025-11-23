# Setup Environment Variables on EC2
# Run this script to configure your .env file on EC2

param(
    [switch]$Upload
)

$EC2_USER = "ubuntu"
$EC2_IP = "43.205.192.171"
$EC2_KEY = "$HOME\Downloads\whatsapp-ai-key.pem"
$EC2_APP_DIR = "/home/ubuntu/SAK-Whatsapp-AI-Hybrid"

if ($Upload) {
    # Check if .env exists locally
    if (Test-Path ".env") {
        Write-Host "Uploading .env file to EC2..." -ForegroundColor Yellow
        scp -i $EC2_KEY .env ${EC2_USER}@${EC2_IP}:${EC2_APP_DIR}/.env
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ .env file uploaded successfully!" -ForegroundColor Green
            Write-Host "Restarting application..." -ForegroundColor Yellow
            ssh -i $EC2_KEY $EC2_USER@$EC2_IP "cd $EC2_APP_DIR && pm2 restart whatsapp-ai"
            Write-Host "✅ Application restarted!" -ForegroundColor Green
        } else {
            Write-Host "❌ Failed to upload .env file" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ .env file not found in current directory" -ForegroundColor Red
        Write-Host "Please create a .env file first or run this script without -Upload flag" -ForegroundColor Yellow
    }
} else {
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "  EC2 Environment Setup Guide" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Your app is crashing because the .env file is missing on EC2." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Option 1: Upload your local .env file (RECOMMENDED)" -ForegroundColor Green
    Write-Host "  Run: .\setup-env-ec2.ps1 -Upload" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Option 2: Create .env manually on EC2" -ForegroundColor Yellow
    Write-Host "  1. SSH to EC2: ssh -i $EC2_KEY $EC2_USER@$EC2_IP" -ForegroundColor Cyan
    Write-Host "  2. cd $EC2_APP_DIR" -ForegroundColor Cyan
    Write-Host "  3. nano .env" -ForegroundColor Cyan
    Write-Host "  4. Add your environment variables (see below)" -ForegroundColor Cyan
    Write-Host "  5. Save (Ctrl+O, Enter, Ctrl+X)" -ForegroundColor Cyan
    Write-Host "  6. pm2 restart whatsapp-ai" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Required Environment Variables:" -ForegroundColor Cyan
    Write-Host "------------------------------"
    Write-Host "SUPABASE_URL=your_supabase_url"
    Write-Host "SUPABASE_SERVICE_ROLE_KEY=your_service_role_key"
    Write-Host "OPENAI_API_KEY=your_openai_key"
    Write-Host "MAYTAPI_PRODUCT_ID=your_maytapi_product_id"
    Write-Host "MAYTAPI_PHONE_ID=your_maytapi_phone_id"
    Write-Host "MAYTAPI_TOKEN=your_maytapi_token"
    Write-Host "PORT=8080"
    Write-Host ""
}
