require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  'https://taqkfimlrlkyjbutashe.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhcWtmaW1scmxreWpidXRhc2hlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODg3NDI2MywiZXhwIjoyMDg0NDUwMjYzfQ.EByeSoM4_Tagk2G6CAwRuO6Zcwrmr5D-YakPyogR41s'
);

async function createAdminUser() {
  // Hash for password: 515253
  const passwordHash = '$2a$10$gyW8eqMREHU9QbsqBdyRDOWewno3wRrdyksFMEtYOhOqEmxA3yuxG';
  
  const { data, error } = await supabase.from('users').insert({
    id: 'admin-' + Date.now(),
    tenant_id: '101f04af63cbefc2bf8f0a98b9ae1205',
    phone: '919537653927',
    name: 'Hylite Admin',
    email: 'admin@hylite.com',
    role: 'admin',
    is_active: 1,
    password_hash: passwordHash,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString()
  });

  if (error) {
    console.error('Error creating user:', error);
  } else {
    console.log('✅ Admin user created successfully!');
    console.log('Phone: 919537653927');
    console.log('Password: 515253');
  }

  // Verify
  const { data: user } = await supabase.from('users')
    .select('*')
    .eq('phone', '919537653927')
    .single();
  
  console.log('\nVerify user:', user);
}

createAdminUser();
