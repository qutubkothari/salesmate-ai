const { supabase } = require('./config');

function normalizeQuestion(text) {
    return String(text || '')
        .toLowerCase()
        .replace(/[^a-z0-9\s]/g, ' ')
        .replace(/\s+/g, ' ')
        .trim();
}

async function upsertKnowledgeItem({
    tenantId,
    question,
    answer,
    sources = [],
    createdBy = 'dashboard',
    createdFromFollowupId = null
}) {
    const tId = String(tenantId || '').trim();
    const q = String(question || '').trim();
    const a = String(answer || '').trim();

    if (!tId) throw new Error('Missing tenantId');
    if (!q) throw new Error('Missing question');
    if (!a) throw new Error('Missing answer');

    const normalized = normalizeQuestion(q);

    // Try exact match by normalized_question for this tenant.
    const { data: existing, error: findErr } = await supabase
        .from('tenant_knowledge_items')
        .select('id')
        .eq('tenant_id', tId)
        .eq('normalized_question', normalized)
        .limit(1);

    if (findErr) throw findErr;

    const now = new Date().toISOString();
    const payload = {
        tenant_id: tId,
        question: q,
        normalized_question: normalized,
        answer: a,
        sources: Array.isArray(sources) ? sources : [],
        created_by: createdBy,
        created_from_followup_id: createdFromFollowupId,
        updated_at: now
    };

    if (Array.isArray(existing) && existing.length > 0 && existing[0]?.id) {
        const id = existing[0].id;
        const { data, error } = await supabase
            .from('tenant_knowledge_items')
            .update(payload)
            .eq('id', id)
            .eq('tenant_id', tId)
            .select('*')
            .limit(1);

        if (error) throw error;
        return Array.isArray(data) ? data[0] : data;
    }

    const insertPayload = {
        ...payload,
        created_at: now
    };

    const { data: inserted, error: insErr } = await supabase
        .from('tenant_knowledge_items')
        .insert(insertPayload)
        .select('*')
        .limit(1);

    if (insErr) throw insErr;
    return Array.isArray(inserted) ? inserted[0] : inserted;
}

function tokenOverlapScore(a, b) {
    const ta = new Set(normalizeQuestion(a).split(' ').filter(Boolean));
    const tb = new Set(normalizeQuestion(b).split(' ').filter(Boolean));
    if (!ta.size || !tb.size) return 0;

    let hits = 0;
    for (const t of ta) {
        if (tb.has(t)) hits++;
    }
    return hits / Math.max(ta.size, tb.size);
}

async function findBestKnowledgeAnswer({ tenantId, query, minScore = 0.65, limit = 30 }) {
    const tId = String(tenantId || '').trim();
    const q = String(query || '').trim();
    if (!tId || !q) return null;

    const normalized = normalizeQuestion(q);

    // Fast path: exact normalized match
    try {
        const { data: exact, error: exactErr } = await supabase
            .from('tenant_knowledge_items')
            .select('id, question, answer, sources, created_at, updated_at')
            .eq('tenant_id', tId)
            .eq('normalized_question', normalized)
            .limit(1);

        if (!exactErr && Array.isArray(exact) && exact.length) {
            return {
                answer: String(exact[0].answer || '').trim(),
                sources: exact[0].sources || [],
                score: 1
            };
        }
    } catch (_) {
        // ignore, fallback to fuzzy
    }

    // Fuzzy: pull a small set and score by token overlap (SQLite-friendly)
    const { data: rows, error } = await supabase
        .from('tenant_knowledge_items')
        .select('id, question, answer, sources')
        .eq('tenant_id', tId)
        .order('updated_at', { ascending: false })
        .limit(limit);

    if (error) return null;
    const items = Array.isArray(rows) ? rows : [];
    if (!items.length) return null;

    let best = null;
    let bestScore = 0;

    for (const it of items) {
        const s = tokenOverlapScore(q, it.question);
        if (s > bestScore) {
            bestScore = s;
            best = it;
        }
    }

    if (!best || bestScore < minScore) return null;

    return {
        answer: String(best.answer || '').trim(),
        sources: best.sources || [],
        score: bestScore
    };
}

module.exports = {
    normalizeQuestion,
    upsertKnowledgeItem,
    findBestKnowledgeAnswer
};
