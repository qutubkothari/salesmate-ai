/**
 * Commission Service
 * Calculates and tracks salesman commissions, targets, and payouts
 */

const { dbClient } = require('./config');

/**
 * Calculate commission for a sale
 * @param {string} salesmanId - Salesman UUID
 * @param {string} tenantId - Tenant UUID
 * @param {number} saleAmount - Sale amount
 * @param {string} orderId - Order/invoice ID
 * @param {string} customerId - Customer UUID
 */
async function calculateCommission(salesmanId, tenantId, saleAmount, orderId, customerId = null) {
  try {
    // Get active commission rule for this salesman/tenant
    const ruleQuery = `
      SELECT id, rule_name, commission_type, base_percentage, fixed_amount, tiers
      FROM commission_rules
      WHERE tenant_id = $1 
        AND is_active = true
        AND (effective_from IS NULL OR effective_from <= CURRENT_DATE)
        AND (effective_to IS NULL OR effective_to >= CURRENT_DATE)
      ORDER BY created_at DESC
      LIMIT 1
    `;

    const ruleResult = await dbClient.query(ruleQuery, [tenantId]);

    let commissionRate = 5.0; // Default 5%
    let commissionAmount = 0;
    let ruleId = null;
    let ruleName = 'Default Rule';

    if (ruleResult.rows.length > 0) {
      const rule = ruleResult.rows[0];
      ruleId = rule.id;
      ruleName = rule.rule_name;

      if (rule.commission_type === 'percentage') {
        commissionRate = parseFloat(rule.base_percentage);
        commissionAmount = (saleAmount * commissionRate) / 100;
      } else if (rule.commission_type === 'fixed') {
        commissionAmount = parseFloat(rule.fixed_amount);
        commissionRate = (commissionAmount / saleAmount) * 100;
      } else if (rule.commission_type === 'tiered' && rule.tiers) {
        // Find applicable tier
        const tiers = Array.isArray(rule.tiers) ? rule.tiers : JSON.parse(rule.tiers);
        for (const tier of tiers) {
          if (saleAmount >= tier.min && (tier.max === null || saleAmount < tier.max)) {
            commissionRate = parseFloat(tier.rate);
            commissionAmount = (saleAmount * commissionRate) / 100;
            break;
          }
        }
      }
    } else {
      // Use default commission from salesman record
      const salesmanQuery = `
        SELECT commission_percentage
        FROM salesmen
        WHERE id = $1
      `;
      const salesmanResult = await dbClient.query(salesmanQuery, [salesmanId]);
      
      if (salesmanResult.rows.length > 0 && salesmanResult.rows[0].commission_percentage) {
        commissionRate = parseFloat(salesmanResult.rows[0].commission_percentage);
        commissionAmount = (saleAmount * commissionRate) / 100;
      } else {
        commissionAmount = (saleAmount * 5.0) / 100;
      }
    }

    // Create commission transaction
    const transactionQuery = `
      INSERT INTO commission_transactions (
        salesman_id, tenant_id, order_id, customer_id,
        sale_amount, commission_rate, commission_amount,
        rule_id, rule_name, transaction_date
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, CURRENT_DATE)
      RETURNING id, commission_amount
    `;

    const transactionResult = await dbClient.query(transactionQuery, [
      salesmanId,
      tenantId,
      orderId,
      customerId,
      saleAmount,
      commissionRate,
      commissionAmount,
      ruleId,
      ruleName
    ]);

    // Update salesman's pending commission
    await dbClient.query(
      `UPDATE salesmen 
       SET pending_commission = pending_commission + $1,
           total_earnings = total_earnings + $1
       WHERE id = $2`,
      [commissionAmount, salesmanId]
    );

    console.log(`[COMMISSION] Calculated ${commissionAmount} for salesman ${salesmanId} on sale ${saleAmount}`);

    return {
      success: true,
      transactionId: transactionResult.rows[0].id,
      commissionAmount,
      commissionRate,
      saleAmount
    };
  } catch (err) {
    console.error('[COMMISSION] Error calculating commission:', err.message);
    throw err;
  }
}

/**
 * Get commission summary for a salesman
 * @param {string} salesmanId - Salesman UUID
 * @param {Date} startDate - Start date
 * @param {Date} endDate - End date
 */
async function getCommissionSummary(salesmanId, startDate, endDate) {
  try {
    const query = `
      SELECT 
        COUNT(*) as transaction_count,
        SUM(sale_amount) as total_sales,
        SUM(commission_amount) as total_commission,
        AVG(commission_rate) as avg_commission_rate,
        SUM(CASE WHEN payout_status = 'pending' THEN commission_amount ELSE 0 END) as pending_commission,
        SUM(CASE WHEN payout_status = 'paid' THEN commission_amount ELSE 0 END) as paid_commission
      FROM commission_transactions
      WHERE salesman_id = $1
        AND transaction_date >= $2
        AND transaction_date <= $3
    `;

    const result = await dbClient.query(query, [salesmanId, startDate, endDate]);

    return {
      success: true,
      summary: result.rows[0]
    };
  } catch (err) {
    console.error('[COMMISSION] Error getting summary:', err.message);
    throw err;
  }
}

/**
 * Get commission transactions for a salesman
 * @param {string} salesmanId - Salesman UUID
 * @param {number} limit - Number of transactions to return
 */
async function getTransactions(salesmanId, limit = 50) {
  try {
    const query = `
      SELECT 
        ct.id,
        ct.order_id,
        ct.sale_amount,
        ct.commission_rate,
        ct.commission_amount,
        ct.transaction_date,
        ct.transaction_type,
        ct.payout_status,
        ct.rule_name,
        cp.name as customer_name,
        cp.phone as customer_phone
      FROM commission_transactions ct
      LEFT JOIN customer_profiles_new cp ON cp.id = ct.customer_id
      WHERE ct.salesman_id = $1
      ORDER BY ct.transaction_date DESC, ct.created_at DESC
      LIMIT $2
    `;

    const result = await dbClient.query(query, [salesmanId, limit]);

    return {
      success: true,
      transactions: result.rows
    };
  } catch (err) {
    console.error('[COMMISSION] Error getting transactions:', err.message);
    throw err;
  }
}

/**
 * Create or update salesman target
 * @param {string} salesmanId - Salesman UUID
 * @param {string} tenantId - Tenant UUID
 * @param {object} targetData - Target data
 */
async function setTarget(salesmanId, tenantId, targetData) {
  try {
    const {
      targetPeriod,
      periodStart,
      periodEnd,
      salesTargetAmount,
      ordersTargetCount,
      customersTargetCount,
      bonusPercentage,
      bonusAmount
    } = targetData;

    const query = `
      INSERT INTO salesman_targets (
        salesman_id, tenant_id, target_period, period_start, period_end,
        sales_target_amount, orders_target_count, customers_target_count,
        bonus_percentage, bonus_amount
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      ON CONFLICT (salesman_id, target_period, period_start)
      DO UPDATE SET
        period_end = EXCLUDED.period_end,
        sales_target_amount = EXCLUDED.sales_target_amount,
        orders_target_count = EXCLUDED.orders_target_count,
        customers_target_count = EXCLUDED.customers_target_count,
        bonus_percentage = EXCLUDED.bonus_percentage,
        bonus_amount = EXCLUDED.bonus_amount,
        updated_at = NOW()
      RETURNING id
    `;

    const result = await dbClient.query(query, [
      salesmanId,
      tenantId,
      targetPeriod,
      periodStart,
      periodEnd,
      salesTargetAmount,
      ordersTargetCount,
      customersTargetCount,
      bonusPercentage,
      bonusAmount
    ]);

    return {
      success: true,
      targetId: result.rows[0].id
    };
  } catch (err) {
    console.error('[COMMISSION] Error setting target:', err.message);
    throw err;
  }
}

/**
 * Get active targets for a salesman
 * @param {string} salesmanId - Salesman UUID
 */
async function getTargets(salesmanId) {
  try {
    const query = `
      SELECT 
        id,
        target_period,
        period_start,
        period_end,
        sales_target_amount,
        orders_target_count,
        customers_target_count,
        bonus_percentage,
        bonus_amount,
        status
      FROM salesman_targets
      WHERE salesman_id = $1
        AND status = 'active'
        AND period_end >= CURRENT_DATE
      ORDER BY period_start DESC
    `;

    const result = await dbClient.query(query, [salesmanId]);

    return {
      success: true,
      targets: result.rows
    };
  } catch (err) {
    console.error('[COMMISSION] Error getting targets:', err.message);
    throw err;
  }
}

/**
 * Calculate target achievement
 * @param {string} salesmanId - Salesman UUID
 * @param {string} targetId - Target UUID
 */
async function getTargetAchievement(salesmanId, targetId) {
  try {
    // Get target details
    const targetQuery = `
      SELECT * FROM salesman_targets
      WHERE id = $1 AND salesman_id = $2
    `;
    const targetResult = await dbClient.query(targetQuery, [targetId, salesmanId]);

    if (targetResult.rows.length === 0) {
      throw new Error('Target not found');
    }

    const target = targetResult.rows[0];

    // Get actual sales in period
    const salesQuery = `
      SELECT 
        COALESCE(SUM(sale_amount), 0) as total_sales,
        COUNT(DISTINCT order_id) as total_orders,
        COUNT(DISTINCT customer_id) as total_customers
      FROM commission_transactions
      WHERE salesman_id = $1
        AND transaction_date >= $2
        AND transaction_date <= $3
        AND transaction_type = 'sale'
    `;

    const salesResult = await dbClient.query(salesQuery, [
      salesmanId,
      target.period_start,
      target.period_end
    ]);

    const actual = salesResult.rows[0];
    const salesAchievement = (parseFloat(actual.total_sales) / parseFloat(target.sales_target_amount)) * 100;

    return {
      success: true,
      target: {
        salesTarget: parseFloat(target.sales_target_amount),
        ordersTarget: target.orders_target_count,
        customersTarget: target.customers_target_count
      },
      actual: {
        totalSales: parseFloat(actual.total_sales),
        totalOrders: parseInt(actual.total_orders),
        totalCustomers: parseInt(actual.total_customers)
      },
      achievement: {
        salesPercentage: Math.round(salesAchievement * 10) / 10,
        ordersPercentage: target.orders_target_count 
          ? Math.round((parseInt(actual.total_orders) / target.orders_target_count) * 1000) / 10
          : null,
        customersPercentage: target.customers_target_count
          ? Math.round((parseInt(actual.total_customers) / target.customers_target_count) * 1000) / 10
          : null
      },
      bonusEligible: salesAchievement >= 100
    };
  } catch (err) {
    console.error('[COMMISSION] Error calculating achievement:', err.message);
    throw err;
  }
}

/**
 * Create payout batch for a salesman
 * @param {string} salesmanId - Salesman UUID
 * @param {string} tenantId - Tenant UUID
 * @param {Date} periodStart - Period start date
 * @param {Date} periodEnd - Period end date
 */
async function createPayout(salesmanId, tenantId, periodStart, periodEnd) {
  try {
    // Get pending transactions
    const transactionsQuery = `
      SELECT id, commission_amount, transaction_type
      FROM commission_transactions
      WHERE salesman_id = $1
        AND payout_status = 'pending'
        AND transaction_date >= $2
        AND transaction_date <= $3
    `;

    const transactionsResult = await dbClient.query(transactionsQuery, [
      salesmanId,
      periodStart,
      periodEnd
    ]);

    if (transactionsResult.rows.length === 0) {
      throw new Error('No pending transactions for this period');
    }

    const totalCommission = transactionsResult.rows.reduce(
      (sum, t) => sum + parseFloat(t.commission_amount),
      0
    );

    // Get adjustments
    const adjustmentsQuery = `
      SELECT adjustment_type, amount
      FROM commission_adjustments
      WHERE salesman_id = $1
        AND adjustment_date >= $2
        AND adjustment_date <= $3
        AND payout_id IS NULL
    `;

    const adjustmentsResult = await dbClient.query(adjustmentsQuery, [
      salesmanId,
      periodStart,
      periodEnd
    ]);

    let deductions = 0;
    let additions = 0;

    adjustmentsResult.rows.forEach(adj => {
      if (adj.adjustment_type === 'deduction') {
        deductions += parseFloat(adj.amount);
      } else {
        additions += parseFloat(adj.amount);
      }
    });

    const netPayout = totalCommission + additions - deductions;

    // Create payout record
    const payoutQuery = `
      INSERT INTO commission_payouts (
        salesman_id, tenant_id, period_start, period_end,
        total_commission, deductions, net_payout, transaction_count
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING id
    `;

    const payoutResult = await dbClient.query(payoutQuery, [
      salesmanId,
      tenantId,
      periodStart,
      periodEnd,
      totalCommission,
      deductions,
      netPayout,
      transactionsResult.rows.length
    ]);

    const payoutId = payoutResult.rows[0].id;

    // Update transactions with payout ID
    await dbClient.query(
      `UPDATE commission_transactions 
       SET payout_id = $1, payout_status = 'approved'
       WHERE id = ANY($2)`,
      [payoutId, transactionsResult.rows.map(t => t.id)]
    );

    // Update adjustments with payout ID
    await dbClient.query(
      `UPDATE commission_adjustments 
       SET payout_id = $1
       WHERE salesman_id = $2
         AND adjustment_date >= $3
         AND adjustment_date <= $4
         AND payout_id IS NULL`,
      [payoutId, salesmanId, periodStart, periodEnd]
    );

    return {
      success: true,
      payoutId,
      netPayout,
      transactionCount: transactionsResult.rows.length
    };
  } catch (err) {
    console.error('[COMMISSION] Error creating payout:', err.message);
    throw err;
  }
}

module.exports = {
  calculateCommission,
  getCommissionSummary,
  getTransactions,
  setTarget,
  getTargets,
  getTargetAchievement,
  createPayout
};
