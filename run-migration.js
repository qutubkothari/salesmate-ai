const { Client } = require('pg');
const fs = require('fs');

// Direct database connection (not pooler)
const client = new Client({
  connectionString: 'postgresql://postgres:Sak3998515253%23@db.taqkfimlrlkyjbutashe.supabase.co:5432/postgres',
  ssl: { rejectUnauthorized: false }
});

async function runMigration() {
  console.log('Connecting to Supabase PostgreSQL...');
  await client.connect();
  console.log('✓ Connected!\n');
  
  try {
    // Run schema
    console.log('Running schema SQL...');
    const schema = fs.readFileSync('supabase-schema-complete.sql', 'utf8');
    await client.query(schema);
    console.log('✓ Schema created!\n');
    
    // Run data
    console.log('Running data SQL...');
    const data = fs.readFileSync('supabase-data-complete.sql', 'utf8');
    await client.query(data);
    console.log('✓ Data imported!\n');
    
    console.log('✅ Migration complete!');
  } catch (err) {
    console.error('❌ Error:', err.message);
    if (err.position) {
      console.error('Position:', err.position);
    }
    throw err;
  } finally {
    await client.end();
  }
}

runMigration().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
