const Database = require('better-sqlite3');
const { generateEmbedding } = require('./services/websiteEmbeddingService');

const db = new Database('./local-database.db');

async function regenerateEmbeddings() {
  try {
    // Get all embeddings with null or mock embeddings
    const records = db.prepare(`
      SELECT id, chunk_text, page_title
      FROM website_embeddings
      WHERE tenant_id = (SELECT id FROM tenants WHERE business_name = 'Test Business')
      ORDER BY created_at DESC
    `).all();

    console.log(`Found ${records.length} embeddings to regenerate`);
    
    for (const record of records) {
      console.log(`\nGenerating embedding for: ${record.page_title}`);
      try {
        const embedding = await generateEmbedding(record.chunk_text);
        if (!embedding) {
          console.log('  ⚠️  No embedding returned');
          continue;
        }
        
        db.prepare(`
          UPDATE website_embeddings 
          SET embedding = ?
          WHERE id = ?
        `).run(JSON.stringify(embedding), record.id);
        
        console.log(`  ✓ Updated embedding (${embedding.length} dimensions)`);
      } catch (err) {
        console.error(`  ✗ Failed: ${err.message}`);
      }
      
      // Add small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 500));
    }
    
    console.log('\n✅ All embeddings regenerated!');
    process.exit(0);
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

regenerateEmbeddings();
