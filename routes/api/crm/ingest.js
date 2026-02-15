const express = require('express');
const router = express.Router();

const { upsertInboundLead, normalizeChannel, normalizePhone } = require('../../../services/crmInboundLeadService');
const { requireCrmAuth } = require('../../../middleware/crmAuth');
const { requireCrmFeature } = require('../../../middleware/requireCrmFeature');
const { isFeatureEnabled } = require('../../../services/crmFeatureFlags');
const { CRM_FEATURES } = require('../../../services/crmFeatureFlags');

function mapInboundBySource(source, payload = {}) {
  const normalizedSource = String(source || payload.source || 'whatsapp').toLowerCase();

  if (normalizedSource === 'indiamart') {
    return {
      source: 'indiamart',
      channel: 'INDIAMART',
      lead: {
        name: payload.lead?.name || payload.sender_name || payload.name || payload.full_name || payload.buyer_name || null,
        phone: normalizePhone(payload.lead?.phone || payload.sender_mobile || payload.phone || payload.mobile || payload.sender_phone || null),
        email: payload.lead?.email || payload.sender_email || payload.email || null
      },
      message: {
        body: [payload.product_name || payload.product, payload.subject || payload.enquiry_subject, payload.message || payload.requirement || payload.enquiry_message]
          .filter(Boolean)
          .join(' - ') || null,
        externalId: payload.query_id || payload.enquiry_id || payload.external_id || null,
        rawPayload: payload
      },
      triageReason: 'IndiaMart enquiry'
    };
  }

  if (normalizedSource === 'justdial') {
    return {
      source: 'justdial',
      channel: 'JUSTDIAL',
      lead: {
        name: payload.lead?.name || payload.name || payload.sender_name || payload.customer_name || null,
        phone: normalizePhone(payload.lead?.phone || payload.phone || payload.mobile || payload.contact || null),
        email: payload.lead?.email || payload.email || null
      },
      message: {
        body: [payload.requirement || payload.message || payload.enquiry, payload.city ? `City: ${payload.city}` : null].filter(Boolean).join(' | ') || null,
        externalId: payload.lead_id || payload.enquiry_id || payload.external_id || null,
        rawPayload: payload
      },
      triageReason: 'JustDial enquiry'
    };
  }

  if (normalizedSource === 'website' || normalizedSource === 'website_form') {
    return {
      source: 'website_form',
      channel: 'WEBSITE',
      lead: {
        name: payload.lead?.name || payload.name || null,
        phone: normalizePhone(payload.lead?.phone || payload.phone || null),
        email: payload.lead?.email || payload.email || null
      },
      message: {
        body: payload.message?.body || payload.message || payload.requirement || null,
        externalId: payload.message?.externalId || payload.externalId || null,
        rawPayload: payload
      },
      triageReason: 'Website enquiry'
    };
  }

  return {
    source: normalizedSource,
    channel: normalizeChannel(payload.channel || 'WHATSAPP'),
    lead: {
      name: payload.lead?.name || null,
      phone: normalizePhone(payload.lead?.phone || null),
      email: payload.lead?.email || null
    },
    message: {
      body: payload.message?.body != null ? String(payload.message.body) : null,
      externalId: payload.message?.externalId != null ? String(payload.message.externalId) : null,
      rawPayload: payload.message?.rawPayload != null ? payload.message.rawPayload : payload
    },
    triageReason: `${normalizeChannel(payload.channel || normalizedSource)} inbound`
  };
}

/**
 * POST /api/crm/ingest
 * Authenticated ingest (internal systems).
 * Body: { channel, lead: {name,phone,email}, message: {body, externalId, rawPayload} }
 */
router.post('/', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_INGEST), async (req, res) => {
  try {
    const tenantId = req.user.tenantId;
    const mapped = mapInboundBySource(req.body?.source, req.body || {});

    const result = await upsertInboundLead({
      tenantId,
      source: mapped.source,
      channel: mapped.channel,
      leadInput: mapped.lead,
      messageInput: mapped.message,
      triageReason: mapped.triageReason,
      autoAssign: true
    });

    return res.json({ success: true, ...result });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'ingest_failed', details: e?.message || String(e) });
  }
});

/**
 * POST /api/crm/ingest/webhook
 * External ingestion (no cookies). Secured via shared secret header.
 * Header: x-webhook-secret: <CRM_WEBHOOK_SECRET>
 */
router.post('/webhook', async (req, res) => {
  try {
    const expected = process.env.CRM_WEBHOOK_SECRET || process.env.WEBHOOK_SECRET;
    if (!expected) return res.status(500).json({ success: false, error: 'server_not_configured' });

    const provided = req.get('x-webhook-secret') || req.get('X-Webhook-Secret');
    if (!provided || provided !== expected) return res.status(401).json({ success: false, error: 'unauthorized' });

    const { tenantId } = req.body || {};
    if (!tenantId) return res.status(400).json({ success: false, error: 'tenantId required' });

    const ingestEnabled = await isFeatureEnabled(tenantId, CRM_FEATURES.CRM_INGEST);
    if (!ingestEnabled) {
      return res.status(403).json({ success: false, error: 'feature_disabled', feature: CRM_FEATURES.CRM_INGEST });
    }

    const mapped = mapInboundBySource(req.body?.source, req.body || {});

    const result = await upsertInboundLead({
      tenantId,
      source: mapped.source,
      channel: mapped.channel,
      leadInput: mapped.lead,
      messageInput: mapped.message,
      triageReason: mapped.triageReason || `${mapped.channel} webhook inbound`,
      autoAssign: true
    });

    return res.json({ success: true, ...result });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'webhook_ingest_failed', details: e?.message || String(e) });
  }
});

module.exports = router;
