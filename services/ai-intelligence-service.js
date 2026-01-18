/**
 * AI Intelligence Service
 * Predictive scoring, churn detection, recommendations, objection handling
 */

const { db } = require('./config');
const crypto = require('crypto');

class AIIntelligenceService {
  
  // ===== LEAD/DEAL SCORING =====
  
  /**
   * Calculate comprehensive lead/deal score using multiple factors
   */
  static calculateEntityScore(tenantId, entityType, entityId) {
    let entity;
    let factors = {};
    
    // Get entity data
    if (entityType === 'deal') {
      entity = db.prepare('SELECT * FROM deals WHERE id = ?').get(entityId);
      if (!entity) return null;
      
      // Deal scoring factors
      factors.dealValue = this._scoreDealValue(entity.deal_value);
      factors.stageProgress = this._scoreStageProgress(entity.stage_id);
      factors.activity = this._scoreActivity(entity.last_activity_date);
      factors.priority = this._scorePriority(entity.priority);
      factors.temperature = this._scoreTemperature(entity.temperature);
      factors.closeDate = this._scoreCloseDate(entity.expected_close_date);
      
    } else if (entityType === 'customer') {
      entity = db.prepare('SELECT * FROM customer_profiles_new WHERE id = ?').get(entityId);
      if (!entity) return null;
      
      // Customer scoring factors
      factors.orderHistory = this._scoreOrderHistory(entityId);
      factors.engagement = this._scoreEngagement(entityId);
      factors.lifetime_value = this._scoreLifetimeValue(entityId);
    }
    
    // Calculate weighted scores
    const conversionScore = Math.min(100, Math.round(
      (factors.dealValue || 0) * 0.25 +
      (factors.stageProgress || 0) * 0.20 +
      (factors.activity || 0) * 0.20 +
      (factors.priority || 0) * 0.15 +
      (factors.temperature || 0) * 0.15 +
      (factors.closeDate || 0) * 0.05
    ));
    
    const engagementScore = Math.min(100, Math.round(
      (factors.activity || 0) * 0.60 +
      (factors.temperature || 0) * 0.40
    ));
    
    const qualityScore = Math.min(100, Math.round(
      (factors.dealValue || 0) * 0.40 +
      (factors.stageProgress || 0) * 0.30 +
      (factors.priority || 0) * 0.30
    ));
    
    const urgencyScore = Math.min(100, Math.round(
      (factors.closeDate || 0) * 0.50 +
      (factors.temperature || 0) * 0.30 +
      (factors.priority || 0) * 0.20
    ));
    
    const compositeScore = Math.round(
      (conversionScore * 0.35) +
      (engagementScore * 0.25) +
      (qualityScore * 0.25) +
      (urgencyScore * 0.15)
    );
    
    // Determine tier
    let scoreTier = 'cold';
    if (compositeScore >= 75) scoreTier = 'hot';
    else if (compositeScore >= 50) scoreTier = 'warm';
    else if (compositeScore < 20) scoreTier = 'dead';
    
    // Save score
    const id = crypto.randomBytes(16).toString('hex');
    db.prepare(`
      INSERT INTO ai_lead_scores (
        id, tenant_id, entity_type, entity_id,
        conversion_score, engagement_score, quality_score, urgency_score,
        composite_score, score_tier, score_factors, confidence_level,
        expires_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now', '+7 days'))
    `).run(
      id, tenantId, entityType, entityId,
      conversionScore, engagementScore, qualityScore, urgencyScore,
      compositeScore, scoreTier, JSON.stringify(factors), 0.85
    );
    
    return {
      scoreId: id,
      compositeScore,
      scoreTier,
      scores: {
        conversion: conversionScore,
        engagement: engagementScore,
        quality: qualityScore,
        urgency: urgencyScore
      },
      factors
    };
  }
  
  // Scoring helper methods
  static _scoreDealValue(value) {
    if (!value) return 0;
    if (value >= 500000) return 100;
    if (value >= 250000) return 80;
    if (value >= 100000) return 60;
    if (value >= 50000) return 40;
    return 20;
  }
  
  static _scoreStageProgress(stageId) {
    const stage = db.prepare('SELECT probability FROM pipeline_stages WHERE id = ?').get(stageId);
    return stage ? stage.probability : 0;
  }
  
  static _scoreActivity(lastActivityDate) {
    if (!lastActivityDate) return 0;
    const daysSince = Math.floor((Date.now() - new Date(lastActivityDate)) / (1000 * 60 * 60 * 24));
    if (daysSince <= 1) return 100;
    if (daysSince <= 3) return 80;
    if (daysSince <= 7) return 60;
    if (daysSince <= 14) return 40;
    if (daysSince <= 30) return 20;
    return 0;
  }
  
  static _scorePriority(priority) {
    const map = { critical: 100, high: 75, medium: 50, low: 25 };
    return map[priority] || 50;
  }
  
  static _scoreTemperature(temp) {
    const map = { hot: 100, warm: 60, cold: 20 };
    return map[temp] || 50;
  }
  
  static _scoreCloseDate(closeDate) {
    if (!closeDate) return 0;
    const daysUntil = Math.floor((new Date(closeDate) - Date.now()) / (1000 * 60 * 60 * 24));
    if (daysUntil < 0) return 0; // Overdue
    if (daysUntil <= 7) return 100;
    if (daysUntil <= 14) return 80;
    if (daysUntil <= 30) return 60;
    if (daysUntil <= 60) return 40;
    return 20;
  }
  
  static _scoreOrderHistory(customerId) {
    const orders = db.prepare('SELECT COUNT(*) as count FROM orders_new WHERE customer_id = ?').get(customerId);
    const count = orders?.count || 0;
    return Math.min(100, count * 10);
  }
  
  static _scoreEngagement(customerId) {
    const messages = db.prepare(`
      SELECT COUNT(*) as count FROM chat_conversations 
      WHERE phone = (SELECT phone FROM customer_profiles_new WHERE id = ?)
      AND updated_at > datetime('now', '-30 days')
    `).get(customerId);
    return Math.min(100, (messages?.count || 0) * 5);
  }
  
  static _scoreLifetimeValue(customerId) {
    const value = db.prepare(`
      SELECT SUM(total_amount) as total FROM orders_new WHERE customer_id = ?
    `).get(customerId);
    return this._scoreDealValue(value?.total || 0);
  }
  
  // ===== CHURN PREDICTION =====
  
  /**
   * Predict customer churn risk
   */
  static predictChurn(tenantId, customerId) {
    const customer = db.prepare('SELECT * FROM customer_profiles_new WHERE id = ?').get(customerId);
    if (!customer) return null;
    
    // Calculate risk factors
    const inactivityDays = this._calculateInactivityDays(customerId);
    const decliningEngagement = this._detectDecliningEngagement(customerId);
    const supportIssues = this._countRecentSupportIssues(customerId);
    const paymentIssues = this._detectPaymentIssues(customerId);
    
    // Calculate churn risk score (0-100)
    let riskScore = 0;
    const riskFactors = {};
    
    if (inactivityDays > 90) {
      riskScore += 30;
      riskFactors.inactivity = 30;
    } else if (inactivityDays > 60) {
      riskScore += 20;
      riskFactors.inactivity = 20;
    } else if (inactivityDays > 30) {
      riskScore += 10;
      riskFactors.inactivity = 10;
    }
    
    if (decliningEngagement) {
      riskScore += 25;
      riskFactors.declining_engagement = 25;
    }
    
    if (supportIssues > 5) {
      riskScore += 20;
      riskFactors.support_issues = 20;
    } else if (supportIssues > 2) {
      riskScore += 10;
      riskFactors.support_issues = 10;
    }
    
    if (paymentIssues) {
      riskScore += 25;
      riskFactors.payment_issues = 25;
    }
    
    const churnProbability = Math.min(1.0, riskScore / 100);
    
    let riskLevel = 'low';
    if (riskScore >= 75) riskLevel = 'critical';
    else if (riskScore >= 50) riskLevel = 'high';
    else if (riskScore >= 25) riskLevel = 'medium';
    
    // Generate prevention strategy
    const strategy = this._generateChurnPreventionStrategy(riskFactors);
    
    // Save prediction
    const id = crypto.randomBytes(16).toString('hex');
    db.prepare(`
      INSERT INTO ai_churn_predictions (
        id, tenant_id, customer_id, churn_risk_score, churn_probability,
        risk_level, inactivity_days, declining_engagement, support_issues_count,
        payment_issues, risk_factors, prevention_strategy,
        predicted_churn_date, confidence_level
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now', '+90 days'), 0.78)
    `).run(
      id, tenantId, customerId, riskScore, churnProbability,
      riskLevel, inactivityDays, decliningEngagement ? 1 : 0, supportIssues,
      paymentIssues ? 1 : 0, JSON.stringify(riskFactors), JSON.stringify(strategy)
    );
    
    return {
      predictionId: id,
      riskScore,
      riskLevel,
      churnProbability: (churnProbability * 100).toFixed(1) + '%',
      riskFactors,
      preventionStrategy: strategy
    };
  }
  
  static _calculateInactivityDays(customerId) {
    const lastOrder = db.prepare(`
      SELECT MAX(created_at) as last_order FROM orders_new WHERE customer_id = ?
    `).get(customerId);
    
    if (!lastOrder?.last_order) return 999;
    return Math.floor((Date.now() - new Date(lastOrder.last_order)) / (1000 * 60 * 60 * 24));
  }
  
  static _detectDecliningEngagement(customerId) {
    // Compare last 30 days vs previous 30 days
    const recent = db.prepare(`
      SELECT COUNT(*) as count FROM chat_conversations
      WHERE phone = (SELECT phone FROM customer_profiles_new WHERE id = ?)
      AND updated_at > datetime('now', '-30 days')
    `).get(customerId);
    
    const previous = db.prepare(`
      SELECT COUNT(*) as count FROM chat_conversations
      WHERE phone = (SELECT phone FROM customer_profiles_new WHERE id = ?)
      AND updated_at BETWEEN datetime('now', '-60 days') AND datetime('now', '-30 days')
    `).get(customerId);
    
    return (previous?.count || 0) > (recent?.count || 0) * 1.5;
  }
  
  static _countRecentSupportIssues(customerId) {
    // Count negative sentiment conversations in last 60 days
    const issues = db.prepare(`
      SELECT COUNT(*) as count FROM ai_sentiment_analysis
      WHERE customer_id = ? AND overall_sentiment < 0
      AND analyzed_at > datetime('now', '-60 days')
    `).get(customerId);
    return issues?.count || 0;
  }
  
  static _detectPaymentIssues(customerId) {
    // Check for failed/pending payments (placeholder - would integrate with payment system)
    return false;
  }
  
  static _generateChurnPreventionStrategy(riskFactors) {
    const strategy = [];
    
    if (riskFactors.inactivity) {
      strategy.push({
        action: 'reach_out',
        priority: 'high',
        description: 'Immediate outreach with personalized offer or check-in call'
      });
    }
    
    if (riskFactors.declining_engagement) {
      strategy.push({
        action: 'engagement_campaign',
        priority: 'high',
        description: 'Launch re-engagement campaign with value-add content'
      });
    }
    
    if (riskFactors.support_issues) {
      strategy.push({
        action: 'support_review',
        priority: 'critical',
        description: 'Executive review of support issues and resolution plan'
      });
    }
    
    if (riskFactors.payment_issues) {
      strategy.push({
        action: 'billing_discussion',
        priority: 'critical',
        description: 'Discuss payment options and flexible terms'
      });
    }
    
    return strategy;
  }
  
  // ===== NEXT BEST ACTION RECOMMENDATIONS =====
  
  /**
   * Generate AI-powered recommendation for next action
   */
  static generateRecommendation(tenantId, entityType, entityId, userId) {
    let recommendations = [];
    
    if (entityType === 'deal') {
      const deal = db.prepare('SELECT * FROM deals WHERE id = ?').get(entityId);
      if (!deal) return null;
      
      // Analyze deal state and generate recommendations
      const daysSinceActivity = deal.last_activity_date
        ? Math.floor((Date.now() - new Date(deal.last_activity_date)) / (1000 * 60 * 60 * 24))
        : 999;
      
      if (daysSinceActivity > 7) {
        recommendations.push({
          type: 'follow_up',
          priority: daysSinceActivity > 14 ? 'critical' : 'high',
          title: 'Follow up on inactive deal',
          description: `No activity in ${daysSinceActivity} days. Reach out to re-engage.`,
          reasoning: 'Deals without activity for >7 days have 40% higher loss rate',
          expectedOutcome: 'Re-engage customer and move deal forward',
          successProbability: 0.65
        });
      }
      
      const stage = db.prepare('SELECT * FROM pipeline_stages WHERE id = ?').get(deal.stage_id);
      if (stage && stage.probability >= 40 && stage.probability < 100) {
        recommendations.push({
          type: 'send_proposal',
          priority: 'high',
          title: 'Send formal proposal',
          description: 'Deal is qualified and ready for proposal',
          reasoning: 'Deals at this stage with proposals close 55% faster',
          expectedOutcome: 'Accelerate deal closure',
          successProbability: 0.72
        });
      }
      
      if (deal.temperature === 'hot' && deal.deal_value > 100000) {
        recommendations.push({
          type: 'offer_discount',
          priority: 'medium',
          title: 'Consider strategic discount',
          description: 'High-value hot lead - limited time offer could close deal',
          reasoning: 'Hot leads respond well to urgency-based incentives',
          expectedOutcome: 'Close deal this week',
          successProbability: 0.68
        });
      }
    }
    
    // Save top recommendation
    if (recommendations.length > 0) {
      const topRec = recommendations[0];
      const id = crypto.randomBytes(16).toString('hex');
      
      db.prepare(`
        INSERT INTO ai_recommendations (
          id, tenant_id, entity_type, entity_id, user_id,
          recommendation_type, priority, action_title, action_description,
          reasoning, expected_outcome, success_probability,
          confidence_score, expires_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0.80, datetime('now', '+7 days'))
      `).run(
        id, tenantId, entityType, entityId, userId,
        topRec.type, topRec.priority, topRec.title, topRec.description,
        topRec.reasoning, topRec.expectedOutcome, topRec.successProbability
      );
      
      return { recommendationId: id, ...topRec };
    }
    
    return null;
  }
  
  // ===== DEAL RISK ANALYSIS =====
  
  /**
   * Analyze deal for risk factors
   */
  static analyzeDealRisk(tenantId, dealId) {
    const deal = db.prepare('SELECT * FROM deals WHERE id = ?').get(dealId);
    if (!deal) return null;
    
    let riskScore = 0;
    const risks = {};
    
    // Timing risk
    const daysInStage = this._calculateDaysInStage(dealId);
    if (daysInStage > 45) {
      risks.timing_risk = 40;
      riskScore += 40;
    } else if (daysInStage > 30) {
      risks.timing_risk = 25;
      riskScore += 25;
    }
    
    // Engagement risk
    const activityCount = db.prepare(`
      SELECT COUNT(*) as count FROM deal_activities
      WHERE deal_id = ? AND performed_at > datetime('now', '-14 days')
    `).get(dealId);
    
    if ((activityCount?.count || 0) < 2) {
      risks.engagement_risk = 35;
      riskScore += 35;
    }
    
    // Budget risk (based on discount requests)
    if (deal.discount_percentage > 15) {
      risks.budget_risk = 30;
      riskScore += 30;
    }
    
    // Cap at 100
    riskScore = Math.min(100, riskScore);
    
    let riskLevel = 'low';
    if (riskScore >= 70) riskLevel = 'critical';
    else if (riskScore >= 50) riskLevel = 'high';
    else if (riskScore >= 25) riskLevel = 'medium';
    
    const id = crypto.randomBytes(16).toString('hex');
    db.prepare(`
      INSERT INTO ai_deal_risks (
        id, tenant_id, deal_id, overall_risk_score, risk_level,
        timing_risk, engagement_risk, budget_risk,
        risk_breakdown, confidence_level
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0.75)
    `).run(
      id, tenantId, dealId, riskScore, riskLevel,
      risks.timing_risk || 0, risks.engagement_risk || 0, risks.budget_risk || 0,
      JSON.stringify(risks)
    );
    
    return {
      riskId: id,
      riskScore,
      riskLevel,
      risks
    };
  }
  
  static _calculateDaysInStage(dealId) {
    const lastChange = db.prepare(`
      SELECT MAX(changed_at) as last_change FROM deal_stage_history WHERE deal_id = ?
    `).get(dealId);
    
    if (!lastChange?.last_change) return 0;
    return Math.floor((Date.now() - new Date(lastChange.last_change)) / (1000 * 60 * 60 * 24));
  }
  
  // ===== SENTIMENT ANALYSIS =====
  
  /**
   * Analyze sentiment from text (rule-based for now, can integrate ML later)
   */
  static analyzeSentiment(tenantId, text, entityType, entityId, customerId, userId) {
    const lowerText = text.toLowerCase();
    
    // Simple keyword-based sentiment
    const positiveWords = ['great', 'excellent', 'good', 'happy', 'love', 'perfect', 'amazing', 'interested', 'yes'];
    const negativeWords = ['bad', 'poor', 'terrible', 'hate', 'no', 'problem', 'issue', 'disappointed', 'expensive'];
    
    let score = 0;
    positiveWords.forEach(word => {
      if (lowerText.includes(word)) score += 10;
    });
    negativeWords.forEach(word => {
      if (lowerText.includes(word)) score -= 15;
    });
    
    // Cap between -100 and 100
    score = Math.max(-100, Math.min(100, score));
    
    let label = 'neutral';
    if (score >= 40) label = 'very_positive';
    else if (score >= 15) label = 'positive';
    else if (score <= -40) label = 'very_negative';
    else if (score <= -15) label = 'negative';
    
    const id = crypto.randomBytes(16).toString('hex');
    db.prepare(`
      INSERT INTO ai_sentiment_analysis (
        id, tenant_id, entity_type, entity_id, customer_id, user_id,
        overall_sentiment, sentiment_label, analyzed_text_sample, confidence_score
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0.70)
    `).run(
      id, tenantId, entityType, entityId, customerId, userId,
      score, label, text.substring(0, 500)
    );
    
    return { sentimentId: id, score, label };
  }
}

module.exports = AIIntelligenceService;
