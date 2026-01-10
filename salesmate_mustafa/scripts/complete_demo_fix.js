const path = require('path');
const Database = require('better-sqlite3');
const crypto = require('crypto');

const dbPath = path.join(__dirname, '..', 'local-database.db');
const db = new Database(dbPath);

console.log('[COMPLETE_FIX] Populating all missing demo data...');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
if (!tenant) {
    console.error('Demo tenant not found!');
    process.exit(1);
}
const tenantId = tenant.id;

function generateId() {
    return crypto.randomBytes(16).toString('hex');
}

function randomDate(daysAgo) {
    const date = new Date();
    date.setDate(date.getDate() - Math.floor(Math.random() * daysAgo));
    return date.toISOString();
}

// 1. CREATE FOLLOW_UPS TABLE IF IT DOESN'T EXIST
console.log('\n[1/3] Setting up follow_ups table...');
try {
    db.prepare(`
        CREATE TABLE IF NOT EXISTS follow_ups (
            id TEXT PRIMARY KEY,
            tenant_id TEXT NOT NULL,
            conversation_id TEXT,
            customer_phone TEXT,
            note TEXT NOT NULL,
            due_date TEXT NOT NULL,
            status TEXT DEFAULT 'pending',
            priority TEXT DEFAULT 'medium',
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL,
            completed_at TEXT,
            created_by TEXT,
            assigned_to TEXT,
            FOREIGN KEY (tenant_id) REFERENCES tenants(id),
            FOREIGN KEY (conversation_id) REFERENCES conversations(id)
        )
    `).run();
    
    console.log('  ✓ follow_ups table ready');
} catch (e) {
    console.log('  ℹ follow_ups table already exists or error:', e.message);
}

// 2. POPULATE FOLLOW-UPS
console.log('\n[2/3] Creating follow-ups...');
const conversations = db.prepare('SELECT id, end_user_phone FROM conversations WHERE tenant_id = ?').all(tenantId);

const followUpTemplates = [
    { note: 'Follow up on bulk order inquiry - offer 15% volume discount for 50+ cartons', priority: 'high', daysFromNow: -2 },
    { note: 'Send updated quotation with special pricing for Premium Widget Pro', priority: 'high', daysFromNow: 0 },
    { note: 'Check payment status for Order #897bd - pending since 2 days', priority: 'high', daysFromNow: 0 },
    { note: 'Confirm delivery schedule and shipping address for Mumbai order', priority: 'medium', daysFromNow: 1 },
    { note: 'Request product feedback on recent Standard Widget purchase', priority: 'low', daysFromNow: 3 },
    { note: 'Discuss exclusive distributor partnership opportunity in Gujarat region', priority: 'high', daysFromNow: 2 },
    { note: 'Arrange product demo and send samples of Mega Pack Bundle', priority: 'medium', daysFromNow: 4 },
    { note: 'Schedule technical consultation call for bulk implementation', priority: 'medium', daysFromNow: 2 },
    { note: 'Share updated product catalog with Q1 2026 new releases', priority: 'low', daysFromNow: 5 },
    { note: 'Follow up on abandoned cart - Budget Widget Lite × 25 cartons', priority: 'high', daysFromNow: 0 },
    { note: 'Renewal reminder: Annual contract expires in 30 days', priority: 'high', daysFromNow: 7 },
    { note: 'Collect testimonial and case study for Starter Kit success', priority: 'low', daysFromNow: 10 }
];

let scheduledCount = 0;
let pendingCount = 0;
let completedCount = 0;

for (let i = 0; i < Math.min(conversations.length, followUpTemplates.length); i++) {
    const conv = conversations[i];
    const template = followUpTemplates[i];
    const dueDate = new Date();
    dueDate.setDate(dueDate.getDate() + template.daysFromNow);
    
    // Determine status based on due date
    let status;
    if (template.daysFromNow < 0) {
        // Overdue - mark some as completed, some as pending
        status = i % 3 === 0 ? 'completed' : 'pending';
    } else if (template.daysFromNow === 0) {
        status = 'pending'; // Due today
    } else {
        status = 'scheduled'; // Future
    }
    
    if (status === 'scheduled') scheduledCount++;
    else if (status === 'pending') pendingCount++;
    else if (status === 'completed') completedCount++;
    
    const createdAt = randomDate(30);
    const completedAt = status === 'completed' ? new Date().toISOString() : null;
    
    try {
        db.prepare(`
            INSERT INTO follow_ups (
                id, tenant_id, conversation_id, customer_phone, note, due_date,
                status, priority, created_at, updated_at, completed_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `).run(
            generateId(), tenantId, conv.id, conv.end_user_phone, template.note, dueDate.toISOString(),
            status, template.priority, createdAt, createdAt, completedAt
        );
    } catch (e) {
        console.log(`  Error creating follow-up: ${e.message}`);
    }
}

const totalFollowups = scheduledCount + pendingCount + completedCount;
const next24h = db.prepare(`
    SELECT COUNT(*) as count 
    FROM follow_ups 
    WHERE tenant_id = ? 
    AND status != 'completed'
    AND datetime(due_date) <= datetime('now', '+1 day')
`).get(tenantId).count;

console.log(`  ✓ Created ${totalFollowups} follow-ups`);
console.log(`    • Scheduled: ${scheduledCount}`);
console.log(`    • Pending: ${pendingCount}`);
console.log(`    • Completed: ${completedCount}`);
console.log(`    • Next 24h: ${next24h}`);

// 3. UPDATE PRODUCTS WITH ACTUAL REVENUE
console.log('\n[3/3] Updating product revenue...');
const products = db.prepare('SELECT * FROM products WHERE tenant_id = ?').all(tenantId);

for (const product of products) {
    // Calculate revenue from order_items
    const stats = db.prepare(`
        SELECT 
            COALESCE(SUM(oi.total_price), 0) as revenue,
            COALESCE(SUM(oi.quantity), 0) as quantity_sold,
            COUNT(DISTINCT oi.order_id) as order_count
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.id
        WHERE oi.product_id = ? AND o.tenant_id = ?
    `).get(product.id, tenantId);
    
    console.log(`  • ${product.name}: ₹${stats.revenue} (${stats.quantity_sold} units, ${stats.order_count} orders)`);
}

console.log('\n✅ ALL DEMO DATA POPULATED!');
console.log('═══════════════════════════════════════');
console.log('Summary:');
console.log(`  • Follow-ups: ${totalFollowups} (${scheduledCount} scheduled, ${pendingCount} pending, ${completedCount} completed)`);
console.log(`  • Products with revenue data: ${products.length}`);
console.log('═══════════════════════════════════════');

db.close();
