const Database = require('better-sqlite3');

const orderId = process.argv[2];
if (!orderId) {
    console.error('Usage: node scripts/ec2_check_order_items.js <orderId> [dbPath]');
    process.exit(1);
}

const dbPath = process.argv[3] || process.env.SQLITE_DB || 'local-database.db';

const db = new Database(dbPath, { readonly: true });

function tableExists(tableName) {
    const row = db
        .prepare("SELECT name FROM sqlite_master WHERE type='table' AND name=?")
        .get(tableName);
    return !!row;
}

if (!tableExists('orders') || !tableExists('order_items')) {
    console.error('Missing required tables. Found:', {
        orders: tableExists('orders'),
        order_items: tableExists('order_items')
    });
    process.exit(2);
}

const order = db.prepare('SELECT * FROM orders WHERE id = ?').get(orderId);
if (!order) {
    console.error('Order not found:', orderId);
    process.exit(3);
}

const items = db.prepare('SELECT * FROM order_items WHERE order_id = ?').all(orderId);

console.log('DB:', dbPath);
console.log('Order:', {
    id: order.id,
    tenant_id: order.tenant_id,
    phone_number: order.phone_number,
    status: order.status || order.order_status,
    subtotal_amount: order.subtotal_amount,
    gst_amount: order.gst_amount,
    total_amount: order.total_amount,
    created_at: order.created_at
});
console.log('order_items count:', items.length);

// Print a compact preview of up to 10 items
const preview = items.slice(0, 10).map((r) => ({
    id: r.id,
    product_id: r.product_id,
    product_name: r.product_name,
    quantity: r.quantity,
    unit_price: r.unit_price,
    total_price: r.total_price,
    price_at_time_of_purchase: r.price_at_time_of_purchase,
    unit_price_before_tax: r.unit_price_before_tax,
    gst_rate: r.gst_rate,
    gst_amount: r.gst_amount,
    tenant_id: r.tenant_id
}));

console.log('order_items preview:', preview);
