param(
  [Parameter(Mandatory=$true)][string]$ZohoClientId,
  [Parameter(Mandatory=$true)][string]$ZohoClientSecret,
  [string]$ZohoAccountsUrl = "",
  [string]$ZohoApiUrl = "",
  [string]$HostName = "13.126.234.92",
  [string]$UserName = "ubuntu",
  [string]$KeyPath = "$HOME\Downloads\whatsapp-ai-key.pem",
  [string]$RepoPath = "/home/ubuntu/salesmate",
  [switch]$RestartService
)

$ErrorActionPreference = "Stop"

function Mask([string]$v) {
  if (-not $v) { return "" }
  if ($v.Length -le 10) { return ($v.Substring(0,2) + "***") }
  return ($v.Substring(0,6) + "***" + $v.Substring($v.Length-4))
}

if (-not (Test-Path -LiteralPath $KeyPath)) {
  throw "SSH key not found at: $KeyPath"
}

if ($ZohoClientId.Contains("'")) { throw "ZohoClientId cannot contain single quotes (')" }
if ($ZohoClientSecret.Contains("'")) { throw "ZohoClientSecret cannot contain single quotes (')" }
if ($ZohoAccountsUrl.Contains("'")) { throw "ZohoAccountsUrl cannot contain single quotes (')" }
if ($ZohoApiUrl.Contains("'")) { throw "ZohoApiUrl cannot contain single quotes (')" }

Write-Host "[EC2_ZOHO_SET_ENV] Host: $UserName@$HostName" -ForegroundColor Cyan
Write-Host "[EC2_ZOHO_SET_ENV] Repo: $RepoPath" -ForegroundColor Cyan
Write-Host "[EC2_ZOHO_SET_ENV] ZOHO_CLIENT_ID: $(Mask $ZohoClientId)" -ForegroundColor Cyan
Write-Host "[EC2_ZOHO_SET_ENV] ZOHO_CLIENT_SECRET: $(Mask $ZohoClientSecret)" -ForegroundColor Cyan
if ($ZohoAccountsUrl) { Write-Host "[EC2_ZOHO_SET_ENV] ZOHO_ACCOUNTS_URL: $ZohoAccountsUrl" -ForegroundColor Cyan }
if ($ZohoApiUrl) { Write-Host "[EC2_ZOHO_SET_ENV] ZOHO_API_URL: $ZohoApiUrl" -ForegroundColor Cyan }

# Use bash to safely rewrite .env with backup, removing old keys and appending new.
# Note: Values are passed as single-quoted strings; do not include single quotes in the values.
$accountsLine = ""
$apiLine = ""
if ($ZohoAccountsUrl -and $ZohoAccountsUrl.Trim().Length -gt 0) { $accountsLine = "ZOHO_ACCOUNTS_URL=$ZohoAccountsUrl" }
if ($ZohoApiUrl -and $ZohoApiUrl.Trim().Length -gt 0) { $apiLine = "ZOHO_API_URL=$ZohoApiUrl" }

$remoteCmd = @'
set -e
cd '__REPO__'
touch .env
backup=".env.bak.$(python3 -c 'import time; print(int(time.time()))')"
cp .env "$backup"
# Filter out existing Zoho keys we manage
grep -v -E '^(ZOHO_CLIENT_ID|ZOHO_CLIENT_SECRET|ZOHO_ACCOUNTS_URL|ZOHO_API_URL)=' .env > .env.tmp || true
printf '\n# Zoho OAuth (managed)\n' >> .env.tmp
printf 'ZOHO_CLIENT_ID=%s\n' '__CID__' >> .env.tmp
printf 'ZOHO_CLIENT_SECRET=%s\n' '__CSECRET__' >> .env.tmp
'@

$remoteCmd = $remoteCmd.Replace('__REPO__', $RepoPath)
$remoteCmd = $remoteCmd.Replace('__CID__', $ZohoClientId)
$remoteCmd = $remoteCmd.Replace('__CSECRET__', $ZohoClientSecret)

if ($accountsLine) {
  $remoteCmd += "printf 'ZOHO_ACCOUNTS_URL=%s\\n' '$ZohoAccountsUrl' >> .env.tmp\n"
}
if ($apiLine) {
  $remoteCmd += "printf 'ZOHO_API_URL=%s\\n' '$ZohoApiUrl' >> .env.tmp\n"
}

$remoteCmd += @'
# Replace
mv .env.tmp .env
chmod 600 .env
printf '[EC2_ZOHO_SET_ENV] Updated .env (backup: %s)\n' "$backup"
'@

ssh -i $KeyPath -o StrictHostKeyChecking=no -o ConnectTimeout=12 -o ServerAliveInterval=15 -o ServerAliveCountMax=2 "$UserName@$HostName" $remoteCmd

if ($RestartService) {
  Write-Host "[EC2_ZOHO_SET_ENV] Restarting salesmate-bot..." -ForegroundColor Yellow
  ssh -i $KeyPath -o StrictHostKeyChecking=no "$UserName@$HostName" "sudo systemctl restart salesmate-bot && sudo systemctl is-active salesmate-bot"
}
