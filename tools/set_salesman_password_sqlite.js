#!/usr/bin/env node

const path = require('path');
const Database = require('better-sqlite3');
const bcrypt = require('bcryptjs');

function parseArgs(argv) {
  const args = {};
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i];
    if (!a.startsWith('--')) continue;
    const key = a.slice(2);
    const next = argv[i + 1];
    if (!next || next.startsWith('--')) {
      args[key] = true;
    } else {
      args[key] = next;
      i++;
    }
  }
  return args;
}

function normalizePhoneDigits(value) {
  if (!value) return '';
  const withoutSuffix = String(value).replace(/@c\.us$/i, '');
  return withoutSuffix.replace(/\D/g, '');
}

function phonesMatch(a, b) {
  const ad = normalizePhoneDigits(a);
  const bd = normalizePhoneDigits(b);
  if (!ad || !bd) return false;
  if (ad === bd) return true;

  const suffixLen = 9;
  if (ad.length >= suffixLen && bd.length >= suffixLen) {
    return ad.slice(-suffixLen) === bd.slice(-suffixLen);
  }

  const minLen = Math.min(ad.length, bd.length);
  if (minLen >= 7) {
    return ad.slice(-minLen) === bd.slice(-minLen);
  }

  return false;
}

function usageAndExit(code = 1) {
  // Intentionally minimal output (no secrets)
  console.log('Usage: node tools/set_salesman_password_sqlite.js --phone <digits> --password <newPassword> [--tenant <tenant_id>]');
  process.exit(code);
}

(async () => {
  const args = parseArgs(process.argv);
  const phoneArg = args.phone;
  const password = args.password;
  const tenantIdArg = args.tenant;

  if (!phoneArg || !password) usageAndExit(1);

  const dbPath = path.join(__dirname, '..', 'local-database.db');
  const db = new Database(dbPath);
  db.pragma('journal_mode = WAL');

  const phoneDigits = normalizePhoneDigits(phoneArg);
  if (!phoneDigits) {
    console.error('Invalid --phone');
    process.exit(1);
  }

  // Find salesman by phone (optionally tenant-scoped)
  let salesman = null;
  try {
    if (tenantIdArg) {
      const candidates = db.prepare('SELECT * FROM salesmen WHERE tenant_id = ?').all(tenantIdArg);
      salesman = candidates.find((s) => phonesMatch(s.phone, phoneDigits)) || null;
    } else {
      const candidates = db.prepare('SELECT * FROM salesmen').all();
      salesman = candidates.find((s) => phonesMatch(s.phone, phoneDigits)) || null;
    }
  } catch (e) {
    console.error('Failed to query salesmen:', e.message);
    process.exit(1);
  }

  if (!salesman) {
    console.error('Salesman not found for that phone. Provide correct --tenant if you have multiple companies.');
    process.exit(1);
  }

  const tenantId = tenantIdArg || salesman.tenant_id;
  if (!tenantId) {
    console.error('Could not resolve tenant_id for salesman.');
    process.exit(1);
  }

  // Ensure a users row exists & is linked
  let user = null;
  if (salesman.user_id) {
    user = db.prepare('SELECT * FROM users WHERE id = ?').get(salesman.user_id) || null;
  }

  if (!user) {
    const users = db.prepare('SELECT * FROM users WHERE tenant_id = ?').all(tenantId);
    user = users.find((u) => phonesMatch(u.phone, phoneDigits)) || null;
  }

  const passwordHash = bcrypt.hashSync(String(password), 10);

  const now = new Date().toISOString();

  const tx = db.transaction(() => {
    if (!user) {
      const newUserId = (globalThis.crypto?.randomUUID ? globalThis.crypto.randomUUID() : require('crypto').randomUUID());
      db.prepare(
        `INSERT INTO users (id, tenant_id, name, phone, role, is_active, password_hash, created_at, updated_at)
         VALUES (?, ?, ?, ?, ?, 1, ?, ?, ?)`
      ).run(newUserId, tenantId, salesman.name || 'Salesman', phoneDigits, 'salesman', passwordHash, now, now);
      user = db.prepare('SELECT * FROM users WHERE id = ?').get(newUserId);
    } else {
      db.prepare(
        `UPDATE users
         SET password_hash = ?, password = NULL, updated_at = ?
         WHERE id = ?`
      ).run(passwordHash, now, user.id);

      // Ensure role is salesman (don’t change if already admin/super_admin)
      const role = String(user.role || '').toLowerCase();
      if (!role) {
        db.prepare('UPDATE users SET role = ? WHERE id = ?').run('salesman', user.id);
      }
    }

    if (!salesman.user_id || salesman.user_id !== user.id) {
      db.prepare('UPDATE salesmen SET user_id = ?, updated_at = ? WHERE id = ?').run(user.id, now, salesman.id);
    }
  });

  try {
    tx();
  } catch (e) {
    console.error('Failed to update password:', e.message);
    process.exit(1);
  }

  console.log('OK: salesman password set');
  console.log(`tenant_id=${tenantId}`);
  console.log(`salesman_id=${salesman.id}`);
  console.log(`user_id=${user.id}`);
})();
