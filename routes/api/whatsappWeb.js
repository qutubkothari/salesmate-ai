const express = require('express');
const router = express.Router();
const axios = require('axios');
const { dbClient } = require('../../services/config');

// WAHA Configuration
const WAHA_URL = process.env.WAHA_URL || 'http://localhost:3001';
const WAHA_API_KEY = process.env.WAHA_API_KEY || 'waha_salesmate_2024';

// Keep last QR briefly so UI doesn't go blank between WAHA QR refreshes
const qrCache = new Map();
const QR_CACHE_TTL_MS = 90 * 1000;

// Helper to make WAHA API calls
async function wahaRequest(method, path, data = null, responseType = 'json') {
    const config = {
        method,
        url: `${WAHA_URL}${path}`,
        headers: {
            'Content-Type': 'application/json',
            'X-Api-Key': WAHA_API_KEY
        },
        responseType,
        timeout: 10000
    };
    if (data) config.data = data;
    return axios(config);
}

function setNoCacheJson(res) {
    res.set('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
    res.set('Pragma', 'no-cache');
    res.set('Expires', '0');
    res.set('Surrogate-Control', 'no-store');
    res.set('ETag', String(Date.now()));
}

async function getPreferredSessionName(tenantId, providedSessionName) {
    if (providedSessionName) return String(providedSessionName);

    try {
        const { data: row } = await dbClient
            .from('whatsapp_connections')
            .select('session_name, provider, status, updated_at, is_primary')
            .eq('tenant_id', tenantId)
            .eq('provider', 'waha')
            .order('is_primary', { ascending: false })
            .order('updated_at', { ascending: false })
            .limit(1)
            .maybeSingle();

        if (row?.session_name) return String(row.session_name);
    } catch (_) {
        // ignore
    }

    // Default to a tenant-scoped WAHA session to avoid collisions across tenants.
    return `tenant_${tenantId}`;
}

/**
 * POST /api/whatsapp-web/connect
 * Initialize WAHA session for tenant
 */
router.post('/connect', async (req, res) => {
    try {
        const { tenantId, sessionName } = req.body;

        if (!tenantId) {
            return res.status(400).json({ success: false, error: 'Tenant ID is required' });
        }

        const sn = await getPreferredSessionName(tenantId, sessionName);
        console.log('[WAHA_API] Starting session for tenant:', tenantId, 'session:', sn);

        // Check if session exists
        try {
            const sessionsRes = await wahaRequest('GET', '/api/sessions');
            const existingSession = sessionsRes.data.find(s => s.name === sn);
            
            if (existingSession) {
                // Session exists, check status
                if (existingSession.status === 'WORKING') {
                    return res.json({ success: true, status: 'ready', message: 'Already connected' });
                }
                // Stop and restart if not working
                try {
                    await wahaRequest('POST', `/api/sessions/${sn}/stop`);
                } catch (e) { /* ignore */ }
            }
        } catch (e) {
            console.log('[WAHA_API] No existing sessions');
        }

        // Start new session
        const startRes = await wahaRequest('POST', '/api/sessions/start', { name: sn });
        console.log('[WAHA_API] Session start result:', startRes.data);

        // Update database
        await dbClient
            .from('whatsapp_connections')
            .upsert({
                id: tenantId.substring(0, 32),
                tenant_id: tenantId,
                session_name: sn,
                status: 'qr_ready',
                provider: 'waha',
                updated_at: new Date().toISOString()
            }, { onConflict: 'tenant_id,session_name' });

        return res.json({ success: true, status: 'qr_ready' });

    } catch (error) {
        console.error('[WAHA_API] Connect error:', error.response?.data || error.message);
        return res.status(500).json({ success: false, error: error.message });
    }
});

/**
 * GET /api/whatsapp-web/qr/:tenantId
 * Get QR code from WAHA
 */
router.get('/qr/:tenantId', async (req, res) => {
    try {
        setNoCacheJson(res);
        const { tenantId } = req.params;
        const sessionName = await getPreferredSessionName(tenantId, req.query.sessionName);

        const cacheKey = `${tenantId}:${String(sessionName)}`;

        // Get QR as base64 image
        const qrRes = await wahaRequest('GET', `/api/${sessionName}/auth/qr`, null, 'arraybuffer');
        const base64 = Buffer.from(qrRes.data).toString('base64');
        const qrCode = `data:image/png;base64,${base64}`;

        qrCache.set(cacheKey, { qrCode, at: Date.now() });

        return res.json({ success: true, qrCode, status: 'qr_ready' });

    } catch (error) {
        // If no QR available, session might be connected or not started
        console.log('[WAHA_API] QR not available:', error.response?.status);

        const { tenantId } = req.params;
        const sessionName = await getPreferredSessionName(tenantId, req.query.sessionName);
        const cacheKey = `${tenantId}:${String(sessionName)}`;
        const cached = qrCache.get(cacheKey);
        if (cached?.qrCode && cached?.at && Date.now() - cached.at < QR_CACHE_TTL_MS) {
            return res.json({ success: true, qrCode: cached.qrCode, status: 'qr_ready', cached: true });
        }

        return res.json({ success: true, qrCode: null, status: 'no_qr' });
    }
});

/**
 * GET /api/whatsapp-web/status/:tenantId
 * Get WAHA session status
 */
router.get('/status/:tenantId', async (req, res) => {
    try {
        setNoCacheJson(res);
        const { tenantId } = req.params;
        const sessionName = await getPreferredSessionName(tenantId, req.query.sessionName);

        let wahaStatus = 'disconnected';
        let phoneNumber = null;
        let hasClient = false;

        try {
            const sessionsRes = await wahaRequest('GET', '/api/sessions');
            const session = sessionsRes.data.find(s => s.name === sessionName);
            
            if (session) {
                hasClient = true;
                if (session.status === 'WORKING') {
                    wahaStatus = 'ready';
                    phoneNumber = session.me?.id?.replace('@c.us', '') || null;
                    
                    // Update database with connected status
                    await dbClient
                        .from('whatsapp_connections')
                        .upsert({
                            id: tenantId.substring(0, 32),
                            tenant_id: tenantId,
                            session_name: sessionName,
                            status: 'ready',
                            phone_number: phoneNumber,
                            provider: 'waha',
                            connected_at: new Date().toISOString(),
                            updated_at: new Date().toISOString()
                        }, { onConflict: 'tenant_id,session_name' });
                        
                } else if (session.status === 'SCAN_QR_CODE') {
                    // Dashboard UI expects `qr_ready` to show QR section.
                    wahaStatus = 'qr_ready';
                } else if (session.status === 'STARTING') {
                    wahaStatus = 'initializing';
                } else {
                    wahaStatus = session.status.toLowerCase();
                }
            }
        } catch (e) {
            console.log('[WAHA_API] Status check error:', e.message);
        }

        // Get database record
        const { data: dbConnection } = await dbClient
            .from('whatsapp_connections')
            .select('*')
            .eq('tenant_id', tenantId)
            .eq('session_name', sessionName)
            .single();

        return res.json({
            success: true,
            status: wahaStatus,
            hasClient,
            connection: dbConnection ? {
                ...dbConnection,
                status: wahaStatus,
                phone_number: phoneNumber || dbConnection.phone_number
            } : { status: wahaStatus, phone_number: phoneNumber }
        });

    } catch (error) {
        console.error('[WAHA_API] Status error:', error);
        return res.status(500).json({ success: false, error: error.message });
    }
});

/**
 * POST /api/whatsapp-web/disconnect
 * Stop WAHA session
 */
router.post('/disconnect', async (req, res) => {
    try {
        const { tenantId, sessionName } = req.body;

        if (!tenantId) {
            return res.status(400).json({ success: false, error: 'Tenant ID is required' });
        }

        const sn = await getPreferredSessionName(tenantId, sessionName);
        console.log('[WAHA_API] Stopping session:', sn);

        try {
            // Logout from WhatsApp (clears session)
            await wahaRequest('POST', `/api/${sn}/auth/logout`);
        } catch (e) {
            console.log('[WAHA_API] Logout error (may be already logged out):', e.message);
        }

        try {
            // Stop the session
            await wahaRequest('POST', `/api/sessions/${sn}/stop`);
        } catch (e) {
            console.log('[WAHA_API] Stop error:', e.message);
        }

        // Update database
        await dbClient
            .from('whatsapp_connections')
            .update({
                status: 'disconnected',
                updated_at: new Date().toISOString()
            })
            .eq('tenant_id', tenantId)
            .eq('session_name', sn);

        return res.json({ success: true, message: 'Disconnected' });

    } catch (error) {
        console.error('[WAHA_API] Disconnect error:', error);
        return res.status(500).json({ success: false, error: error.message });
    }
});

/**
 * GET /api/whatsapp-web/connections
 * Get all connections
 */
router.get('/connections', async (req, res) => {
    try {
        let activeConnections = [];
        
        try {
            const sessionsRes = await wahaRequest('GET', '/api/sessions');
            activeConnections = sessionsRes.data.map(s => ({
                name: s.name,
                status: s.status,
                phone: s.me?.id?.replace('@c.us', '') || null
            }));
        } catch (e) {
            console.log('[WAHA_API] Could not get WAHA sessions:', e.message);
        }

        const { data: dbConnections } = await dbClient
            .from('whatsapp_connections')
            .select('*')
            .order('updated_at', { ascending: false });

        return res.json({
            success: true,
            activeConnections,
            allConnections: dbConnections
        });

    } catch (error) {
        console.error('[WAHA_API] Connections list error:', error);
        return res.status(500).json({ success: false, error: error.message });
    }
});

module.exports = router;


