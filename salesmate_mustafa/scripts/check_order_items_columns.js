const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[CHECKING ORDER_ITEMS SCHEMA]\n');

// Get schema
const schema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name='order_items'`).get();
console.log('Schema:');
console.log(schema.sql);

console.log('\n---\n');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
const tenantId = tenant.id;

// Get sample order items
const samples = db.prepare(`
    SELECT oi.*
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.tenant_id = ?
    LIMIT 3
`).all(tenantId);

console.log('Sample order_items:');
samples.forEach((item, i) => {
    console.log(`\nItem ${i + 1}:`);
    console.log(`  product_name: ${item.product_name}`);
    console.log(`  quantity: ${item.quantity}`);
    console.log(`  price_at_time_of_purchase: ${item.price_at_time_of_purchase || 'NULL'}`);
    console.log(`  unit_price: ${item.unit_price || 'NULL'}`);
    console.log(`  total_price: ${item.total_price || 'NULL'}`);
    console.log('  All columns:', Object.keys(item).join(', '));
});

db.close();
