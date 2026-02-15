require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');
const crypto = require('crypto');

function mustEnv(name) {
  const v = process.env[name];
  if (!v) throw new Error(`Missing env var: ${name}`);
  return v;
}

const SUPABASE_URL = mustEnv('SUPABASE_URL');
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY || process.env.SUPABASE_KEY;
if (!SUPABASE_KEY) throw new Error('Missing env var: SUPABASE_SERVICE_KEY (or SUPABASE_KEY)');

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const KNOWN_HYLITE_TENANT_ID = '112f12b8-55e9-4de8-9fda-d58e37c75796';

async function main() {
  const { data: tenantById, error: tenantIdErr } = await supabase
    .from('tenants')
    .select('*')
    .eq('id', KNOWN_HYLITE_TENANT_ID)
    .maybeSingle();

  if (tenantIdErr) throw tenantIdErr;

  if (tenantById) {
    const safeTenant = {
      id: tenantById.id,
      business_name: tenantById.business_name,
      phone_number: tenantById.phone_number,
      owner_whatsapp_number: tenantById.owner_whatsapp_number,
      bot_phone_number: tenantById.bot_phone_number,
      status: tenantById.status,
      is_active: tenantById.is_active,
      updated_at: tenantById.updated_at,
    };

    console.log('Hylite tenant (safe fields):');
    console.log(JSON.stringify(safeTenant, null, 2));
  }

  const tenantId = tenantById && tenantById.id;
  if (!tenantId) {
    throw new Error(`Could not find Hylite tenant in Supabase by id=${KNOWN_HYLITE_TENANT_ID}`);
  }

  const desiredSessionName = `tenant_${tenantId}`;
  console.log('\nTarget tenantId:', tenantId);
  console.log('Desired WAHA session:', desiredSessionName);

  const { data: waRows, error: waErr } = await supabase
    .from('whatsapp_connections')
    .select('*')
    .eq('tenant_id', tenantId)
    .order('updated_at', { ascending: false })
    .limit(20);

  if (waErr) throw waErr;

  const wahaRows = (waRows || []).filter(r => (r.provider || 'waha') === 'waha');
  console.log(`\nwhatsapp_connections rows (total=${(waRows || []).length}, waha=${wahaRows.length})`);
  for (const r of wahaRows) {
    console.log(`- session=${r.session_name} status=${r.status} primary=${r.is_primary} updated=${r.updated_at}`);
  }

  const hasDesired = wahaRows.some(r => String(r.session_name) === desiredSessionName);

  // Best-effort: demote any existing WAHA rows so the desired one becomes preferred.
  // In this schema `is_primary` is an integer (0/1).
  if ((wahaRows || []).length > 0) {
    const { error: demoteErr } = await supabase
      .from('whatsapp_connections')
      .update({ is_primary: 0 })
      .eq('tenant_id', tenantId)
      .eq('provider', 'waha');
    if (demoteErr) console.warn('Warning: could not demote existing WAHA rows:', demoteErr.message);
  }

  if (!hasDesired) {
    console.log('\nNo row found with desired session_name. Creating/upserting one...');

    const upsertPayload = {
      id: crypto.randomUUID(),
      tenant_id: tenantId,
      provider: 'waha',
      session_name: desiredSessionName,
      status: 'disconnected',
      is_primary: 1,
      updated_at: new Date().toISOString(),
    };

    const { error: upsertErr } = await supabase
      .from('whatsapp_connections')
      .upsert(upsertPayload, { onConflict: 'tenant_id,session_name' });

    if (upsertErr) throw upsertErr;
  } else {
    console.log('\nDesired session_name already present. Marking it primary (best effort)...');
    const { error: primaryErr } = await supabase
      .from('whatsapp_connections')
      .update({ is_primary: 1, updated_at: new Date().toISOString() })
      .eq('tenant_id', tenantId)
      .eq('provider', 'waha')
      .eq('session_name', desiredSessionName);

    if (primaryErr) console.warn('Warning: could not set is_primary:', primaryErr.message);
  }

  console.log('\nDone.');
}

main().then(() => process.exit(0)).catch((err) => {
  console.error('ERROR:', err?.message || err);
  if (err?.details) console.error(err.details);
  process.exit(1);
});
