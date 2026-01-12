# Run Multi-User Database Migration Locally
# This script updates your local SQLite database with the new multi-user schema

$ErrorActionPreference = "Stop"

Write-Host "`n===================================================" -ForegroundColor Cyan
Write-Host "   MULTI-USER SYSTEM DATABASE MIGRATION" -ForegroundColor Green
Write-Host "===================================================`n" -ForegroundColor Cyan

$dbPath = "salesmate.db"
$migrationPath = "migrations/001_multi_user_support.sql"

# Check if database exists
if (-not (Test-Path $dbPath)) {
    Write-Host "ERROR: Database file not found: $dbPath" -ForegroundColor Red
    Write-Host "Make sure you're in the salesmate directory" -ForegroundColor Yellow
    exit 1
}

# Check if migration file exists
if (-not (Test-Path $migrationPath)) {
    Write-Host "ERROR: Migration file not found: $migrationPath" -ForegroundColor Red
    exit 1
}

# Check if sqlite3 is available
try {
    $null = sqlite3 -version
} catch {
    Write-Host "ERROR: sqlite3 not found in PATH" -ForegroundColor Red
    Write-Host "Please install SQLite: https://www.sqlite.org/download.html" -ForegroundColor Yellow
    exit 1
}

Write-Host "[1/4] Backing up current database..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupPath = "salesmate_backup_$timestamp.db"
Copy-Item $dbPath $backupPath
Write-Host "✓ Backup created: $backupPath" -ForegroundColor Green

Write-Host "`n[2/4] Checking current schema..." -ForegroundColor Yellow
$beforeTables = sqlite3 $dbPath "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"
Write-Host "Current tables: $($beforeTables.Count) found" -ForegroundColor Gray

Write-Host "`n[3/4] Running migration..." -ForegroundColor Yellow
try {
    Get-Content $migrationPath | sqlite3 $dbPath
    Write-Host "✓ Migration completed successfully" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Migration failed!" -ForegroundColor Red
    Write-Host "Restoring backup..." -ForegroundColor Yellow
    Copy-Item $backupPath $dbPath -Force
    Write-Host "Database restored from backup" -ForegroundColor Green
    throw $_
}

Write-Host "`n[4/4] Verifying migration..." -ForegroundColor Yellow

# Check for new tables
$newTables = @("user_sessions", "product_expertise", "activity_log", "email_classification_cache", "role_permissions")
$verified = 0

foreach ($table in $newTables) {
    $exists = sqlite3 $dbPath "SELECT name FROM sqlite_master WHERE type='table' AND name='$table';"
    if ($exists) {
        Write-Host "  ✓ Table '$table' created" -ForegroundColor Green
        $verified++
    } else {
        Write-Host "  ✗ Table '$table' NOT found" -ForegroundColor Red
    }
}

# Check for new columns in sales_users
$columns = sqlite3 $dbPath "PRAGMA table_info(sales_users);"
if ($columns -match "email" -and $columns -match "password_hash") {
    Write-Host "  ✓ sales_users table updated with email/password fields" -ForegroundColor Green
    $verified++
} else {
    Write-Host "  ✗ sales_users table NOT properly updated" -ForegroundColor Red
}

Write-Host "`n===================================================" -ForegroundColor Cyan
if ($verified -eq 6) {
    Write-Host "   MIGRATION SUCCESSFUL!" -ForegroundColor Green
    Write-Host "===================================================`n" -ForegroundColor Cyan
    Write-Host "✓ All 5 new tables created" -ForegroundColor Green
    Write-Host "✓ sales_users table enhanced" -ForegroundColor Green
    Write-Host "`nBackup saved to: $backupPath" -ForegroundColor Gray
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "1. Invite your first admin: See HOW_TO_REGISTER_USERS.md" -ForegroundColor White
    Write-Host "2. Deploy to production: .\deploy-salesmate-hostinger.ps1" -ForegroundColor White
} else {
    Write-Host "   MIGRATION INCOMPLETE!" -ForegroundColor Red
    Write-Host "===================================================`n" -ForegroundColor Cyan
    Write-Host "Only $verified/6 checks passed" -ForegroundColor Red
    Write-Host "Check the migration file and try again" -ForegroundColor Yellow
    Write-Host "`nBackup available at: $backupPath" -ForegroundColor Gray
    exit 1
}
