/**
 * Document Generation Service
 * Template management, document generation, PDF export
 */

const { db } = require('./config');
const crypto = require('crypto');

class DocumentGenerationService {
  
  // ===== TEMPLATE MANAGEMENT =====
  
  /**
   * Create document template
   */
  static createTemplate(tenantId, templateData) {
    const {
      templateName,
      templateType,
      description,
      templateFormat = 'html',
      templateBody,
      headerContent = null,
      footerContent = null,
      cssStyles = null,
      pageSize = 'A4',
      pageOrientation = 'portrait',
      margins = { top: 20, right: 20, bottom: 20, left: 20 },
      isDefault = false,
      language = 'en',
      autoNumber = true,
      numberPrefix = null,
      numberFormat = '{PREFIX}{YEAR}{MONTH}{SEQUENCE}',
      tags = [],
      category = null,
      createdBy
    } = templateData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    // If setting as default, unset other defaults
    if (isDefault) {
      db.prepare(`
        UPDATE document_templates 
        SET is_default = 0 
        WHERE tenant_id = ? AND template_type = ?
      `).run(tenantId, templateType);
    }
    
    db.prepare(`
      INSERT INTO document_templates (
        id, tenant_id, template_name, template_type, description,
        template_format, template_body, header_content, footer_content,
        css_styles, page_size, page_orientation, margins,
        is_default, language, auto_number, number_prefix, number_format,
        tags, category, created_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, tenantId, templateName, templateType, description,
      templateFormat, templateBody, headerContent, footerContent,
      cssStyles, pageSize, pageOrientation, JSON.stringify(margins),
      isDefault ? 1 : 0, language, autoNumber ? 1 : 0, numberPrefix, numberFormat,
      JSON.stringify(tags), category, createdBy || null
    );
    
    return { id, templateName, templateType };
  }
  
  /**
   * Get template by ID or default for type
   */
  static getTemplate(templateId, tenantId, templateType = null) {
    if (templateId) {
      return db.prepare('SELECT * FROM document_templates WHERE id = ?').get(templateId);
    } else if (templateType) {
      return db.prepare(`
        SELECT * FROM document_templates 
        WHERE tenant_id = ? AND template_type = ? AND is_default = 1 AND is_active = 1
      `).get(tenantId, templateType);
    }
    return null;
  }
  
  /**
   * Register template placeholders
   */
  static registerPlaceholder(templateId, placeholderData) {
    const {
      placeholderKey,
      placeholderLabel,
      placeholderType,
      dataSource,
      sourceField,
      formatPattern = null,
      defaultValue = null,
      transformFunction = null,
      isRequired = false
    } = placeholderData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO document_template_placeholders (
        id, template_id, placeholder_key, placeholder_label, placeholder_type,
        data_source, source_field, format_pattern, default_value,
        transform_function, is_required
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, templateId, placeholderKey, placeholderLabel, placeholderType,
      dataSource, sourceField, formatPattern, defaultValue,
      transformFunction ? JSON.stringify(transformFunction) : null,
      isRequired ? 1 : 0
    );
    
    return id;
  }
  
  // ===== DOCUMENT GENERATION =====
  
  /**
   * Generate document from template
   */
  static generateDocument(tenantId, generationData) {
    const {
      templateId,
      documentType,
      documentTitle,
      entityType,
      entityId,
      mergeData = {},
      generatedBy
    } = generationData;
    
    // Get template
    const template = this.getTemplate(templateId, tenantId, documentType);
    if (!template) throw new Error('Template not found');
    
    // Generate document number
    const documentNumber = this._generateDocumentNumber(template);
    
    // Merge data into template
    const generatedHtml = this._mergeTemplate(template, mergeData);
    
    // Calculate totals if financial document
    let totalAmount = null;
    if (['invoice', 'quotation', 'purchase_order'].includes(documentType)) {
      totalAmount = mergeData.total_amount || this._calculateTotal(mergeData.line_items || []);
    }
    
    // Create document record
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO generated_documents (
        id, tenant_id, template_id, document_number, document_type, document_title,
        entity_type, entity_id, generated_html, merge_data, total_amount,
        currency, due_date, payment_status, generated_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, tenantId, templateId, documentNumber, documentType, documentTitle,
      entityType, entityId, generatedHtml, JSON.stringify(mergeData),
      totalAmount, mergeData.currency || 'INR', mergeData.due_date || null,
      mergeData.payment_status || 'pending', generatedBy || null
    );
    
    // Save line items if provided
    if (mergeData.line_items && Array.isArray(mergeData.line_items)) {
      mergeData.line_items.forEach((item, index) => {
        this._createLineItem(id, item, index + 1);
      });
    }
    
    // Create initial version
    this._createVersion(id, 1, 'Initial generation', generatedHtml, mergeData, generatedBy);
    
    return {
      id,
      documentNumber,
      documentType,
      generatedHtml,
      totalAmount
    };
  }
  
  /**
   * Generate document number
   */
  static _generateDocumentNumber(template) {
    if (!template.auto_number) {
      return `DOC-${Date.now()}`;
    }
    
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    
    // Increment sequence
    const newSequence = template.current_sequence + 1;
    db.prepare('UPDATE document_templates SET current_sequence = ? WHERE id = ?')
      .run(newSequence, template.id);
    
    // Format number
    let number = template.number_format || '{PREFIX}{YEAR}{MONTH}{SEQUENCE}';
    number = number.replace('{PREFIX}', template.number_prefix || '');
    number = number.replace('{YEAR}', year);
    number = number.replace('{MONTH}', month);
    number = number.replace('{SEQUENCE}', String(newSequence).padStart(4, '0'));
    
    return number;
  }
  
  /**
   * Merge template with data
   */
  static _mergeTemplate(template, data) {
    let html = template.template_body;
    
    // Simple placeholder replacement {{key}}
    const placeholderRegex = /\{\{([^}]+)\}\}/g;
    
    html = html.replace(placeholderRegex, (match, key) => {
      const value = this._getNestedValue(data, key.trim());
      return value !== undefined && value !== null ? value : match;
    });
    
    // Add header and footer
    if (template.header_content) {
      html = template.header_content + '\n' + html;
    }
    
    if (template.footer_content) {
      html = html + '\n' + template.footer_content;
    }
    
    // Wrap in basic HTML structure if needed
    if (!html.toLowerCase().includes('<html')) {
      html = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    ${template.css_styles || this._getDefaultStyles()}
  </style>
</head>
<body>
  ${html}
</body>
</html>`;
    }
    
    return html;
  }
  
  /**
   * Get nested value from object using dot notation
   */
  static _getNestedValue(obj, path) {
    const keys = path.split('.');
    let value = obj;
    
    for (const key of keys) {
      if (value && typeof value === 'object') {
        value = value[key];
      } else {
        return undefined;
      }
    }
    
    return value;
  }
  
  /**
   * Get default CSS styles
   */
  static _getDefaultStyles() {
    return `
      body { font-family: Arial, sans-serif; margin: 20px; }
      h1 { color: #333; }
      table { width: 100%; border-collapse: collapse; margin: 20px 0; }
      th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
      th { background-color: #f8f9fa; font-weight: bold; }
      .total { font-weight: bold; font-size: 1.2em; }
    `;
  }
  
  /**
   * Calculate total from line items
   */
  static _calculateTotal(lineItems) {
    return lineItems.reduce((sum, item) => sum + (item.total || 0), 0);
  }
  
  /**
   * Create line item
   */
  static _createLineItem(documentId, itemData, lineNumber) {
    const {
      itemType = 'product',
      productId = null,
      productName,
      productDescription = null,
      quantity,
      unitPrice,
      discountPercent = 0,
      discountAmount = 0,
      taxPercent = 0,
      taxAmount = 0
    } = itemData;
    
    const subtotal = quantity * unitPrice;
    const totalDiscount = discountAmount || (subtotal * discountPercent / 100);
    const afterDiscount = subtotal - totalDiscount;
    const totalTax = taxAmount || (afterDiscount * taxPercent / 100);
    const total = afterDiscount + totalTax;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO document_line_items (
        id, document_id, line_number, item_type, product_id, product_name,
        product_description, quantity, unit_price, discount_percent, discount_amount,
        tax_percent, tax_amount, subtotal, total
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, documentId, lineNumber, itemType, productId, productName,
      productDescription, quantity, unitPrice, discountPercent, totalDiscount,
      taxPercent, totalTax, subtotal, total
    );
    
    return id;
  }
  
  /**
   * Create document version
   */
  static _createVersion(documentId, versionNumber, versionNote, htmlSnapshot, mergeDataSnapshot, changedBy) {
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO document_versions (
        id, document_id, version_number, version_note, html_snapshot,
        merge_data_snapshot, changed_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, documentId, versionNumber, versionNote, htmlSnapshot,
      JSON.stringify(mergeDataSnapshot), changedBy || null
    );
    
    return id;
  }
  
  /**
   * Finalize document (make it immutable)
   */
  static finalizeDocument(documentId, finalizedBy) {
    db.prepare(`
      UPDATE generated_documents 
      SET generation_status = 'finalized', finalized_at = CURRENT_TIMESTAMP, finalized_by = ?
      WHERE id = ?
    `).run(finalizedBy, documentId);
    
    const doc = db.prepare('SELECT * FROM generated_documents WHERE id = ?').get(documentId);
    return doc;
  }
  
  /**
   * Update document status
   */
  static updateDocumentStatus(documentId, status, paymentStatus = null) {
    const updates = ['generation_status = ?'];
    const values = [status, documentId];
    
    if (paymentStatus) {
      updates.push('payment_status = ?');
      values.splice(1, 0, paymentStatus);
    }
    
    db.prepare(`UPDATE generated_documents SET ${updates.join(', ')} WHERE id = ?`)
      .run(...values);
  }
  
  /**
   * Create new version of document
   */
  static createDocumentRevision(documentId, mergeData, revisedBy) {
    const original = db.prepare('SELECT * FROM generated_documents WHERE id = ?').get(documentId);
    if (!original) throw new Error('Original document not found');
    
    const template = db.prepare('SELECT * FROM document_templates WHERE id = ?').get(original.template_id);
    const generatedHtml = this._mergeTemplate(template, mergeData);
    
    const newVersion = original.version + 1;
    
    // Mark old version as not latest
    db.prepare('UPDATE generated_documents SET is_latest_version = 0 WHERE id = ?')
      .run(documentId);
    
    // Create new document as revision
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO generated_documents (
        id, tenant_id, template_id, document_number, document_type, document_title,
        entity_type, entity_id, generated_html, merge_data, total_amount,
        currency, due_date, payment_status, version, parent_document_id,
        is_latest_version, generated_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, original.tenant_id, original.template_id, original.document_number,
      original.document_type, original.document_title, original.entity_type,
      original.entity_id, generatedHtml, JSON.stringify(mergeData),
      mergeData.total_amount || original.total_amount, original.currency,
      mergeData.due_date || original.due_date, original.payment_status,
      newVersion, documentId, 1, revisedBy
    );
    
    // Create version record
    this._createVersion(id, newVersion, 'Revision', generatedHtml, mergeData, revisedBy);
    
    return { id, version: newVersion };
  }
  
  // ===== BRANDING =====
  
  /**
   * Update company branding
   */
  static updateBranding(tenantId, brandingData) {
    const existing = db.prepare('SELECT id FROM document_branding WHERE tenant_id = ?').get(tenantId);
    
    if (existing) {
      const updates = [];
      const values = [];
      
      Object.keys(brandingData).forEach(key => {
        if (brandingData[key] !== undefined) {
          updates.push(`${key} = ?`);
          values.push(brandingData[key]);
        }
      });
      
      if (updates.length > 0) {
        updates.push('updated_at = CURRENT_TIMESTAMP');
        values.push(tenantId);
        
        db.prepare(`UPDATE document_branding SET ${updates.join(', ')} WHERE tenant_id = ?`)
          .run(...values);
      }
    } else {
      const id = crypto.randomBytes(16).toString('hex');
      const keys = ['id', 'tenant_id', ...Object.keys(brandingData)];
      const placeholders = keys.map(() => '?').join(', ');
      const vals = [id, tenantId, ...Object.values(brandingData)];
      
      db.prepare(`INSERT INTO document_branding (${keys.join(', ')}) VALUES (${placeholders})`)
        .run(...vals);
    }
    
    return db.prepare('SELECT * FROM document_branding WHERE tenant_id = ?').get(tenantId);
  }
  
  /**
   * Get company branding
   */
  static getBranding(tenantId) {
    return db.prepare('SELECT * FROM document_branding WHERE tenant_id = ?').get(tenantId);
  }
  
  // ===== ACCESS LOGGING =====
  
  /**
   * Log document access
   */
  static logAccess(documentId, accessData) {
    const {
      accessType,
      accessedBy,
      ipAddress = null,
      userAgent = null,
      accessSource = 'web'
    } = accessData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO document_access_logs (
        id, document_id, access_type, accessed_by, ip_address, user_agent, access_source
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
    `).run(id, documentId, accessType, accessedBy, ipAddress, userAgent, accessSource);
  }
  
  // ===== SIGNATURES =====
  
  /**
   * Add signature to document
   */
  static addSignature(documentId, signatureData) {
    const {
      signerName,
      signerRole,
      signerEmail,
      signatureType,
      signatureData: sigData,
      signatureIp = null,
      signatureDevice = null
    } = signatureData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO document_signatures (
        id, document_id, signer_name, signer_role, signer_email,
        signature_type, signature_data, signature_ip, signature_device,
        signature_status, signed_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'signed', CURRENT_TIMESTAMP)
    `).run(
      id, documentId, signerName, signerRole, signerEmail,
      signatureType, sigData, signatureIp, signatureDevice
    );
    
    return id;
  }
  
  // ===== REPORTS/ANALYTICS =====
  
  /**
   * Get document statistics
   */
  static getDocumentStats(tenantId, documentType = null, startDate = null, endDate = null) {
    let query = `
      SELECT 
        document_type,
        generation_status,
        payment_status,
        COUNT(*) as count,
        SUM(total_amount) as total_value,
        AVG(total_amount) as avg_value
      FROM generated_documents
      WHERE tenant_id = ?
    `;
    const params = [tenantId];
    
    if (documentType) {
      query += ' AND document_type = ?';
      params.push(documentType);
    }
    
    if (startDate) {
      query += ' AND generated_at >= ?';
      params.push(startDate);
    }
    
    if (endDate) {
      query += ' AND generated_at <= ?';
      params.push(endDate);
    }
    
    query += ' GROUP BY document_type, generation_status, payment_status';
    
    return db.prepare(query).all(...params);
  }
}

module.exports = DocumentGenerationService;
