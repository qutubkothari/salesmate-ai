/**
 * Performance & Scale Migration Runner
 * Creates performance tables: cache, query performance, rate limiting, health checks, metrics
 */

const fs = require('fs');
const path = require('path');
const { db } = require('./services/config');

console.log('🚀 Starting Performance & Scale migration...\n');

// Read migration file
const migrationPath = path.join(__dirname, 'migrations', 'create_performance.sql');
const migrationSQL = fs.readFileSync(migrationPath, 'utf8');

// Split into individual statements properly
const statements = [];
let currentStatement = '';

const lines = migrationSQL.split('\n');
for (const line of lines) {
  const trimmed = line.trim();
  
  // Skip comments and empty lines
  if (!trimmed || trimmed.startsWith('--')) continue;
  
  currentStatement += line + '\n';
  
  // Check if we've hit a semicolon
  if (trimmed.endsWith(';')) {
    statements.push(currentStatement.trim());
    currentStatement = '';
  }
}

// Separate CREATE TABLE and CREATE INDEX statements
const createTableStatements = statements.filter(s => s.toUpperCase().includes('CREATE TABLE'));
const createIndexStatements = statements.filter(s => s.toUpperCase().includes('CREATE INDEX'));

console.log(`Found ${createTableStatements.length} table statements, ${createIndexStatements.length} index statements\n`);

let tablesCreated = 0;
let indexesCreated = 0;
let errors = 0;

// First, create all tables
console.log('Creating tables...');
createTableStatements.forEach((statement, index) => {
  try {
    db.prepare(statement).run();
    const match = statement.match(/CREATE TABLE (?:IF NOT EXISTS )?([a-z_]+)/i);
    if (match) {
      tablesCreated++;
      console.log(`✅ Table created: ${match[1]}`);
    }
  } catch (error) {
    errors++;
    console.error(`❌ Error creating table ${index + 1}:`, error.message);
    console.error(`Statement: ${statement.substring(0, 100)}...`);
  }
});

// Then, create all indexes
console.log('\nCreating indexes...');
createIndexStatements.forEach((statement, index) => {
  try {
    db.prepare(statement).run();
    const match = statement.match(/CREATE INDEX (?:IF NOT EXISTS )?([a-z_]+)/i);
    if (match) {
      indexesCreated++;
      console.log(`✅ Index created: ${match[1]}`);
    }
  } catch (error) {
    errors++;
    console.error(`❌ Error creating index ${index + 1}:`, error.message);
    console.error(`Statement: ${statement.substring(0, 100)}...`);
  }
});

console.log('\n📊 Migration Summary:');
console.log(`   Tables created: ${tablesCreated}`);
console.log(`   Indexes created: ${indexesCreated}`);
console.log(`   Errors: ${errors}`);

// Verify tables
console.log('\n🔍 Verifying tables...');
const tables = db.prepare(`
  SELECT name FROM sqlite_master 
  WHERE type='table' AND (
    name LIKE 'cache_%' OR 
    name LIKE 'query_%' OR 
    name LIKE 'rate_%' OR 
    name LIKE 'api_%' OR 
    name LIKE 'health_%' OR 
    name LIKE '%_metrics' OR 
    name LIKE '%_alerts' OR 
    name LIKE '%scaling%' OR 
    name LIKE 'connection_%' OR 
    name LIKE 'load_%'
  )
  ORDER BY name
`).all();

console.log(`Found ${tables.length} performance tables:`);
tables.forEach(table => {
  console.log(`   - ${table.name}`);
});

console.log('\n✨ Performance & Scale migration complete!\n');
