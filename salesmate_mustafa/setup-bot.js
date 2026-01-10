const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

const BOT_PHONE = '96567709452';

console.log('Setting up bot on phone:', BOT_PHONE);

let tenant = db.prepare('SELECT * FROM tenants LIMIT 1').get();

if (!tenant) {
  db.prepare(`INSERT INTO tenants (phone_number, business_name, password, bot_phone_number, is_active) VALUES (?, 'Test Business', '5253', ?, 1)`).run(BOT_PHONE, BOT_PHONE + '@c.us');
  tenant = db.prepare('SELECT * FROM tenants LIMIT 1').get();
  console.log('Created new tenant');
} else {
  db.prepare(`UPDATE tenants SET phone_number = ?, bot_phone_number = ? WHERE id = ?`).run(BOT_PHONE, BOT_PHONE + '@c.us', tenant.id);
  tenant = db.prepare('SELECT * FROM tenants WHERE id = ?').get(tenant.id);
  console.log('Updated tenant');
}

console.log('\n=== BOT READY ===');
console.log('Login: http://13.126.234.92:8081/dashboard');
console.log('Phone:', tenant.phone_number);
console.log('Password:', tenant.password);
console.log('\nTest: Send WhatsApp message to', BOT_PHONE);
console.log('Try: "Hi" or "show products"');

db.close();
