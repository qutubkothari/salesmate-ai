const Database = require('better-sqlite3');
const fs = require('fs');

const db = new Database('local-database.db');

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

let sql = '-- Supabase Schema\n-- Generated from local SQLite database\n\n';

for (const table of TABLES) {
  const schema = db.prepare(`SELECT sql FROM sqlite_master WHERE type='table' AND name=?`).get(table);
  if (schema && schema.sql) {
    // Convert SQLite to PostgreSQL
    let pgSql = schema.sql
      .replace(/INTEGER PRIMARY KEY AUTOINCREMENT/g, 'SERIAL PRIMARY KEY')
      .replace(/TEXT/g, 'TEXT')
      .replace(/DATETIME/g, 'TIMESTAMP')
      .replace(/BOOLEAN/g, 'BOOLEAN')
      .replace(/REAL/g, 'NUMERIC')
      + ';\n\n';
    
    sql += pgSql;
  }
}

fs.writeFileSync('supabase-schema.sql', sql);
console.log('Schema exported to supabase-schema.sql');
console.log('\nNext steps:');
console.log('1. Open https://taqkfimlrlkyjbutashe.supabase.co');
console.log('2. Go to SQL Editor');
console.log('3. Paste the contents of supabase-schema.sql');
console.log('4. Run the SQL');
console.log('5. Then run: node migrate-to-supabase.js');

db.close();
