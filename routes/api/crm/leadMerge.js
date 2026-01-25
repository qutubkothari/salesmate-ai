const express = require('express');
const router = express.Router();

const { dbClient: supabase } = require('../../../services/config');
const { requireCrmAuth, requireRole } = require('../../../middleware/crmAuth');
const { requireCrmFeature } = require('../../../middleware/requireCrmFeature');
const { CRM_FEATURES } = require('../../../services/crmFeatureFlags');

function nowIso() {
  return new Date().toISOString();
}

async function addLeadEvent({ tenantId, leadId, actorUserId, eventType, eventPayload }) {
  await supabase
    .from('crm_lead_events')
    .insert({
      tenant_id: tenantId,
      lead_id: leadId,
      actor_user_id: actorUserId || null,
      event_type: eventType,
      event_payload: eventPayload || {}
    });
}

/**
 * POST /api/crm/leads/find-duplicates
 * Find potential duplicate leads by phone and/or email
 */
router.post('/find-duplicates', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { phone, email, excludeLeadId } = req.body;

    if (!phone && !email) {
      return res.status(400).json({ success: false, error: 'phone_or_email_required' });
    }

    let query = supabase
      .from('crm_leads')
      .select('*')
      .eq('tenant_id', req.user.tenantId);

    if (phone && email) {
      // Check for phone OR email match
      query = query.or(`phone.eq.${phone},email.eq.${email}`);
    } else if (phone) {
      query = query.eq('phone', phone);
    } else if (email) {
      query = query.eq('email', email.toLowerCase());
    }

    if (excludeLeadId) {
      query = query.neq('id', excludeLeadId);
    }

    const { data: duplicates, error } = await query;
    if (error) throw error;

    return res.json({ 
      success: true, 
      duplicates: duplicates || [],
      count: (duplicates || []).length
    });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'search_failed', details: e?.message || String(e) });
  }
});

/**
 * POST /api/crm/leads/merge
 * Merge duplicate leads - keeps primary lead, transfers data from secondary leads
 */
router.post('/merge', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { primaryLeadId, secondaryLeadIds } = req.body;

    if (!primaryLeadId || !Array.isArray(secondaryLeadIds) || secondaryLeadIds.length === 0) {
      return res.status(400).json({ success: false, error: 'invalid_merge_params' });
    }

    // Fetch primary lead
    const { data: primaryLead, error: primaryError } = await supabase
      .from('crm_leads')
      .select('*')
      .eq('id', primaryLeadId)
      .eq('tenant_id', req.user.tenantId)
      .single();

    if (primaryError || !primaryLead) {
      return res.status(404).json({ success: false, error: 'primary_lead_not_found' });
    }

    // Fetch secondary leads
    const { data: secondaryLeads, error: secondaryError } = await supabase
      .from('crm_leads')
      .select('*')
      .eq('tenant_id', req.user.tenantId)
      .in('id', secondaryLeadIds);

    if (secondaryError || !secondaryLeads || secondaryLeads.length === 0) {
      return res.status(404).json({ success: false, error: 'secondary_leads_not_found' });
    }

    // Merge logic: update primary lead with missing info from secondary leads
    const mergedData = { ...primaryLead };
    const mergedHistory = {
      merged_at: nowIso(),
      merged_by: req.user.id,
      secondary_lead_ids: secondaryLeadIds,
      data_transferred: []
    };

    for (const secondaryLead of secondaryLeads) {
      // Merge email if missing
      if (!mergedData.email && secondaryLead.email) {
        mergedData.email = secondaryLead.email;
        mergedHistory.data_transferred.push({ field: 'email', from: secondaryLead.id });
      }

      // Merge phone if missing
      if (!mergedData.phone && secondaryLead.phone) {
        mergedData.phone = secondaryLead.phone;
        mergedHistory.data_transferred.push({ field: 'phone', from: secondaryLead.id });
      }

      // Merge name if missing
      if (!mergedData.name && secondaryLead.name) {
        mergedData.name = secondaryLead.name;
        mergedHistory.data_transferred.push({ field: 'name', from: secondaryLead.id });
      }

      // Take higher score
      if ((secondaryLead.score || 0) > (mergedData.score || 0)) {
        mergedHistory.data_transferred.push({ field: 'score', from: secondaryLead.id, old: mergedData.score, new: secondaryLead.score });
        mergedData.score = secondaryLead.score;
      }

      // Take hotter heat level
      const heatLevels = { 'COLD': 1, 'WARM': 2, 'HOT': 3, 'ON_FIRE': 4 };
      const currentHeatLevel = heatLevels[mergedData.heat] || 1;
      const secondaryHeatLevel = heatLevels[secondaryLead.heat] || 1;
      if (secondaryHeatLevel > currentHeatLevel) {
        mergedHistory.data_transferred.push({ field: 'heat', from: secondaryLead.id, old: mergedData.heat, new: secondaryLead.heat });
        mergedData.heat = secondaryLead.heat;
      }

      // Transfer lead events
      const { error: eventsError } = await supabase
        .from('crm_lead_events')
        .update({ lead_id: primaryLeadId })
        .eq('lead_id', secondaryLead.id)
        .eq('tenant_id', req.user.tenantId);

      if (eventsError) {
        console.error('[LEAD_MERGE] Failed to transfer events:', eventsError);
      } else {
        mergedHistory.data_transferred.push({ field: 'events', from: secondaryLead.id });
      }
    }

    // Update primary lead
    const { data: updatedLead, error: updateError } = await supabase
      .from('crm_leads')
      .update({
        ...mergedData,
        updated_at: nowIso(),
        last_activity_at: nowIso()
      })
      .eq('id', primaryLeadId)
      .select('*')
      .single();

    if (updateError) throw updateError;

    // Mark secondary leads as merged (soft delete)
    const { error: deleteError } = await supabase
      .from('crm_leads')
      .update({
        status: 'MERGED',
        notes: `Merged into lead ${primaryLeadId}`,
        updated_at: nowIso()
      })
      .eq('tenant_id', req.user.tenantId)
      .in('id', secondaryLeadIds);

    if (deleteError) {
      console.error('[LEAD_MERGE] Failed to mark secondary leads as merged:', deleteError);
    }

    // Log merge event
    await addLeadEvent({
      tenantId: req.user.tenantId,
      leadId: primaryLeadId,
      actorUserId: req.user.id,
      eventType: 'LEADS_MERGED',
      eventPayload: mergedHistory
    });

    return res.json({ 
      success: true, 
      lead: updatedLead,
      mergedCount: secondaryLeadIds.length,
      mergedHistory
    });
  } catch (e) {
    console.error('[LEAD_MERGE] Error:', e);
    return res.status(500).json({ success: false, error: 'merge_failed', details: e?.message || String(e) });
  }
});

/**
 * POST /api/crm/leads/bulk-update
 * Bulk update multiple leads at once (status, assignment, etc.)
 */
router.post('/bulk-update', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { leadIds, updates } = req.body;

    if (!Array.isArray(leadIds) || leadIds.length === 0) {
      return res.status(400).json({ success: false, error: 'no_leads_selected' });
    }

    if (!updates || typeof updates !== 'object') {
      return res.status(400).json({ success: false, error: 'no_updates_provided' });
    }

    // Allowed bulk update fields
    const allowedFields = ['status', 'assigned_user_id', 'heat', 'channel'];
    const sanitizedUpdates = {};

    for (const field of allowedFields) {
      if (updates[field] !== undefined) {
        sanitizedUpdates[field] = updates[field];
      }
    }

    if (Object.keys(sanitizedUpdates).length === 0) {
      return res.status(400).json({ success: false, error: 'no_valid_updates' });
    }

    sanitizedUpdates.updated_at = nowIso();

    const { data: updatedLeads, error } = await supabase
      .from('crm_leads')
      .update(sanitizedUpdates)
      .eq('tenant_id', req.user.tenantId)
      .in('id', leadIds)
      .select('*');

    if (error) throw error;

    // Log bulk update events
    for (const leadId of leadIds) {
      await addLeadEvent({
        tenantId: req.user.tenantId,
        leadId: leadId,
        actorUserId: req.user.id,
        eventType: 'LEAD_BULK_UPDATED',
        eventPayload: { updates: sanitizedUpdates }
      });
    }

    return res.json({ 
      success: true, 
      leads: updatedLeads,
      count: updatedLeads?.length || 0
    });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'bulk_update_failed', details: e?.message || String(e) });
  }
});

module.exports = router;
