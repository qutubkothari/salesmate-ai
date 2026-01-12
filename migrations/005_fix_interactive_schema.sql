-- Migration 005: Fix interactive_messages table schema
-- Date: 2026-01-12

-- Add missing columns to interactive_messages table
ALTER TABLE interactive_messages ADD COLUMN type TEXT DEFAULT 'buttons';
ALTER TABLE interactive_messages ADD COLUMN body TEXT;
ALTER TABLE interactive_messages ADD COLUMN options TEXT;
ALTER TABLE interactive_messages ADD COLUMN recipient_count INTEGER DEFAULT 0;
ALTER TABLE interactive_messages ADD COLUMN response_count INTEGER DEFAULT 0;
ALTER TABLE interactive_messages ADD COLUMN status TEXT DEFAULT 'pending';
ALTER TABLE interactive_messages ADD COLUMN created_at TEXT DEFAULT CURRENT_TIMESTAMP;

-- Create missing index
CREATE INDEX IF NOT EXISTS idx_interactive_status ON interactive_messages(status);
