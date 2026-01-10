const Database = require('better-sqlite3');
const crypto = require('crypto');

const db = new Database('./local-database.db');

console.log('[FIXING PRODUCT ID MISMATCH]\n');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
if (!tenant) {
    console.error('Demo tenant not found!');
    process.exit(1);
}
const tenantId = tenant.id;

// Strategy: Update order_items to use product_id from products table by matching product_name
const products = db.prepare('SELECT id, name FROM products WHERE tenant_id = ?').all(tenantId);

console.log('Updating order_items to use correct product IDs...\n');

let updatedCount = 0;
for (const product of products) {
    // Find order items with matching product name
    const itemsToUpdate = db.prepare(`
        SELECT oi.id, oi.product_name
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.id
        WHERE o.tenant_id = ? AND oi.product_name = ?
    `).all(tenantId, product.name);
    
    if (itemsToUpdate.length > 0) {
        console.log(`${product.name}: Updating ${itemsToUpdate.length} order items`);
        
        // Update all matching items
        db.prepare(`
            UPDATE order_items
            SET product_id = ?
            WHERE id IN (
                SELECT oi.id 
                FROM order_items oi
                JOIN orders o ON oi.order_id = o.id
                WHERE o.tenant_id = ? AND oi.product_name = ?
            )
        `).run(product.id, tenantId, product.name);
        
        updatedCount += itemsToUpdate.length;
    }
}

console.log(`\n✅ Updated ${updatedCount} order items with correct product IDs`);

// Verify the fix
console.log('\n--- VERIFICATION ---\n');

const verification = db.prepare(`
    SELECT p.name, 
        COUNT(DISTINCT oi.id) as item_count,
        SUM(oi.quantity) as total_qty,
        SUM(oi.total_price) as total_revenue
    FROM products p
    LEFT JOIN order_items oi ON p.id = oi.product_id
    JOIN orders o ON oi.order_id = o.id
    WHERE p.tenant_id = ? AND o.tenant_id = ?
    GROUP BY p.id, p.name
    HAVING item_count > 0
    ORDER BY total_revenue DESC
`).all(tenantId, tenantId);

verification.forEach(v => {
    console.log(`${v.name}: ₹${v.total_revenue} (${v.total_qty} units, ${v.item_count} line items)`);
});

console.log('\n✅ Products now correctly linked to orders!');

db.close();
