/**
 * Deploy autonomous follow-up sequence tables migration to Supabase
 */

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

require('dotenv').config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing SUPABASE_URL or SUPABASE_SERVICE_KEY/SUPABASE_KEY in .env');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function runMigration() {
  console.log('🚀 Deploying autonomous follow-up sequence tables...');

  const sqlFile = path.join(__dirname, 'migrations', '20260215_autonomous_followup_sequences_supabase.sql');
  const sql = fs.readFileSync(sqlFile, 'utf8');

  // Remove single-line comments so we don't accidentally drop a statement
  // that starts with "--" but contains CREATE statements.
  const sqlNoComments = sql
    .split('\n')
    .filter(line => !line.trim().startsWith('--'))
    .join('\n');

  // Execute SQL via Supabase RPC (requires an exec_sql function)
  const statements = sqlNoComments
    .split(';')
    .map(s => s.trim())
    .filter(Boolean);

  for (const [i, statement] of statements.entries()) {
    const { error } = await supabase.rpc('exec_sql', { sql_query: statement + ';' });
    if (error) {
      console.error(`❌ Failed at statement ${i + 1}/${statements.length}`);
      console.error(statement);
      throw error;
    }
  }

  console.log('✅ Migration applied. Verifying tables...');

  const tables = [
    'followup_sequences',
    'sequence_steps',
    'sequence_enrollments',
    'sequence_messages',
    'sequence_triggers',
    'sequence_unsubscribes',
  ];

  for (const table of tables) {
    const { error } = await supabase.from(table).select('*', { count: 'exact', head: true });
    if (error) {
      console.error(`❌ Table check failed: ${table}`, error);
      throw error;
    }
    console.log(`✓ ${table}`);
  }

  console.log('🎉 Autonomous follow-up sequence tables deployed successfully!');
}

runMigration().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
