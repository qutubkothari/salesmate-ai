-- Push Notification System Tables
-- Stores device tokens and notification logs

-- Table: salesman_devices
-- Stores FCM device tokens for salesmen
CREATE TABLE IF NOT EXISTS salesman_devices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  device_token TEXT NOT NULL UNIQUE,
  platform TEXT NOT NULL CHECK (platform IN ('ios', 'android')),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW(),
  last_active_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for quick device lookup by salesman
CREATE INDEX IF NOT EXISTS idx_salesman_devices_salesman ON salesman_devices(salesman_id) WHERE is_active = true;

-- Index for tenant-level queries
CREATE INDEX IF NOT EXISTS idx_salesman_devices_tenant ON salesman_devices(tenant_id);

-- Table: notification_logs (optional, for tracking sent notifications)
CREATE TABLE IF NOT EXISTS notification_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  notification_type TEXT NOT NULL, -- 'followup_reminder', 'followup_overdue', 'new_message', etc.
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  data JSONB,
  sent_at TIMESTAMP DEFAULT NOW(),
  success BOOLEAN DEFAULT true,
  error_message TEXT
);

-- Index for notification history queries
CREATE INDEX IF NOT EXISTS idx_notification_logs_salesman ON notification_logs(salesman_id, sent_at DESC);

-- Add columns to conversations_new for tracking reminder sends
ALTER TABLE conversations_new 
ADD COLUMN IF NOT EXISTS follow_up_reminder_sent_at TIMESTAMP,
ADD COLUMN IF NOT EXISTS follow_up_overdue_alert_sent_at TIMESTAMP;

-- Index for finding follow-ups due for reminders
CREATE INDEX IF NOT EXISTS idx_conversations_followup_reminders 
ON conversations_new(follow_up_at) 
WHERE follow_up_at IS NOT NULL 
  AND follow_up_completed_at IS NULL
  AND salesman_id IS NOT NULL;

COMMENT ON TABLE salesman_devices IS 'FCM device tokens for push notifications to salesmen';
COMMENT ON TABLE notification_logs IS 'Log of all push notifications sent';
COMMENT ON COLUMN conversations_new.follow_up_reminder_sent_at IS 'Last time a reminder notification was sent for this follow-up';
COMMENT ON COLUMN conversations_new.follow_up_overdue_alert_sent_at IS 'Last time an overdue alert was sent for this follow-up';
