/**
 * Migrate Local SQLite Data to Supabase
 * Exports all data from local SQLite and imports to Supabase
 */

require('dotenv').config();
const Database = require('better-sqlite3');
const { createClient } = require('@supabase/supabase-js');
const path = require('path');

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://taqkfimlrlkyjbutashe.supabase.co';
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhcWtmaW1scmxreWpidXRhc2hlIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2ODg3NDI2MywiZXhwIjoyMDg0NDUwMjYzfQ.EByeSoM4_Tagk2G6CAwRuO6Zcwrmr5D-YakPyogR41s';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);
const db = new Database(path.join(__dirname, 'local-database.db'));

// Tables to migrate (order matters for foreign keys)
const TABLES = [
  'users',
  'whatsapp_connections',
  'conversations_new',
  'messages',
  'inbound_messages',
  'categories',
  'salesmen',
  'plants',
  'visits',
  'targets',
  'branches'
];

async function checkSupabaseConnection() {
  console.log('\n=== Testing Supabase Connection ===');
  try {
    const { data, error } = await supabase.from('users').select('count').limit(1);
    if (error && error.code === 'PGRST204') {
      console.log('✓ Supabase connected (tables not created yet)');
      return true;
    }
    if (error) {
      console.error('✗ Supabase error:', error);
      return false;
    }
    console.log('✓ Supabase connected and tables exist');
    return true;
  } catch (err) {
    console.error('✗ Connection failed:', err.message);
    return false;
  }
}

async function getTableSchema(tableName) {
  const stmt = db.prepare(`PRAGMA table_info(${tableName})`);
  return stmt.all();
}

async function exportTableData(tableName) {
  console.log(`\n📤 Exporting ${tableName}...`);
  const rows = db.prepare(`SELECT * FROM ${tableName}`).all();
  console.log(`   Found ${rows.length} rows`);
  return rows;
}

async function importTableData(tableName, rows) {
  if (rows.length === 0) {
    console.log(`   ⏭️  Skipped (empty)`);
    return;
  }

  console.log(`📥 Importing ${rows.length} rows to ${tableName}...`);
  
  // Batch insert (Supabase limit is 1000 rows per request)
  const BATCH_SIZE = 500;
  for (let i = 0; i < rows.length; i += BATCH_SIZE) {
    const batch = rows.slice(i, i + BATCH_SIZE);
    const { data, error } = await supabase.from(tableName).insert(batch);
    
    if (error) {
      console.error(`   ✗ Error inserting batch ${i}-${i + batch.length}:`, error);
      
      // Try one-by-one for this batch
      console.log(`   Retrying batch one-by-one...`);
      for (const row of batch) {
        const { error: rowError } = await supabase.from(tableName).insert(row);
        if (rowError) {
          console.error(`   ✗ Failed to insert row:`, rowError.message);
        }
      }
    } else {
      console.log(`   ✓ Inserted batch ${i}-${i + batch.length}`);
    }
  }
}

async function migrateTable(tableName) {
  console.log(`\n━━━ Migrating: ${tableName} ━━━`);
  
  // Check if table exists in Supabase
  const { error: checkError } = await supabase.from(tableName).select('count').limit(1);
  
  if (checkError && checkError.code === 'PGRST204') {
    console.log(`⚠️  Table '${tableName}' doesn't exist in Supabase yet`);
    console.log(`   Run the SQL schema creation first in Supabase dashboard`);
    return false;
  }
  
  // Export from SQLite
  const rows = await exportTableData(tableName);
  
  // Import to Supabase
  await importTableData(tableName, rows);
  
  return true;
}

async function main() {
  console.log('╔══════════════════════════════════════╗');
  console.log('║  SQLite → Supabase Migration Tool   ║');
  console.log('╚══════════════════════════════════════╝');
  
  // Check connection
  const connected = await checkSupabaseConnection();
  if (!connected) {
    console.error('\n❌ Cannot connect to Supabase. Check credentials.');
    process.exit(1);
  }
  
  // Migrate each table
  for (const table of TABLES) {
    try {
      await migrateTable(table);
    } catch (err) {
      console.error(`\n❌ Failed to migrate ${table}:`, err.message);
    }
  }
  
  console.log('\n✅ Migration complete!');
  db.close();
}

main().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
