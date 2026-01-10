param(
  [string]$HostName = "13.126.234.92",
  [string]$UserName = "ubuntu",
  [string]$KeyPath = "$HOME\Downloads\whatsapp-ai-key.pem",
  [string]$RepoPath = "/home/ubuntu/salesmate",
  [string]$TenantId = ""
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $KeyPath)) {
  throw "SSH key not found at: $KeyPath"
}

$tenantArg = ""
if ($TenantId -and $TenantId.Trim().Length -gt 0) {
  $tenantArg = " --tenant $TenantId"
}

$remoteCmd = "cd $RepoPath && node check_zoho_config.js$tenantArg"

Write-Host "[EC2_ZOHO_CHECK] Host: $UserName@$HostName" -ForegroundColor Cyan
Write-Host "[EC2_ZOHO_CHECK] Repo: $RepoPath" -ForegroundColor Cyan
if ($tenantArg) {
  Write-Host "[EC2_ZOHO_CHECK] Tenant: $TenantId" -ForegroundColor Cyan
}
Write-Host "[EC2_ZOHO_CHECK] Running: $remoteCmd" -ForegroundColor DarkGray

ssh -i $KeyPath -o StrictHostKeyChecking=no -o ConnectTimeout=12 -o ServerAliveInterval=15 -o ServerAliveCountMax=2 "$UserName@$HostName" $remoteCmd
