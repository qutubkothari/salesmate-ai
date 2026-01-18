/**
 * AI Intelligence Migration Runner
 * Creates tables for AI features
 */

const fs = require('fs');
const path = require('path');
const { db } = require('./services/config');

console.log('🚀 Starting AI Intelligence migration...');

try {
  // Read SQL file
  const sqlPath = path.join(__dirname, 'migrations', 'create_ai_intelligence.sql');
  const sql = fs.readFileSync(sqlPath, 'utf8');

  // Remove comments
  const sqlNoComments = sql
    .split('\n')
    .filter(line => !line.trim().startsWith('--'))
    .join('\n');

  // Split by semicolon, but keep CREATE TABLE blocks together
  const statements = [];
  let currentStatement = '';
  let inCreateTable = false;
  
  sqlNoComments.split('\n').forEach(line => {
    currentStatement += line + '\n';
    
    if (line.trim().toUpperCase().startsWith('CREATE TABLE') || 
        line.trim().toUpperCase().startsWith('CREATE INDEX')) {
      inCreateTable = true;
    }
    
    if (line.includes(');') && inCreateTable) {
      inCreateTable = false;
      statements.push(currentStatement.trim());
      currentStatement = '';
    } else if (line.includes(';') && !inCreateTable) {
      statements.push(currentStatement.trim());
      currentStatement = '';
    }
  });

  const validStatements = statements.filter(s => s.length > 0);
  console.log(`📄 Found ${validStatements.length} SQL statements`);

  // Execute each statement
  validStatements.forEach((statement, index) => {
    try {
      db.prepare(statement).run();
      
      // Extract table/index name
      const tableMatch = statement.match(/CREATE TABLE\s+IF NOT EXISTS\s+(\w+)/i);
      const indexMatch = statement.match(/CREATE INDEX\s+IF NOT EXISTS\s+(\w+)/i);
      
      if (tableMatch) {
        console.log(`✅ Created table: ${tableMatch[1]}`);
      } else if (indexMatch) {
        console.log(`✅ Created index: ${indexMatch[1]}`);
      } else {
        console.log(`✅ Statement ${index + 1} executed`);
      }
    } catch (error) {
      if (error.message.includes('already exists')) {
        console.log(`⚠️  Statement ${index + 1} skipped (already exists)`);
      } else {
        console.error(`❌ Statement ${index + 1} failed:`, error.message);
        console.error(`Statement was: ${statement.substring(0, 150)}...`);
        throw error;
      }
    }
  });

  // Verify tables
  const tables = db.prepare(`
    SELECT name FROM sqlite_master 
    WHERE type='table' AND name LIKE 'ai_%'
  `).all();

  console.log('\n📊 AI Intelligence Tables Created:');
  tables.forEach(t => console.log(`   - ${t.name}`));

  console.log('\n✅ AI Intelligence migration completed successfully!');

} catch (error) {
  console.error('❌ Migration failed:', error);
  process.exit(1);
}
