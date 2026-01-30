/**
 * Push Notifications API
 * Manages device registration and notification sending for mobile app
 */

const express = require('express');
const router = express.Router();
const { requireSalesmanAuth } = require('../../services/salesmanAuth');
const pushService = require('../../services/pushNotificationService');

/**
 * POST /api/push/register
 * Register a device token for push notifications
 */
router.post('/register', requireSalesmanAuth, async (req, res) => {
  try {
    const { deviceToken, platform } = req.body;
    const { salesmanId, tenantId } = req.salesmanAuth;
    
    if (!deviceToken) {
      return res.status(400).json({
        success: false,
        error: 'Device token is required'
      });
    }
    
    if (!platform || !['ios', 'android'].includes(platform)) {
      return res.status(400).json({
        success: false,
        error: 'Valid platform (ios or android) is required'
      });
    }
    
    const result = await pushService.registerDeviceToken(
      salesmanId,
      deviceToken,
      platform,
      tenantId
    );
    
    res.json(result);
  } catch (err) {
    console.error('[PUSH API] Register error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

/**
 * POST /api/push/unregister
 * Unregister a device token (logout)
 */
router.post('/unregister', requireSalesmanAuth, async (req, res) => {
  try {
    const { deviceToken } = req.body;
    
    if (!deviceToken) {
      return res.status(400).json({
        success: false,
        error: 'Device token is required'
      });
    }
    
    const result = await pushService.unregisterDeviceToken(deviceToken);
    
    res.json(result);
  } catch (err) {
    console.error('[PUSH API] Unregister error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

/**
 * POST /api/push/test
 * Send a test notification (development only)
 */
router.post('/test', requireSalesmanAuth, async (req, res) => {
  try {
    const { salesmanId } = req.salesmanAuth;
    
    const result = await pushService.sendToSalesman(
      salesmanId,
      '🔔 Test Notification',
      'This is a test push notification from Salesmate AI',
      { type: 'test', timestamp: new Date().toISOString() }
    );
    
    res.json(result);
  } catch (err) {
    console.error('[PUSH API] Test error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

module.exports = router;
