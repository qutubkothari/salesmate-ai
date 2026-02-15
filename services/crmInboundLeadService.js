const { dbClient } = require('./config');
const { autoAssignLead, analyzeLeadQuality } = require('./leadAutoCreateService');

function nowIso() {
  return new Date().toISOString();
}

function normalizeChannel(channel, fallback = 'WHATSAPP') {
  return String(channel || fallback).toUpperCase();
}

function normalizePhone(value) {
  if (!value) return null;
  const cleaned = String(value).replace(/@c\.us$/, '').replace(/\D/g, '');
  return cleaned || null;
}

function normalizeEmail(value) {
  if (!value) return null;
  const cleaned = String(value).trim().toLowerCase();
  return cleaned || null;
}

function normalizeName(value) {
  if (!value) return null;
  const cleaned = String(value).trim();
  return cleaned || null;
}

function buildMessageBody(parts = []) {
  return parts
    .map((p) => (p == null ? '' : String(p).trim()))
    .filter(Boolean)
    .join(' | ')
    .trim() || null;
}

function escalateHeat(currentHeat, nextHeat) {
  const level = { COLD: 1, WARM: 2, HOT: 3, ON_FIRE: 4 };
  const current = String(currentHeat || 'COLD').toUpperCase();
  const next = String(nextHeat || 'COLD').toUpperCase();
  return (level[next] || 1) > (level[current] || 1) ? next : current;
}

async function findExistingLead({ tenantId, phone, email }) {
  if (phone) {
    const { data } = await dbClient
      .from('crm_leads')
      .select('*')
      .eq('tenant_id', tenantId)
      .eq('phone', phone)
      .maybeSingle();

    if (data) return data;
  }

  if (email) {
    const { data } = await dbClient
      .from('crm_leads')
      .select('*')
      .eq('tenant_id', tenantId)
      .eq('email', email)
      .maybeSingle();

    if (data) return data;
  }

  return null;
}

async function upsertInboundLead({
  tenantId,
  channel,
  source,
  leadInput = {},
  messageInput = {},
  triageReason,
  autoAssign = true
}) {
  const normalizedChannel = normalizeChannel(channel, source || 'WHATSAPP');
  const normalizedSource = String(source || normalizedChannel).toLowerCase();

  const name = normalizeName(leadInput.name);
  const phone = normalizePhone(leadInput.phone);
  const email = normalizeEmail(leadInput.email);

  const messageBody = messageInput.body != null ? String(messageInput.body) : null;
  const externalId = messageInput.externalId != null ? String(messageInput.externalId) : null;
  const aiAnalysis = analyzeLeadQuality(messageBody || '');

  if (externalId) {
    const { data: existingMsg } = await dbClient
      .from('crm_messages')
      .select('id, lead_id')
      .eq('tenant_id', tenantId)
      .eq('channel', normalizedChannel)
      .eq('external_id', externalId)
      .maybeSingle();

    if (existingMsg?.lead_id) {
      const { data: existingLead } = await dbClient
        .from('crm_leads')
        .select('*')
        .eq('tenant_id', tenantId)
        .eq('id', existingMsg.lead_id)
        .maybeSingle();

      if (existingLead) {
        return {
          lead: existingLead,
          message: { id: existingMsg.id, lead_id: existingMsg.lead_id, deduped: true },
          isNew: false,
          assignmentResult: null,
          aiAnalysis
        };
      }
    }
  }

  const existingLead = await findExistingLead({ tenantId, phone, email });

  let lead;
  let isNew = false;

  if (existingLead) {
    const updates = {
      updated_at: nowIso(),
      last_activity_at: nowIso(),
      score: Math.max(Number(existingLead.score || 0), Number(aiAnalysis.score || 0)),
      heat: escalateHeat(existingLead.heat, aiAnalysis.heat)
    };

    if (name && !existingLead.name) updates.name = name;
    if (phone && !existingLead.phone) updates.phone = phone;
    if (email && !existingLead.email) updates.email = email;
    if (!existingLead.channel) updates.channel = normalizedChannel;

    if (
      String(existingLead.status || '').toUpperCase() === 'NEW' &&
      (aiAnalysis.intent === 'purchase' || ['HOT', 'ON_FIRE'].includes(aiAnalysis.heat))
    ) {
      updates.status = 'QUALIFIED';
    }

    const { data: updated, error: updateErr } = await dbClient
      .from('crm_leads')
      .update(updates)
      .eq('tenant_id', tenantId)
      .eq('id', existingLead.id)
      .select('*')
      .single();

    if (updateErr) throw updateErr;
    lead = updated;
  } else {
    isNew = true;

    const { data: created, error: createErr } = await dbClient
      .from('crm_leads')
      .insert({
        tenant_id: tenantId,
        name,
        phone,
        email,
        channel: normalizedChannel,
        status: aiAnalysis.intent === 'purchase' || ['HOT', 'ON_FIRE'].includes(aiAnalysis.heat) ? 'QUALIFIED' : 'NEW',
        heat: aiAnalysis.heat,
        score: Number(aiAnalysis.score || 0),
        last_activity_at: nowIso()
      })
      .select('*')
      .single();

    if (createErr) throw createErr;
    lead = created;
  }

  const { data: message, error: msgErr } = await dbClient
    .from('crm_messages')
    .insert({
      tenant_id: tenantId,
      lead_id: lead.id,
      direction: 'INBOUND',
      channel: normalizedChannel,
      body: messageBody,
      external_id: externalId,
      raw_payload: messageInput.rawPayload != null ? messageInput.rawPayload : null,
      created_at: nowIso()
    })
    .select('*')
    .single();

  if (msgErr) throw msgErr;

  await dbClient
    .from('crm_lead_events')
    .insert({
      tenant_id: tenantId,
      lead_id: lead.id,
      event_type: isNew ? 'LEAD_CREATED' : 'LEAD_UPDATED',
      event_payload: {
        source: normalizedSource,
        channel: normalizedChannel,
        ai_qualification: aiAnalysis,
        external_id: externalId
      },
      created_at: nowIso()
    });

  let assignmentResult = null;
  if (!lead.assigned_user_id) {
    await dbClient
      .from('crm_triage_items')
      .insert({
        tenant_id: tenantId,
        lead_id: lead.id,
        status: 'OPEN',
        reason: triageReason || `${normalizedChannel} inbound`,
        created_at: nowIso(),
        updated_at: nowIso()
      });

    if (autoAssign) {
      assignmentResult = await autoAssignLead(tenantId, lead.id);
    }
  }

  return { lead, message, isNew, assignmentResult, aiAnalysis };
}

module.exports = {
  normalizeChannel,
  normalizePhone,
  normalizeEmail,
  normalizeName,
  buildMessageBody,
  upsertInboundLead
};
