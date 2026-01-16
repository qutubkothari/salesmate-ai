/**
 * Import FSM tenants/users/plants/salesmen into Salesmate SQLite.
 *
 * Usage: node import-fsm-bootstrap.js
 * Env:
 *   SQLITE_DB_PATH or DB_PATH
 *   FSM_IMPORT_FILE (default: fsm-import-data.json)
 */

const fs = require('fs');
const path = require('path');
const Database = require('better-sqlite3');

const dataFile = process.env.FSM_IMPORT_FILE || path.join(__dirname, 'fsm-import-data.json');
const dbPath = process.env.SQLITE_DB_PATH || process.env.DB_PATH || path.join(__dirname, 'local-database.db');

if (!fs.existsSync(dataFile)) {
  console.error('❌ Import file not found:', dataFile);
  process.exit(1);
}

const payload = JSON.parse(fs.readFileSync(dataFile, 'utf8'));
const tenants = payload.tenants || [];
const plants = payload.plants || [];
const users = payload.users || [];
const salesmen = payload.salesmen || [];

const db = new Database(dbPath);

const toIso = (value) => {
  if (!value) return new Date().toISOString();
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return new Date().toISOString();
  return date.toISOString();
};

const ensurePhone = (tenant) => {
  const slug = tenant?.slug || tenant?.name || tenant?.company_name || tenant?.id || 'tenant';
  return `tenant_${String(slug).replace(/\s+/g, '_').toLowerCase()}`;
};

const normalizeAssignedPlants = (value) => {
  if (!value) return '[]';
  if (Array.isArray(value)) return JSON.stringify(value);
  if (typeof value === 'string') {
    const trimmed = value.trim();
    if (!trimmed) return '[]';
    try {
      const parsed = JSON.parse(trimmed);
      return Array.isArray(parsed) ? JSON.stringify(parsed) : '[]';
    } catch {
      return '[]';
    }
  }
  return '[]';
};

const insertTenant = db.prepare(`
  INSERT OR IGNORE INTO tenants (
    id, business_name, phone_number, owner_whatsapp_number, email,
    subscription_tier, subscription_status, is_active, status,
    currency_symbol, created_at, updated_at
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
`);

const insertPlant = db.prepare(`
  INSERT OR IGNORE INTO plants (
    id, tenant_id, name, location, city, state, country, timezone,
    created_at, updated_at
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
`);

const insertUser = db.prepare(`
  INSERT OR IGNORE INTO users (
    id, tenant_id, phone, name, password, role, email,
    assigned_plants, preferred_language, is_active, created_at, updated_at
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
`);

const insertSalesman = db.prepare(`
  INSERT OR IGNORE INTO salesmen (
    id, tenant_id, user_id, name, phone, email, plant_id,
    is_active, created_at, updated_at
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
`);

const updateSalesman = db.prepare(`
  UPDATE salesmen
  SET user_id = COALESCE(user_id, ?),
      plant_id = COALESCE(plant_id, ?),
      updated_at = ?
  WHERE id = ?
`);

const getUserByPhone = db.prepare(`
  SELECT * FROM users WHERE tenant_id = ? AND phone = ?
`);

const transaction = db.transaction(() => {
  let tenantCount = 0;
  let plantCount = 0;
  let userCount = 0;
  let salesmanCount = 0;
  let skippedUsers = 0;

  for (const t of tenants) {
    const phone = t.contact_phone || ensurePhone(t);
    const ownerWhatsapp = t.contact_phone ? `${t.contact_phone}@c.us` : phone;
    insertTenant.run(
      t.id,
      (t.company_name || t.name || t.slug || 'Tenant').trim(),
      phone,
      ownerWhatsapp,
      t.contact_email || null,
      t.subscription_plan || 'standard',
      t.is_active ? 'active' : 'inactive',
      t.is_active ? 1 : 0,
      t.is_active ? 'active' : 'inactive',
      t.currency_symbol || '₹',
      toIso(t.created_at),
      toIso(t.updated_at)
    );
    tenantCount++;
  }

  for (const p of plants) {
    insertPlant.run(
      p.id,
      p.tenant_id,
      (p.plant_name || p.plant_code || p.id).trim(),
      p.area || null,
      p.city || null,
      null,
      null,
      p.timezone || null,
      toIso(p.created_at),
      toIso(p.updated_at)
    );
    plantCount++;
  }

  for (const u of users) {
    const phone = (u.phone || '').trim();
    if (!phone) {
      skippedUsers++;
      continue;
    }

    insertUser.run(
      u.id,
      u.tenant_id,
      phone,
      u.name || phone,
      u.password || null,
      u.role || 'salesman',
      u.email || null,
      normalizeAssignedPlants(u.assigned_plants),
      u.preferred_language || 'en',
      u.is_active ? 1 : 0,
      toIso(u.created_at),
      toIso(u.updated_at)
    );
    userCount++;
  }

  for (const s of salesmen) {
    const phone = (s.phone || '').trim() || null;
    let plantId = null;
    if (Array.isArray(s.plant) && s.plant.length > 0) {
      plantId = s.plant[0];
    } else if (typeof s.plant === 'string' && s.plant.trim()) {
      plantId = s.plant.trim();
    }

    const user = phone ? getUserByPhone.get(s.tenant_id, phone) : null;
    const userId = user?.id || null;

    insertSalesman.run(
      s.id,
      s.tenant_id,
      userId,
      s.name || phone || s.id,
      phone,
      s.email || null,
      plantId,
      s.is_active ? 1 : 0,
      toIso(s.created_at),
      toIso(s.updated_at)
    );

    updateSalesman.run(userId, plantId, toIso(s.updated_at), s.id);
    salesmanCount++;
  }

  return { tenantCount, plantCount, userCount, salesmanCount, skippedUsers };
});

const summary = transaction();

console.log('✅ FSM import complete');
console.log(summary);

// Ensure FK checks after import
try {
  db.pragma('foreign_keys = ON');
} catch {}

const counts = {
  tenants: db.prepare('SELECT COUNT(*) as c FROM tenants').get().c,
  users: db.prepare('SELECT COUNT(*) as c FROM users').get().c,
  plants: db.prepare('SELECT COUNT(*) as c FROM plants').get().c,
  salesmen: db.prepare('SELECT COUNT(*) as c FROM salesmen').get().c
};

console.log('Current totals:', counts);

// Done

