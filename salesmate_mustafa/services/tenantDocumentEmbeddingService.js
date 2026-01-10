/**
 * Tenant Document Embedding Service
 * - Chunks and embeds uploaded tenant documents
 * - Stores embeddings in tenant_document_embeddings
 * - Performs semantic search over those chunks
 */

const { supabase } = require('./config');
const { chunkText, generateEmbedding, generateEmbeddingsBatch } = require('./websiteEmbeddingService');

const MAX_CHARS_TO_INDEX = 60_000; // cap per document
const MAX_CHUNKS_PER_DOC = 12; // keep upload indexing responsive

function cosineSimilarity(a, b) {
  if (!Array.isArray(a) || !Array.isArray(b) || a.length !== b.length || a.length === 0) {
    return 0;
  }

  let dotProduct = 0;
  let normA = 0;
  let normB = 0;

  for (let i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }

  const denom = Math.sqrt(normA) * Math.sqrt(normB);
  return denom ? dotProduct / denom : 0;
}

function safeJsonParseArray(maybeJson) {
  if (Array.isArray(maybeJson)) return maybeJson;
  if (typeof maybeJson !== 'string') return null;
  try {
    const parsed = JSON.parse(maybeJson);
    return Array.isArray(parsed) ? parsed : null;
  } catch {
    return null;
  }
}

function capText(text, maxChars) {
  const s = String(text || '');
  return s.length > maxChars ? s.slice(0, maxChars) : s;
}

async function deleteEmbeddingsForDocument(tenantId, documentId) {
  if (!tenantId || !documentId) return;
  try {
    await supabase
      .from('tenant_document_embeddings')
      .delete()
      .eq('tenant_id', tenantId)
      .eq('document_id', documentId);
  } catch (e) {
    // Table may not exist in some deployments; treat as best-effort.
    console.warn('[DOC_EMBED] deleteEmbeddingsForDocument skipped:', e?.message || e);
  }
}

async function indexTenantDocument({ tenantId, documentId }) {
  if (!tenantId || !documentId) {
    return { success: false, reason: 'missing_params' };
  }

  // Load document text
  const { data: doc, error } = await supabase
    .from('tenant_documents')
    .select('id, tenant_id, filename, original_name, extracted_text, created_at')
    .eq('tenant_id', tenantId)
    .eq('id', documentId)
    .maybeSingle();

  if (error) {
    return { success: false, error: error.message || String(error) };
  }

  const extracted = String(doc?.extracted_text || '').trim();
  if (!extracted) {
    return { success: false, reason: 'no_extracted_text' };
  }

  const name = doc.original_name || doc.filename || 'document';
  const textToIndex = capText(extracted, MAX_CHARS_TO_INDEX);

  const chunks = chunkText(textToIndex, {
    chunkSize: 1100,
    chunkOverlap: 180,
    minChunkSize: 120
  }).slice(0, MAX_CHUNKS_PER_DOC);

  if (!chunks.length) {
    return { success: false, reason: 'no_chunks' };
  }

  const chunkTexts = chunks.map(c => c.text);

  let embeddings = null;
  try {
    embeddings = await generateEmbeddingsBatch(chunkTexts);
  } catch (e) {
    console.warn('[DOC_EMBED] batch embeddings failed; trying single embedding fallback:', e?.message || e);
    embeddings = [];
    for (const t of chunkTexts) {
      const emb = await generateEmbedding(t);
      embeddings.push(emb);
    }
  }

  // Replace any existing embeddings for this document
  await deleteEmbeddingsForDocument(tenantId, documentId);

  const records = chunks.map((chunk, idx) => ({
    tenant_id: tenantId,
    document_id: documentId,
    filename: name,
    chunk_text: chunk.text,
    chunk_index: chunk.index ?? idx,
    embedding: JSON.stringify(embeddings[idx] || [])
  }));

  try {
    const { error: insertError } = await supabase
      .from('tenant_document_embeddings')
      .insert(records);

    if (insertError) {
      return { success: false, error: insertError.message || String(insertError) };
    }

    return { success: true, chunksIndexed: records.length };
  } catch (e) {
    // Table may not exist in Supabase deployments; treat as best-effort.
    return { success: false, error: e?.message || String(e) };
  }
}

async function ensureTenantDocumentsIndexed(tenantId, { maxDocs = 2 } = {}) {
  if (!tenantId) return { success: false, reason: 'missing_tenant' };

  // If we already have any embeddings for this tenant, assume indexing exists.
  try {
    const { data: existing } = await supabase
      .from('tenant_document_embeddings')
      .select('id')
      .eq('tenant_id', tenantId)
      .limit(1);

    if (Array.isArray(existing) && existing.length) {
      return { success: true, alreadyIndexed: true };
    }
  } catch {
    // ignore; may not exist
  }

  const { data: docs } = await supabase
    .from('tenant_documents')
    .select('id, extracted_text, created_at')
    .eq('tenant_id', tenantId)
    .order('created_at', { ascending: false })
    .limit(maxDocs);

  const list = Array.isArray(docs) ? docs : [];
  const indexable = list.filter(d => String(d.extracted_text || '').trim().length > 0);

  let indexed = 0;
  for (const d of indexable) {
    const r = await indexTenantDocument({ tenantId, documentId: d.id });
    if (r?.success) indexed += 1;
  }

  return { success: true, attempted: indexable.length, indexed };
}

async function searchTenantDocumentContent(query, tenantId, options = {}) {
  const {
    limit = 4,
    minSimilarity = 0.62,
    candidateLimit = 300
  } = options;

  if (!tenantId || !String(query || '').trim()) return [];

  // Try semantic search first
  try {
    const queryEmbedding = await generateEmbedding(String(query));

    const { data: candidates, error } = await supabase
      .from('tenant_document_embeddings')
      .select('id, document_id, filename, chunk_text, chunk_index, embedding, created_at')
      .eq('tenant_id', tenantId)
      .limit(candidateLimit);

    if (error) throw error;

    // If nothing is indexed yet for this tenant, fall back to lexical search over extracted_text.
    if (!Array.isArray(candidates) || candidates.length === 0) {
      throw new Error('no_doc_embeddings');
    }

    const scored = (Array.isArray(candidates) ? candidates : [])
      .map((row) => {
        const emb = safeJsonParseArray(row.embedding);
        if (!emb || !emb.length) return null;
        const similarity = cosineSimilarity(queryEmbedding, emb);
        return { ...row, similarity };
      })
      .filter(Boolean)
      .sort((a, b) => b.similarity - a.similarity);

    const filtered = scored.filter(r => r.similarity >= minSimilarity);
    const final = (filtered.length ? filtered : scored)
      .slice(0, limit)
      .map(r => ({
        id: r.id,
        documentId: r.document_id,
        filename: r.filename,
        chunkText: r.chunk_text,
        chunkIndex: r.chunk_index,
        similarity: r.similarity,
        relevanceScore: Math.max(1, Math.round((r.similarity || 0) * 100))
      }));

    return final;
  } catch (e) {
    // Lexical fallback over tenant_documents
    console.warn('[DOC_SEARCH] Semantic search unavailable, falling back to lexical:', e?.message || e);

    const q = String(query).toLowerCase();
    const tokens = q
      .split(/[^a-z0-9]+/g)
      .filter(t => t && t.length >= 3)
      .slice(0, 10);

    const { data: docs } = await supabase
      .from('tenant_documents')
      .select('id, filename, original_name, extracted_text, created_at')
      .eq('tenant_id', tenantId)
      .order('created_at', { ascending: false })
      .limit(10);

    const rows = Array.isArray(docs) ? docs : [];

    const scored = rows
      .map((d) => {
        const hay = (
          String(d.original_name || '') + ' ' +
          String(d.filename || '') + ' ' +
          String(d.extracted_text || '')
        ).toLowerCase();

        let score = 0;
        for (const t of tokens) {
          if (hay.includes(t)) score += 1;
        }

        return { doc: d, score };
      })
      .filter(x => x.score > 0)
      .sort((a, b) => b.score - a.score)
      .slice(0, limit)
      .map(({ doc, score }) => {
        const name = doc.original_name || doc.filename || 'document';
        const text = String(doc.extracted_text || '');

        // Extract a small snippet around the first matching token
        let idx = -1;
        for (const t of tokens) {
          const i = text.toLowerCase().indexOf(t);
          if (i >= 0) { idx = i; break; }
        }

        const start = Math.max(0, idx >= 0 ? idx - 350 : 0);
        const snippet = text.slice(start, start + 1200).trim();

        return {
          id: doc.id,
          documentId: doc.id,
          filename: name,
          chunkText: snippet,
          chunkIndex: 0,
          similarity: null,
          relevanceScore: Math.min(100, Math.round((score / Math.max(1, tokens.length)) * 100))
        };
      });

    return scored;
  }
}

module.exports = {
  indexTenantDocument,
  ensureTenantDocumentsIndexed,
  deleteEmbeddingsForDocument,
  searchTenantDocumentContent
};
