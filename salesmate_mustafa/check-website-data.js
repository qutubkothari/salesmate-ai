const Database = require('better-sqlite3');
const db = new Database('./local-database.db');

console.log('\n🌐 Checking Website Data in Database...\n');
console.log('='.repeat(80));

// Check website_embeddings table
try {
  const embeddings = db.prepare('SELECT * FROM website_embeddings').all();
  
  if (embeddings.length > 0) {
    console.log(`\n✅ Found ${embeddings.length} website content chunks:\n`);
    
    embeddings.forEach((e, i) => {
      console.log(`${i + 1}. Page: ${e.page_url || 'N/A'}`);
      console.log(`   Content: ${e.content ? e.content.substring(0, 100) : 'N/A'}...`);
      console.log(`   Tokens: ${e.token_count || 'N/A'}`);
      console.log(`   Created: ${e.created_at || 'N/A'}`);
      console.log('');
    });
  } else {
    console.log('\n❌ No website embeddings found in database');
  }
} catch (err) {
  console.log('\n⚠️  website_embeddings table error:', err.message);
}

// Check crawl_jobs table
try {
  const crawlJobs = db.prepare('SELECT * FROM crawl_jobs').all();
  
  if (crawlJobs.length > 0) {
    console.log(`\n📊 Crawl Jobs (${crawlJobs.length}):\n`);
    crawlJobs.forEach((job, i) => {
      console.log(`${i + 1}. URL: ${job.start_url}`);
      console.log(`   Status: ${job.status}`);
      console.log(`   Pages: ${job.pages_crawled || 0}`);
      console.log(`   Created: ${job.created_at}`);
      console.log('');
    });
  } else {
    console.log('\n❌ No crawl jobs found');
  }
} catch (err) {
  console.log('\n⚠️  crawl_jobs table error:', err.message);
}

// Check tenant_documents table
try {
  const docs = db.prepare('SELECT * FROM tenant_documents').all();
  
  if (docs.length > 0) {
    console.log(`\n📄 Tenant Documents (${docs.length}):\n`);
    docs.forEach((doc, i) => {
      console.log(`${i + 1}. ${doc.filename || doc.document_type}`);
      console.log(`   Type: ${doc.document_type}`);
      console.log(`   Tenant: ${doc.tenant_id}`);
      console.log('');
    });
  } else {
    console.log('\n❌ No tenant documents found');
  }
} catch (err) {
  console.log('\n⚠️  tenant_documents table error:', err.message);
}

console.log('='.repeat(80));
console.log('\n💡 To add website data:');
console.log('   1. Go to dashboard: http://13.126.234.92:8081/dashboard');
console.log('   2. Navigate to Website Content section');
console.log('   3. Enter URL: https://saksolution.ae');
console.log('   4. Click "Crawl Website"\n');

db.close();
