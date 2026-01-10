const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('[TESTING PRODUCTS API SIMULATION]\n');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
if (!tenant) {
    console.error('Demo tenant not found!');
    process.exit(1);
}
const tenantId = tenant.id;

// Get products
const products = db.prepare('SELECT id, name FROM products WHERE tenant_id = ? LIMIT 3').all(tenantId);

console.log('Testing first 3 products:\n');

for (const product of products) {
    // Get tenant orders
    const orders = db.prepare('SELECT id FROM orders WHERE tenant_id = ?').all(tenantId);
    const orderIds = orders.map(o => o.id);
    
    console.log(`Product: ${product.name} (${product.id})`);
    console.log(`  Total orders in system: ${orderIds.length}`);
    
    if (orderIds.length > 0) {
        // Get order items for this product
        const items = db.prepare(`
            SELECT oi.*, o.tenant_id
            FROM order_items oi
            JOIN orders o ON oi.order_id = o.id
            WHERE oi.product_id = ? AND o.tenant_id = ?
        `).all(product.id, tenantId);
        
        console.log(`  Order items for this product: ${items.length}`);
        
        if (items.length > 0) {
            let totalRevenue = 0;
            let totalQty = 0;
            
            items.forEach(item => {
                const qty = Number(item.quantity || 0);
                const price = Number(item.price_at_time_of_purchase || item.unit_price || 0);
                const revenue = qty * price;
                
                totalRevenue += revenue;
                totalQty += qty;
                
                console.log(`    Item: ${qty} × ₹${price} = ₹${revenue}`);
            });
            
            console.log(`  TOTAL: ${totalQty} units, ₹${totalRevenue} revenue`);
        } else {
            console.log(`  NO ORDER ITEMS FOUND!`);
            
            // Check if product_id matches
            const allItems = db.prepare(`
                SELECT DISTINCT oi.product_id
                FROM order_items oi
                JOIN orders o ON oi.order_id = o.id
                WHERE o.tenant_id = ?
            `).all(tenantId);
            
            console.log(`  Available product_ids in order_items:`, allItems.map(i => i.product_id.substring(0, 8) + '...'));
        }
    }
    
    console.log('');
}

db.close();
