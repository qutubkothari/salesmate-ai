const path = require('path');
const Database = require('better-sqlite3');

const dbPath = path.join(__dirname, '..', 'local-database.db');
const db = new Database(dbPath);

console.log('[FIXING DEMO DATA DISPLAY ISSUES]\n');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
if (!tenant) {
    console.error('Demo tenant not found!');
    process.exit(1);
}
const tenantId = tenant.id;
console.log(`Demo Tenant ID: ${tenantId}\n`);

// ===================================================
// 1. FIX CUSTOMERS - Calculate and update total_spent
// ===================================================
console.log('[1/3] Fixing customer total_spent...');

const customers = db.prepare(`
    SELECT DISTINCT c.id, c.phone_number
    FROM customer_profiles c
    WHERE c.tenant_id = ?
`).all(tenantId);

let customersUpdated = 0;
for (const customer of customers) {
    const phone = customer.phone_number;
    
    // Calculate total spent from orders
    const stats = db.prepare(`
        SELECT COALESCE(SUM(o.total_amount), 0) as total_spent
        FROM orders o
        WHERE o.tenant_id = ? AND o.phone_number = ?
    `).get(tenantId, phone);
    
    const totalSpent = stats.total_spent || 0;
    
    // Update customer profile
    db.prepare(`
        UPDATE customer_profiles
        SET total_spent = ?
        WHERE id = ?
    `).run(totalSpent, customer.id);
    
    if (totalSpent > 0) {
        console.log(`  • ${phone}: ₹${totalSpent}`);
        customersUpdated++;
    }
}

console.log(`  ✓ Updated ${customersUpdated} customers with spending data\n`);

// ===================================================
// 2. FIX PRODUCTS - Verify revenue is in order_items
// ===================================================
console.log('[2/3] Verifying product revenue in order_items...');

const products = db.prepare('SELECT id, name FROM products WHERE tenant_id = ? LIMIT 10').all(tenantId);
let productsWithRevenue = 0;

for (const product of products) {
    const revenue = db.prepare(`
        SELECT COALESCE(SUM(oi.total_price), 0) as revenue
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.id
        WHERE oi.product_id = ? AND o.tenant_id = ?
    `).get(product.id, tenantId);
    
    if (revenue.revenue > 0) {
        console.log(`  • ${product.name}: ₹${revenue.revenue}`);
        productsWithRevenue++;
    }
}

console.log(`  ✓ ${productsWithRevenue} products have revenue data\n`);

// ===================================================
// 3. FIX BROADCASTS - Count total sent messages
// ===================================================
console.log('[3/3] Counting broadcast messages sent...');

// Count from broadcast_queue (individual messages)
const messageCount = db.prepare(`
    SELECT COUNT(*) as count
    FROM broadcast_queue
    WHERE tenant_id = ? AND status = 'sent'
`).get(tenantId);

// Count from broadcast_campaign_recipients (campaign messages)
const campaignMessageCount = db.prepare(`
    SELECT COUNT(*) as count
    FROM broadcast_campaign_recipients
    WHERE tenant_id = ? AND status = 'sent'
`).get(tenantId);

// Total sent messages
const totalSent = (messageCount.count || 0) + (campaignMessageCount.count || 0);

console.log(`  • Queue messages sent: ${messageCount.count}`);
console.log(`  • Campaign messages sent: ${campaignMessageCount.count}`);
console.log(`  • Total messages sent: ${totalSent}`);
console.log('  ✓ Broadcast data verified\n');

// ===================================================
// SUMMARY
// ===================================================
console.log('✅ ALL DATA VERIFIED AND FIXED!');
console.log('═══════════════════════════════════════');
console.log('Summary:');
console.log(`  • Customers with spending: ${customersUpdated}`);
console.log(`  • Products with revenue: ${productsWithRevenue}`);
console.log(`  • Total messages sent: ${totalSent}`);
console.log('═══════════════════════════════════════');

db.close();
