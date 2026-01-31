require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function checkAlok() {
  const phone = '8600259300';
  const tenantId = '112f12b8-55e9-4de8-9fda-d58e37c75796';
  
  console.log('\n=== Checking Alok in Supabase ===\n');
  console.log('Phone:', phone);
  console.log('Tenant:', tenantId);
  console.log('Supabase URL:', SUPABASE_URL);
  
  // Check user
  const { data: user, error: userError } = await supabase
    .from('users')
    .select('id, tenant_id, phone, role, is_active, password_hash')
    .eq('phone', phone)
    .eq('tenant_id', tenantId)
    .maybeSingle();
    
  if (userError) {
    console.log('\n❌ User query error:', userError);
    return;
  }
  
  if (!user) {
    console.log('\n❌ User not found with phone:', phone);
    
    // Try finding similar
    const { data: similar } = await supabase
      .from('users')
      .select('phone, role, tenant_id')
      .ilike('phone', `%${phone.slice(-5)}%`)
      .limit(5);
      
    console.log('\nSimilar phones:', similar);
    return;
  }
  
  console.log('\n✅ User found:');
  console.log(JSON.stringify(user, null, 2));
  
  // Check salesman
  const { data: salesman, error: salesmanError } = await supabase
    .from('salesmen')
    .select('id, user_id, name, phone, email, is_active')
    .eq('user_id', user.id)
    .eq('tenant_id', tenantId)
    .maybeSingle();
    
  if (salesmanError) {
    console.log('\n❌ Salesman query error:', salesmanError);
  } else if (!salesman) {
    console.log('\n❌ No salesman record found!');
  } else {
    console.log('\n✅ Salesman found:');
    console.log(JSON.stringify(salesman, null, 2));
  }
  
  // Test password
  if (user.password_hash) {
    const bcrypt = require('bcrypt');
    const testPasswords = ['8600259300', '515253', 'Sales@1234'];
    
    console.log('\n🔐 Testing passwords:');
    for (const pwd of testPasswords) {
      try {
        const match = await bcrypt.compare(pwd, user.password_hash);
        if (match) {
          console.log(`  ✅ MATCH: "${pwd}"`);
        } else {
          console.log(`  ❌ No match: "${pwd}"`);
        }
      } catch (e) {
        console.log(`  ⚠️ Error testing "${pwd}":`, e.message);
      }
    }
  } else {
    console.log('\n⚠️ No password_hash set!');
  }
}

checkAlok().then(() => process.exit(0)).catch(err => {
  console.error('\n❌ Error:', err);
  process.exit(1);
});
