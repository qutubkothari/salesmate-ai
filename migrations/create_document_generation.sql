-- Document Generation Schema
-- Templates, generated documents, versions, merge data
-- Supports: Invoices, Quotations, Purchase Orders, Reports, Contracts

-- Document Templates
CREATE TABLE IF NOT EXISTS document_templates (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  
  -- Template details
  template_name TEXT NOT NULL,
  template_type TEXT NOT NULL, -- invoice, quotation, purchase_order, report, contract, letter, custom
  description TEXT,
  
  -- Template content
  template_format TEXT DEFAULT 'html', -- html, markdown, plaintext, custom
  template_body TEXT NOT NULL, -- HTML/Markdown template with placeholders
  header_content TEXT, -- Template header
  footer_content TEXT, -- Template footer
  
  -- Styling
  css_styles TEXT, -- Custom CSS
  page_size TEXT DEFAULT 'A4', -- A4, A5, Letter, Legal, Custom
  page_orientation TEXT DEFAULT 'portrait', -- portrait, landscape
  margins TEXT, -- JSON: {top, right, bottom, left} in mm
  
  -- Settings
  is_default INTEGER DEFAULT 0, -- Default template for type
  is_active INTEGER DEFAULT 1,
  version INTEGER DEFAULT 1,
  language TEXT DEFAULT 'en', -- en, hi, ar (multilingual support)
  
  -- Numbering
  auto_number INTEGER DEFAULT 1,
  number_prefix TEXT, -- INV-, QT-, PO-, etc.
  number_format TEXT, -- {PREFIX}{YEAR}{MONTH}{SEQUENCE}
  current_sequence INTEGER DEFAULT 0,
  
  -- Metadata
  tags TEXT, -- JSON: array of tags
  category TEXT,
  
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Template Placeholders (available merge fields)
CREATE TABLE IF NOT EXISTS document_template_placeholders (
  id TEXT PRIMARY KEY,
  template_id TEXT NOT NULL,
  
  -- Placeholder details
  placeholder_key TEXT NOT NULL, -- {{customer.name}}, {{order.total}}, etc.
  placeholder_label TEXT NOT NULL,
  placeholder_type TEXT NOT NULL, -- text, number, date, currency, boolean, array, object
  
  -- Data source
  data_source TEXT, -- orders, customers, products, company, custom
  source_field TEXT, -- Field name in source table
  
  -- Formatting
  format_pattern TEXT, -- Date format, number format, etc.
  default_value TEXT,
  
  -- Transformation
  transform_function TEXT, -- JSON: transformation logic
  
  -- Validation
  is_required INTEGER DEFAULT 0,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (template_id) REFERENCES document_templates(id)
);

-- Generated Documents
CREATE TABLE IF NOT EXISTS generated_documents (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  template_id TEXT NOT NULL,
  
  -- Document details
  document_number TEXT NOT NULL UNIQUE,
  document_type TEXT NOT NULL, -- invoice, quotation, purchase_order, etc.
  document_title TEXT,
  
  -- Related entities
  entity_type TEXT, -- order, customer, deal, etc.
  entity_id TEXT,
  
  -- Content
  generated_html TEXT NOT NULL, -- Final HTML
  generated_pdf_path TEXT, -- Path to stored PDF
  generated_pdf_url TEXT, -- Public URL if cloud-stored
  
  -- Metadata
  generation_status TEXT DEFAULT 'draft', -- draft, finalized, sent, paid, cancelled
  file_size INTEGER, -- Bytes
  page_count INTEGER,
  
  -- Data used for generation
  merge_data TEXT, -- JSON: Data merged into template
  
  -- Versioning
  version INTEGER DEFAULT 1,
  parent_document_id TEXT, -- For revisions
  is_latest_version INTEGER DEFAULT 1,
  
  -- Delivery
  sent_at TEXT,
  sent_to TEXT, -- Email addresses (JSON array)
  sent_method TEXT, -- email, whatsapp, download, print
  
  -- Financial (for invoices/quotes)
  total_amount REAL,
  currency TEXT DEFAULT 'INR',
  due_date TEXT,
  payment_status TEXT, -- pending, paid, partial, overdue
  
  -- Audit
  generated_by TEXT,
  generated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  finalized_at TEXT,
  finalized_by TEXT,
  
  FOREIGN KEY (template_id) REFERENCES document_templates(id),
  FOREIGN KEY (parent_document_id) REFERENCES generated_documents(id)
);

-- Document Versions (revision history)
CREATE TABLE IF NOT EXISTS document_versions (
  id TEXT PRIMARY KEY,
  document_id TEXT NOT NULL,
  
  -- Version details
  version_number INTEGER NOT NULL,
  version_note TEXT,
  
  -- Content snapshot
  html_snapshot TEXT NOT NULL,
  pdf_snapshot_path TEXT,
  merge_data_snapshot TEXT, -- JSON
  
  -- Changes
  changes_summary TEXT,
  changed_by TEXT,
  changed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (document_id) REFERENCES generated_documents(id)
);

-- Document Line Items (for invoices, quotes, POs)
CREATE TABLE IF NOT EXISTS document_line_items (
  id TEXT PRIMARY KEY,
  document_id TEXT NOT NULL,
  
  -- Item details
  line_number INTEGER NOT NULL,
  item_type TEXT, -- product, service, discount, tax, shipping
  
  -- Product/service
  product_id TEXT,
  product_name TEXT NOT NULL,
  product_description TEXT,
  
  -- Pricing
  quantity REAL NOT NULL,
  unit_price REAL NOT NULL,
  discount_percent REAL DEFAULT 0,
  discount_amount REAL DEFAULT 0,
  tax_percent REAL DEFAULT 0,
  tax_amount REAL DEFAULT 0,
  
  -- Calculations
  subtotal REAL NOT NULL,
  total REAL NOT NULL,
  
  -- Metadata
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (document_id) REFERENCES generated_documents(id)
);

-- Document Signatures (approval workflow)
CREATE TABLE IF NOT EXISTS document_signatures (
  id TEXT PRIMARY KEY,
  document_id TEXT NOT NULL,
  
  -- Signer details
  signer_name TEXT NOT NULL,
  signer_role TEXT, -- approver, witness, customer, vendor
  signer_email TEXT,
  
  -- Signature
  signature_type TEXT, -- digital, image, text
  signature_data TEXT, -- Base64 image or text
  signature_ip TEXT,
  signature_device TEXT,
  
  -- Status
  signature_status TEXT DEFAULT 'pending', -- pending, signed, rejected
  signed_at TEXT,
  rejection_reason TEXT,
  
  -- Verification
  is_verified INTEGER DEFAULT 0,
  verification_token TEXT,
  
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (document_id) REFERENCES generated_documents(id)
);

-- Document Sharing/Access Logs
CREATE TABLE IF NOT EXISTS document_access_logs (
  id TEXT PRIMARY KEY,
  document_id TEXT NOT NULL,
  
  -- Access details
  access_type TEXT NOT NULL, -- view, download, email, print
  accessed_by TEXT, -- User ID or email
  
  -- Context
  ip_address TEXT,
  user_agent TEXT,
  access_source TEXT, -- web, mobile, api, email_link
  
  -- Tracking
  accessed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (document_id) REFERENCES generated_documents(id)
);

-- Document Workflows (approval routing)
CREATE TABLE IF NOT EXISTS document_workflows (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL,
  
  -- Workflow details
  workflow_name TEXT NOT NULL,
  document_type TEXT NOT NULL,
  
  -- Workflow steps
  workflow_steps TEXT NOT NULL, -- JSON: [{step, approver_role, required}]
  
  -- Settings
  is_active INTEGER DEFAULT 1,
  auto_approve_threshold REAL, -- Auto-approve if amount < threshold
  
  created_by TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Document Approval Instances
CREATE TABLE IF NOT EXISTS document_approvals (
  id TEXT PRIMARY KEY,
  document_id TEXT NOT NULL,
  workflow_id TEXT NOT NULL,
  
  -- Approval details
  current_step INTEGER DEFAULT 1,
  approval_status TEXT DEFAULT 'pending', -- pending, approved, rejected, cancelled
  
  -- Step tracking
  steps_completed INTEGER DEFAULT 0,
  total_steps INTEGER NOT NULL,
  
  -- Result
  final_decision TEXT, -- approved, rejected
  final_decision_by TEXT,
  final_decision_at TEXT,
  decision_note TEXT,
  
  -- Metadata
  initiated_by TEXT,
  initiated_at TEXT DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (document_id) REFERENCES generated_documents(id),
  FOREIGN KEY (workflow_id) REFERENCES document_workflows(id)
);

-- Company/Tenant Branding Settings
CREATE TABLE IF NOT EXISTS document_branding (
  id TEXT PRIMARY KEY,
  tenant_id TEXT NOT NULL UNIQUE,
  
  -- Company info
  company_name TEXT,
  company_logo_url TEXT,
  company_address TEXT,
  company_city TEXT,
  company_state TEXT,
  company_country TEXT,
  company_pincode TEXT,
  company_phone TEXT,
  company_email TEXT,
  company_website TEXT,
  
  -- Tax/Legal
  tax_registration_number TEXT, -- GST, VAT, etc.
  business_registration TEXT,
  
  -- Branding
  primary_color TEXT DEFAULT '#007bff',
  secondary_color TEXT DEFAULT '#6c757d',
  accent_color TEXT DEFAULT '#28a745',
  font_family TEXT DEFAULT 'Arial, sans-serif',
  
  -- Settings
  show_watermark INTEGER DEFAULT 0,
  watermark_text TEXT,
  
  updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_document_templates_tenant ON document_templates(tenant_id, template_type);
CREATE INDEX IF NOT EXISTS idx_document_templates_active ON document_templates(is_active, is_default);
CREATE INDEX IF NOT EXISTS idx_template_placeholders_template ON document_template_placeholders(template_id);
CREATE INDEX IF NOT EXISTS idx_generated_documents_tenant ON generated_documents(tenant_id, document_type);
CREATE INDEX IF NOT EXISTS idx_generated_documents_number ON generated_documents(document_number);
CREATE INDEX IF NOT EXISTS idx_generated_documents_entity ON generated_documents(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_generated_documents_status ON generated_documents(generation_status, payment_status);
CREATE INDEX IF NOT EXISTS idx_document_versions_document ON document_versions(document_id, version_number DESC);
CREATE INDEX IF NOT EXISTS idx_document_line_items_document ON document_line_items(document_id, line_number);
CREATE INDEX IF NOT EXISTS idx_document_signatures_document ON document_signatures(document_id, signature_status);
CREATE INDEX IF NOT EXISTS idx_document_access_logs_document ON document_access_logs(document_id, accessed_at DESC);
CREATE INDEX IF NOT EXISTS idx_document_workflows_tenant ON document_workflows(tenant_id, document_type);
CREATE INDEX IF NOT EXISTS idx_document_approvals_document ON document_approvals(document_id, approval_status);
