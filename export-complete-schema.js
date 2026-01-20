const Database = require('better-sqlite3');
const fs = require('fs');

const db = new Database('local-database.db');

// Get ALL tables from SQLite
const tables = db.prepare(`
  SELECT name FROM sqlite_master 
  WHERE type='table' 
  AND name NOT LIKE 'sqlite_%'
  AND name NOT LIKE '%_view'
  ORDER BY name
`).all();

console.log(`Found ${tables.length} tables to export:`);
tables.forEach(t => console.log(`  - ${t.name}`));

let schema = `-- ============================================
-- Supabase Schema - Complete Export
-- Generated: ${new Date().toISOString()}
-- Total Tables: ${tables.length}
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

`;

let data = `-- ============================================
-- Data Migration SQL
-- Generated: ${new Date().toISOString()}
-- ============================================

`;

// Convert SQLite types to PostgreSQL
function sqliteToPostgres(sqliteType) {
  const type = (sqliteType || '').toUpperCase();
  
  if (type.includes('INT')) return 'INTEGER';
  if (type.includes('TEXT') || type.includes('VARCHAR') || type.includes('CHAR')) return 'TEXT';
  if (type.includes('REAL') || type.includes('DOUBLE') || type.includes('FLOAT')) return 'NUMERIC';
  if (type.includes('BLOB')) return 'BYTEA';
  if (type.includes('BOOLEAN') || type.includes('BOOL')) return 'BOOLEAN';
  if (type.includes('DATETIME') || type.includes('TIMESTAMP')) return 'TIMESTAMP';
  if (type.includes('DATE')) return 'DATE';
  if (type.includes('TIME')) return 'TIME';
  
  return 'TEXT'; // Default
}

// Process each table
for (const { name: tableName } of tables) {
  console.log(`\nProcessing: ${tableName}`);
  
  // Get table schema
  const columns = db.prepare(`PRAGMA table_info(${tableName})`).all();
  const indexes = db.prepare(`PRAGMA index_list(${tableName})`).all();
  
  // Start CREATE TABLE
  schema += `\n-- Table: ${tableName}\n`;
  schema += `CREATE TABLE IF NOT EXISTS ${tableName} (\n`;
  
  const columnDefs = [];
  let hasPrimaryKey = false;
  
  for (const col of columns) {
    let def = `  ${col.name} ${sqliteToPostgres(col.type)}`;
    
    // Handle primary key
    if (col.pk === 1) {
      hasPrimaryKey = true;
      if (col.type.toUpperCase().includes('INTEGER')) {
        def = `  ${col.name} SERIAL PRIMARY KEY`;
      } else {
        def += ' PRIMARY KEY';
      }
      
      // Add default UUID for text primary keys
      if (col.type.toUpperCase().includes('TEXT') && !col.dflt_value) {
        def += " DEFAULT gen_random_uuid()::text";
      }
    } else {
      // NOT NULL
      if (col.notnull === 1) {
        def += ' NOT NULL';
      }
      
      // Default value
      if (col.dflt_value) {
        let defaultVal = col.dflt_value;
        
        // Convert SQLite functions to PostgreSQL
        defaultVal = defaultVal
          .replace(/datetime\('now'\)/gi, 'CURRENT_TIMESTAMP')
          .replace(/date\('now'\)/gi, 'CURRENT_DATE')
          .replace(/time\('now'\)/gi, 'CURRENT_TIME')
          .replace(/\(lower\(hex\(randomblob\(16\)\)\)\)/gi, "gen_random_uuid()::text")
          .replace(/CURRENT_TIMESTAMP/g, 'CURRENT_TIMESTAMP');
        
        // Convert BOOLEAN defaults from integers to TRUE/FALSE
        if (col.type.toUpperCase().includes('BOOL')) {
          if (defaultVal === '1') defaultVal = 'TRUE';
          if (defaultVal === '0') defaultVal = 'FALSE';
        }
        
        def += ` DEFAULT ${defaultVal}`;
      }
    }
    
    columnDefs.push(def);
  }
  
  schema += columnDefs.join(',\n');
  schema += '\n);\n';
  
  // Get data count
  const count = db.prepare(`SELECT COUNT(*) as count FROM ${tableName}`).get().count;
  console.log(`  ${count} rows`);
  
  if (count > 0) {
    // Export data
    data += `\n-- Data for: ${tableName} (${count} rows)\n`;
    
    const rows = db.prepare(`SELECT * FROM ${tableName}`).all();
    
    if (rows.length > 0) {
      const cols = Object.keys(rows[0]);
      
      // Generate INSERT statements in batches
      const BATCH_SIZE = 100;
      for (let i = 0; i < rows.length; i += BATCH_SIZE) {
        const batch = rows.slice(i, i + BATCH_SIZE);
        
        data += `INSERT INTO ${tableName} (${cols.join(', ')}) VALUES\n`;
        
        const values = batch.map(row => {
          const vals = cols.map(col => {
            const val = row[col];
            if (val === null) return 'NULL';
            if (typeof val === 'boolean') return val ? 'TRUE' : 'FALSE';
            
            // Check column type from schema
            const colSchema = columns.find(c => c.name === col);
            if (colSchema && colSchema.type.toUpperCase().includes('BOOL')) {
              // SQLite stores booleans as 0/1
              return val === 1 || val === '1' || val === true ? 'TRUE' : 'FALSE';
            }
            
            if (typeof val === 'number') return val;
            // Escape single quotes
            return `'${String(val).replace(/'/g, "''")}'`;
          });
          return `  (${vals.join(', ')})`;
        });
        
        data += values.join(',\n');
        data += '\nON CONFLICT DO NOTHING;\n\n';
      }
    }
  }
}

// Add indexes
schema += `\n-- ============================================\n`;
schema += `-- Indexes and Constraints\n`;
schema += `-- ============================================\n\n`;

for (const { name: tableName } of tables) {
  const indexes = db.prepare(`PRAGMA index_list(${tableName})`).all();
  
  for (const idx of indexes) {
    if (idx.origin === 'c') continue; // Skip auto-created indexes
    
    const indexInfo = db.prepare(`PRAGMA index_info(${idx.name})`).all();
    const columns = indexInfo.map(i => i.name).join(', ');
    
    if (idx.unique === 1) {
      schema += `CREATE UNIQUE INDEX IF NOT EXISTS ${idx.name} ON ${tableName} (${columns});\n`;
    } else {
      schema += `CREATE INDEX IF NOT EXISTS ${idx.name} ON ${tableName} (${columns});\n`;
    }
  }
}

// Write files
fs.writeFileSync('supabase-schema-complete.sql', schema);
fs.writeFileSync('supabase-data-complete.sql', data);

console.log('\n✅ Export complete!');
console.log('\nGenerated files:');
console.log('  1. supabase-schema-complete.sql - CREATE TABLE statements');
console.log('  2. supabase-data-complete.sql   - INSERT statements');
console.log('\nNext steps:');
console.log('  1. Go to https://taqkfimlrlkyjbutashe.supabase.co');
console.log('  2. SQL Editor → New Query');
console.log('  3. Run supabase-schema-complete.sql first');
console.log('  4. Then run supabase-data-complete.sql');

db.close();
