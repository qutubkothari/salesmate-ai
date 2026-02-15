const express = require('express');
const router = express.Router();
const { normalizePhone, upsertInboundLead } = require('../../../services/crmInboundLeadService');

/**
 * POST /api/integrations/indiamart/webhook
 * Secured via shared secret header.
 * Header: x-webhook-secret or x-indiamart-secret
 */
router.post('/webhook', async (req, res) => {
  try {
    const expected = process.env.INDIAMART_WEBHOOK_SECRET || process.env.CRM_WEBHOOK_SECRET || process.env.WEBHOOK_SECRET;
    if (!expected) return res.status(500).json({ success: false, error: 'server_not_configured' });

    const provided = req.get('x-indiamart-secret') || req.get('x-webhook-secret') || req.get('X-Webhook-Secret');
    if (!provided || provided !== expected) return res.status(401).json({ success: false, error: 'unauthorized' });

    const payload = req.body || {};
    const tenantId = payload.tenantId || payload.tenant_id;
    if (!tenantId) return res.status(400).json({ success: false, error: 'tenantId required' });

    const name = payload.sender_name || payload.name || payload.full_name || payload.buyer_name || null;
    const phone = normalizePhone(payload.sender_mobile || payload.phone || payload.mobile || payload.sender_phone || null);
    const email = payload.sender_email || payload.email || null;
    const subject = payload.subject || payload.enquiry_subject || '';
    const productName = payload.product_name || payload.product || '';
    const message = payload.message || payload.requirement || payload.enquiry_message || '';
    const queryId = payload.query_id || payload.enquiry_id || payload.external_id || null;

    const body = [productName, subject, message].filter(Boolean).join(' - ').trim() || null;

    const result = await upsertInboundLead({
      tenantId,
      source: 'indiamart',
      channel: 'INDIAMART',
      leadInput: { name, phone, email },
      messageInput: {
        body,
        externalId: queryId ? String(queryId) : null,
        rawPayload: payload
      },
      triageReason: 'IndiaMart enquiry',
      autoAssign: true
    });

    return res.json({ success: true, ...result });
  } catch (e) {
    console.error('[INDIAMART] Webhook error:', e?.message || e);
    return res.status(500).json({ success: false, error: 'indiamart_webhook_failed', details: e?.message || String(e) });
  }
});

module.exports = router;
