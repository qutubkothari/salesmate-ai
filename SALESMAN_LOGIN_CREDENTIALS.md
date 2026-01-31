# SALESMAN MOBILE APP TEST LOGIN CREDENTIALS

## Authentication Methods

The mobile app supports **2 authentication methods**:

### Method 1: Phone + Password (Recommended)
Use these headers when testing APIs:
```
X-Tenant-Id: 112f12b8-55e9-4de8-9fda-d58e37c75796
X-Salesman-Phone: <phone_number>
X-Salesman-Password: <password>
```

### Method 2: Bearer Token (User ID)
```
X-Tenant-Id: 112f12b8-55e9-4de8-9fda-d58e37c75796
Authorization: Bearer <user_id>
```

---

## Test Credentials

You'll need to create a salesman user first. Here's how:

### Step 1: Check Existing Salesmen
Run in Supabase SQL Editor:
```sql
SELECT 
  s.id as salesman_id,
  s.name,
  s.phone,
  s.user_id,
  u.phone as user_phone,
  u.role
FROM salesmen s
LEFT JOIN users u ON u.id = s.user_id
WHERE s.tenant_id = '112f12b8-55e9-4de8-9fda-d58e37c75796'
  AND s.is_active = true
LIMIT 5;
```

### Step 2: Create Test Salesman (if needed)
If no salesmen exist, create one:

```sql
-- First, create a user with password
INSERT INTO users (id, tenant_id, phone, name, password_hash, role, is_active)
VALUES (
  gen_random_uuid()::text,
  '112f12b8-55e9-4de8-9fda-d58e37c75796',
  '9876543210',  -- Test phone number
  'Test Salesman',
  '$2b$10$rGxQF5Z.4kK5F5z5F5z5FeuYH8F5F5F5F5F5F5F5F5F5F5F5F5F',  -- bcrypt hash of "Test@123"
  'salesman',
  true
)
RETURNING id;

-- Then, create salesman record (use the user id from above)
INSERT INTO salesmen (id, tenant_id, user_id, name, phone, is_active)
VALUES (
  gen_random_uuid()::text,
  '112f12b8-55e9-4de8-9fda-d58e37c75796',
  '<USER_ID_FROM_ABOVE>',
  'Test Salesman',
  '9876543210',
  true
);
```

---

## Testing Mobile APIs

### Example: Test Follow-ups API

**PowerShell:**
```powershell
$headers = @{
    "X-Tenant-Id" = "112f12b8-55e9-4de8-9fda-d58e37c75796"
    "X-Salesman-Phone" = "9876543210"
    "X-Salesman-Password" = "Test@123"
    "Content-Type" = "application/json"
}

Invoke-RestMethod -Uri "https://sak-ai.saksolution.ae/api/mobile/followups" -Headers $headers -Method GET
```

**curl:**
```bash
curl -X GET "https://sak-ai.saksolution.ae/api/mobile/followups" \
  -H "X-Tenant-Id: 112f12b8-55e9-4de8-9fda-d58e37c75796" \
  -H "X-Salesman-Phone: 9876543210" \
  -H "X-Salesman-Password: Test@123" \
  -H "Content-Type: application/json"
```

---

## Quick Start (Using Existing Data)

If you already have salesmen in your database, find one using:

```sql
-- Find an active salesman
SELECT 
  s.name,
  s.phone,
  u.phone as login_phone,
  s.user_id
FROM salesmen s
LEFT JOIN users u ON u.id = s.user_id
WHERE s.tenant_id = '112f12b8-55e9-4de8-9fda-d58e37c75796'
  AND s.is_active = true
LIMIT 1;
```

Then:
1. **If the salesman has a user_id**: Use Method 2 (Bearer token with user_id)
2. **If the salesman has a phone**: Use Method 1 but you'll need to set a password first

### Set Password for Existing Salesman:
```sql
-- Update user password (bcrypt hash of "Test@123")
UPDATE users 
SET password_hash = '$2b$10$rGxQF5Z.4kK5F5z5F5z5FeuYH8F5F5F5F5F5F5F5F5F5F5F5F5F'
WHERE phone = '<SALESMAN_PHONE>'
  AND tenant_id = '112f12b8-55e9-4de8-9fda-d58e37c75796';
```

---

## Default Test Credentials (Recommended)

**Phone:** `9876543210`  
**Password:** `Test@123`  
**Tenant ID:** `112f12b8-55e9-4de8-9fda-d58e37c75796`

Use the SQL above to create this user, then test with PowerShell/curl examples.

---

## Troubleshooting

**401 Unauthorized:**
- Check tenant_id is correct
- Verify phone/password match database
- Ensure user has `role='salesman'` and `is_active=true`
- Ensure salesman record exists with matching user_id

**No data returned:**
- Run migrations first (COMPLETE_MIGRATION.sql)
- Create some follow-up test data
- Check salesman has access to the data
