# EC2 Demo Data Fix Script
$ErrorActionPreference = "Stop"

Write-Host "================================" -ForegroundColor Cyan
Write-Host "  EC2 Demo Data Fix" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

$EC2_HOST = "13.126.234.92"
$EC2_USER = "ubuntu"
$EC2_DIR = "/home/ubuntu/salesmate"

# Run final_demo_fix.js on EC2
Write-Host "[1/1] Running demo fix script on EC2..." -ForegroundColor Yellow
$CMD = "cd $EC2_DIR && node scripts/final_demo_fix.js"
plink -batch -i "C:\Users\musta\.ssh\QK-EC2-2025.ppk" "$EC2_USER@$EC2_HOST" $CMD

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "  DEMO DATA FIX COMPLETE!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
