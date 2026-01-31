require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');
const bcrypt = require('bcryptjs');

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function fixAlok() {
  const userId = '48e61957-3431-43cf-a75f-3d95c15ab1c5';
  const tenantId = '112f12b8-55e9-4de8-9fda-d58e37c75796';
  const phone = '8600259300';
  const password = '8600259300';
  const name = 'Alok';
  
  console.log('\n=== Fixing Alok ===\n');
  
  // 1. Set password hash
  const passwordHash = await bcrypt.hash(password, 10);
  console.log('Generated password hash:', passwordHash.substring(0, 20) + '...');
  
  const { error: updateError } = await supabase
    .from('users')
    .update({ password_hash: passwordHash })
    .eq('id', userId);
    
  if (updateError) {
    console.log('❌ Failed to update password:', updateError);
    return;
  }
  
  console.log('✅ Password hash set for user');
  
  // 2. Create or update salesman record
  const { data: existing } = await supabase
    .from('salesmen')
    .select('id')
    .eq('user_id', userId)
    .maybeSingle();
    
  if (existing) {
    console.log('✅ Salesman record already exists:', existing.id);
  } else {
    const { error: insertError } = await supabase
      .from('salesmen')
      .insert({
        user_id: userId,
        tenant_id: tenantId,
        name: name,
        phone: phone,
        is_active: true
      });
      
    if (insertError) {
      console.log('❌ Failed to create salesman:', insertError);
    } else {
      console.log('✅ Salesman record created');
    }
  }
  
  // 3. Verify
  console.log('\n=== Verification ===\n');
  
  const { data: user } = await supabase
    .from('users')
    .select('id, phone, role, password_hash')
    .eq('id', userId)
    .single();
    
  console.log('User:', {
    id: user.id,
    phone: user.phone,
    role: user.role,
    has_password: !!user.password_hash
  });
  
  const { data: salesman } = await supabase
    .from('salesmen')
    .select('id, name, phone, is_active')
    .eq('user_id', userId)
    .maybeSingle();
    
  console.log('Salesman:', salesman || 'NOT FOUND');
  
  // Test password
  if (user.password_hash) {
    const match = await bcrypt.compare(password, user.password_hash);
    console.log('\n🔐 Password test:', match ? '✅ MATCH' : '❌ NO MATCH');
  }
  
  console.log('\n✅ Alok is ready to login with:');
  console.log('  Phone: 8600259300');
  console.log('  Password: 8600259300');
  console.log('  Tenant: 112f12b8-55e9-4de8-9fda-d58e37c75796');
}

fixAlok().then(() => process.exit(0)).catch(err => {
  console.error('\n❌ Error:', err);
  process.exit(1);
});
