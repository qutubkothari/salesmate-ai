const path = require('path');
const Database = require('better-sqlite3');
const crypto = require('crypto');

const dbPath = path.join(__dirname, '..', 'local-database.db');
const db = new Database(dbPath);

console.log('[DEMO_SETUP] Setting up demo account with fake data...');

// Demo tenant details
const DEMO_PHONE = '910000000000';
const DEMO_PASSWORD = '000000';
const DEMO_BUSINESS = 'Demo Business Inc.';

// Helper to generate UUID
function generateId() {
    return crypto.randomBytes(16).toString('hex');
}

// Helper to get random date within last N days
function randomDate(daysAgo) {
    const date = new Date();
    date.setDate(date.getDate() - Math.floor(Math.random() * daysAgo));
    return date.toISOString();
}

// 1. Create or update demo tenant
console.log('[DEMO_SETUP] Creating demo tenant...');
const existingTenant = db.prepare('SELECT id FROM tenants WHERE phone_number = ?').get(DEMO_PHONE);

let tenantId;
if (existingTenant) {
    tenantId = existingTenant.id;
    console.log('[DEMO_SETUP] Demo tenant exists, updating...');
    db.prepare(`
        UPDATE tenants 
        SET business_name = ?, password = ?, is_active = 1, status = 'active'
        WHERE phone_number = ?
    `).run(DEMO_BUSINESS, DEMO_PASSWORD, DEMO_PHONE);
} else {
    tenantId = generateId();
    console.log('[DEMO_SETUP] Creating new demo tenant...');
    db.prepare(`
        INSERT INTO tenants (id, phone_number, business_name, password, bot_phone_number, is_active, status, created_at)
        VALUES (?, ?, ?, ?, ?, 1, 'active', datetime('now'))
    `).run(tenantId, DEMO_PHONE, DEMO_BUSINESS, DEMO_PASSWORD, DEMO_PHONE + '@c.us');
}

console.log('[DEMO_SETUP] Demo tenant ID:', tenantId);

// 2. Create demo products
console.log('[DEMO_SETUP] Creating demo products...');
const demoProducts = [
    { name: 'Premium Widget Pro', price: 2500, sku: 'PWP-001', description: 'High-quality premium widget with advanced features', units_per_carton: 50, category: 'Electronics' },
    { name: 'Standard Widget', price: 1200, sku: 'SW-002', description: 'Reliable standard widget for everyday use', units_per_carton: 100, category: 'Electronics' },
    { name: 'Budget Widget Lite', price: 750, sku: 'BWL-003', description: 'Affordable widget for basic needs', units_per_carton: 200, category: 'Electronics' },
    { name: 'Mega Pack Bundle', price: 5000, sku: 'MPB-004', description: 'Complete bundle with all accessories', units_per_carton: 25, category: 'Bundles' },
    { name: 'Starter Kit', price: 1800, sku: 'SK-005', description: 'Perfect starter package for new users', units_per_carton: 75, category: 'Bundles' }
];

const productIds = [];
for (const product of demoProducts) {
    const productId = generateId();
    productIds.push(productId);
    db.prepare(`
        INSERT OR REPLACE INTO products (id, tenant_id, name, price, sku, description, units_per_carton, category, is_active, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1, datetime('now'))
    `).run(productId, tenantId, product.name, product.price, product.sku, product.description, product.units_per_carton, product.category);
}

console.log('[DEMO_SETUP] Created', productIds.length, 'demo products');

// 3. Create demo conversations
console.log('[DEMO_SETUP] Creating demo conversations...');
const demoConversations = [
    { phone: '919876543210', lastMsg: 'Thanks for the quick delivery! The products are perfect.', msgCount: 15 },
    { phone: '918765432109', lastMsg: 'Can I get a quote for 100 cartons of Premium Widget Pro?', msgCount: 8 },
    { phone: '917654321098', lastMsg: 'Order received successfully. Payment completed.', msgCount: 12 },
    { phone: '916543210987', lastMsg: 'Do you have any discounts for bulk orders?', msgCount: 5 },
    { phone: '915432109876', lastMsg: 'Please send me the product catalog.', msgCount: 3 },
    { phone: '914321098765', lastMsg: 'What is the warranty period for Premium Widget Pro?', msgCount: 7 },
    { phone: '913210987654', lastMsg: 'Can you arrange delivery to Mumbai?', msgCount: 4 },
    { phone: '912109876543', lastMsg: 'Interested in becoming a distributor.', msgCount: 10 }
];

const conversationIds = [];
for (const conv of demoConversations) {
    const conversationId = generateId();
    conversationIds.push(conversationId);
    const createdAt = randomDate(30);
    
    db.prepare(`
        INSERT INTO conversations (id, tenant_id, phone_number, end_user_phone, created_at, updated_at, last_message_at)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    `).run(conversationId, tenantId, conv.phone, conv.phone, createdAt, createdAt, createdAt);
}

console.log('[DEMO_SETUP] Created', conversationIds.length, 'demo conversations');

// 3.5. Create demo messages for conversations
console.log('[DEMO_SETUP] Creating demo messages...');
const demoMessagePairs = [
    { user: 'Hi, I need information about Premium Widget Pro', bot: 'Hello! Premium Widget Pro is our flagship product with advanced features. It costs ₹2500 per carton (50 units). Would you like to know more details?' },
    { user: 'Do you offer bulk discounts?', bot: 'Yes! We offer volume discounts: 5-10 cartons: 5% off, 11-25 cartons: 10% off, 25+ cartons: 15% off. How many cartons are you interested in?' },
    { user: 'Can I get a quotation for 100 cartons?', bot: 'Absolutely! For 100 cartons of Premium Widget Pro: Base price: ₹2,50,000, Volume discount (15%): -₹37,500, Subtotal: ₹2,12,500, GST (18%): ₹38,250, Total: ₹2,50,750. Shall I proceed with the order?' },
    { user: 'What is the delivery time?', bot: 'Standard delivery takes 3-5 business days. For bulk orders above 50 cartons, we offer free shipping! Express delivery (1-2 days) is also available at extra cost.' },
    { user: 'Please send me the product catalog', bot: 'Sure! Here are our main products:\n1. Premium Widget Pro - ₹2500/carton\n2. Standard Widget - ₹1200/carton\n3. Budget Widget Lite - ₹750/carton\n4. Mega Pack Bundle - ₹5000/carton\n5. Starter Kit - ₹1800/carton\n\nWhich one interests you?' },
    { user: 'What payment methods do you accept?', bot: 'We accept: Bank Transfer, UPI, Credit/Debit Cards, and Cash on Delivery for orders below ₹50,000. For bulk orders, we also offer 30-day credit terms for verified businesses.' },
    { user: 'Is there a warranty?', bot: 'Yes! All our products come with a 1-year manufacturer warranty. Premium Widget Pro has an extended 2-year warranty. We also offer replacement for any manufacturing defects.' },
    { user: 'Can you deliver to Mumbai?', bot: 'Yes, we deliver pan-India! Mumbai deliveries typically take 2-3 days. Free shipping applies for orders above ₹25,000. Would you like to place an order?' }
];

let messageCount = 0;
for (let i = 0; i < conversationIds.length; i++) {
    const conversationId = conversationIds[i];
    const numMessages = Math.floor(Math.random() * 4) + 2; // 2-5 message pairs
    
    for (let j = 0; j < numMessages; j++) {
        const msgPair = demoMessagePairs[Math.floor(Math.random() * demoMessagePairs.length)];
        const timestamp = randomDate(30);
        
        // User message
        db.prepare(`
            INSERT INTO messages (id, tenant_id, conversation_id, sender, message_body, message_type, created_at)
            VALUES (?, ?, ?, 'user', ?, 'text', ?)
        `).run(generateId(), tenantId, conversationId, msgPair.user, timestamp);
        messageCount++;
        
        // Bot response
        const botTimestamp = new Date(timestamp);
        botTimestamp.setSeconds(botTimestamp.getSeconds() + Math.floor(Math.random() * 60) + 10);
        db.prepare(`
            INSERT INTO messages (id, tenant_id, conversation_id, sender, message_body, message_type, created_at)
            VALUES (?, ?, ?, 'bot', ?, 'text', ?)
        `).run(generateId(), tenantId, conversationId, msgPair.bot, botTimestamp.toISOString());
        messageCount++;
    }
}

console.log('[DEMO_SETUP] Created', messageCount, 'demo messages');

// 4. Create demo orders
console.log('[DEMO_SETUP] Creating demo orders...');
const orderStatuses = ['pending', 'processing', 'completed', 'delivered'];
const customerTypes = ['retail', 'wholesale', 'distributor'];

for (let i = 0; i < 15; i++) {
    const orderId = generateId();
    const conversationId = conversationIds[Math.floor(Math.random() * conversationIds.length)];
    const conversation = db.prepare('SELECT end_user_phone FROM conversations WHERE id = ?').get(conversationId);
    
    const numItems = Math.floor(Math.random() * 3) + 1;
    let subtotal = 0;
    const orderItems = [];
    
    for (let j = 0; j < numItems; j++) {
        const productId = productIds[Math.floor(Math.random() * productIds.length)];
        const product = db.prepare('SELECT name, price, units_per_carton FROM products WHERE id = ?').get(productId);
        const quantity = Math.floor(Math.random() * 5) + 1;
        const unitPrice = product.price;
        const totalPrice = unitPrice * quantity;
        subtotal += totalPrice;
        
        orderItems.push({
            productId,
            productName: product.name,
            quantity,
            unitPrice,
            totalPrice,
            unitsPerCarton: product.units_per_carton
        });
    }
    
    const gstRate = 0.18;
    const gstAmount = Math.round(subtotal * gstRate);
    const totalAmount = subtotal + gstAmount;
    const status = orderStatuses[Math.floor(Math.random() * orderStatuses.length)];
    const customerType = customerTypes[Math.floor(Math.random() * customerTypes.length)];
    const createdAt = randomDate(60);
    
    // Insert order
    db.prepare(`
        INSERT INTO orders (
            id, tenant_id, conversation_id, phone_number, customer_type,
            subtotal_amount, gst_amount, total_amount, status, order_status,
            created_at, updated_at, cgst_amount, sgst_amount, igst_amount
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
        orderId, tenantId, conversationId, conversation.end_user_phone, customerType,
        subtotal, gstAmount, totalAmount, status, status,
        createdAt, createdAt, gstAmount / 2, gstAmount / 2, 0
    );
    
    // Insert order items
    for (const item of orderItems) {
        db.prepare(`
            INSERT INTO order_items (
                id, order_id, product_id, product_name, quantity,
                unit_price, total_price
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
        `).run(
            generateId(), orderId, item.productId, item.productName, item.quantity,
            item.unitPrice, item.totalPrice
        );
    }
}

console.log('[DEMO_SETUP] Created 15 demo orders with items');

// 5. Create demo broadcasts using broadcast_queue and broadcast_recipients
console.log('[DEMO_SETUP] Creating demo broadcasts...');
try {
    const broadcastMessages = [
        { text: '🎉 New Year Special! Get 20% off on all products. Limited time offer! Shop now and save big!', phones: 120 },
        { text: '⚡ Flash Sale Alert! Premium Widget Pro now at ₹1999 (Regular price ₹2500). Hurry, only 50 cartons left in stock!', phones: 95 },
        { text: 'Thank you for being our valued customer! 🙏 Check out our new product catalog with exciting additions. Download: [link]', phones: 150 },
        { text: '🎊 Festive Season Sale! Flat 15% discount on bulk orders above 50 cartons. Valid till end of month. Call now!', phones: 88 },
        { text: '🚀 New Product Launch: Introducing Mega Pack Bundle with FREE shipping! Complete package at unbeatable price. Order today!', phones: 110 }
    ];

    // Get some random phone numbers from conversations for broadcast recipients
    const recipientPhones = db.prepare('SELECT DISTINCT end_user_phone FROM conversations WHERE tenant_id = ? LIMIT 50').all(tenantId);
    
    for (let i = 0; i < broadcastMessages.length; i++) {
        const broadcast = broadcastMessages[i];
        const createdAt = randomDate(45);
        const totalRecipients = broadcast.phones;
        const sentCount = i < 3 ? totalRecipients : Math.floor(totalRecipients * (0.6 + Math.random() * 0.3)); // First 3 completed
        const failedCount = i < 3 ? 0 : Math.floor((totalRecipients - sentCount) * 0.3);
        const pendingCount = totalRecipients - sentCount - failedCount;
        
        // Add to broadcast_queue (represents individual message sends)
        for (let j = 0; j < sentCount; j++) {
            const recipientPhone = recipientPhones[j % recipientPhones.length]?.end_user_phone || '919999999999';
            const queueId = generateId();
            const sentAt = new Date(createdAt);
            sentAt.setMinutes(sentAt.getMinutes() + j * 2); // Stagger sends
            
            db.prepare(`
                INSERT INTO broadcast_queue (
                    id, tenant_id, recipient_phone, message_text,
                    scheduled_at, status, sent_at, created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, 'sent', ?, ?, ?)
            `).run(queueId, tenantId, recipientPhone, broadcast.text, createdAt, sentAt.toISOString(), createdAt, sentAt.toISOString());
        }
        
        // Add pending messages
        for (let j = 0; j < pendingCount; j++) {
            const recipientPhone = recipientPhones[(sentCount + j) % recipientPhones.length]?.end_user_phone || '919999999999';
            db.prepare(`
                INSERT INTO broadcast_queue (
                    id, tenant_id, recipient_phone, message_text,
                    scheduled_at, status, created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, 'pending', ?, ?)
            `).run(generateId(), tenantId, recipientPhone, broadcast.text, createdAt, createdAt, createdAt);
        }
        
        // Add failed messages
        for (let j = 0; j < failedCount; j++) {
            const recipientPhone = recipientPhones[(sentCount + pendingCount + j) % recipientPhones.length]?.end_user_phone || '919999999999';
            db.prepare(`
                INSERT INTO broadcast_queue (
                    id, tenant_id, recipient_phone, message_text,
                    scheduled_at, status, error_message, created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, 'failed', 'Invalid phone number', ?, ?)
            `).run(generateId(), tenantId, recipientPhone, broadcast.text, createdAt, createdAt, createdAt);
        }
    }

    console.log('[DEMO_SETUP] Created demo broadcasts with', broadcastMessages.reduce((sum, b) => sum + b.phones, 0), 'total messages');
} catch (e) {
    console.log('[DEMO_SETUP] Error creating broadcasts:', e.message);
}

// 6. Create demo follow-ups (skip if table doesn't exist)
console.log('[DEMO_SETUP] Creating demo follow-ups...');
try {
    const followUpNotes = [
        'Follow up on bulk order inquiry',
        'Send updated quotation with discount',
        'Check payment status',
        'Confirm delivery schedule',
        'Request feedback on recent order',
        'Discuss partnership opportunities',
        'Send product samples',
        'Schedule demo session'
    ];

    for (let i = 0; i < 12; i++) {
        const followUpId = generateId();
        const conversationId = conversationIds[Math.floor(Math.random() * conversationIds.length)];
        const note = followUpNotes[Math.floor(Math.random() * followUpNotes.length)];
        const dueDate = new Date();
        dueDate.setDate(dueDate.getDate() + Math.floor(Math.random() * 14) - 7); // -7 to +7 days
        const status = dueDate < new Date() ? 'completed' : 'pending';
        const createdAt = randomDate(30);
        
        db.prepare(`
            INSERT INTO follow_ups (
                id, tenant_id, conversation_id, note, due_date,
                status, created_at, updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `).run(
            followUpId, tenantId, conversationId, note, dueDate.toISOString(),
            status, createdAt, createdAt
        );
    }

    console.log('[DEMO_SETUP] Created 12 demo follow-ups');
} catch (e) {
    console.log('[DEMO_SETUP] Skipping follow-ups (table does not exist):', e.message);
}

// 7. Create demo customer profiles (skip if table doesn't exist or has wrong schema)
console.log('[DEMO_SETUP] Creating demo customer profiles...');
try {
    const demoCustomers = [
        { name: 'Rajesh Kumar', business: 'Kumar Electronics', city: 'Mumbai', type: 'wholesale' },
        { name: 'Priya Sharma', business: 'Sharma Traders', city: 'Delhi', type: 'distributor' },
        { name: 'Amit Patel', business: 'Patel & Sons', city: 'Ahmedabad', type: 'retail' },
        { name: 'Sneha Reddy', business: 'Reddy Enterprises', city: 'Hyderabad', type: 'wholesale' },
        { name: 'Vikram Singh', business: 'Singh Trading Co.', city: 'Jaipur', type: 'distributor' }
    ];

    for (let i = 0; i < demoCustomers.length; i++) {
        const customer = demoCustomers[i];
        const customerId = generateId();
        const phone = demoConversations[i].phone;
        
        db.prepare(`
            INSERT INTO customer_profiles (
                id, tenant_id, phone_number, name,
                city, customer_type, created_at, updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `).run(
            customerId, tenantId, phone, customer.name,
            customer.city, customer.type, randomDate(90), randomDate(30)
        );
    }

    console.log('[DEMO_SETUP] Created', demoCustomers.length, 'demo customer profiles');
} catch (e) {
    console.log('[DEMO_SETUP] Skipping customer profiles:', e.message);
}

console.log('\n✅ DEMO SETUP COMPLETE!');
console.log('═══════════════════════════════════════');
console.log('Demo Account Credentials:');
console.log('Phone:', DEMO_PHONE);
console.log('Password:', DEMO_PASSWORD);
console.log('═══════════════════════════════════════');
console.log('Demo Data Summary:');
console.log('  • Products:', productIds.length);
console.log('  • Conversations:', conversationIds.length);
console.log('  • Messages: ~' + (conversationIds.length * 6) + ' (avg 6 per conversation)');
console.log('  • Orders: 15 with line items');
console.log('  • Broadcasts: 5 campaigns with 563 total messages');
console.log('═══════════════════════════════════════');
console.log('\nLogin at: http://13.126.234.92:8081/dashboard.html');
console.log('  or locally: http://localhost:8081/dashboard.html');
console.log('═══════════════════════════════════════');

db.close();
