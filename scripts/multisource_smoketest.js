/**
 * Multi-source brain smoketest
 *
 * Seeds minimal test data for:
 * - Products
 * - Tenant documents
 * - Website embeddings
 * - Conversation + messages (for memory continuity)
 *
 * Then calls the built-in preview endpoint to show which source is used.
 *
 * Usage:
 *   TENANT_ID=<uuid> PHONE=919xxxxxxxxx BASE_URL=http://localhost:8081 node scripts/multisource_smoketest.js
 */

require('dotenv').config();

const axios = require('axios');
const { supabase } = require('../services/config');
const ConversationMemory = require('../services/core/ConversationMemory');
const { findProductByCode } = require('../services/smartResponseRouter');

let tenantId = process.env.TENANT_ID || process.argv[2];
const phone = (process.env.PHONE || process.argv[3] || '919000000000').toString();
const baseUrl = (process.env.BASE_URL || 'http://localhost:8081').replace(/\/$/, '');

const cleanPhone = phone.replace('@c.us', '');

function isMissingColumnError(err, columnName) {
  const msg = String(err?.message || err || '');
  return msg.toLowerCase().includes('no such column') && msg.toLowerCase().includes(String(columnName).toLowerCase());
}

async function findLatestConversationIdByPhone() {
  const candidates = ['end_user_phone', 'phone_number', 'phone'];
  for (const col of candidates) {
    try {
      const { data, error } = await supabase
        .from('conversations')
        .select('id')
        .eq('tenant_id', tenantId)
        .eq(col, cleanPhone)
        .order('created_at', { ascending: false })
        .limit(1)
        .maybeSingle();

      if (error) {
        if (isMissingColumnError(error, col)) continue;
        continue;
      }

      if (data?.id) return data.id;
    } catch (e) {
      continue;
    }
  }
  return null;
}

async function ensureConversation() {
  const existingId = await findLatestConversationIdByPhone();
  if (existingId) return existingId;

  const insertCandidates = [
    { end_user_phone: cleanPhone },
    { phone_number: cleanPhone },
    { phone: cleanPhone }
  ];

  for (const phoneColPayload of insertCandidates) {
    const insertPayload = {
      tenant_id: tenantId,
      ...phoneColPayload,
      state: 'greeting',
      context: '{}'
    };

    const { data: inserted, error: insertError } = await supabase
      .from('conversations')
      .insert(insertPayload)
      .select('id')
      .maybeSingle();

    if (insertError) {
      const key = Object.keys(phoneColPayload)[0];
      if (isMissingColumnError(insertError, key)) continue;
      throw new Error(`Failed to create conversation: ${insertError.message || insertError}`);
    }

    if (inserted?.id) return inserted.id;

    // Fallback if sqlite/supabase wrapper doesn't return inserted row
    const afterId = await findLatestConversationIdByPhone();
    if (afterId) return afterId;
  }

  throw new Error('Failed to create conversation: no compatible phone column found');
}

async function insertMessageSafe(row) {
  const withType = {
    ...row,
    message_type: row.sender === 'customer' ? 'user_input' : 'bot_response'
  };

  let result = await supabase.from('messages').insert(withType);
  if (!result.error) return;

  // Older schemas may not have message_type
  const { message_type: _omit, ...withoutType } = withType;
  result = await supabase.from('messages').insert(withoutType);
  if (result.error) {
    throw new Error(`Failed to insert message: ${result.error.message || result.error}`);
  }
}

async function seedConversationMessages(conversationId) {
  const stamp = new Date().toISOString();

  await insertMessageSafe({
    tenant_id: tenantId,
    conversation_id: conversationId,
    message_body: 'I want to know about AlphaFeature.',
    sender: 'customer',
    created_at: stamp
  });

  await insertMessageSafe({
    tenant_id: tenantId,
    conversation_id: conversationId,
    message_body: 'AlphaFeature is our test feature for verifying docs + website grounding.',
    sender: 'bot',
    created_at: stamp
  });

  await insertMessageSafe({
    tenant_id: tenantId,
    conversation_id: conversationId,
    message_body: 'Give me more details.',
    sender: 'customer',
    created_at: stamp
  });
}

async function seedProducts() {
  const now = Date.now();
  const { error } = await supabase.from('products').insert({
    tenant_id: tenantId,
    name: '8x80 TEST PRODUCT',
    description: `Smoketest product (${now})`,
    price: 123.45,
    stock_quantity: 7,
    units_per_carton: 100,
    packaging_unit: 'carton',
    sku: `SMOKE-8x80-${now}`,
    is_active: 1
  });

  if (error) {
    throw new Error(`Failed to seed product: ${error.message || error}`);
  }
}

async function seedTenantDoc() {
  const now = Date.now();
  const { error } = await supabase.from('tenant_documents').insert({
    tenant_id: tenantId,
    filename: `smoketest-${now}.txt`,
    original_name: `smoketest-${now}.txt`,
    mime_type: 'text/plain',
    size_bytes: 100,
    extracted_text: 'AlphaFeature: This sentence is from TENANT DOCUMENTS. If you see this, docs grounding works.'
  });

  if (error) {
    throw new Error(`Failed to seed tenant document: ${error.message || error}`);
  }
}

async function seedWebsiteEmbedding() {
  const now = Date.now();
  const { error } = await supabase.from('website_embeddings').insert({
    tenant_id: tenantId,
    content: 'Official statement: AlphaFeature batch OCR is a WEBSITE EMBEDDING smoketest sentence.',
    metadata: JSON.stringify({ tag: 'smoketest', ts: now }),
    source_url: `https://example.invalid/smoketest/${now}`
  });

  if (error) {
    throw new Error(`Failed to seed website embedding: ${error.message || error}`);
  }
}

async function preview(message) {
  const resp = await axios.post(`${baseUrl}/api/test/preview-smart-response`, {
    tenantId,
    phone,
    message
  }, { timeout: 60000 });

  return resp.data?.result || null;
}

(async () => {
  if (!tenantId) {
    const { data: latestTenant, error } = await supabase
      .from('tenants')
      .select('id')
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle();

    if (error || !latestTenant?.id) {
      console.error('Missing TENANT_ID and could not auto-detect a tenant from the database.');
      console.error('Provide TENANT_ID=<uuid> (and optionally PHONE, BASE_URL).');
      process.exit(1);
    }

    tenantId = latestTenant.id;
    console.log('ℹ️  TENANT_ID not provided; using latest tenant:', tenantId);
  }

  console.log('🔎 Multisource smoketest starting...');
  console.log('  tenantId:', tenantId);
  console.log('  phone:', phone);
  console.log('  baseUrl:', baseUrl);

  const conversationId = await ensureConversation();
  console.log('✅ Conversation ID:', conversationId);

  await Promise.all([
    seedProducts(),
    seedTenantDoc(),
    seedWebsiteEmbedding(),
    seedConversationMessages(conversationId)
  ]);

  console.log('✅ Seeded: products + docs + website + messages');

  const { data: seededProducts, error: seededProductsError } = await supabase
    .from('products')
    .select('id, tenant_id, name, price, is_active')
    .eq('tenant_id', tenantId)
    .ilike('name', '%8x80%')
    .order('created_at', { ascending: false })
    .limit(5);

  if (seededProductsError) {
    console.log('🔎 Product DB check error:', seededProductsError.message || seededProductsError);
  } else {
    console.log('🔎 Product DB check:', {
      rows: seededProducts?.length || 0,
      sample: seededProducts?.[0] ? { name: seededProducts[0].name, price: seededProducts[0].price, is_active: seededProducts[0].is_active } : null
    });
  }

  const { data: seededProductsFiltered, error: seededProductsFilteredError } = await supabase
    .from('products')
    .select('id, name, price, is_active')
    .eq('tenant_id', tenantId)
    .or('is_active.eq.true,is_active.eq.1')
    .ilike('name', '%8x80%')
    .neq('price', 0)
    .order('created_at', { ascending: false })
    .limit(5);

  if (seededProductsFilteredError) {
    console.log('🔎 Product DB check (with filters) error:', seededProductsFilteredError.message || seededProductsFilteredError);
  } else {
    console.log('🔎 Product DB check (with filters):', {
      rows: seededProductsFiltered?.length || 0,
      sample: seededProductsFiltered?.[0] ? { name: seededProductsFiltered[0].name, price: seededProductsFiltered[0].price, is_active: seededProductsFiltered[0].is_active } : null
    });
  }

    const { data: recentDocs, error: recentDocsError } = await supabase
      .from('tenant_documents')
      .select('id, original_name, filename, extracted_text, created_at')
      .eq('tenant_id', tenantId)
      .order('created_at', { ascending: false })
      .limit(3);

    if (recentDocsError) {
      console.log('🔎 Tenant docs check error:', recentDocsError.message || recentDocsError);
    } else {
      const sampleDoc = recentDocs?.[0];
      console.log('🔎 Tenant docs check:', {
        rows: recentDocs?.length || 0,
        sample: sampleDoc ? {
          name: sampleDoc.original_name || sampleDoc.filename,
          extractedTextLen: (sampleDoc.extracted_text || '').length,
          extractedTextPreview: (sampleDoc.extracted_text || '').slice(0, 80)
        } : null
      });
    }

  const directLookup = await findProductByCode(tenantId, '8x80');
  console.log('🔎 Direct findProductByCode("8x80"):', directLookup ? { id: directLookup.id, name: directLookup.name, price: directLookup.price, is_active: directLookup.is_active } : null);

  const memory = await ConversationMemory.getMemory(tenantId, phone);
  console.log('🧠 Memory check:', {
    recentMessages: memory.recentMessages.length,
    lastIntent: memory.lastIntent,
    products: memory.products
  });

  const productResult = await preview('8x80 price');
  console.log('🧪 Product preview:', {
    source: productResult?.source,
    hasResponse: !!productResult?.response,
    responsePreview: productResult?.response ? String(productResult.response).slice(0, 140) : null
  });

  const docsResult = await preview('What does the uploaded tenant document say about AlphaFeature?');
  console.log('🧪 Docs/website preview:', {
    source: docsResult?.source,
    hasResponse: !!docsResult?.response,
    responsePreview: docsResult?.response ? String(docsResult.response).slice(0, 140) : null
  });

  const websiteResult = await preview('What is the official statement about AlphaFeature batch OCR?');
  console.log('🧪 Website preview:', {
    source: websiteResult?.source,
    hasResponse: !!websiteResult?.response,
    responsePreview: websiteResult?.response ? String(websiteResult.response).slice(0, 140) : null
  });

  const followupResult = await preview('give me more details');
  console.log('🧪 Follow-up preview:', {
    source: followupResult?.source,
    hasResponse: !!followupResult?.response,
    responsePreview: followupResult?.response ? String(followupResult.response).slice(0, 140) : null
  });

  console.log('✅ Done.');
})().catch((err) => {
  console.error('❌ Smoketest failed:', err?.message || err);
  process.exit(1);
});
