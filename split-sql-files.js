const fs = require('fs');

console.log('Splitting SQL files into smaller chunks...\n');

// Read schema file
const schema = fs.readFileSync('supabase-schema-complete.sql', 'utf8');
const schemaTables = schema.split('-- Table:').filter(s => s.trim());

console.log(`Schema: ${schemaTables.length} table definitions`);

// Split into batches of 20 tables
const BATCH_SIZE = 20;
const header = schemaTables[0]; // First part before any table

for (let i = 1; i < schemaTables.length; i += BATCH_SIZE) {
  const batch = schemaTables.slice(i, i + BATCH_SIZE);
  const content = header + batch.map(t => '-- Table:' + t).join('\n');
  
  const batchNum = Math.floor(i / BATCH_SIZE) + 1;
  fs.writeFileSync(`supabase-schema-batch-${batchNum}.sql`, content);
  console.log(`  Created batch ${batchNum}: ${batch.length} tables`);
}

// Read data file
const data = fs.readFileSync('supabase-data-complete.sql', 'utf8');
const dataBlocks = data.split('-- Data for:').filter(s => s.trim());

console.log(`\nData: ${dataBlocks.length} table inserts`);

// Split into batches of 15 tables
const DATA_BATCH_SIZE = 15;
const dataHeader = dataBlocks[0];

for (let i = 1; i < dataBlocks.length; i += DATA_BATCH_SIZE) {
  const batch = dataBlocks.slice(i, i + DATA_BATCH_SIZE);
  const content = dataHeader + batch.map(t => '-- Data for:' + t).join('\n');
  
  const batchNum = Math.floor(i / DATA_BATCH_SIZE) + 1;
  fs.writeFileSync(`supabase-data-batch-${batchNum}.sql`, content);
  console.log(`  Created data batch ${batchNum}: ${batch.length} tables`);
}

console.log('\n✅ Files split successfully!');
console.log('\nRun these in Supabase SQL Editor in order:');
console.log('  1. Schema batches first (1, 2, 3, ...)');
console.log('  2. Then data batches (1, 2, 3, ...)');
