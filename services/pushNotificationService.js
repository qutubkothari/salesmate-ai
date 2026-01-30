/**
 * Push Notification Service
 * Sends push notifications to salesmen for follow-up reminders
 * Supports Firebase Cloud Messaging (FCM) for both Android and iOS
 */

const { dbClient } = require('./config');
const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
let fcmInitialized = false;

function initializeFCM() {
  if (fcmInitialized) return true;
  
  try {
    // Check if service account key exists
    const serviceAccount = process.env.FIREBASE_SERVICE_ACCOUNT_KEY;
    
    if (!serviceAccount) {
      console.warn('[PUSH] Firebase service account not configured. Set FIREBASE_SERVICE_ACCOUNT_KEY environment variable.');
      return false;
    }
    
    const serviceAccountObj = JSON.parse(serviceAccount);
    
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccountObj)
    });
    
    fcmInitialized = true;
    console.log('[PUSH] Firebase Admin SDK initialized successfully');
    return true;
  } catch (err) {
    console.error('[PUSH] Failed to initialize Firebase:', err.message);
    return false;
  }
}

/**
 * Register a device token for a salesman
 * @param {string} salesmanId - Salesman UUID
 * @param {string} deviceToken - FCM device token
 * @param {string} platform - 'ios' or 'android'
 * @param {string} tenantId - Tenant UUID
 */
async function registerDeviceToken(salesmanId, deviceToken, platform, tenantId) {
  try {
    const query = `
      INSERT INTO salesman_devices (id, salesman_id, tenant_id, device_token, platform, created_at, last_active_at)
      VALUES (gen_random_uuid(), $1, $2, $3, $4, NOW(), NOW())
      ON CONFLICT (device_token) 
      DO UPDATE SET 
        salesman_id = EXCLUDED.salesman_id,
        platform = EXCLUDED.platform,
        last_active_at = NOW(),
        is_active = true
      RETURNING id
    `;
    
    const result = await dbClient.query(query, [salesmanId, tenantId, deviceToken, platform]);
    
    console.log(`[PUSH] Registered device token for salesman ${salesmanId}`);
    return { success: true, deviceId: result.rows[0]?.id };
  } catch (err) {
    console.error('[PUSH] Error registering device token:', err.message);
    throw err;
  }
}

/**
 * Unregister a device token (when user logs out)
 * @param {string} deviceToken - FCM device token
 */
async function unregisterDeviceToken(deviceToken) {
  try {
    const query = `
      UPDATE salesman_devices 
      SET is_active = false, updated_at = NOW()
      WHERE device_token = $1
    `;
    
    await dbClient.query(query, [deviceToken]);
    console.log(`[PUSH] Unregistered device token`);
    return { success: true };
  } catch (err) {
    console.error('[PUSH] Error unregistering device token:', err.message);
    throw err;
  }
}

/**
 * Send a push notification to a specific salesman
 * @param {string} salesmanId - Salesman UUID
 * @param {string} title - Notification title
 * @param {string} body - Notification body
 * @param {object} data - Additional data payload
 */
async function sendToSalesman(salesmanId, title, body, data = {}) {
  if (!initializeFCM()) {
    console.warn('[PUSH] FCM not initialized, skipping notification');
    return { success: false, reason: 'fcm_not_initialized' };
  }
  
  try {
    // Get active device tokens for salesman
    const query = `
      SELECT device_token, platform
      FROM salesman_devices
      WHERE salesman_id = $1 AND is_active = true
    `;
    
    const result = await dbClient.query(query, [salesmanId]);
    
    if (result.rows.length === 0) {
      console.log(`[PUSH] No active devices for salesman ${salesmanId}`);
      return { success: false, reason: 'no_devices' };
    }
    
    const tokens = result.rows.map(row => row.device_token);
    
    // Prepare FCM message
    const message = {
      notification: {
        title,
        body
      },
      data: {
        ...data,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        timestamp: new Date().toISOString()
      },
      tokens
    };
    
    // Send multicast message
    const response = await admin.messaging().sendMulticast(message);
    
    console.log(`[PUSH] Sent ${response.successCount}/${tokens.length} notifications to salesman ${salesmanId}`);
    
    // Handle failed tokens (remove invalid tokens)
    if (response.failureCount > 0) {
      const failedTokens = [];
      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          failedTokens.push(tokens[idx]);
          console.warn(`[PUSH] Failed to send to token ${tokens[idx]}: ${resp.error?.message}`);
        }
      });
      
      // Remove invalid tokens from database
      if (failedTokens.length > 0) {
        await dbClient.query(
          `UPDATE salesman_devices SET is_active = false WHERE device_token = ANY($1)`,
          [failedTokens]
        );
      }
    }
    
    return {
      success: true,
      successCount: response.successCount,
      failureCount: response.failureCount
    };
  } catch (err) {
    console.error('[PUSH] Error sending notification:', err.message);
    throw err;
  }
}

/**
 * Send follow-up reminder notification
 * @param {string} salesmanId - Salesman UUID
 * @param {object} followup - Follow-up details
 */
async function sendFollowupReminder(salesmanId, followup) {
  const title = `📅 Follow-up Reminder: ${followup.customer_name || 'Customer'}`;
  
  let body = `${followup.follow_up_type || 'Follow-up'} scheduled`;
  if (followup.follow_up_note) {
    body += `: ${followup.follow_up_note.substring(0, 100)}`;
  }
  
  const data = {
    type: 'followup_reminder',
    followup_id: followup.id,
    conversation_id: followup.conversation_id,
    customer_id: followup.customer_id,
    priority: followup.follow_up_priority || 'medium'
  };
  
  return await sendToSalesman(salesmanId, title, body, data);
}

/**
 * Send overdue follow-up notification
 * @param {string} salesmanId - Salesman UUID
 * @param {object} followup - Follow-up details
 */
async function sendOverdueFollowup(salesmanId, followup) {
  const title = `⚠️ Overdue: ${followup.customer_name || 'Customer'}`;
  const body = `Follow-up was scheduled for ${new Date(followup.follow_up_at).toLocaleDateString()}`;
  
  const data = {
    type: 'followup_overdue',
    followup_id: followup.id,
    conversation_id: followup.conversation_id,
    customer_id: followup.customer_id,
    priority: 'high'
  };
  
  return await sendToSalesman(salesmanId, title, body, data);
}

/**
 * Send new message notification
 * @param {string} salesmanId - Salesman UUID
 * @param {string} customerName - Customer name
 * @param {string} messagePreview - Message preview
 * @param {string} conversationId - Conversation UUID
 */
async function sendNewMessage(salesmanId, customerName, messagePreview, conversationId) {
  const title = `💬 New message from ${customerName}`;
  const body = messagePreview.substring(0, 150);
  
  const data = {
    type: 'new_message',
    conversation_id: conversationId
  };
  
  return await sendToSalesman(salesmanId, title, body, data);
}

/**
 * Check for due follow-ups and send reminders
 * This should be called from a cron job every 15 minutes
 */
async function sendDueFollowupReminders() {
  if (!initializeFCM()) {
    return { success: false, reason: 'fcm_not_initialized' };
  }
  
  try {
    // Get follow-ups due in the next 30 minutes that haven't been reminded yet
    const query = `
      SELECT 
        c.id,
        c.conversation_id,
        c.customer_id,
        c.salesman_id,
        c.follow_up_at,
        c.follow_up_type,
        c.follow_up_priority,
        c.follow_up_note,
        cp.name as customer_name,
        cp.phone as customer_phone
      FROM conversations_new c
      LEFT JOIN customer_profiles_new cp ON cp.id = c.customer_id
      WHERE c.follow_up_at IS NOT NULL
        AND c.follow_up_at <= NOW() + INTERVAL '30 minutes'
        AND c.follow_up_at > NOW()
        AND c.follow_up_completed_at IS NULL
        AND c.salesman_id IS NOT NULL
        AND (c.follow_up_reminder_sent_at IS NULL OR c.follow_up_reminder_sent_at < NOW() - INTERVAL '1 hour')
      ORDER BY c.follow_up_at ASC
      LIMIT 50
    `;
    
    const result = await dbClient.query(query);
    
    console.log(`[PUSH] Found ${result.rows.length} follow-ups due for reminders`);
    
    let sentCount = 0;
    
    for (const followup of result.rows) {
      try {
        const notifResult = await sendFollowupReminder(followup.salesman_id, followup);
        
        if (notifResult.success) {
          // Mark reminder as sent
          await dbClient.query(
            `UPDATE conversations_new SET follow_up_reminder_sent_at = NOW() WHERE id = $1`,
            [followup.id]
          );
          sentCount++;
        }
      } catch (err) {
        console.error(`[PUSH] Error sending reminder for followup ${followup.id}:`, err.message);
      }
    }
    
    console.log(`[PUSH] Sent ${sentCount} follow-up reminders`);
    
    return {
      success: true,
      checked: result.rows.length,
      sent: sentCount
    };
  } catch (err) {
    console.error('[PUSH] Error in sendDueFollowupReminders:', err.message);
    throw err;
  }
}

/**
 * Check for overdue follow-ups and send alerts
 * This should be called from a cron job daily
 */
async function sendOverdueFollowupAlerts() {
  if (!initializeFCM()) {
    return { success: false, reason: 'fcm_not_initialized' };
  }
  
  try {
    // Get follow-ups that are overdue
    const query = `
      SELECT 
        c.id,
        c.conversation_id,
        c.customer_id,
        c.salesman_id,
        c.follow_up_at,
        c.follow_up_type,
        c.follow_up_priority,
        c.follow_up_note,
        cp.name as customer_name,
        cp.phone as customer_phone
      FROM conversations_new c
      LEFT JOIN customer_profiles_new cp ON cp.id = c.customer_id
      WHERE c.follow_up_at IS NOT NULL
        AND c.follow_up_at < NOW()
        AND c.follow_up_completed_at IS NULL
        AND c.salesman_id IS NOT NULL
        AND (c.follow_up_overdue_alert_sent_at IS NULL OR c.follow_up_overdue_alert_sent_at < NOW() - INTERVAL '24 hours')
      ORDER BY c.follow_up_at ASC
      LIMIT 100
    `;
    
    const result = await dbClient.query(query);
    
    console.log(`[PUSH] Found ${result.rows.length} overdue follow-ups`);
    
    let sentCount = 0;
    
    for (const followup of result.rows) {
      try {
        const notifResult = await sendOverdueFollowup(followup.salesman_id, followup);
        
        if (notifResult.success) {
          // Mark overdue alert as sent
          await dbClient.query(
            `UPDATE conversations_new SET follow_up_overdue_alert_sent_at = NOW() WHERE id = $1`,
            [followup.id]
          );
          sentCount++;
        }
      } catch (err) {
        console.error(`[PUSH] Error sending overdue alert for followup ${followup.id}:`, err.message);
      }
    }
    
    console.log(`[PUSH] Sent ${sentCount} overdue alerts`);
    
    return {
      success: true,
      checked: result.rows.length,
      sent: sentCount
    };
  } catch (err) {
    console.error('[PUSH] Error in sendOverdueFollowupAlerts:', err.message);
    throw err;
  }
}

module.exports = {
  registerDeviceToken,
  unregisterDeviceToken,
  sendToSalesman,
  sendFollowupReminder,
  sendOverdueFollowup,
  sendNewMessage,
  sendDueFollowupReminders,
  sendOverdueFollowupAlerts
};
