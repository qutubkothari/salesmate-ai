/**
 * Mobile App API Routes
 * Offline sync, push notifications, device management, data optimization
 */

const express = require('express');
const router = express.Router();
const MobileAppService = require('../../services/mobile-app-service');

// ===== DEVICE MANAGEMENT =====

/**
 * POST /api/mobile-app/devices/register
 * Register mobile device
 */
router.post('/devices/register', async (req, res) => {
  try {
    const { tenantId, userId } = req.user || req.body;
    const result = MobileAppService.registerDevice(tenantId, userId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Device registration error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/mobile-app/devices/:deviceId/status
 * Update device status
 */
router.put('/devices/:deviceId/status', async (req, res) => {
  try {
    MobileAppService.updateDeviceStatus(req.params.deviceId, req.body);
    res.json({ success: true, message: 'Device status updated' });
  } catch (error) {
    console.error('Device status update error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/mobile-app/devices/user/:userId
 * Get user devices
 */
router.get('/devices/user/:userId', async (req, res) => {
  try {
    const { tenantId } = req.user || req.query;
    const devices = MobileAppService.getUserDevices(req.params.userId, tenantId);
    res.json({ success: true, data: devices });
  } catch (error) {
    console.error('Get user devices error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== OFFLINE SYNC QUEUE =====

/**
 * POST /api/mobile-app/sync/queue
 * Queue offline operation
 */
router.post('/sync/queue', async (req, res) => {
  try {
    const { deviceId, tenantId, userId } = req.body;
    const result = MobileAppService.queueOperation(deviceId, tenantId, userId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Queue operation error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/mobile-app/sync/pending/:deviceId
 * Get pending sync operations
 */
router.get('/sync/pending/:deviceId', async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 50;
    const operations = MobileAppService.getPendingOperations(req.params.deviceId, limit);
    res.json({ success: true, data: operations, count: operations.length });
  } catch (error) {
    console.error('Get pending operations error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/mobile-app/sync/process/:operationId
 * Process sync operation
 */
router.post('/sync/process/:operationId', async (req, res) => {
  try {
    const { success, result } = req.body;
    const syncResult = MobileAppService.processSyncOperation(req.params.operationId, success, result);
    res.json({ success: true, data: syncResult });
  } catch (error) {
    console.error('Process sync operation error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/mobile-app/sync/conflict/:operationId
 * Mark operation as conflicted
 */
router.post('/sync/conflict/:operationId', async (req, res) => {
  try {
    const { serverVersion, conflictReason } = req.body;
    const result = MobileAppService.markConflict(req.params.operationId, serverVersion, conflictReason);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Mark conflict error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== SYNC CHECKPOINTS =====

/**
 * POST /api/mobile-app/sync/checkpoint
 * Update sync checkpoint
 */
router.post('/sync/checkpoint', async (req, res) => {
  try {
    const { deviceId, tenantId } = req.body;
    const result = MobileAppService.updateCheckpoint(deviceId, tenantId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Update checkpoint error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/mobile-app/sync/checkpoint/:deviceId/:entityType/:syncDirection
 * Get sync checkpoint
 */
router.get('/sync/checkpoint/:deviceId/:entityType/:syncDirection', async (req, res) => {
  try {
    const { deviceId, entityType, syncDirection } = req.params;
    const checkpoint = MobileAppService.getCheckpoint(deviceId, entityType, syncDirection);
    res.json({ success: true, data: checkpoint });
  } catch (error) {
    console.error('Get checkpoint error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== PUSH NOTIFICATIONS =====

/**
 * POST /api/mobile-app/push/send
 * Send push notification
 */
router.post('/push/send', async (req, res) => {
  try {
    const { tenantId } = req.user || req.body;
    const result = MobileAppService.sendPushNotification(tenantId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Send push notification error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * PUT /api/mobile-app/push/delivery/:deliveryId/status
 * Update notification delivery status
 */
router.put('/push/delivery/:deliveryId/status', async (req, res) => {
  try {
    const { status, errorMessage } = req.body;
    MobileAppService.updateDeliveryStatus(req.params.deliveryId, status, errorMessage);
    res.json({ success: true, message: 'Delivery status updated' });
  } catch (error) {
    console.error('Update delivery status error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== MOBILE SESSIONS =====

/**
 * POST /api/mobile-app/session/start
 * Start mobile session
 */
router.post('/session/start', async (req, res) => {
  try {
    const { deviceId, tenantId, userId } = req.body;
    const result = MobileAppService.startSession(deviceId, tenantId, userId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Start session error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/mobile-app/session/:sessionId/end
 * End mobile session
 */
router.post('/session/:sessionId/end', async (req, res) => {
  try {
    const result = MobileAppService.endSession(req.params.sessionId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('End session error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== OFFLINE CACHE =====

/**
 * POST /api/mobile-app/cache
 * Add entity to offline cache
 */
router.post('/cache', async (req, res) => {
  try {
    const { deviceId, tenantId } = req.body;
    const result = MobileAppService.cacheEntity(deviceId, tenantId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Cache entity error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/mobile-app/cache/stale/:deviceId
 * Get stale cache entries
 */
router.get('/cache/stale/:deviceId', async (req, res) => {
  try {
    const entries = MobileAppService.getStaleCacheEntries(req.params.deviceId);
    res.json({ success: true, data: entries, count: entries.length });
  } catch (error) {
    console.error('Get stale cache error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * POST /api/mobile-app/cache/invalidate
 * Mark cache as stale
 */
router.post('/cache/invalidate', async (req, res) => {
  try {
    const { deviceId, entityType, entityId } = req.body;
    MobileAppService.markCacheStale(deviceId, entityType, entityId);
    res.json({ success: true, message: 'Cache marked as stale' });
  } catch (error) {
    console.error('Invalidate cache error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== APP UPDATES =====

/**
 * GET /api/mobile-app/updates/check
 * Check for app updates
 */
router.get('/updates/check', async (req, res) => {
  try {
    const { platform, currentVersion } = req.query;
    const result = MobileAppService.checkForUpdates(platform, currentVersion);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Check updates error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/mobile-app/feature-flags
 * Get feature flags for device
 */
router.get('/feature-flags', async (req, res) => {
  try {
    const { platform, appVersion, userId } = req.query;
    const flags = MobileAppService.getFeatureFlags(platform, appVersion, userId);
    res.json({ success: true, data: flags });
  } catch (error) {
    console.error('Get feature flags error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// ===== ANALYTICS =====

/**
 * POST /api/mobile-app/analytics/track
 * Track analytics event
 */
router.post('/analytics/track', async (req, res) => {
  try {
    const { deviceId, tenantId, userId } = req.body;
    const result = MobileAppService.trackEvent(deviceId, tenantId, userId, req.body);
    res.json({ success: true, data: result });
  } catch (error) {
    console.error('Track event error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

/**
 * GET /api/mobile-app/analytics
 * Get mobile analytics
 */
router.get('/analytics', async (req, res) => {
  try {
    const { tenantId, startDate, endDate } = req.query;
    const analytics = MobileAppService.getMobileAnalytics(tenantId, startDate, endDate);
    res.json({ success: true, data: analytics });
  } catch (error) {
    console.error('Get mobile analytics error:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

module.exports = router;
