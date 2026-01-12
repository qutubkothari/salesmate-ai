const Database = require('better-sqlite3');
const crypto = require('crypto');

const db = new Database('./local-database.db');

// Get the test business tenant
const tenant = db.prepare('SELECT id FROM tenants WHERE business_name = ?').get('Test Business');
if (!tenant) {
  console.error('Test Business tenant not found');
  process.exit(1);
}

const tenantId = tenant.id;
console.log(`Adding document management embeddings for tenant: ${tenantId}`);

// Sample document management content for M-Paperless
const documentContent = [
  {
    page_title: 'M-Paperless - Document Management System',
    url: 'https://saksolution.com/features/m-paperless',
    content_type: 'feature',
    chunk_text: `M-Paperless is our advanced document management system. It provides comprehensive document scanning, storage, and retrieval capabilities. 

Key Features:
- Document Upload & Storage: Upload and organize documents with automatic categorization
- Multilingual Support: Full support for Arabic, English, and other languages for document content and metadata
- Scanning Integration: Direct integration with document scanning devices and mobile scanning
- Document Search: Intelligent search across all scanned and uploaded documents
- Compliance: Built for Middle East and UAE regulatory compliance
- Access Control: Role-based permissions for document access
- Version Control: Track document versions and changes over time

The M-Paperless system is perfect for businesses that need to digitize their paper workflows and maintain organized electronic records.`
  },
  {
    page_title: 'Document Management Features',
    url: 'https://saksolution.com/features/documents',
    content_type: 'documentation',
    chunk_text: `SAK Solutions offers comprehensive document management features:

Document System Capabilities:
- Scan physical documents directly into the system
- Upload PDF, Word, and image files
- Organize documents by folders and tags
- Full-text search across document content
- Arabic language support for document text and metadata
- Automatic document classification

Document Management System Benefits:
- Reduce paper usage and storage costs
- Improve document security with encrypted storage
- Enable remote access to all your documents
- Maintain audit trails for compliance
- Share documents securely with team members
- Backup documents automatically to cloud

The document management system is part of our M-Paperless platform.`
  },
  {
    page_title: 'Arabic Document Support',
    url: 'https://saksolution.com/features/arabic',
    content_type: 'feature',
    chunk_text: `Our document management system and M-Paperless platform include full Arabic language support.

Arabic Features:
- Document upload with Arabic text recognition
- Arabic OCR (Optical Character Recognition) for scanned documents
- Arabic search and filtering
- Arabic metadata and document properties
- Right-to-left text support for document viewing
- Arabic language settings in the document management interface

For businesses operating in the UAE, Saudi Arabia, and other Gulf countries, our system ensures that documents in Arabic can be processed just as effectively as English documents.`
  },
  {
    page_title: 'Document Scanning & OCR',
    url: 'https://saksolution.com/features/scanning',
    content_type: 'feature',
    chunk_text: `The M-Paperless document scanning system makes it easy to digitize your paper records.

Scanning Capabilities:
- High-quality scanning integration with common scanner devices
- Mobile scanning through smartphone camera
- Automatic document orientation correction
- Multi-page document handling
- OCR (Optical Character Recognition) for text extraction
- Arabic and English text recognition
- Batch scanning for large volumes
- Document enhancement for better readability

Transform your paper documents into searchable, organized digital records.`
  },
  {
    page_title: 'Frequently Asked Questions - Document Management',
    url: 'https://saksolution.com/faq/documents',
    content_type: 'documentation',
    chunk_text: `Q: Do you have a document management system?
A: Yes! We offer M-Paperless, our comprehensive document management system. It includes scanning, storage, retrieval, and advanced search capabilities.

Q: Can I scan documents directly?
A: Yes, our M-Paperless system supports both scanner device integration and mobile scanning.

Q: Does it support Arabic documents?
A: Yes, full support for Arabic language in documents, metadata, and search.

Q: Is it secure?
A: Documents are encrypted, backed up, and access is controlled through role-based permissions.

Q: Can I search documents?
A: Yes, intelligent search with OCR text extraction allows you to find documents by content.

Q: What file types are supported?
A: PDF, Word documents, images (JPG, PNG), and scanned documents.`
  }
];

console.log(`\nInserting ${documentContent.length} document-related embeddings...`);

documentContent.forEach((doc, index) => {
  // Create a mock embedding (in production, this would be generated by OpenAI)
  // For now, we'll use a hash-based deterministic embedding
  const mockEmbedding = Array.from({ length: 1536 }, (_, i) => {
    const hash = crypto.createHash('sha256')
      .update(`${doc.page_title}-${doc.url}-${i}`)
      .digest('hex');
    return (parseInt(hash.substring(0, 8), 16) % 1000) / 1000 - 0.5;
  });

  try {
    db.prepare(`
      INSERT INTO website_embeddings (
        tenant_id,
        url,
        page_title,
        chunk_text,
        content,
        content_type,
        embedding,
        status,
        created_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
    `).run(
      tenantId,
      doc.url,
      doc.page_title,
      doc.chunk_text,
      doc.chunk_text,
      doc.content_type,
      JSON.stringify(mockEmbedding),
      'active'
    );
    console.log(`  ✓ Added: ${doc.page_title}`);
  } catch (err) {
    console.error(`  ✗ Failed to add ${doc.page_title}:`, err.message);
  }
});

console.log(`\n✅ Document embeddings inserted successfully!`);
console.log(`\nVerifying insertion...`);

const count = db.prepare('SELECT COUNT(*) as count FROM website_embeddings WHERE tenant_id = ?').get(tenantId);
const docCount = db.prepare(`
  SELECT COUNT(*) as count FROM website_embeddings 
  WHERE tenant_id = ? AND (chunk_text LIKE ? OR chunk_text LIKE ?)
`).get(tenantId, '%document%', '%M-Paperless%');

console.log(`Total embeddings for tenant: ${count.count}`);
console.log(`Document-related embeddings: ${docCount.count}`);
