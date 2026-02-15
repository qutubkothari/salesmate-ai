const express = require('express');
const router = express.Router();
const { normalizePhone, upsertInboundLead } = require('../../../services/crmInboundLeadService');

/**
 * POST /api/integrations/justdial/webhook
 * Header: x-justdial-secret or x-webhook-secret
 */
router.post('/webhook', async (req, res) => {
  try {
    const expected = process.env.JUSTDIAL_WEBHOOK_SECRET || process.env.CRM_WEBHOOK_SECRET || process.env.WEBHOOK_SECRET;
    if (!expected) return res.status(500).json({ success: false, error: 'server_not_configured' });

    const provided = req.get('x-justdial-secret') || req.get('x-webhook-secret') || req.get('X-Webhook-Secret');
    if (!provided || provided !== expected) return res.status(401).json({ success: false, error: 'unauthorized' });

    const payload = req.body || {};
    const tenantId = payload.tenantId || payload.tenant_id;
    if (!tenantId) return res.status(400).json({ success: false, error: 'tenantId required' });

    const name = payload.name || payload.sender_name || payload.customer_name || null;
    const phone = normalizePhone(payload.phone || payload.mobile || payload.contact || null);
    const email = payload.email || null;
    const city = payload.city || null;
    const requirement = payload.requirement || payload.message || payload.enquiry || '';
    const externalId = payload.lead_id || payload.enquiry_id || payload.external_id || null;

    const body = [requirement, city ? `City: ${city}` : null].filter(Boolean).join(' | ') || null;

    const result = await upsertInboundLead({
      tenantId,
      source: 'justdial',
      channel: 'JUSTDIAL',
      leadInput: { name, phone, email },
      messageInput: {
        body,
        externalId: externalId ? String(externalId) : null,
        rawPayload: payload
      },
      triageReason: 'JustDial enquiry',
      autoAssign: true
    });

    return res.json({ success: true, ...result });
  } catch (e) {
    console.error('[JUSTDIAL] Webhook error:', e?.message || e);
    return res.status(500).json({ success: false, error: 'justdial_webhook_failed', details: e?.message || String(e) });
  }
});

module.exports = router;
