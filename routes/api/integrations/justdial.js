const express = require('express');
const router = express.Router();
const { dbClient } = require('../../../services/config');
const { autoAssignLead } = require('../../../services/leadAutoCreateService');

function nowIso() {
  return new Date().toISOString();
}

function normalizePhone(value) {
  if (!value) return null;
  return String(value).replace(/\D/g, '');
}

function normalizeChannel(channel) {
  return String(channel || 'JUSTDIAL').toUpperCase();
}

async function upsertLeadFromInbound({ tenantId, channel, name, phone, email }) {
  const phoneKey = phone ? String(phone).trim() : null;
  const emailKey = email ? String(email).trim().toLowerCase() : null;

  let lead = null;
  if (phoneKey) {
    const { data } = await dbClient
      .from('crm_leads')
      .select('*')
      .eq('tenant_id', tenantId)
      .eq('phone', phoneKey)
      .maybeSingle();
    lead = data || null;
  }

  if (!lead && emailKey) {
    const { data } = await dbClient
      .from('crm_leads')
      .select('*')
      .eq('tenant_id', tenantId)
      .eq('email', emailKey)
      .maybeSingle();
    lead = data || null;
  }

  if (lead) {
    const updates = {
      updated_at: nowIso(),
      last_activity_at: nowIso()
    };
    if (name && !lead.name) updates.name = String(name).trim();
    if (phoneKey && !lead.phone) updates.phone = phoneKey;
    if (emailKey && !lead.email) updates.email = emailKey;
    if (channel && !lead.channel) updates.channel = normalizeChannel(channel);

    const { data: updated, error } = await dbClient
      .from('crm_leads')
      .update(updates)
      .eq('tenant_id', tenantId)
      .eq('id', lead.id)
      .select('*')
      .single();

    if (error) throw error;
    return { lead: updated, isNew: false };
  }

  const { data: created, error } = await dbClient
    .from('crm_leads')
    .insert({
      tenant_id: tenantId,
      name: name ? String(name).trim() : null,
      phone: phoneKey,
      email: emailKey,
      channel: normalizeChannel(channel),
      status: 'NEW',
      heat: 'COLD',
      score: 0,
      last_activity_at: nowIso()
    })
    .select('*')
    .single();

  if (error) throw error;
  return { lead: created, isNew: true };
}

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

    const channel = normalizeChannel('JUSTDIAL');
    const { lead, isNew } = await upsertLeadFromInbound({ tenantId, channel, name, phone, email });

    const body = [requirement, city ? `City: ${city}` : null].filter(Boolean).join(' | ');

    const { data: msg, error: msgErr } = await dbClient
      .from('crm_messages')
      .insert({
        tenant_id: tenantId,
        lead_id: lead.id,
        direction: 'INBOUND',
        channel,
        body: body || null,
        external_id: externalId ? String(externalId) : null,
        raw_payload: payload,
        created_at: nowIso()
      })
      .select('*')
      .single();

    if (msgErr) throw msgErr;

    if (!lead.assigned_user_id) {
      await dbClient
        .from('crm_triage_items')
        .insert({
          tenant_id: tenantId,
          lead_id: lead.id,
          status: 'OPEN',
          reason: 'JustDial enquiry',
          created_at: nowIso()
        });

      await autoAssignLead(tenantId, lead.id);
    }

    await dbClient
      .from('crm_lead_events')
      .insert({
        tenant_id: tenantId,
        lead_id: lead.id,
        event_type: isNew ? 'LEAD_CREATED' : 'LEAD_UPDATED',
        event_payload: {
          source: 'justdial',
          external_id: externalId || null
        }
      });

    return res.json({ success: true, lead, message: msg });
  } catch (e) {
    console.error('[JUSTDIAL] Webhook error:', e?.message || e);
    return res.status(500).json({ success: false, error: 'justdial_webhook_failed', details: e?.message || String(e) });
  }
});

module.exports = router;
