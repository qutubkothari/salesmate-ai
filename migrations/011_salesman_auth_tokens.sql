-- Salesman auth tokens (server-side sessions)
-- Adds hashed session tokens + expiry tracking to salesman_sessions.

ALTER TABLE salesman_sessions ADD COLUMN session_token_hash TEXT;
ALTER TABLE salesman_sessions ADD COLUMN session_expires_at TEXT;
ALTER TABLE salesman_sessions ADD COLUMN last_seen_at TEXT;
ALTER TABLE salesman_sessions ADD COLUMN revoked_at TEXT;

CREATE INDEX IF NOT EXISTS idx_sessions_token_hash ON salesman_sessions(session_token_hash);
