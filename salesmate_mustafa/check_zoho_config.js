require('dotenv').config();

const { supabase } = require('./services/config');

function hasValue(v) {
    return v !== null && v !== undefined && String(v).trim() !== '';
}

function status(v) {
    return hasValue(v) ? '✅' : '❌';
}

function mask(v, visibleStart = 6, visibleEnd = 4) {
    if (!hasValue(v)) return '';
    const s = String(v);
    if (s.length <= visibleStart + visibleEnd + 3) return `${s.slice(0, 2)}***`;
    return `${s.slice(0, visibleStart)}***${s.slice(-visibleEnd)}`;
}

function getArg(name) {
    const idx = process.argv.indexOf(name);
    if (idx === -1) return null;
    return process.argv[idx + 1] || null;
}

async function checkZohoConfig() {
    const filterTenantId = getArg('--tenant') || getArg('-t');

    console.log('=== Zoho Env Readiness ===');
    console.log('USE_LOCAL_DB:', process.env.USE_LOCAL_DB);
    console.log('ZOHO_CLIENT_ID:', hasValue(process.env.ZOHO_CLIENT_ID) ? `✅ (${mask(process.env.ZOHO_CLIENT_ID)})` : '❌');
    console.log('ZOHO_CLIENT_SECRET:', hasValue(process.env.ZOHO_CLIENT_SECRET) ? `✅ (${mask(process.env.ZOHO_CLIENT_SECRET)})` : '❌');
    console.log('ZOHO_ACCOUNTS_URL:', process.env.ZOHO_ACCOUNTS_URL || '(default in code)');
    console.log('ZOHO_API_URL:', process.env.ZOHO_API_URL || '(default in code)');
    console.log('ZOHO_REFRESH_TOKEN (legacy single-tenant):', status(process.env.ZOHO_REFRESH_TOKEN));
    console.log('ZOHO_ORGANIZATION_ID (legacy single-tenant):', status(process.env.ZOHO_ORGANIZATION_ID));

    console.log('\n=== Tenant Zoho Status (DB) ===');
    const qb = supabase
        .from('tenants')
        .select([
            'id',
            'business_name',
            'zoho_client_id',
            'zoho_client_secret',
            'zoho_access_token',
            'zoho_refresh_token',
            'zoho_organization_id',
            'zoho_organization_name',
            'zoho_scopes',
            'zoho_authorized_at',
            'zoho_token_expires_at',
        ].join(', '));

    if (filterTenantId) qb.eq('id', filterTenantId);

    const { data: tenants, error } = await qb;
    if (error) {
        console.error('Failed to fetch tenants:', error);
        process.exit(1);
    }

    if (!tenants || tenants.length === 0) {
        console.log(filterTenantId ? `No tenant found for id: ${filterTenantId}` : 'No tenants found.');
        process.exit(0);
    }

    for (const t of tenants) {
        console.log(`\n--- Tenant: ${t.business_name || '(no business_name)'} ---`);
        console.log('ID:', t.id);
        console.log('Authorized At:', t.zoho_authorized_at || '❌');
        console.log('Organization:', hasValue(t.zoho_organization_id) ? `${t.zoho_organization_id}${t.zoho_organization_name ? ` (${t.zoho_organization_name})` : ''}` : '❌');
        console.log('Scopes:', t.zoho_scopes || '❌');
        console.log('Access Token:', hasValue(t.zoho_access_token) ? `✅ (${mask(t.zoho_access_token)})` : '❌');
        console.log('Refresh Token:', hasValue(t.zoho_refresh_token) ? `✅ (${mask(t.zoho_refresh_token)})` : '❌');
        console.log('Token Expires At:', t.zoho_token_expires_at || '❌');
        console.log('Client ID (DB):', hasValue(t.zoho_client_id) ? `✅ (${mask(t.zoho_client_id)})` : '❌');
        console.log('Client Secret (DB):', hasValue(t.zoho_client_secret) ? `✅ (${mask(t.zoho_client_secret)})` : '❌');
    }

    console.log('\n=== Interpretation ===');
    console.log('- If tenant tokens are ❌, you must complete Zoho OAuth for that tenant.');
    console.log('- OAuth initialization requires ZOHO_CLIENT_ID + ZOHO_CLIENT_SECRET in env (.env or service env).');
    console.log('- In production/systemd, ensure your service actually loads these env vars.');

    process.exit(0);
}

checkZohoConfig().catch((e) => {
    console.error('Unexpected error:', e);
    process.exit(1);
});
