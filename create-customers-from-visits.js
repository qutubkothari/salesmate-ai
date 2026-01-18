const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('📊 Creating customers from visits data...\n');

// Disable foreign key constraints temporarily
db.exec('PRAGMA foreign_keys = OFF');

try {
  // Get tenant info
  const tenants = db.prepare('SELECT id FROM tenants LIMIT 1').all();
  const tenantId = tenants.length > 0 ? tenants[0].id : 'aaaaaaaa-bbbb-cccc-dddd-000000000001';
  
  console.log(`Using tenant ID: ${tenantId}\n`);
  
  // First, delete test customers
  const testCustomers = db.prepare(`
    DELETE FROM customer_profiles_new 
    WHERE business_name IN ('ABC Manufacturing', 'XYZ Industries', 'Global Traders')
  `).run();
  console.log(`✅ Deleted ${testCustomers.changes} test customers\n`);
  
  // Get unique customers from visits with their salesman
  const visitCustomers = db.prepare(`
    SELECT DISTINCT 
      customer_name,
      salesman_id,
      MIN(created_at) as first_visit,
      MAX(created_at) as last_visit
    FROM visits 
    WHERE customer_name IS NOT NULL 
    GROUP BY customer_name, salesman_id
  `).all();
  
  console.log(`Found ${visitCustomers.length} unique customers from visits\n`);
  
  const insertCustomer = db.prepare(`
    INSERT OR IGNORE INTO customer_profiles_new (
      id, tenant_id, business_name, contact_person, phone, 
      status, assigned_salesman_id, last_visit_date, 
      visit_frequency, source, created_at, updated_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `);
  
  let inserted = 0;
  
  db.exec('BEGIN TRANSACTION');
  
  visitCustomers.forEach(customer => {
    const customerId = `cust_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
    
    const result = insertCustomer.run(
      customerId,
      tenantId,
      customer.customer_name,                    // business_name
      '',                                        // contact_person
      '',                                        // phone
      'active',                                  // status
      customer.salesman_id,                      // assigned_salesman_id
      customer.last_visit,                       // last_visit_date
      'monthly',                                 // visit_frequency
      'visit',                                   // source
      customer.first_visit,                      // created_at
      customer.last_visit                        // updated_at
    );
    
    if (result.changes > 0) {
      inserted++;
      console.log(`   ✅ Created: ${customer.customer_name}`);
    }
  });
  
  db.exec('COMMIT');
  
  console.log(`\n✅ Successfully created ${inserted} customers from visits\n`);
  
  // Show summary
  const totalCustomers = db.prepare('SELECT COUNT(*) as count FROM customer_profiles_new').get();
  console.log(`📊 Total customers in database: ${totalCustomers.count}\n`);
  
  // Show sample
  const sampleCustomers = db.prepare(`
    SELECT business_name, assigned_salesman_id, last_visit_date 
    FROM customer_profiles_new 
    ORDER BY last_visit_date DESC 
    LIMIT 10
  `).all();
  
  console.log('Recent customers:');
  sampleCustomers.forEach(c => {
    console.log(`   ${c.business_name.padEnd(30)} | Last visit: ${c.last_visit_date?.substring(0, 10)}`);
  });
  
} catch (error) {
  console.error('❌ Error:', error.message);
  db.exec('ROLLBACK');
  db.exec('PRAGMA foreign_keys = ON');
  process.exit(1);
}

db.exec('PRAGMA foreign_keys = ON');
db.close();
console.log('\n✅ Done!');
