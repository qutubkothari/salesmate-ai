/**
 * FSM Users Migration Script
 * Copies users from an existing FSM SQLite database into the Salesmate SQLite DB.
 *
 * Usage:
 *   node migrate-fsm-users.js
 *
 * Env overrides:
 *   FSM_USERS_SOURCE_DB (default: local-database-with-fsm.db)
 *   SQLITE_DB_PATH or DB_PATH (default: local-database.db)
 *   FSM_DEFAULT_TENANT_ID (fallback tenant_id if missing)
 */

const Database = require('better-sqlite3');
const path = require('path');

const sourcePath = process.env.FSM_USERS_SOURCE_DB || path.join(__dirname, 'local-database-with-fsm.db');
const targetPath = process.env.SQLITE_DB_PATH || process.env.DB_PATH || path.join(__dirname, 'local-database.db');
const DEFAULT_TENANT_ID = process.env.FSM_DEFAULT_TENANT_ID || '112f12b8-55e9-4de8-9fda-d58e37c75796';

console.log('========================================');
console.log('  FSM Users Migration: SQLite → SQLite');
console.log('========================================');
console.log('Source:', sourcePath);
console.log('Target:', targetPath);

const sourceDb = new Database(sourcePath, { readonly: true });
const targetDb = new Database(targetPath);

// Ensure users table exists in target
try {
  targetDb.exec(`
    CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      tenant_id TEXT NOT NULL,
      phone TEXT NOT NULL,
      name TEXT NOT NULL,
      password TEXT,
      password_hash TEXT,
      role TEXT DEFAULT 'salesman',
      email TEXT,
      assigned_plants TEXT DEFAULT '[]',
      preferred_language TEXT DEFAULT 'en',
      is_active INTEGER DEFAULT 1,
      created_at TEXT DEFAULT (DATETIME('now')),
      updated_at TEXT DEFAULT (DATETIME('now')),
      UNIQUE(tenant_id, phone)
    );
    CREATE INDEX IF NOT EXISTS idx_users_tenant ON users(tenant_id);
    CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
  `);
} catch (e) {
  console.error('❌ Failed to ensure users table:', e.message);
  process.exit(1);
}

let sourceUsers = [];
try {
  sourceUsers = sourceDb.prepare('SELECT * FROM users').all();
} catch (e) {
  console.error('❌ Source DB does not contain users table:', e.message);
  process.exit(1);
}

if (!sourceUsers.length) {
  console.log('No users found in source DB.');
  process.exit(0);
}

const insertUser = targetDb.prepare(`
  INSERT OR IGNORE INTO users (
    id, tenant_id, phone, name, password, password_hash,
    role, email, assigned_plants, preferred_language,
    is_active, created_at, updated_at
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
`);

const migrate = targetDb.transaction((rows) => {
  let migrated = 0;
  let skipped = 0;

  for (const row of rows) {
    const tenantId = row.tenant_id || DEFAULT_TENANT_ID;
    const assignedPlants = row.assigned_plants || '[]';

    const result = insertUser.run(
      row.id || null,
      tenantId,
      row.phone || null,
      row.name || null,
      row.password || null,
      row.password_hash || null,
      row.role || 'salesman',
      row.email || null,
      assignedPlants,
      row.preferred_language || 'en',
      row.is_active == null ? 1 : (row.is_active ? 1 : 0),
      row.created_at || new Date().toISOString(),
      row.updated_at || new Date().toISOString()
    );

    if (result.changes > 0) migrated++;
    else skipped++;
  }

  return { migrated, skipped };
});

const { migrated, skipped } = migrate(sourceUsers);

console.log(`✅ Users migrated: ${migrated}`);
console.log(`ℹ️  Users skipped (already exist): ${skipped}`);

sourceDb.close();
targetDb.close();
console.log('Done.');
