const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[FINDING PRODUCTS WITH REVENUE]\n');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
if (!tenant) {
    console.error('Demo tenant not found!');
    process.exit(1);
}
const tenantId = tenant.id;

// Get all product IDs from order_items
const productIdsInOrders = db.prepare(`
    SELECT DISTINCT oi.product_id, oi.product_name,
        SUM(oi.quantity) as total_qty,
        SUM(oi.total_price) as total_revenue
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.tenant_id = ?
    GROUP BY oi.product_id
    ORDER BY total_revenue DESC
`).all(tenantId);

console.log('Products with revenue (from order_items):');
productIdsInOrders.forEach(p => {
    console.log(`  ${p.product_name}: ₹${p.total_revenue} (${p.total_qty} units) - ID: ${p.product_id.substring(0, 12)}...`);
});

console.log('\n---\n');

// Get all products in products table
const productsInTable = db.prepare(`
    SELECT id, name
    FROM products
    WHERE tenant_id = ?
    LIMIT 10
`).all(tenantId);

console.log('Products in products table:');
productsInTable.forEach(p => {
    console.log(`  ${p.name} - ID: ${p.id.substring(0, 12)}...`);
});

console.log('\n---\n');
console.log('THE PROBLEM: Product IDs don\'t match!');
console.log('Order items reference different product IDs than the products table.');

db.close();
