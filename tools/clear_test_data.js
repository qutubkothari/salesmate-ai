const Database = require('better-sqlite3');
const path = require('path');

const db = new Database(path.join(__dirname, '../local-database.db'));
db.pragma('foreign_keys = OFF');

const tenantId = 'aaaaaaaa-bbbb-cccc-dddd-000000000001';
const salesmanId = '27a44053-3f43-4ba3-9213-2dae0870de11';

console.log('Clearing test data...\n');

// Get counts before deletion
const beforeCounts = {
    customers: db.prepare('SELECT COUNT(*) as count FROM customer_profiles_new WHERE tenant_id = ?').get(tenantId).count,
    visits: db.prepare('SELECT COUNT(*) as count FROM visits WHERE salesman_id = ?').get(salesmanId).count,
    targets: db.prepare('SELECT COUNT(*) as count FROM salesman_targets WHERE salesman_id = ?').get(salesmanId).count,
    expenses: db.prepare('SELECT COUNT(*) as count FROM salesman_expenses WHERE salesman_id = ?').get(salesmanId).count,
    attendance: db.prepare('SELECT COUNT(*) as count FROM salesman_attendance WHERE salesman_id = ?').get(salesmanId).count,
};

console.log('Before cleanup:');
console.log(`- Customers: ${beforeCounts.customers}`);
console.log(`- Visits: ${beforeCounts.visits}`);
console.log(`- Targets: ${beforeCounts.targets}`);
console.log(`- Expenses: ${beforeCounts.expenses}`);
console.log(`- Attendance: ${beforeCounts.attendance}`);
console.log();

// Delete customer locations first (FK constraint)
const deletedLocations = db.prepare('DELETE FROM customer_locations WHERE tenant_id = ?').run(tenantId);
console.log(`✓ Deleted ${deletedLocations.changes} customer locations`);

// Delete all customers for this tenant
const deletedCustomers = db.prepare('DELETE FROM customer_profiles_new WHERE tenant_id = ?').run(tenantId);
console.log(`✓ Deleted ${deletedCustomers.changes} customers`);

// Delete all visits for this salesman
const deletedVisits = db.prepare('DELETE FROM visits WHERE salesman_id = ?').run(salesmanId);
console.log(`✓ Deleted ${deletedVisits.changes} visits`);

// Delete all targets for this salesman
const deletedTargets = db.prepare('DELETE FROM salesman_targets WHERE salesman_id = ?').run(salesmanId);
console.log(`✓ Deleted ${deletedTargets.changes} targets`);

// Delete all expenses for this salesman
const deletedExpenses = db.prepare('DELETE FROM salesman_expenses WHERE salesman_id = ?').run(salesmanId);
console.log(`✓ Deleted ${deletedExpenses.changes} expenses`);

// Delete all attendance for this salesman
const deletedAttendance = db.prepare('DELETE FROM salesman_attendance WHERE salesman_id = ?').run(salesmanId);
console.log(`✓ Deleted ${deletedAttendance.changes} attendance records`);

console.log('\n✅ Test data cleared successfully!');
console.log('\nYou can now add your own real data through the app.');

db.pragma('foreign_keys = ON');
db.close();
