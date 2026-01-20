const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  'https://taqkfimlrlkyjbutashe.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhcWtmaW1scmxreWpidXRhc2hlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODg3NDI2MywiZXhwIjoyMDg0NDUwMjYzfQ.EByeSoM4_Tagk2G6CAwRuO6Zcwrmr5D-YakPyogR41s'
);

async function checkDB() {
  console.log('Checking Supabase database...\n');
  
  // Check tenants first
  const { data: tenants } = await supabase.from('tenants').select('id, name, phone');
  console.log('Tenants:');
  if (tenants) {
    tenants.forEach(t => console.log(`  ${t.id} - ${t.name} (${t.phone})`));
  }
  console.log('');
  
  const tables = [
    'whatsapp_connections',
    'tenants',
    'salesmen',
    'visits',
    'conversations_new',
    'messages'
  ];
  
  for (const table of tables) {
    const { data, error, count } = await supabase
      .from(table)
      .select('*', { count: 'exact', head: true });
    
    if (error) {
      console.log(`❌ ${table}: ERROR - ${error.message}`);
    } else {
      console.log(`✅ ${table}: ${count} rows`);
    }
  }
  
  // Check WhatsApp connection details
  const { data: waData } = await supabase
    .from('whatsapp_connections')
    .select('phone_number, status')
    .limit(5);
  
  if (waData && waData.length > 0) {
    console.log('\nWhatsApp Connections:');
    waData.forEach(wa => {
      console.log(`  ${wa.phone_number}: ${wa.status}`);
    });
  }
  
  console.log('\n✅ Supabase database is working!');
}

checkDB().catch(console.error);
