require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function fixSalesmanRecord() {
  const userId = '48e61957-3431-43cf-a75f-3d95c15ab1c5';
  const tenantId = '112f12b8-55e9-4de8-9fda-d58e37c75796';
  const phone = '8600259300';
  
  console.log('\n=== Finding Conflicting Salesman Record ===\n');
  
  // Find salesman with this phone
  const { data: byPhone } = await supabase
    .from('salesmen')
    .select('id, user_id, tenant_id, phone, name, is_active')
    .eq('tenant_id', tenantId)
    .eq('phone', phone);
    
  console.log('Salesmen with phone 8600259300:', byPhone);
  
  // Find salesman with this user_id
  const { data: byUser } = await supabase
    .from('salesmen')
    .select('id, user_id, tenant_id, phone, name, is_active')
    .eq('user_id', userId);
    
  console.log('\nSalesmen with user_id:', byUser);
  
  if (byPhone && byPhone.length > 0) {
    const salesman = byPhone[0];
    
    if (salesman.user_id !== userId) {
      console.log('\n⚠️ Found salesman with same phone but different user_id!');
      console.log('Updating user_id to:', userId);
      
      const { error } = await supabase
        .from('salesmen')
        .update({ user_id: userId })
        .eq('id', salesman.id);
        
      if (error) {
        console.log('❌ Update failed:', error);
      } else {
        console.log('✅ Updated salesman record to link to correct user');
      }
    } else {
      console.log('\n✅ Salesman record is already correct!');
    }
  }
  
  // Final verification
  console.log('\n=== Final Verification ===\n');
  
  const { data: final } = await supabase
    .from('salesmen')
    .select('id, user_id, name, phone, is_active')
    .eq('user_id', userId)
    .maybeSingle();
    
  console.log('Salesman record:', final || 'NOT FOUND');
}

fixSalesmanRecord().then(() => process.exit(0)).catch(err => {
  console.error('\n❌ Error:', err);
  process.exit(1);
});
