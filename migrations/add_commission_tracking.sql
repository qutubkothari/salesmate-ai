-- Commission Tracking System
-- Tracks salesman commissions, targets, and payouts

-- Table: commission_rules
-- Define commission calculation rules per tenant
CREATE TABLE IF NOT EXISTS commission_rules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  rule_name TEXT NOT NULL,
  
  -- Commission calculation
  commission_type TEXT NOT NULL, -- 'percentage', 'fixed', 'tiered'
  base_percentage DECIMAL(5, 2), -- e.g., 5.50 for 5.5%
  fixed_amount DECIMAL(10, 2),
  
  -- Tiered commission structure (JSON)
  tiers JSONB, -- [{min: 0, max: 10000, rate: 5}, {min: 10000, max: 50000, rate: 7}, ...]
  
  -- Applicability
  applies_to TEXT DEFAULT 'all', -- 'all', 'specific_products', 'specific_categories'
  product_ids TEXT[], -- Array of product IDs if applies_to = 'specific_products'
  category_ids TEXT[], -- Array of category IDs
  
  -- Validity
  effective_from DATE,
  effective_to DATE,
  is_active BOOLEAN DEFAULT true,
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for active rules
CREATE INDEX IF NOT EXISTS idx_commission_rules_tenant 
ON commission_rules(tenant_id) 
WHERE is_active = true;

-- Table: salesman_targets
-- Monthly/quarterly sales targets for salesmen
CREATE TABLE IF NOT EXISTS salesman_targets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  
  -- Target period
  target_period TEXT NOT NULL, -- 'monthly', 'quarterly', 'annual'
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  
  -- Targets
  sales_target_amount DECIMAL(12, 2) NOT NULL,
  orders_target_count INTEGER,
  customers_target_count INTEGER,
  
  -- Achievement bonuses
  bonus_percentage DECIMAL(5, 2), -- Extra commission if target met
  bonus_amount DECIMAL(10, 2), -- Fixed bonus if target met
  
  -- Status
  status TEXT DEFAULT 'active', -- 'active', 'completed', 'missed'
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for active targets
CREATE INDEX IF NOT EXISTS idx_salesman_targets_salesman 
ON salesman_targets(salesman_id, period_start DESC);

-- Unique constraint: one target per salesman per period
CREATE UNIQUE INDEX IF NOT EXISTS idx_salesman_targets_unique 
ON salesman_targets(salesman_id, target_period, period_start);

-- Table: commission_transactions
-- Individual commission transactions for each sale
CREATE TABLE IF NOT EXISTS commission_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  
  -- Source transaction
  order_id TEXT, -- Reference to order/invoice
  conversation_id UUID REFERENCES conversations_new(id) ON DELETE SET NULL,
  customer_id UUID REFERENCES customer_profiles_new(id) ON DELETE SET NULL,
  
  -- Transaction details
  sale_amount DECIMAL(12, 2) NOT NULL,
  commission_rate DECIMAL(5, 2) NOT NULL,
  commission_amount DECIMAL(10, 2) NOT NULL,
  
  -- Commission rule applied
  rule_id UUID REFERENCES commission_rules(id) ON DELETE SET NULL,
  rule_name TEXT,
  
  -- Transaction metadata
  transaction_date DATE NOT NULL,
  transaction_type TEXT DEFAULT 'sale', -- 'sale', 'bonus', 'adjustment', 'clawback'
  description TEXT,
  
  -- Payout tracking
  payout_status TEXT DEFAULT 'pending', -- 'pending', 'approved', 'paid', 'disputed'
  payout_id UUID, -- Links to payout batch
  paid_at TIMESTAMP,
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for salesman transactions
CREATE INDEX IF NOT EXISTS idx_commission_transactions_salesman 
ON commission_transactions(salesman_id, transaction_date DESC);

-- Index for pending payouts
CREATE INDEX IF NOT EXISTS idx_commission_transactions_payout 
ON commission_transactions(payout_status, salesman_id) 
WHERE payout_status = 'pending';

-- Table: commission_payouts
-- Batch payouts to salesmen
CREATE TABLE IF NOT EXISTS commission_payouts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  
  -- Payout period
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  
  -- Payout details
  total_commission DECIMAL(12, 2) NOT NULL,
  total_bonus DECIMAL(10, 2) DEFAULT 0,
  deductions DECIMAL(10, 2) DEFAULT 0,
  net_payout DECIMAL(12, 2) NOT NULL,
  
  -- Transaction count
  transaction_count INTEGER DEFAULT 0,
  
  -- Payment details
  payment_method TEXT, -- 'bank_transfer', 'cash', 'cheque', 'upi'
  payment_reference TEXT,
  payment_notes TEXT,
  
  -- Status
  status TEXT DEFAULT 'pending', -- 'pending', 'approved', 'paid', 'cancelled'
  approved_by UUID REFERENCES users(id),
  approved_at TIMESTAMP,
  paid_at TIMESTAMP,
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for salesman payouts
CREATE INDEX IF NOT EXISTS idx_commission_payouts_salesman 
ON commission_payouts(salesman_id, created_at DESC);

-- Index for pending approvals
CREATE INDEX IF NOT EXISTS idx_commission_payouts_pending 
ON commission_payouts(tenant_id, status) 
WHERE status = 'pending';

-- Table: commission_adjustments
-- Manual adjustments to commissions
CREATE TABLE IF NOT EXISTS commission_adjustments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  salesman_id UUID NOT NULL REFERENCES salesmen(id) ON DELETE CASCADE,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  
  adjustment_type TEXT NOT NULL, -- 'addition', 'deduction'
  amount DECIMAL(10, 2) NOT NULL,
  reason TEXT NOT NULL,
  
  adjusted_by UUID REFERENCES users(id),
  adjustment_date DATE DEFAULT CURRENT_DATE,
  
  -- Link to payout if already applied
  payout_id UUID REFERENCES commission_payouts(id) ON DELETE SET NULL,
  
  created_at TIMESTAMP DEFAULT NOW()
);

-- Index for salesman adjustments
CREATE INDEX IF NOT EXISTS idx_commission_adjustments_salesman 
ON commission_adjustments(salesman_id, adjustment_date DESC);

-- Add commission columns to salesmen table (if not exists)
ALTER TABLE salesmen
ADD COLUMN IF NOT EXISTS commission_percentage DECIMAL(5, 2) DEFAULT 5.00,
ADD COLUMN IF NOT EXISTS total_earnings DECIMAL(12, 2) DEFAULT 0.00,
ADD COLUMN IF NOT EXISTS pending_commission DECIMAL(12, 2) DEFAULT 0.00,
ADD COLUMN IF NOT EXISTS paid_commission DECIMAL(12, 2) DEFAULT 0.00;

-- Comments
COMMENT ON TABLE commission_rules IS 'Commission calculation rules for tenant';
COMMENT ON TABLE salesman_targets IS 'Sales targets and bonuses for salesmen';
COMMENT ON TABLE commission_transactions IS 'Individual commission transactions per sale';
COMMENT ON TABLE commission_payouts IS 'Batch commission payouts to salesmen';
COMMENT ON TABLE commission_adjustments IS 'Manual commission adjustments';
