-- 20260127_tenant_media_assets.sql
-- Media library assets for WhatsApp sharing

CREATE TABLE IF NOT EXISTS tenant_media_assets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,
  title TEXT,
  description TEXT,
  category TEXT,
  asset_type TEXT,
  product_code TEXT,
  keywords TEXT,
  file_url TEXT NOT NULL,
  file_path TEXT NOT NULL,
  mime_type TEXT,
  size_bytes BIGINT,
  original_name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_tenant_media_assets_tenant ON tenant_media_assets(tenant_id);
CREATE INDEX IF NOT EXISTS idx_tenant_media_assets_category ON tenant_media_assets(category);
