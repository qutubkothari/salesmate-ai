const express = require('express');
const fs = require('fs');
const path = require('path');

const router = express.Router();

const {
  initializeClient,
  getQRCode,
  getClientStatus,
  disconnectClient,
} = require('../../services/whatsappWebService');

function requireAdminKey(req, res) {
  const adminKey = process.env.FSM_ADMIN_KEY;
  if (!adminKey) {
    res.status(403).json({ success: false, error: 'FSM_ADMIN_KEY not configured' });
    return false;
  }
  if (req.headers['x-admin-key'] !== adminKey) {
    res.status(403).json({ success: false, error: 'Invalid admin key' });
    return false;
  }
  return true;
}

function normalizeSessionName(value) {
  const raw = (value == null || value === '') ? 'default' : String(value);
  const cleaned = raw.trim().toLowerCase().replace(/[^a-z0-9_-]/g, '_');
  return cleaned || 'default';
}

function setNoCacheJson(res) {
  res.set('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
  res.set('Pragma', 'no-cache');
  res.set('Expires', '0');
  res.set('Surrogate-Control', 'no-store');
  res.set('ETag', String(Date.now()));
}

/**
 * POST /api/whatsapp-webjs/connect
 * Body: { tenantId, sessionName? }
 */
router.post('/connect', async (req, res) => {
  if (!requireAdminKey(req, res)) return;

  try {
    const tenantId = req.body?.tenantId;
    const sessionName = normalizeSessionName(req.body?.sessionName || 'default');

    if (!tenantId) {
      return res.status(400).json({ success: false, error: 'tenantId is required' });
    }

    const result = await initializeClient(String(tenantId), sessionName, { isSalesmanConnection: false });
    return res.json({ success: true, ...result, tenantId: String(tenantId), sessionName });
  } catch (error) {
    console.error('[WA_WEBJS] connect error:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/whatsapp-webjs/qr/:tenantId?sessionName=default
 * Returns a stable PNG URL served from /public to scan.
 */
router.get('/qr/:tenantId', async (req, res) => {
  if (!requireAdminKey(req, res)) return;
  setNoCacheJson(res);

  try {
    const tenantId = String(req.params.tenantId);
    const sessionName = normalizeSessionName(req.query?.sessionName || 'default');
    const qr = getQRCode(tenantId, sessionName);

    if (!qr?.qrCode) {
      return res.json({ success: true, status: qr?.status || 'not_initialized', qrPngUrl: null });
    }

    if (!String(qr.qrCode).startsWith('data:image/png;base64,')) {
      return res.json({ success: true, status: qr?.status || 'unknown', qrPngUrl: null });
    }

    const b64 = String(qr.qrCode).split(',')[1];
    const fileName = `waweb_qr_${tenantId}_${sessionName}.png`;
    const outPath = path.join(__dirname, '..', '..', '..', 'public', fileName);
    fs.writeFileSync(outPath, Buffer.from(b64, 'base64'));

    return res.json({
      success: true,
      status: qr.status,
      qrPngUrl: `/${fileName}`,
    });
  } catch (error) {
    console.error('[WA_WEBJS] qr error:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/whatsapp-webjs/status/:tenantId?sessionName=default
 */
router.get('/status/:tenantId', async (req, res) => {
  if (!requireAdminKey(req, res)) return;
  setNoCacheJson(res);

  try {
    const tenantId = String(req.params.tenantId);
    const sessionName = normalizeSessionName(req.query?.sessionName || 'default');
    const status = getClientStatus(tenantId, sessionName);
    return res.json({ success: true, tenantId, sessionName, ...status });
  } catch (error) {
    console.error('[WA_WEBJS] status error:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/whatsapp-webjs/disconnect
 * Body: { tenantId, sessionName? }
 */
router.post('/disconnect', async (req, res) => {
  if (!requireAdminKey(req, res)) return;

  try {
    const tenantId = req.body?.tenantId;
    const sessionName = normalizeSessionName(req.body?.sessionName || 'default');
    if (!tenantId) {
      return res.status(400).json({ success: false, error: 'tenantId is required' });
    }

    const result = await disconnectClient(String(tenantId), sessionName);
    return res.json({ success: true, ...result, tenantId: String(tenantId), sessionName });
  } catch (error) {
    console.error('[WA_WEBJS] disconnect error:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
