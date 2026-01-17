const Database = require('better-sqlite3');
const path = require('path');

const db = new Database(path.join(__dirname, '../local-database.db'));

const tenantId = 'aaaaaaaa-bbbb-cccc-dddd-000000000001';

function generateId() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        const r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

console.log('Adding sample customers for testing...\n');

const customers = [
    { business_name: 'ABC Manufacturing', contact_person: 'Rajesh Kumar', phone: '9876543210', city: 'Mumbai', state: 'Maharashtra' },
    { business_name: 'XYZ Industries', contact_person: 'Priya Sharma', phone: '9876543211', city: 'Pune', state: 'Maharashtra' },
    { business_name: 'Global Traders', contact_person: 'Amit Patel', phone: '9876543212', city: 'Ahmedabad', state: 'Gujarat' },
];

customers.forEach(c => {
    const id = generateId();
    db.prepare(`INSERT INTO customer_profiles_new 
        (id, tenant_id, business_name, contact_person, phone, city, state, status, source, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, 'active', 'manual', datetime('now'), datetime('now'))`
    ).run(id, tenantId, c.business_name, c.contact_person, c.phone, c.city, c.state);
    
    console.log(`✓ Added ${c.business_name}`);
});

console.log(`\n✅ ${customers.length} customers added successfully!`);
db.close();
