-- Migration: Add Desktop Agent Support
-- Date: 2025-11-20
-- Description: Add columns to track desktop agent status for hybrid architecture

-- Add desktop agent columns to tenants table
ALTER TABLE tenants 
ADD COLUMN IF NOT EXISTS desktop_agent_status TEXT DEFAULT 'offline',
ADD COLUMN IF NOT EXISTS desktop_agent_phone TEXT,
ADD COLUMN IF NOT EXISTS desktop_agent_device TEXT,
ADD COLUMN IF NOT EXISTS desktop_agent_last_seen TIMESTAMP;

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_tenants_agent_status ON tenants(desktop_agent_status);

-- Add comments
COMMENT ON COLUMN tenants.desktop_agent_status IS 'Status of desktop agent: online, offline';
COMMENT ON COLUMN tenants.desktop_agent_phone IS 'WhatsApp phone number connected via desktop agent';
COMMENT ON COLUMN tenants.desktop_agent_device IS 'Device name running the desktop agent';
COMMENT ON COLUMN tenants.desktop_agent_last_seen IS 'Last time desktop agent communicated with server';
