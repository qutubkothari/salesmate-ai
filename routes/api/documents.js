/**
 * Document Generation API Routes
 * Templates, document generation, versioning, signatures
 */

const express = require('express');
const router = express.Router();
const { db } = require('../../services/config');
const DocumentGenerationService = require('../../services/document-generation-service');

// ===== TEMPLATES =====

/**
 * GET /api/documents/templates
 * List all templates
 */
router.get('/templates', (req, res) => {
  try {
    const tenantId = req.query.tenant_id || 'default-tenant';
    const { template_type, is_active } = req.query;
    
    let query = 'SELECT * FROM document_templates WHERE tenant_id = ?';
    const params = [tenantId];
    
    if (template_type) {
      query += ' AND template_type = ?';
      params.push(template_type);
    }
    
    if (is_active !== undefined) {
      query += ' AND is_active = ?';
      params.push(is_active === 'true' ? 1 : 0);
    }
    
    query += ' ORDER BY template_type, template_name';
    
    const templates = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      templates: templates.map(t => ({
        ...t,
        margins: t.margins ? JSON.parse(t.margins) : null,
        tags: t.tags ? JSON.parse(t.tags) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching templates:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/documents/templates
 * Create new template
 */
router.post('/templates', (req, res) => {
  try {
    const tenantId = req.body.tenant_id || 'default-tenant';
    
    const template = DocumentGenerationService.createTemplate(tenantId, req.body);
    
    res.json({
      success: true,
      template
    });
  } catch (error) {
    console.error('Error creating template:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/documents/templates/:id
 * Get template details
 */
router.get('/templates/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    const template = db.prepare('SELECT * FROM document_templates WHERE id = ?').get(id);
    
    if (!template) {
      return res.status(404).json({ success: false, error: 'Template not found' });
    }
    
    // Get placeholders
    const placeholders = db.prepare('SELECT * FROM document_template_placeholders WHERE template_id = ?').all(id);
    
    res.json({
      success: true,
      template: {
        ...template,
        margins: template.margins ? JSON.parse(template.margins) : null,
        tags: template.tags ? JSON.parse(template.tags) : null,
        placeholders
      }
    });
  } catch (error) {
    console.error('Error fetching template:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/documents/templates/:id
 * Update template
 */
router.put('/templates/:id', (req, res) => {
  try {
    const { id } = req.params;
    const { template_name, template_body, is_active, is_default } = req.body;
    
    const updates = [];
    const values = [];
    
    if (template_name) {
      updates.push('template_name = ?');
      values.push(template_name);
    }
    if (template_body) {
      updates.push('template_body = ?');
      values.push(template_body);
    }
    if (is_active !== undefined) {
      updates.push('is_active = ?');
      values.push(is_active ? 1 : 0);
    }
    if (is_default !== undefined) {
      updates.push('is_default = ?');
      values.push(is_default ? 1 : 0);
    }
    
    if (updates.length > 0) {
      updates.push('updated_at = CURRENT_TIMESTAMP');
      values.push(id);
      
      db.prepare(`UPDATE document_templates SET ${updates.join(', ')} WHERE id = ?`)
        .run(...values);
    }
    
    res.json({ success: true, message: 'Template updated' });
  } catch (error) {
    console.error('Error updating template:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * DELETE /api/documents/templates/:id
 * Delete template
 */
router.delete('/templates/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    db.prepare('DELETE FROM document_templates WHERE id = ?').run(id);
    
    res.json({ success: true, message: 'Template deleted' });
  } catch (error) {
    console.error('Error deleting template:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== DOCUMENT GENERATION =====

/**
 * POST /api/documents/generate
 * Generate document from template
 */
router.post('/generate', (req, res) => {
  try {
    const tenantId = req.body.tenant_id || 'default-tenant';
    
    const document = DocumentGenerationService.generateDocument(tenantId, req.body);
    
    res.json({
      success: true,
      document
    });
  } catch (error) {
    console.error('Error generating document:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/documents
 * List generated documents
 */
router.get('/', (req, res) => {
  try {
    const tenantId = req.query.tenant_id || 'default-tenant';
    const { document_type, generation_status, payment_status, entity_type, entity_id, limit = 50 } = req.query;
    
    let query = 'SELECT * FROM generated_documents WHERE tenant_id = ?';
    const params = [tenantId];
    
    if (document_type) {
      query += ' AND document_type = ?';
      params.push(document_type);
    }
    
    if (generation_status) {
      query += ' AND generation_status = ?';
      params.push(generation_status);
    }
    
    if (payment_status) {
      query += ' AND payment_status = ?';
      params.push(payment_status);
    }
    
    if (entity_type) {
      query += ' AND entity_type = ?';
      params.push(entity_type);
    }
    
    if (entity_id) {
      query += ' AND entity_id = ?';
      params.push(entity_id);
    }
    
    query += ' ORDER BY generated_at DESC LIMIT ?';
    params.push(parseInt(limit));
    
    const documents = db.prepare(query).all(...params);
    
    res.json({
      success: true,
      documents: documents.map(doc => ({
        ...doc,
        merge_data: doc.merge_data ? JSON.parse(doc.merge_data) : null
      }))
    });
  } catch (error) {
    console.error('Error fetching documents:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/documents/:id
 * Get document details
 */
router.get('/:id', (req, res) => {
  try {
    const { id } = req.params;
    
    const document = db.prepare('SELECT * FROM generated_documents WHERE id = ?').get(id);
    
    if (!document) {
      return res.status(404).json({ success: false, error: 'Document not found' });
    }
    
    // Get line items
    const lineItems = db.prepare('SELECT * FROM document_line_items WHERE document_id = ? ORDER BY line_number').all(id);
    
    // Get signatures
    const signatures = db.prepare('SELECT * FROM document_signatures WHERE document_id = ?').all(id);
    
    // Get versions
    const versions = db.prepare('SELECT * FROM document_versions WHERE document_id = ? ORDER BY version_number DESC').all(id);
    
    // Log access
    DocumentGenerationService.logAccess(id, {
      accessType: 'view',
      accessedBy: req.query.user_id || 'anonymous',
      ipAddress: req.ip,
      userAgent: req.headers['user-agent'],
      accessSource: 'api'
    });
    
    res.json({
      success: true,
      document: {
        ...document,
        merge_data: document.merge_data ? JSON.parse(document.merge_data) : null,
        lineItems,
        signatures,
        versions: versions.map(v => ({
          ...v,
          merge_data_snapshot: v.merge_data_snapshot ? JSON.parse(v.merge_data_snapshot) : null
        }))
      }
    });
  } catch (error) {
    console.error('Error fetching document:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/documents/:id/preview
 * Get document HTML preview
 */
router.get('/:id/preview', (req, res) => {
  try {
    const { id } = req.params;
    
    const document = db.prepare('SELECT generated_html FROM generated_documents WHERE id = ?').get(id);
    
    if (!document) {
      return res.status(404).json({ success: false, error: 'Document not found' });
    }
    
    // Log access
    DocumentGenerationService.logAccess(id, {
      accessType: 'view',
      accessedBy: req.query.user_id || 'anonymous',
      ipAddress: req.ip,
      userAgent: req.headers['user-agent'],
      accessSource: 'preview'
    });
    
    res.setHeader('Content-Type', 'text/html');
    res.send(document.generated_html);
  } catch (error) {
    console.error('Error fetching document preview:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/documents/:id/finalize
 * Finalize document (make immutable)
 */
router.post('/:id/finalize', (req, res) => {
  try {
    const { id } = req.params;
    const { finalized_by } = req.body;
    
    const document = DocumentGenerationService.finalizeDocument(id, finalized_by);
    
    res.json({
      success: true,
      document: {
        id: document.id,
        status: document.generation_status,
        finalizedAt: document.finalized_at
      }
    });
  } catch (error) {
    console.error('Error finalizing document:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/documents/:id/revise
 * Create new version of document
 */
router.post('/:id/revise', (req, res) => {
  try {
    const { id } = req.params;
    const { merge_data, revised_by } = req.body;
    
    const revision = DocumentGenerationService.createDocumentRevision(id, merge_data, revised_by);
    
    res.json({
      success: true,
      revision
    });
  } catch (error) {
    console.error('Error creating revision:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/documents/:id/status
 * Update document status
 */
router.put('/:id/status', (req, res) => {
  try {
    const { id } = req.params;
    const { generation_status, payment_status } = req.body;
    
    DocumentGenerationService.updateDocumentStatus(id, generation_status, payment_status);
    
    res.json({ success: true, message: 'Status updated' });
  } catch (error) {
    console.error('Error updating status:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== SIGNATURES =====

/**
 * POST /api/documents/:id/sign
 * Add signature to document
 */
router.post('/:id/sign', (req, res) => {
  try {
    const { id } = req.params;
    
    const signatureId = DocumentGenerationService.addSignature(id, req.body);
    
    res.json({
      success: true,
      signatureId
    });
  } catch (error) {
    console.error('Error adding signature:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/documents/:id/signatures
 * Get document signatures
 */
router.get('/:id/signatures', (req, res) => {
  try {
    const { id } = req.params;
    
    const signatures = db.prepare('SELECT * FROM document_signatures WHERE document_id = ?').all(id);
    
    res.json({
      success: true,
      signatures
    });
  } catch (error) {
    console.error('Error fetching signatures:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== BRANDING =====

/**
 * GET /api/documents/branding
 * Get company branding
 */
router.get('/branding/config', (req, res) => {
  try {
    const tenantId = req.query.tenant_id || 'default-tenant';
    
    const branding = DocumentGenerationService.getBranding(tenantId);
    
    res.json({
      success: true,
      branding
    });
  } catch (error) {
    console.error('Error fetching branding:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/documents/branding
 * Update company branding
 */
router.put('/branding/config', (req, res) => {
  try {
    const tenantId = req.body.tenant_id || 'default-tenant';
    
    const branding = DocumentGenerationService.updateBranding(tenantId, req.body);
    
    res.json({
      success: true,
      branding
    });
  } catch (error) {
    console.error('Error updating branding:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== ANALYTICS =====

/**
 * GET /api/documents/stats
 * Get document statistics
 */
router.get('/stats/overview', (req, res) => {
  try {
    const tenantId = req.query.tenant_id || 'default-tenant';
    const { document_type, start_date, end_date } = req.query;
    
    const stats = DocumentGenerationService.getDocumentStats(
      tenantId,
      document_type,
      start_date,
      end_date
    );
    
    res.json({
      success: true,
      stats
    });
  } catch (error) {
    console.error('Error fetching stats:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/documents/access-logs
 * Get document access logs
 */
router.get('/access-logs/:documentId', (req, res) => {
  try {
    const { documentId } = req.params;
    const { limit = 50 } = req.query;
    
    const logs = db.prepare(`
      SELECT * FROM document_access_logs
      WHERE document_id = ?
      ORDER BY accessed_at DESC
      LIMIT ?
    `).all(documentId, parseInt(limit));
    
    res.json({
      success: true,
      logs
    });
  } catch (error) {
    console.error('Error fetching access logs:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
