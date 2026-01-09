// routes/api/triage.js
const express = require('express');
const router = express.Router();
const { supabase } = require('../../services/config');

function normalizeStatus(raw) {
  const v = String(raw || '').trim().toUpperCase();
  if (v === 'NEW' || v === 'IN_PROGRESS' || v === 'CLOSED') return v;
  return null;
}

function normalizeType(raw) {
  const v = String(raw || '').trim();
  return v || 'HUMAN_ATTENTION';
}

/**
 * GET /api/triage/:tenantId
 * List triage items
 * Query params: status=NEW|IN_PROGRESS|CLOSED
 */
router.get('/:tenantId', async (req, res) => {
  try {
    const { tenantId } = req.params;
    const status = normalizeStatus(req.query.status);

    let query = supabase
      .from('triage_queue')
      .select('*')
      .eq('tenant_id', tenantId)
      .order('created_at', { ascending: false })
      .limit(500);

    if (status) query = query.eq('status', status);

    const { data, error } = await query;
    if (error) throw error;

    return res.json({ success: true, items: data || [] });
  } catch (error) {
    console.error('[API][TRIAGE] list error:', error);
    return res.status(500).json({ success: false, error: error.message || String(error) });
  }
});

/**
 * POST /api/triage/:tenantId
 * Create a triage item
 */
router.post('/:tenantId', async (req, res) => {
  try {
    const { tenantId } = req.params;
    const body = req.body || {};

    const endUserPhone = String(body.end_user_phone || body.phone || '').trim();
    const conversationId = body.conversation_id ? String(body.conversation_id) : null;

    const type = normalizeType(body.type);
    const messagePreview = body.message_preview ? String(body.message_preview) : null;
    const metadata = body.metadata ?? null;

    if (!endUserPhone && !conversationId) {
      return res.status(400).json({ success: false, error: 'end_user_phone or conversation_id is required' });
    }

    const row = {
      tenant_id: tenantId,
      conversation_id: conversationId,
      end_user_phone: endUserPhone || null,
      type,
      status: 'NEW',
      assigned_to: null,
      message_preview: messagePreview,
      metadata,
      updated_at: new Date().toISOString(),
    };

    const { data, error } = await supabase
      .from('triage_queue')
      .insert(row)
      .select('*')
      .single();

    if (error) throw error;

    return res.json({ success: true, item: data });
  } catch (error) {
    console.error('[API][TRIAGE] create error:', error);
    return res.status(500).json({ success: false, error: error.message || String(error) });
  }
});

/**
 * POST /api/triage/:tenantId/:id/assign
 * Body: { assigned_to: string }
 */
router.post('/:tenantId/:id/assign', async (req, res) => {
  try {
    const { tenantId, id } = req.params;
    const assignedTo = String(req.body?.assigned_to || '').trim();

    if (!assignedTo) {
      return res.status(400).json({ success: false, error: 'assigned_to is required' });
    }

    const { data, error } = await supabase
      .from('triage_queue')
      .update({
        assigned_to: assignedTo,
        status: 'IN_PROGRESS',
        updated_at: new Date().toISOString(),
      })
      .eq('id', id)
      .eq('tenant_id', tenantId)
      .select('*')
      .single();

    if (error) throw error;

    return res.json({ success: true, item: data });
  } catch (error) {
    console.error('[API][TRIAGE] assign error:', error);
    return res.status(500).json({ success: false, error: error.message || String(error) });
  }
});

/**
 * POST /api/triage/:tenantId/:id/close
 * Body: { reason?: string }
 */
router.post('/:tenantId/:id/close', async (req, res) => {
  try {
    const { tenantId, id } = req.params;
    const reason = req.body?.reason != null ? String(req.body.reason) : null;

    const now = new Date().toISOString();

    const { data, error } = await supabase
      .from('triage_queue')
      .update({
        status: 'CLOSED',
        closed_reason: reason,
        closed_at: now,
        updated_at: now,
      })
      .eq('id', id)
      .eq('tenant_id', tenantId)
      .select('*')
      .single();

    if (error) throw error;

    return res.json({ success: true, item: data });
  } catch (error) {
    console.error('[API][TRIAGE] close error:', error);
    return res.status(500).json({ success: false, error: error.message || String(error) });
  }
});

/**
 * POST /api/triage/:tenantId/:id/reopen
 */
router.post('/:tenantId/:id/reopen', async (req, res) => {
  try {
    const { tenantId, id } = req.params;
    const now = new Date().toISOString();

    const { data, error } = await supabase
      .from('triage_queue')
      .update({
        status: 'IN_PROGRESS',
        closed_reason: null,
        closed_at: null,
        updated_at: now,
      })
      .eq('id', id)
      .eq('tenant_id', tenantId)
      .select('*')
      .single();

    if (error) throw error;

    return res.json({ success: true, item: data });
  } catch (error) {
    console.error('[API][TRIAGE] reopen error:', error);
    return res.status(500).json({ success: false, error: error.message || String(error) });
  }
});

module.exports = router;
