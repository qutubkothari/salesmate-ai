const Database = require('better-sqlite3');
const path = require('path');

const db = new Database(path.join(__dirname, '../local-database.db'));

// Disable foreign key checks temporarily to avoid orders table FK
db.pragma('foreign_keys = OFF');

const tenantId = 'aaaaaaaa-bbbb-cccc-dddd-000000000001';
const salesmanId = '27a44053-3f43-4ba3-9213-2dae0870de11';

console.log('Creating sample data for salesman app...\n');

// Helper to generate UUID
function generateId() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        const r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

// 1. Create sample customers
console.log('Creating customers...');
const customers = [
    { business_name: 'ABC Manufacturing', contact_person: 'Rajesh Kumar', phone: '9876543210', city: 'Mumbai', state: 'Maharashtra' },
    { business_name: 'XYZ Industries', contact_person: 'Priya Sharma', phone: '9876543211', city: 'Pune', state: 'Maharashtra' },
    { business_name: 'Global Traders', contact_person: 'Amit Patel', phone: '9876543212', city: 'Ahmedabad', state: 'Gujarat' },
    { business_name: 'Tech Solutions Ltd', contact_person: 'Suresh Reddy', phone: '9876543213', city: 'Bangalore', state: 'Karnataka' },
    { business_name: 'Prime Enterprises', contact_person: 'Neha Gupta', phone: '9876543214', city: 'Delhi', state: 'Delhi' },
    { business_name: 'Metro Steel Works', contact_person: 'Vijay Singh', phone: '9876543215', city: 'Jaipur', state: 'Rajasthan' },
    { business_name: 'Sunshine Traders', contact_person: 'Anita Desai', phone: '9876543216', city: 'Chennai', state: 'Tamil Nadu' },
    { business_name: 'Royal Industries', contact_person: 'Manoj Kumar', phone: '9876543217', city: 'Hyderabad', state: 'Telangana' },
];

const customerIds = [];
customers.forEach((c, i) => {
    const id = generateId();
    customerIds.push(id);
    try {
        db.prepare(`INSERT INTO customer_profiles_new 
            (id, tenant_id, business_name, contact_person, phone, city, state, status, source, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, 'active', 'manual', datetime('now'), datetime('now'))`
        ).run(id, tenantId, c.business_name, c.contact_person, c.phone, c.city, c.state);
    } catch (err) {
        console.log(`Skipping customer ${c.business_name}: ${err.message}`);
        return;
    }
    
    // Add location for some customers
    if (i < 5) {
        const lat = 19.0760 + (Math.random() - 0.5) * 0.5; // Mumbai area
        const lng = 72.8777 + (Math.random() - 0.5) * 0.5;
        db.prepare(`INSERT INTO customer_locations 
            (id, tenant_id, customer_id, latitude, longitude, address, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))`
        ).run(generateId(), tenantId, id, lat, lng, `${c.city}, ${c.state}`);
    }
});
console.log(`Created ${customers.length} customers`);

// 2. Create visits for this month
console.log('Creating visits...');
const visitTypes = ['regular', 'follow_up', 'cold_call', 'demo'];
const products = ['Fasteners', 'Bolts', 'Nuts', 'Washers', 'Screws'];

const now = new Date();
const thisMonth = now.getMonth();
const thisYear = now.getFullYear();

for (let day = 1; day <= now.getDate(); day++) {
    const numVisits = Math.floor(Math.random() * 3); // 0-2 visits per day
    
    for (let v = 0; v < numVisits; v++) {
        const visitDate = new Date(thisYear, thisMonth, day, 9 + v * 2, 0);
        const customerId = customerIds[Math.floor(Math.random() * customerIds.length)];
        const customer = customers.find((c, i) => customerIds[i] === customerId);
        
        const checkinTime = new Date(visitDate);
        const checkoutTime = new Date(checkinTime.getTime() + (30 + Math.random() * 60) * 60000); // 30-90 min
        
        const hasOrder = Math.random() > 0.6;
        const orderId = null; // Would link to orders table if it existed
        
        db.prepare(`INSERT INTO visits 
            (id, tenant_id, salesman_id, customer_id, customer_name, contact_person, customer_phone,
             visit_type, visit_date, products_discussed, potential, remarks, next_action,
             gps_latitude, gps_longitude, location_accuracy, time_in, time_out, duration_minutes,
             order_id, synced, created_at, updated_at, checkin_time, checkout_time, actual_duration)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, datetime('now'), datetime('now'), ?, ?, ?)`
        ).run(
            generateId(), tenantId, salesmanId, customerId, customer.business_name, customer.contact_person, customer.phone,
            visitTypes[Math.floor(Math.random() * visitTypes.length)],
            visitDate.toISOString().split('T')[0],
            JSON.stringify([products[Math.floor(Math.random() * products.length)]]),
            hasOrder ? 'High' : 'Medium',
            hasOrder ? 'Order placed' : 'Follow up required',
            hasOrder ? null : 'Follow-up call',
            19.0760 + (Math.random() - 0.5) * 0.5,
            72.8777 + (Math.random() - 0.5) * 0.5,
            10.0,
            checkinTime.toISOString(),
            checkoutTime.toISOString(),
            Math.floor((checkoutTime - checkinTime) / 60000),
            orderId,
            checkinTime.toISOString(),
            checkoutTime.toISOString(),
            Math.floor((checkoutTime - checkinTime) / 60000)
        );
    }
}

// Add some future scheduled visits
for (let i = 1; i <= 5; i++) {
    const futureDate = new Date(now.getTime() + i * 24 * 60 * 60 * 1000);
    const customerId = customerIds[i % customerIds.length];
    const customer = customers[i % customers.length];
    
    const scheduledTime = new Date(futureDate);
    scheduledTime.setHours(10 + i, 0, 0, 0);
    
    db.prepare(`INSERT INTO visits 
        (id, tenant_id, salesman_id, customer_id, customer_name, contact_person, customer_phone,
         visit_type, visit_date, products_discussed, remarks,
         gps_latitude, gps_longitude, location_accuracy, time_in,
         synced, created_at, updated_at, checkin_time)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, datetime('now'), datetime('now'), ?)`
    ).run(
        generateId(), tenantId, salesmanId, customerId, customer.business_name, customer.contact_person, customer.phone,
        'scheduled',
        futureDate.toISOString().split('T')[0],
        JSON.stringify([products[Math.floor(Math.random() * products.length)]]),
        'Scheduled follow-up visit',
        19.0760,
        72.8777,
        10.0,
        scheduledTime.toISOString(),
        scheduledTime.toISOString()
    );
}

console.log('Created visits for current month + 5 future visits');

// 3. Create monthly targets
console.log('Creating targets...');
for (let m = 0; m < 3; m++) {
    const targetDate = new Date(thisYear, thisMonth - m, 1);
    const period = targetDate.toISOString().substring(0, 7);
    
    db.prepare(`INSERT OR IGNORE INTO salesman_targets 
        (id, tenant_id, salesman_id, period, target_visits, target_revenue, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))`
    ).run(generateId(), tenantId, salesmanId, period, 50 + m * 5, 500000 + m * 50000);
}
console.log('Created 3 months of targets');

// 4. Create expenses
console.log('Creating expenses...');
const expenseTypes = ['fuel', 'meals', 'travel', 'accommodation', 'other'];
for (let day = 1; day <= Math.min(now.getDate(), 15); day++) {
    const expenseDate = new Date(thisYear, thisMonth, day);
    const numExpenses = Math.floor(Math.random() * 2) + 1;
    
    for (let e = 0; e < numExpenses; e++) {
        const type = expenseTypes[Math.floor(Math.random() * expenseTypes.length)];
        const amount = type === 'fuel' ? 500 + Math.random() * 1000 :
                      type === 'meals' ? 200 + Math.random() * 500 :
                      type === 'accommodation' ? 1500 + Math.random() * 2000 :
                      300 + Math.random() * 700;
        
        db.prepare(`INSERT INTO salesman_expenses 
            (id, tenant_id, salesman_id, expense_date, expense_type, amount, description, status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, 'pending', datetime('now'), datetime('now'))`
        ).run(
            generateId(), tenantId, salesmanId,
            expenseDate.toISOString().split('T')[0],
            type,
            Math.round(amount),
            `${type.charAt(0).toUpperCase() + type.slice(1)} expense for field work`,
        );
    }
}
console.log('Created expenses');

// 5. Create attendance records
console.log('Creating attendance...');
for (let day = 1; day <= now.getDate(); day++) {
    const attendanceDate = new Date(thisYear, thisMonth, day);
    if (attendanceDate.getDay() !== 0) { // Skip Sundays
        const checkIn = new Date(attendanceDate);
        checkIn.setHours(9, Math.floor(Math.random() * 30), 0, 0);
        
        const checkOut = new Date(attendanceDate);
        checkOut.setHours(18, Math.floor(Math.random() * 60), 0, 0);
        
        db.prepare(`INSERT OR IGNORE INTO salesman_attendance 
            (id, tenant_id, salesman_id, attendance_date, checkin_time, checkout_time, 
             checkin_latitude, checkin_longitude, checkout_latitude, checkout_longitude,
             status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'present', datetime('now'), datetime('now'))`
        ).run(
            generateId(), tenantId, salesmanId,
            attendanceDate.toISOString().split('T')[0],
            checkIn.toISOString(),
            checkOut.toISOString(),
            19.0760, 72.8777,
            19.0760 + 0.01, 72.8777 + 0.01
        );
    }
}
console.log('Created attendance records');

console.log('\n✅ Sample data created successfully!');
console.log('\nSummary:');
console.log(`- ${customers.length} customers`);
console.log(`- Visits for current month + 5 scheduled`);
console.log(`- 3 months of targets`);
console.log(`- Expenses for current month`);
console.log(`- Attendance records`);
// Re-enable foreign keys
db.pragma('foreign_keys = ON');
db.close();
