const path = require('path');
const Database = require('better-sqlite3');
const crypto = require('crypto');

const dbPath = path.join(__dirname, '..', 'local-database.db');
const db = new Database(dbPath);

console.log('[FINAL_DEMO_FIX] Fixing all demo data issues...\n');

// Get demo tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get('910000000000');
if (!tenant) {
    console.error('Demo tenant not found!');
    process.exit(1);
}
const tenantId = tenant.id;
console.log(`Demo Tenant ID: ${tenantId}`);

function generateId() {
    return crypto.randomBytes(16).toString('hex');
}

function randomDate(daysAgo, futureMode = false) {
    const date = new Date();
    const days = Math.floor(Math.random() * daysAgo);
    if (futureMode) {
        date.setDate(date.getDate() + days);
    } else {
        date.setDate(date.getDate() - days);
    }
    return date.toISOString();
}

// ======================
// 1. POPULATE SCHEDULED_FOLLOWUPS
// ======================
console.log('\n[1/2] Creating scheduled_followups...');

const conversations = db.prepare('SELECT id, end_user_phone FROM conversations WHERE tenant_id = ?').all(tenantId);

const followUpTemplates = [
    { message: 'Follow up on bulk order inquiry - offer 15% volume discount for 50+ cartons', priority: 'high', daysFromNow: -2, status: 'completed' },
    { message: 'Send updated quotation with special pricing for Premium Widget Pro', priority: 'high', daysFromNow: 0, status: 'pending' },
    { message: 'Check payment status for Order #897bd - pending since 2 days', priority: 'high', daysFromNow: 0, status: 'pending' },
    { message: 'Confirm delivery schedule and shipping address for Mumbai order', priority: 'medium', daysFromNow: 1, status: 'scheduled' },
    { message: 'Request product feedback on recent Standard Widget purchase', priority: 'low', daysFromNow: 3, status: 'scheduled' },
    { message: 'Discuss exclusive distributor partnership opportunity in Gujarat region', priority: 'high', daysFromNow: 2, status: 'scheduled' },
    { message: 'Arrange product demo and send samples of Mega Pack Bundle', priority: 'medium', daysFromNow: 4, status: 'scheduled' },
    { message: 'Schedule technical consultation call for bulk implementation', priority: 'medium', daysFromNow: 2, status: 'scheduled' },
    { message: 'Share updated product catalog with Q1 2026 new releases', priority: 'low', daysFromNow: 5, status: 'scheduled' },
    { message: 'Follow up on abandoned cart - Budget Widget Lite × 25 cartons', priority: 'high', daysFromNow: 0, status: 'pending' },
    { message: 'Renewal reminder: Annual contract expires in 30 days', priority: 'high', daysFromNow: 7, status: 'scheduled' },
    { message: 'Collect testimonial and case study for Starter Kit success', priority: 'low', daysFromNow: 10, status: 'scheduled' }
];

// Clear existing scheduled_followups for demo tenant
db.prepare('DELETE FROM scheduled_followups WHERE tenant_id = ?').run(tenantId);

let scheduledCount = 0;
let pendingCount = 0;
let completedCount = 0;
let failedCount = 0;

for (let i = 0; i < Math.min(conversations.length, followUpTemplates.length); i++) {
    const conv = conversations[i];
    const template = followUpTemplates[i];
    const scheduledTime = new Date();
    scheduledTime.setDate(scheduledTime.getDate() + template.daysFromNow);
    
    const status = template.status;
    
    if (status === 'scheduled') scheduledCount++;
    else if (status === 'pending') pendingCount++;
    else if (status === 'completed') completedCount++;
    else if (status === 'failed') failedCount++;
    
    const createdAt = randomDate(30);
    const triggeredAt = (status === 'completed' || status === 'failed') ? new Date().toISOString() : null;
    
    const context = JSON.stringify({
        lastMessagePreview: template.message.substring(0, 50),
        inquiry: template.message,
        sentiment: template.priority === 'high' ? 'interested' : 'neutral'
    });
    
    try {
        // Use columns that exist in scheduled_followups: id, tenant_id, end_user_phone, scheduled_time, description, original_request, conversation_context, status, created_at, completed_at
        const completedAt = status === 'completed' ? new Date().toISOString() : null;
        
        db.prepare(`
            INSERT INTO scheduled_followups (
                id, tenant_id, end_user_phone, scheduled_time,
                description, original_request, conversation_context, status, created_at, completed_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `).run(
            generateId(), tenantId, conv.end_user_phone, scheduledTime.toISOString(),
            template.message, template.message, context, status, createdAt, completedAt
        );
    } catch (e) {
        console.log(`  Error creating scheduled follow-up: ${e.message}`);
    }
}

const totalFollowups = scheduledCount + pendingCount + completedCount + failedCount;
const next24h = db.prepare(`
    SELECT COUNT(*) as count 
    FROM scheduled_followups 
    WHERE tenant_id = ? 
    AND status != 'completed'
    AND datetime(scheduled_time) <= datetime('now', '+1 day')
`).get(tenantId).count;

console.log(`  ✓ Created ${totalFollowups} scheduled follow-ups`);
console.log(`    • Scheduled: ${scheduledCount}`);
console.log(`    • Pending: ${pendingCount}`);
console.log(`    • Completed: ${completedCount}`);
console.log(`    • Failed: ${failedCount}`);
console.log(`    • Next 24h: ${next24h}`);

// ======================
// 2. VERIFY PRODUCT REVENUE CALCULATION
// ======================
console.log('\n[2/2] Verifying product revenue...');
const products = db.prepare('SELECT * FROM products WHERE tenant_id = ?').all(tenantId);

console.log(`  Found ${products.length} products for demo tenant`);

for (const product of products) {
    const stats = db.prepare(`
        SELECT 
            COALESCE(SUM(oi.total_price), 0) as revenue,
            COALESCE(SUM(oi.quantity), 0) as quantity_sold,
            COUNT(DISTINCT oi.order_id) as order_count
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.id
        WHERE oi.product_id = ? AND o.tenant_id = ?
    `).get(product.id, tenantId);
    
    if (stats.revenue > 0) {
        console.log(`  • ${product.name}: ₹${stats.revenue} (${stats.quantity_sold} units, ${stats.order_count} orders)`);
    }
}

console.log('\n✅ ALL DEMO DATA FIXED!');
console.log('═══════════════════════════════════════');
console.log('Summary:');
console.log(`  • Follow-ups: ${totalFollowups} (${scheduledCount} scheduled, ${pendingCount} pending, ${completedCount} completed, ${failedCount} failed)`);
console.log(`  • Next 24h: ${next24h}`);
console.log(`  • Products: ${products.length}`);
console.log('═══════════════════════════════════════');

db.close();
