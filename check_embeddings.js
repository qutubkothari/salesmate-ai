const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

// List all tenants
const allTenants = db.prepare('SELECT id, business_name FROM tenants').all();
console.log('All tenants:');
allTenants.forEach(t => {
  const embedCount = db.prepare('SELECT COUNT(*) as count FROM website_embeddings WHERE tenant_id = ?').get(t.id);
  console.log(`  - ${t.business_name} (${t.id}): ${embedCount.count} embeddings`);
});

const testBiz = allTenants[0];
if (testBiz) {
  console.log(`\nChecking embeddings for ${testBiz.business_name}...`);
  
  // Get sample embeddings
  const samples = db.prepare(`
    SELECT page_title, url, chunk_text, content_type 
    FROM website_embeddings 
    WHERE tenant_id = ?
    LIMIT 5
  `).all(testBiz.id);
  
  console.log(`\nSample embeddings (${samples.length} shown):`);
  samples.forEach(s => {
    console.log(`  Title: ${s.page_title}`);
    console.log(`  URL: ${s.url}`);
    console.log(`  Content: ${s.chunk_text.slice(0, 80)}...`);
    console.log();
  });
  
  // Check specifically for document management keywords
  const docKeywords = db.prepare(`
    SELECT COUNT(*) as count FROM website_embeddings 
    WHERE tenant_id = ?
    AND (chunk_text LIKE ? OR chunk_text LIKE ? OR chunk_text LIKE ? OR chunk_text LIKE ?)
  `).get(testBiz.id, '%document%', '%paperless%', '%scan%', '%M-Paperless%');
  
  console.log(`\nDocument-related keywords found: ${docKeywords.count}`);
}
