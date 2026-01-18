/**
 * Mobile App Service
 * Offline sync, push notifications, device management, data optimization
 */

const crypto = require('crypto');
const { db } = require('./config');

class MobileAppService {
  
  // ===== DEVICE MANAGEMENT =====
  
  /**
   * Register mobile device
   */
  static registerDevice(tenantId, userId, deviceData) {
    const {
      deviceUuid,
      deviceName,
      deviceModel,
      devicePlatform,
      platformVersion,
      appVersion,
      appBuildNumber,
      pushToken = null,
      timezone = 'UTC',
      supportsOffline = true,
      supportsBackgroundSync = true
    } = deviceData;
    
    // Check if device already exists
    const existing = db.prepare('SELECT * FROM mobile_devices WHERE device_uuid = ?').get(deviceUuid);
    
    if (existing) {
      // Update existing device
      db.prepare(`
        UPDATE mobile_devices 
        SET app_version = ?, app_build_number = ?, push_token = ?,
            platform_version = ?, timezone = ?, is_active = 1,
            last_online_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP
        WHERE device_uuid = ?
      `).run(appVersion, appBuildNumber, pushToken, platformVersion, timezone, deviceUuid);
      
      return { id: existing.id, deviceUuid, updated: true };
    } else {
      // Register new device
      const id = crypto.randomBytes(16).toString('hex');
      
      db.prepare(`
        INSERT INTO mobile_devices (
          id, tenant_id, user_id, device_uuid, device_name, device_model,
          device_platform, platform_version, app_version, app_build_number,
          push_token, timezone, supports_offline, supports_background_sync,
          last_online_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
      `).run(
        id, tenantId, userId, deviceUuid, deviceName, deviceModel,
        devicePlatform, platformVersion, appVersion, appBuildNumber,
        pushToken, timezone, supportsOffline ? 1 : 0, supportsBackgroundSync ? 1 : 0
      );
      
      return { id, deviceUuid, registered: true };
    }
  }
  
  /**
   * Update device status
   */
  static updateDeviceStatus(deviceId, statusData) {
    const {
      pushToken,
      lastLocation,
      networkType,
      storageAvailableMb,
      isActive
    } = statusData;
    
    const updates = [];
    const values = [];
    
    if (pushToken !== undefined) {
      updates.push('push_token = ?');
      values.push(pushToken);
    }
    if (lastLocation) {
      updates.push('last_location = ?');
      values.push(JSON.stringify(lastLocation));
    }
    if (networkType) {
      updates.push('network_type = ?');
      values.push(networkType);
    }
    if (storageAvailableMb !== undefined) {
      updates.push('storage_available_mb = ?');
      values.push(storageAvailableMb);
    }
    if (isActive !== undefined) {
      updates.push('is_active = ?');
      values.push(isActive ? 1 : 0);
    }
    
    updates.push('last_online_at = CURRENT_TIMESTAMP');
    updates.push('updated_at = CURRENT_TIMESTAMP');
    values.push(deviceId);
    
    db.prepare(`UPDATE mobile_devices SET ${updates.join(', ')} WHERE id = ?`).run(...values);
  }
  
  /**
   * Get user devices
   */
  static getUserDevices(userId, tenantId) {
    return db.prepare(`
      SELECT * FROM mobile_devices 
      WHERE user_id = ? AND tenant_id = ? AND is_active = 1
      ORDER BY last_online_at DESC
    `).all(userId, tenantId);
  }
  
  // ===== OFFLINE SYNC QUEUE =====
  
  /**
   * Queue offline operation
   */
  static queueOperation(deviceId, tenantId, userId, operationData) {
    const {
      operationType,
      entityType,
      entityId = null,
      data,
      priority = 5
    } = operationData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO offline_sync_queue (
        id, device_id, tenant_id, user_id, operation_type, entity_type,
        entity_id, operation_data, sync_priority
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, deviceId, tenantId, userId, operationType, entityType,
      entityId, JSON.stringify(data), priority
    );
    
    return { id, operationType, entityType, queuedAt: new Date().toISOString() };
  }
  
  /**
   * Get pending sync operations
   */
  static getPendingOperations(deviceId, limit = 50) {
    return db.prepare(`
      SELECT * FROM offline_sync_queue 
      WHERE device_id = ? AND sync_status IN ('pending', 'failed')
      ORDER BY sync_priority DESC, created_at ASC
      LIMIT ?
    `).all(deviceId, limit).map(op => ({
      ...op,
      operation_data: JSON.parse(op.operation_data)
    }));
  }
  
  /**
   * Process sync operation
   */
  static processSyncOperation(operationId, success, result = null) {
    const operation = db.prepare('SELECT * FROM offline_sync_queue WHERE id = ?').get(operationId);
    
    if (!operation) return null;
    
    if (success) {
      db.prepare(`
        UPDATE offline_sync_queue 
        SET sync_status = 'completed', synced_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `).run(operationId);
      
      return { operationId, status: 'completed' };
    } else {
      const retryCount = operation.retry_count + 1;
      const status = retryCount >= operation.max_retries ? 'failed' : 'pending';
      
      db.prepare(`
        UPDATE offline_sync_queue 
        SET sync_status = ?, retry_count = ?, last_retry_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `).run(status, retryCount, operationId);
      
      return { operationId, status, retryCount };
    }
  }
  
  /**
   * Detect and mark conflicts
   */
  static markConflict(operationId, serverVersion, conflictReason) {
    db.prepare(`
      UPDATE offline_sync_queue 
      SET conflict_detected = 1, conflict_reason = ?, server_version = ?, sync_status = 'conflict'
      WHERE id = ?
    `).run(conflictReason, serverVersion, operationId);
    
    return { operationId, conflictDetected: true, reason: conflictReason };
  }
  
  // ===== SYNC CHECKPOINTS =====
  
  /**
   * Update sync checkpoint
   */
  static updateCheckpoint(deviceId, tenantId, checkpointData) {
    const {
      entityType,
      lastSyncTimestamp,
      lastSyncRecordId = null,
      syncDirection,
      recordsSynced = 0,
      syncDurationMs = 0
    } = checkpointData;
    
    const existing = db.prepare(`
      SELECT * FROM sync_checkpoints 
      WHERE device_id = ? AND entity_type = ? AND sync_direction = ?
    `).get(deviceId, entityType, syncDirection);
    
    if (existing) {
      db.prepare(`
        UPDATE sync_checkpoints 
        SET last_sync_timestamp = ?, last_sync_record_id = ?, 
            records_synced = ?, sync_duration_ms = ?, updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `).run(lastSyncTimestamp, lastSyncRecordId, recordsSynced, syncDurationMs, existing.id);
    } else {
      const id = crypto.randomBytes(16).toString('hex');
      
      db.prepare(`
        INSERT INTO sync_checkpoints (
          id, device_id, tenant_id, entity_type, last_sync_timestamp,
          last_sync_record_id, sync_direction, records_synced, sync_duration_ms
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).run(
        id, deviceId, tenantId, entityType, lastSyncTimestamp,
        lastSyncRecordId, syncDirection, recordsSynced, syncDurationMs
      );
    }
    
    return { entityType, syncDirection, recordsSynced };
  }
  
  /**
   * Get sync checkpoint
   */
  static getCheckpoint(deviceId, entityType, syncDirection) {
    return db.prepare(`
      SELECT * FROM sync_checkpoints 
      WHERE device_id = ? AND entity_type = ? AND sync_direction = ?
    `).get(deviceId, entityType, syncDirection);
  }
  
  // ===== PUSH NOTIFICATIONS =====
  
  /**
   * Send push notification
   */
  static sendPushNotification(tenantId, notificationData) {
    const {
      targetType,
      targetId,
      title,
      body,
      icon = null,
      image = null,
      actionType = 'open_app',
      actionData = null,
      deepLink = null,
      priority = 'normal',
      scheduledFor = null,
      dataPayload = null,
      isSilent = false,
      channel = 'default',
      collapseKey = null,
      createdBy
    } = notificationData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO push_notifications (
        id, tenant_id, target_type, target_id, notification_title, notification_body,
        notification_icon, notification_image, action_type, action_data, deep_link,
        priority, scheduled_for, data_payload, is_silent, notification_channel,
        collapse_key, created_by
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, tenantId, targetType, targetId, title, body, icon, image, actionType,
      actionData ? JSON.stringify(actionData) : null, deepLink, priority, scheduledFor,
      dataPayload ? JSON.stringify(dataPayload) : null, isSilent ? 1 : 0,
      channel, collapseKey, createdBy
    );
    
    // Create delivery records for target devices
    const devices = this._getTargetDevices(targetType, targetId, tenantId);
    
    devices.forEach(device => {
      const deliveryId = crypto.randomBytes(16).toString('hex');
      db.prepare(`
        INSERT INTO push_notification_deliveries (
          id, notification_id, device_id
        ) VALUES (?, ?, ?)
      `).run(deliveryId, id, device.id);
    });
    
    return { id, notificationId: id, devicesTargeted: devices.length };
  }
  
  /**
   * Get target devices for notification
   */
  static _getTargetDevices(targetType, targetId, tenantId) {
    if (targetType === 'device') {
      return db.prepare('SELECT * FROM mobile_devices WHERE id = ? AND is_active = 1').all(targetId);
    } else if (targetType === 'user') {
      return db.prepare('SELECT * FROM mobile_devices WHERE user_id = ? AND tenant_id = ? AND is_active = 1 AND push_enabled = 1').all(targetId, tenantId);
    } else if (targetType === 'broadcast') {
      return db.prepare('SELECT * FROM mobile_devices WHERE tenant_id = ? AND is_active = 1 AND push_enabled = 1').all(tenantId);
    }
    return [];
  }
  
  /**
   * Update notification delivery status
   */
  static updateDeliveryStatus(deliveryId, status, errorMessage = null) {
    const updates = ['delivery_status = ?'];
    const values = [status];
    
    const timestampField = {
      sent: 'sent_at',
      delivered: 'delivered_at',
      clicked: 'clicked_at',
      failed: 'failed_at'
    }[status];
    
    if (timestampField) {
      updates.push(`${timestampField} = CURRENT_TIMESTAMP`);
    }
    
    if (status === 'failed' && errorMessage) {
      updates.push('error_message = ?');
      values.push(errorMessage);
    }
    
    values.push(deliveryId);
    
    db.prepare(`UPDATE push_notification_deliveries SET ${updates.join(', ')} WHERE id = ?`).run(...values);
    
    // Update parent notification status
    const delivery = db.prepare('SELECT notification_id FROM push_notification_deliveries WHERE id = ?').get(deliveryId);
    if (delivery) {
      db.prepare(`
        UPDATE push_notifications 
        SET delivery_status = ?, ${timestampField ? `${timestampField} = CURRENT_TIMESTAMP,` : ''} updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
      `).run(status, delivery.notification_id);
    }
  }
  
  // ===== MOBILE SESSIONS =====
  
  /**
   * Start mobile session
   */
  static startSession(deviceId, tenantId, userId, sessionData = {}) {
    const {
      networkType = 'unknown',
      batteryLevel = null,
      appVersion = null
    } = sessionData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO mobile_sessions (
        id, device_id, tenant_id, user_id, network_type, battery_level, app_version
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
    `).run(id, deviceId, tenantId, userId, networkType, batteryLevel, appVersion);
    
    return { id, sessionStart: new Date().toISOString() };
  }
  
  /**
   * End mobile session
   */
  static endSession(sessionId, sessionData = {}) {
    const session = db.prepare('SELECT * FROM mobile_sessions WHERE id = ?').get(sessionId);
    
    if (!session) return null;
    
    const sessionStart = new Date(session.session_start);
    const sessionEnd = new Date();
    const duration = Math.floor((sessionEnd - sessionStart) / 1000); // seconds
    
    db.prepare(`
      UPDATE mobile_sessions 
      SET session_end = ?, session_duration = ?,
          screens_viewed = ?, actions_performed = ?,
          data_synced_kb = ?, data_downloaded_kb = ?, data_uploaded_kb = ?,
          crash_occurred = ?, crash_log = ?
      WHERE id = ?
    `).run(
      sessionEnd.toISOString(), duration,
      sessionData.screensViewed ? JSON.stringify(sessionData.screensViewed) : null,
      sessionData.actionsPerformed ? JSON.stringify(sessionData.actionsPerformed) : null,
      sessionData.dataSyncedKb || 0,
      sessionData.dataDownloadedKb || 0,
      sessionData.dataUploadedKb || 0,
      sessionData.crashOccurred ? 1 : 0,
      sessionData.crashLog || null,
      sessionId
    );
    
    return { sessionId, duration, ended: true };
  }
  
  // ===== OFFLINE CACHE =====
  
  /**
   * Add to offline cache
   */
  static cacheEntity(deviceId, tenantId, cacheData) {
    const {
      entityType,
      entityId,
      cacheVersion,
      cacheSizeKb = 0,
      expiresAt = null,
      cachePriority = 'normal',
      autoRefresh = true
    } = cacheData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    // Upsert logic
    const existing = db.prepare(`
      SELECT * FROM offline_cache_manifest 
      WHERE device_id = ? AND entity_type = ? AND entity_id = ?
    `).get(deviceId, entityType, entityId);
    
    if (existing) {
      db.prepare(`
        UPDATE offline_cache_manifest 
        SET cache_version = ?, cache_size_kb = ?, cached_at = CURRENT_TIMESTAMP,
            expires_at = ?, is_stale = 0, last_accessed_at = CURRENT_TIMESTAMP,
            access_count = access_count + 1
        WHERE id = ?
      `).run(cacheVersion, cacheSizeKb, expiresAt, existing.id);
      
      return { id: existing.id, cached: true, updated: true };
    } else {
      db.prepare(`
        INSERT INTO offline_cache_manifest (
          id, device_id, tenant_id, entity_type, entity_id, cache_version,
          cache_size_kb, expires_at, cache_priority, auto_refresh
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `).run(
        id, deviceId, tenantId, entityType, entityId, cacheVersion,
        cacheSizeKb, expiresAt, cachePriority, autoRefresh ? 1 : 0
      );
      
      return { id, cached: true, created: true };
    }
  }
  
  /**
   * Get stale cache entries
   */
  static getStaleCacheEntries(deviceId) {
    return db.prepare(`
      SELECT * FROM offline_cache_manifest 
      WHERE device_id = ? AND (
        is_stale = 1 OR 
        (expires_at IS NOT NULL AND expires_at < datetime('now'))
      )
      ORDER BY cache_priority DESC
    `).all(deviceId);
  }
  
  /**
   * Mark cache as stale
   */
  static markCacheStale(deviceId, entityType, entityId = null) {
    if (entityId) {
      db.prepare(`
        UPDATE offline_cache_manifest 
        SET is_stale = 1 
        WHERE device_id = ? AND entity_type = ? AND entity_id = ?
      `).run(deviceId, entityType, entityId);
    } else {
      db.prepare(`
        UPDATE offline_cache_manifest 
        SET is_stale = 1 
        WHERE device_id = ? AND entity_type = ?
      `).run(deviceId, entityType);
    }
  }
  
  // ===== APP UPDATES =====
  
  /**
   * Check for app updates
   */
  static checkForUpdates(platform, currentVersion) {
    const update = db.prepare(`
      SELECT * FROM app_updates 
      WHERE platform IN (?, 'all') 
        AND release_status = 'released'
        AND version_number > ?
      ORDER BY created_at DESC 
      LIMIT 1
    `).get(platform, currentVersion);
    
    if (!update) return { updateAvailable: false };
    
    return {
      updateAvailable: true,
      update: {
        version: update.version_number,
        build: update.build_number,
        isMandatory: update.is_mandatory === 1,
        releaseNotes: update.release_notes,
        downloadUrl: update.download_url,
        fileSizeMb: update.file_size_mb
      }
    };
  }
  
  /**
   * Get feature flags for device
   */
  static getFeatureFlags(platform, appVersion, userId = null) {
    const flags = db.prepare(`
      SELECT * FROM mobile_feature_flags 
      WHERE is_enabled = 1 
        AND (platform = ? OR platform = 'all')
        AND (min_app_version IS NULL OR min_app_version <= ?)
        AND (expires_at IS NULL OR expires_at > datetime('now'))
    `).all(platform, appVersion);
    
    // Filter by rollout percentage (simple random)
    const activeFlags = flags.filter(flag => {
      if (flag.rollout_percentage === 100) return true;
      if (flag.rollout_percentage === 0) return false;
      // Simple random rollout (in production, use deterministic user-based rollout)
      return Math.random() * 100 < flag.rollout_percentage;
    });
    
    return activeFlags.reduce((acc, flag) => {
      acc[flag.feature_key] = {
        enabled: true,
        config: flag.feature_config ? JSON.parse(flag.feature_config) : null
      };
      return acc;
    }, {});
  }
  
  // ===== ANALYTICS =====
  
  /**
   * Track analytics event
   */
  static trackEvent(deviceId, tenantId, userId, eventData) {
    const {
      eventName,
      eventCategory = 'engagement',
      eventProperties = {},
      screenName = null,
      networkType = 'unknown',
      isOffline = false,
      eventDurationMs = null,
      sessionId = null
    } = eventData;
    
    const id = crypto.randomBytes(16).toString('hex');
    
    db.prepare(`
      INSERT INTO mobile_analytics_events (
        id, device_id, tenant_id, user_id, event_name, event_category,
        event_properties, screen_name, network_type, is_offline,
        event_duration_ms, session_id
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).run(
      id, deviceId, tenantId, userId, eventName, eventCategory,
      JSON.stringify(eventProperties), screenName, networkType, isOffline ? 1 : 0,
      eventDurationMs, sessionId
    );
    
    return { eventId: id, tracked: true };
  }
  
  /**
   * Get mobile analytics
   */
  static getMobileAnalytics(tenantId, startDate, endDate) {
    return {
      sessions: db.prepare(`
        SELECT 
          DATE(session_start) as date,
          COUNT(*) as session_count,
          AVG(session_duration) as avg_duration,
          SUM(data_synced_kb) as total_data_synced
        FROM mobile_sessions
        WHERE tenant_id = ? AND session_start BETWEEN ? AND ?
        GROUP BY DATE(session_start)
      `).all(tenantId, startDate, endDate),
      
      events: db.prepare(`
        SELECT 
          event_name,
          COUNT(*) as count
        FROM mobile_analytics_events
        WHERE tenant_id = ? AND timestamp BETWEEN ? AND ?
        GROUP BY event_name
        ORDER BY count DESC
        LIMIT 20
      `).all(tenantId, startDate, endDate),
      
      devices: db.prepare(`
        SELECT 
          device_platform,
          COUNT(*) as count
        FROM mobile_devices
        WHERE tenant_id = ? AND is_active = 1
        GROUP BY device_platform
      `).all(tenantId)
    };
  }
}

module.exports = MobileAppService;
