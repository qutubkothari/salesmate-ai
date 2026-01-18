// Add sample data for testing
const Database = require('better-sqlite3');
const path = require('path');

const db = new Database(path.join(__dirname, 'local-database.db'));
db.pragma('journal_mode = WAL');

const TENANT_ID = 'aaaaaaaa-bbbb-cccc-dddd-000000000001';

function generateId() {
    return require('crypto').randomBytes(16).toString('hex');
}

console.log('Adding sample products...');

const products = [
    { name: 'Bolt M10x50', category: 'Fasteners', price: 5.50, stock: 1000, description: 'High tensile strength bolt' },
    { name: 'Nut M10', category: 'Fasteners', price: 2.25, stock: 2000, description: 'Hexagonal nut' },
    { name: 'Washer 10mm', category: 'Fasteners', price: 0.75, stock: 5000, description: 'Flat washer' },
    { name: 'Screw M6x30', category: 'Fasteners', price: 3.00, stock: 1500, description: 'Machine screw' },
    { name: 'Anchor Bolt M12', category: 'Fasteners', price: 12.50, stock: 500, description: 'Heavy duty anchor' },
    { name: 'Rivet 6mm', category: 'Fasteners', price: 1.50, stock: 3000, description: 'Aluminum rivet' },
    { name: 'Thread Lock Blue', category: 'Chemicals', price: 85.00, stock: 50, description: 'Medium strength threadlocker' },
    { name: 'Lubricant Spray', category: 'Chemicals', price: 120.00, stock: 100, description: 'Multi-purpose lubricant' },
    { name: 'Safety Gloves', category: 'Safety', price: 45.00, stock: 200, description: 'Cut resistant gloves' },
    { name: 'Safety Goggles', category: 'Safety', price: 95.00, stock: 150, description: 'Impact resistant goggles' }
];

products.forEach(p => {
    try {
        db.prepare(`
            INSERT INTO products (id, tenant_id, name, category, price, stock_quantity, description, is_active, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, 1, datetime('now'), datetime('now'))
        `).run(generateId(), TENANT_ID, p.name, p.category, p.price, p.stock, p.description);
        console.log(`✓ Added product: ${p.name}`);
    } catch (error) {
        console.log(`- Product ${p.name} might already exist`);
    }
});

console.log('\nAdding sample customers...');

const customers = [
    { name: 'ABC Manufacturing Pvt Ltd', phone: '9876543210', contact: 'Rajesh Kumar', city: 'Mumbai', state: 'Maharashtra', type: 'wholesale' },
    { name: 'XYZ Industries', phone: '9876543211', contact: 'Priya Sharma', city: 'Pune', state: 'Maharashtra', type: 'distributor' },
    { name: 'Global Traders', phone: '9876543212', contact: 'Amit Patel', city: 'Ahmedabad', state: 'Gujarat', type: 'wholesale' },
    { name: 'Tech Solutions Ltd', phone: '9876543213', contact: 'Neha Singh', city: 'Bangalore', state: 'Karnataka', type: 'retail' },
    { name: 'Prime Engineering', phone: '9876543214', contact: 'Suresh Reddy', city: 'Hyderabad', state: 'Telangana', type: 'wholesale' }
];

customers.forEach(c => {
    try {
        db.prepare(`
            INSERT INTO customer_profiles_new (id, tenant_id, business_name, phone, contact_person, city, state, customer_type, status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'active', datetime('now'), datetime('now'))
        `).run(generateId(), TENANT_ID, c.name, c.phone, c.contact, c.city, c.state, c.type);
        console.log(`✓ Added customer: ${c.name}`);
    } catch (error) {
        console.log(`- Customer ${c.name} might already exist`);
    }
});

console.log('\n✅ Sample data added successfully!');
console.log('You can now test the admin dashboard with this data.');

db.close();
