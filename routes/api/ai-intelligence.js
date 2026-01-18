/**
 * AI Intelligence API
 * Endpoints for predictive scoring, churn detection, recommendations, risk analysis
 */

const express = require('express');
const router = express.Router();
const { db } = require('../../services/config');
const AIIntelligenceService = require('../../services/ai-intelligence-service');

// ===== LEAD/DEAL SCORING =====

// Calculate score for entity
router.post('/score/:entityType/:entityId', (req, res) => {
  try {
    const { entityType, entityId } = req.params;
    const { tenantId } = req.body;

    const result = AIIntelligenceService.calculateEntityScore(tenantId, entityType, entityId);
    
    if (!result) {
      return res.status(404).json({ error: 'Entity not found' });
    }

    res.json({ success: true, ...result });
  } catch (error) {
    console.error('Calculate score error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get scores for tenant
router.get('/scores/:tenantId', (req, res) => {
  try {
    const { tenantId } = req.params;
    const { entityType, tier, limit } = req.query;

    let query = 'SELECT * FROM ai_lead_scores WHERE tenant_id = ?';
    const params = [tenantId];

    if (entityType) {
      query += ' AND entity_type = ?';
      params.push(entityType);
    }

    if (tier) {
      query += ' AND score_tier = ?';
      params.push(tier);
    }

    query += ' ORDER BY composite_score DESC';

    if (limit) {
      query += ' LIMIT ?';
      params.push(parseInt(limit));
    }

    const scores = db.prepare(query).all(...params);

    res.json({ scores });
  } catch (error) {
    console.error('Get scores error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get score for specific entity
router.get('/score/:entityType/:entityId', (req, res) => {
  try {
    const { entityType, entityId } = req.params;

    const score = db.prepare(`
      SELECT * FROM ai_lead_scores
      WHERE entity_type = ? AND entity_id = ?
      ORDER BY calculated_at DESC LIMIT 1
    `).get(entityType, entityId);

    if (!score) {
      return res.status(404).json({ error: 'No score found' });
    }

    res.json({ score });
  } catch (error) {
    console.error('Get score error:', error);
    res.status(500).json({ error: error.message });
  }
});

// ===== CHURN PREDICTION =====

// Predict churn for customer
router.post('/churn/predict/:customerId', (req, res) => {
  try {
    const { customerId } = req.params;
    const { tenantId } = req.body;

    const result = AIIntelligenceService.predictChurn(tenantId, customerId);
    
    if (!result) {
      return res.status(404).json({ error: 'Customer not found' });
    }

    res.json({ success: true, ...result });
  } catch (error) {
    console.error('Predict churn error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get churn predictions
router.get('/churn/:tenantId', (req, res) => {
  try {
    const { tenantId } = req.params;
    const { riskLevel, limit } = req.query;

    let query = `
      SELECT cp.*, c.business_name as customer_name, c.phone
      FROM ai_churn_predictions cp
      LEFT JOIN customer_profiles_new c ON cp.customer_id = c.id
      WHERE cp.tenant_id = ?
    `;
    const params = [tenantId];

    if (riskLevel) {
      query += ' AND cp.risk_level = ?';
      params.push(riskLevel);
    }

    query += ' ORDER BY cp.churn_risk_score DESC';

    if (limit) {
      query += ' LIMIT ?';
      params.push(parseInt(limit));
    }

    const predictions = db.prepare(query).all(...params);

    res.json({ predictions });
  } catch (error) {
    console.error('Get churn predictions error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Update churn outcome
router.post('/churn/:predictionId/outcome', (req, res) => {
  try {
    const { predictionId } = req.params;
    const { outcome, actualChurnDate, preventionActions } = req.body;

    db.prepare(`
      UPDATE ai_churn_predictions 
      SET outcome = ?, actual_churn_date = ?, prevention_actions_taken = ?
      WHERE id = ?
    `).run(outcome, actualChurnDate, JSON.stringify(preventionActions || []), predictionId);

    res.json({ success: true });
  } catch (error) {
    console.error('Update churn outcome error:', error);
    res.status(500).json({ error: error.message });
  }
});

// ===== RECOMMENDATIONS =====

// Generate recommendation
router.post('/recommend/:entityType/:entityId', (req, res) => {
  try {
    const { entityType, entityId } = req.params;
    const { tenantId, userId } = req.body;

    const result = AIIntelligenceService.generateRecommendation(tenantId, entityType, entityId, userId);
    
    if (!result) {
      return res.json({ success: true, message: 'No recommendations at this time' });
    }

    res.json({ success: true, recommendation: result });
  } catch (error) {
    console.error('Generate recommendation error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get recommendations for user
router.get('/recommendations/:tenantId/:userId', (req, res) => {
  try {
    const { tenantId, userId } = req.params;
    const { status, priority } = req.query;

    let query = `
      SELECT * FROM ai_recommendations
      WHERE tenant_id = ? AND user_id = ?
    `;
    const params = [tenantId, userId];

    if (status) {
      query += ' AND status = ?';
      params.push(status);
    }

    if (priority) {
      query += ' AND priority = ?';
      params.push(priority);
    }

    query += ' ORDER BY created_at DESC LIMIT 50';

    const recommendations = db.prepare(query).all(...params);

    res.json({ recommendations });
  } catch (error) {
    console.error('Get recommendations error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Update recommendation status
router.post('/recommendations/:recommendationId/status', (req, res) => {
  try {
    const { recommendationId } = req.params;
    const { status, outcome, outcomeSuccess, rejectionReason } = req.body;

    const updates = [];
    const values = [];

    updates.push('status = ?');
    values.push(status);

    if (status === 'accepted') {
      updates.push('accepted_at = ?');
      values.push(new Date().toISOString());
    } else if (status === 'completed') {
      updates.push('completed_at = ?');
      values.push(new Date().toISOString());
      if (outcome) {
        updates.push('actual_outcome = ?', 'outcome_success = ?');
        values.push(outcome, outcomeSuccess ? 1 : 0);
      }
    } else if (status === 'rejected') {
      updates.push('rejected_at = ?');
      values.push(new Date().toISOString());
      if (rejectionReason) {
        updates.push('rejection_reason = ?');
        values.push(rejectionReason);
      }
    }

    values.push(recommendationId);

    db.prepare(`
      UPDATE ai_recommendations SET ${updates.join(', ')} WHERE id = ?
    `).run(...values);

    res.json({ success: true });
  } catch (error) {
    console.error('Update recommendation status error:', error);
    res.status(500).json({ error: error.message });
  }
});

// ===== DEAL RISK ANALYSIS =====

// Analyze deal risk
router.post('/risk/deal/:dealId', (req, res) => {
  try {
    const { dealId } = req.params;
    const { tenantId } = req.body;

    const result = AIIntelligenceService.analyzeDealRisk(tenantId, dealId);
    
    if (!result) {
      return res.status(404).json({ error: 'Deal not found' });
    }

    res.json({ success: true, ...result });
  } catch (error) {
    console.error('Analyze deal risk error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get high-risk deals
router.get('/risk/:tenantId/deals', (req, res) => {
  try {
    const { tenantId } = req.params;
    const { riskLevel } = req.query;

    let query = `
      SELECT dr.*, d.deal_name, d.deal_value, d.owner_id
      FROM ai_deal_risks dr
      LEFT JOIN deals d ON dr.deal_id = d.id
      WHERE dr.tenant_id = ?
    `;
    const params = [tenantId];

    if (riskLevel) {
      query += ' AND dr.risk_level = ?';
      params.push(riskLevel);
    }

    query += ' ORDER BY dr.overall_risk_score DESC LIMIT 50';

    const risks = db.prepare(query).all(...params);

    res.json({ risks });
  } catch (error) {
    console.error('Get deal risks error:', error);
    res.status(500).json({ error: error.message });
  }
});

// ===== SENTIMENT ANALYSIS =====

// Analyze text sentiment
router.post('/sentiment/analyze', (req, res) => {
  try {
    const { tenantId, text, entityType, entityId, customerId, userId } = req.body;

    if (!text) {
      return res.status(400).json({ error: 'Text required' });
    }

    const result = AIIntelligenceService.analyzeSentiment(
      tenantId, text, entityType, entityId, customerId, userId
    );

    res.json({ success: true, ...result });
  } catch (error) {
    console.error('Analyze sentiment error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get sentiment history
router.get('/sentiment/:tenantId/customer/:customerId', (req, res) => {
  try {
    const { tenantId, customerId } = req.params;
    const { limit } = req.query;

    const query = `
      SELECT * FROM ai_sentiment_analysis
      WHERE tenant_id = ? AND customer_id = ?
      ORDER BY analyzed_at DESC
      LIMIT ?
    `;

    const sentiments = db.prepare(query).all(tenantId, customerId, parseInt(limit) || 50);

    // Calculate average
    const avg = sentiments.length > 0
      ? sentiments.reduce((sum, s) => sum + s.overall_sentiment, 0) / sentiments.length
      : 0;

    res.json({ 
      sentiments,
      summary: {
        count: sentiments.length,
        averageSentiment: Math.round(avg),
        trend: sentiments.length >= 2 ? (sentiments[0].overall_sentiment > sentiments[1].overall_sentiment ? 'improving' : 'declining') : 'stable'
      }
    });
  } catch (error) {
    console.error('Get sentiment history error:', error);
    res.status(500).json({ error: error.message });
  }
});

// ===== ANALYTICS & INSIGHTS =====

// Get AI dashboard summary
router.get('/dashboard/:tenantId', (req, res) => {
  try {
    const { tenantId } = req.params;

    // Hot leads
    const hotLeads = db.prepare(`
      SELECT COUNT(*) as count FROM ai_lead_scores
      WHERE tenant_id = ? AND score_tier = 'hot'
    `).get(tenantId);

    // High churn risk customers
    const churnRisk = db.prepare(`
      SELECT COUNT(*) as count FROM ai_churn_predictions
      WHERE tenant_id = ? AND risk_level IN ('critical', 'high')
    `).get(tenantId);

    // Pending recommendations
    const pendingRecs = db.prepare(`
      SELECT COUNT(*) as count FROM ai_recommendations
      WHERE tenant_id = ? AND status = 'pending'
    `).get(tenantId);

    // High-risk deals
    const riskDeals = db.prepare(`
      SELECT COUNT(*) as count FROM ai_deal_risks
      WHERE tenant_id = ? AND risk_level IN ('critical', 'high')
    `).get(tenantId);

    // Average sentiment
    const avgSentiment = db.prepare(`
      SELECT AVG(overall_sentiment) as avg FROM ai_sentiment_analysis
      WHERE tenant_id = ? AND analyzed_at > datetime('now', '-30 days')
    `).get(tenantId);

    res.json({
      hotLeads: hotLeads?.count || 0,
      churnRiskCustomers: churnRisk?.count || 0,
      pendingRecommendations: pendingRecs?.count || 0,
      highRiskDeals: riskDeals?.count || 0,
      averageSentiment: Math.round(avgSentiment?.avg || 0)
    });
  } catch (error) {
    console.error('Get AI dashboard error:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
