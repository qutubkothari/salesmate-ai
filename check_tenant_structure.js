require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

async function checkStructure() {
  const { data, error } = await supabase
    .from('tenants')
    .select('*')
    .limit(1);

  if (error) {
    console.error('Error:', error);
    process.exit(1);
  }

  console.log('Tenant columns:');
  console.log(JSON.stringify(data[0], null, 2));
  process.exit(0);
}

checkStructure();
