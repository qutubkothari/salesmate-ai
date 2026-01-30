/**
 * Commission API
 * Manages salesman commissions, targets, and payouts
 */

const express = require('express');
const router = express.Router();
const { requireSalesmanAuth } = require('../../services/salesmanAuth');
const commissionService = require('../../services/commissionService');

/**
 * GET /api/commission/summary
 * Get commission summary for salesman
 */
router.get('/summary', requireSalesmanAuth, async (req, res) => {
  try {
    const { salesmanId } = req.salesmanAuth;
    const { startDate, endDate } = req.query;

    const start = startDate ? new Date(startDate) : new Date(new Date().getFullYear(), new Date().getMonth(), 1);
    const end = endDate ? new Date(endDate) : new Date();

    const result = await commissionService.getCommissionSummary(salesmanId, start, end);

    res.json(result);
  } catch (err) {
    console.error('[COMMISSION API] Summary error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

/**
 * GET /api/commission/transactions
 * Get commission transactions for salesman
 */
router.get('/transactions', requireSalesmanAuth, async (req, res) => {
  try {
    const { salesmanId } = req.salesmanAuth;
    const limit = req.query.limit ? parseInt(req.query.limit) : 50;

    const result = await commissionService.getTransactions(salesmanId, limit);

    res.json(result);
  } catch (err) {
    console.error('[COMMISSION API] Transactions error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

/**
 * GET /api/commission/targets
 * Get active targets for salesman
 */
router.get('/targets', requireSalesmanAuth, async (req, res) => {
  try {
    const { salesmanId } = req.salesmanAuth;

    const result = await commissionService.getTargets(salesmanId);

    res.json(result);
  } catch (err) {
    console.error('[COMMISSION API] Targets error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

/**
 * GET /api/commission/targets/:targetId/achievement
 * Get target achievement for a specific target
 */
router.get('/targets/:targetId/achievement', requireSalesmanAuth, async (req, res) => {
  try {
    const { salesmanId } = req.salesmanAuth;
    const { targetId } = req.params;

    const result = await commissionService.getTargetAchievement(salesmanId, targetId);

    res.json(result);
  } catch (err) {
    console.error('[COMMISSION API] Achievement error:', err);
    res.status(500).json({
      success: false,
      error: err.message
    });
  }
});

module.exports = router;
