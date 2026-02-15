const express = require('express');
const router = express.Router();

const { dbClient: supabase } = require('../../../services/config');
const { requireCrmAuth, requireRole } = require('../../../middleware/crmAuth');
const { requireCrmFeature } = require('../../../middleware/requireCrmFeature');
const { CRM_FEATURES } = require('../../../services/crmFeatureFlags');

/**
 * GET /api/crm/analytics/conversion-funnel
 * Get conversion funnel metrics by channel/source
 */
router.get('/conversion-funnel', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { startDate, endDate, channel } = req.query;

    let query = supabase
      .from('crm_leads')
      .select('id, channel, status, heat, created_at')
      .eq('tenant_id', req.user.tenantId);

    if (startDate) query = query.gte('created_at', startDate);
    if (endDate) query = query.lte('created_at', endDate);
    if (channel) query = query.eq('channel', channel.toUpperCase());

    const { data: leads, error } = await query;
    if (error) throw error;

    // Calculate funnel metrics
    const funnel = {
      total: leads.length,
      byStatus: {},
      byChannel: {},
      byHeat: {},
      conversionRates: {}
    };

    // Group by status
    leads.forEach(lead => {
      funnel.byStatus[lead.status] = (funnel.byStatus[lead.status] || 0) + 1;
      funnel.byChannel[lead.channel] = (funnel.byChannel[lead.channel] || 0) + 1;
      funnel.byHeat[lead.heat] = (funnel.byHeat[lead.heat] || 0) + 1;
    });

    // Calculate conversion rates
    const statusOrder = ['NEW', 'CONTACTED', 'QUALIFIED', 'PROPOSAL', 'NEGOTIATION', 'WON', 'LOST'];
    statusOrder.forEach((status, index) => {
      if (index === 0) {
        funnel.conversionRates[status] = 100;
      } else {
        const prevCount = funnel.byStatus[statusOrder[index - 1]] || 0;
        const currentCount = funnel.byStatus[status] || 0;
        funnel.conversionRates[status] = prevCount > 0 ? ((currentCount / prevCount) * 100).toFixed(2) : 0;
      }
    });

    // Overall conversion rate (WON / TOTAL)
    funnel.overallConversionRate = funnel.total > 0 
      ? (((funnel.byStatus['WON'] || 0) / funnel.total) * 100).toFixed(2)
      : 0;

    return res.json({ success: true, funnel });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'funnel_failed', details: e?.message || String(e) });
  }
});

/**
 * GET /api/crm/analytics/source-performance
 * Get performance metrics by lead source/channel
 */
router.get('/source-performance', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { startDate, endDate } = req.query;

    let query = supabase
      .from('crm_leads')
      .select('id, channel, status, score, heat, created_at')
      .eq('tenant_id', req.user.tenantId);

    if (startDate) query = query.gte('created_at', startDate);
    if (endDate) query = query.lte('created_at', endDate);

    const { data: leads, error } = await query;
    if (error) throw error;

    // Group by channel
    const sourceMetrics = {};

    leads.forEach(lead => {
      const channel = lead.channel || 'UNKNOWN';
      
      if (!sourceMetrics[channel]) {
        sourceMetrics[channel] = {
          total: 0,
          won: 0,
          lost: 0,
          active: 0,
          avgScore: 0,
          totalScore: 0,
          hot: 0,
          warm: 0,
          cold: 0
        };
      }

      const metrics = sourceMetrics[channel];
      metrics.total++;
      metrics.totalScore += lead.score || 0;

      if (lead.status === 'WON') metrics.won++;
      else if (lead.status === 'LOST') metrics.lost++;
      else metrics.active++;

      if (lead.heat === 'HOT' || lead.heat === 'ON_FIRE') metrics.hot++;
      else if (lead.heat === 'WARM') metrics.warm++;
      else metrics.cold++;
    });

    // Calculate averages and rates
    Object.keys(sourceMetrics).forEach(channel => {
      const metrics = sourceMetrics[channel];
      metrics.avgScore = metrics.total > 0 ? (metrics.totalScore / metrics.total).toFixed(1) : 0;
      metrics.conversionRate = metrics.total > 0 ? ((metrics.won / metrics.total) * 100).toFixed(2) : 0;
      metrics.lossRate = metrics.total > 0 ? ((metrics.lost / metrics.total) * 100).toFixed(2) : 0;
      metrics.hotRate = metrics.total > 0 ? ((metrics.hot / metrics.total) * 100).toFixed(2) : 0;
      delete metrics.totalScore; // Remove intermediate calculation
    });

    return res.json({ success: true, sources: sourceMetrics });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'source_analytics_failed', details: e?.message || String(e) });
  }
});

/**
 * GET /api/crm/analytics/time-to-conversion
 * Get time-to-conversion metrics
 */
router.get('/time-to-conversion', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { startDate, endDate, channel } = req.query;

    let query = supabase
      .from('crm_leads')
      .select('id, channel, status, created_at, updated_at')
      .eq('tenant_id', req.user.tenantId)
      .eq('status', 'WON');

    if (startDate) query = query.gte('created_at', startDate);
    if (endDate) query = query.lte('created_at', endDate);
    if (channel) query = query.eq('channel', channel.toUpperCase());

    const { data: wonLeads, error } = await query;
    if (error) throw error;

    const conversionTimes = [];
    const byChannel = {};

    wonLeads.forEach(lead => {
      const createdAt = new Date(lead.created_at);
      const updatedAt = new Date(lead.updated_at);
      const daysToConvert = Math.ceil((updatedAt - createdAt) / (1000 * 60 * 60 * 24));

      conversionTimes.push(daysToConvert);

      const ch = lead.channel || 'UNKNOWN';
      if (!byChannel[ch]) {
        byChannel[ch] = [];
      }
      byChannel[ch].push(daysToConvert);
    });

    // Calculate overall metrics
    const avgTime = conversionTimes.length > 0
      ? (conversionTimes.reduce((sum, val) => sum + val, 0) / conversionTimes.length).toFixed(1)
      : 0;

    const medianTime = conversionTimes.length > 0
      ? conversionTimes.sort((a, b) => a - b)[Math.floor(conversionTimes.length / 2)]
      : 0;

    const minTime = conversionTimes.length > 0 ? Math.min(...conversionTimes) : 0;
    const maxTime = conversionTimes.length > 0 ? Math.max(...conversionTimes) : 0;

    // Calculate by channel
    const channelMetrics = {};
    Object.keys(byChannel).forEach(ch => {
      const times = byChannel[ch];
      channelMetrics[ch] = {
        count: times.length,
        avgDays: (times.reduce((sum, val) => sum + val, 0) / times.length).toFixed(1),
        minDays: Math.min(...times),
        maxDays: Math.max(...times),
        medianDays: times.sort((a, b) => a - b)[Math.floor(times.length / 2)]
      };
    });

    return res.json({
      success: true,
      overall: {
        totalWon: wonLeads.length,
        avgDays: avgTime,
        medianDays: medianTime,
        minDays: minTime,
        maxDays: maxTime
      },
      byChannel: channelMetrics
    });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'time_conversion_failed', details: e?.message || String(e) });
  }
});

/**
 * GET /api/crm/analytics/trends
 * Get trend data over time (daily/weekly/monthly)
 */
router.get('/trends', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { startDate, endDate, groupBy = 'day' } = req.query;

    let query = supabase
      .from('crm_leads')
      .select('id, channel, status, created_at')
      .eq('tenant_id', req.user.tenantId);

    if (startDate) query = query.gte('created_at', startDate);
    if (endDate) query = query.lte('created_at', endDate);

    const { data: leads, error } = await query;
    if (error) throw error;

    const trends = {};

    leads.forEach(lead => {
      const date = new Date(lead.created_at);
      let key;

      if (groupBy === 'week') {
        const weekStart = new Date(date.setDate(date.getDate() - date.getDay()));
        key = weekStart.toISOString().split('T')[0];
      } else if (groupBy === 'month') {
        key = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`;
      } else {
        key = date.toISOString().split('T')[0];
      }

      if (!trends[key]) {
        trends[key] = { total: 0, won: 0, lost: 0, active: 0, byChannel: {} };
      }

      trends[key].total++;
      if (lead.status === 'WON') trends[key].won++;
      else if (lead.status === 'LOST') trends[key].lost++;
      else trends[key].active++;

      const ch = lead.channel || 'UNKNOWN';
      trends[key].byChannel[ch] = (trends[key].byChannel[ch] || 0) + 1;
    });

    // Convert to sorted array
    const trendArray = Object.keys(trends)
      .sort()
      .map(key => ({
        date: key,
        ...trends[key]
      }));

    return res.json({ success: true, trends: trendArray });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'trends_failed', details: e?.message || String(e) });
  }
});

/**
 * GET /api/crm/analytics/team-performance
 * Get performance metrics by assigned user/salesman
 */
router.get('/team-performance', requireCrmAuth, requireCrmFeature(CRM_FEATURES.CRM_LEADS), requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const { startDate, endDate } = req.query;

    let query = supabase
      .from('crm_leads')
      .select('id, assigned_user_id, status, score, created_at')
      .eq('tenant_id', req.user.tenantId);

    if (startDate) query = query.gte('created_at', startDate);
    if (endDate) query = query.lte('created_at', endDate);

    const { data: leads, error } = await query;
    if (error) throw error;

    // Get user details
    const { data: users } = await supabase
      .from('crm_users')
      .select('id, name, email')
      .eq('tenant_id', req.user.tenantId);

    const userMap = {};
    (users || []).forEach(user => {
      userMap[user.id] = user;
    });

    // Group by assigned user
    const teamMetrics = {};

    leads.forEach(lead => {
      const userId = lead.assigned_user_id || 'UNASSIGNED';
      
      if (!teamMetrics[userId]) {
        teamMetrics[userId] = {
          userId,
          name: userMap[userId]?.name || 'Unassigned',
          email: userMap[userId]?.email || null,
          total: 0,
          won: 0,
          lost: 0,
          active: 0,
          avgScore: 0,
          totalScore: 0
        };
      }

      const metrics = teamMetrics[userId];
      metrics.total++;
      metrics.totalScore += lead.score || 0;

      if (lead.status === 'WON') metrics.won++;
      else if (lead.status === 'LOST') metrics.lost++;
      else metrics.active++;
    });

    // Calculate rates
    Object.keys(teamMetrics).forEach(userId => {
      const metrics = teamMetrics[userId];
      metrics.avgScore = metrics.total > 0 ? (metrics.totalScore / metrics.total).toFixed(1) : 0;
      metrics.conversionRate = metrics.total > 0 ? ((metrics.won / metrics.total) * 100).toFixed(2) : 0;
      metrics.lossRate = metrics.total > 0 ? ((metrics.lost / metrics.total) * 100).toFixed(2) : 0;
      delete metrics.totalScore;
    });

    // Convert to array and sort by conversion rate
    const teamArray = Object.values(teamMetrics).sort((a, b) => 
      parseFloat(b.conversionRate) - parseFloat(a.conversionRate)
    );

    return res.json({ success: true, team: teamArray });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'team_performance_failed', details: e?.message || String(e) });
  }
});

/**
 * GET /api/crm/analytics/executive-insights
 * Management-grade summary with actionable red flags.
 */
router.get('/executive-insights', requireCrmAuth, requireRole(['OWNER', 'ADMIN', 'MANAGER']), async (req, res) => {
  try {
    const tenantId = req.user.tenantId;
    const now = new Date();
    const sevenDaysAgo = new Date(now.getTime() - (7 * 24 * 60 * 60 * 1000)).toISOString();
    const previousSevenDaysAgo = new Date(now.getTime() - (14 * 24 * 60 * 60 * 1000)).toISOString();
    const fourteenDaysAgo = new Date(now.getTime() - (14 * 24 * 60 * 60 * 1000)).toISOString();
    const thirtyDaysAgo = new Date(now.getTime() - (30 * 24 * 60 * 60 * 1000)).toISOString();

    const [{ data: leads, error: leadsErr }, { data: triageItems }, { data: users }] = await Promise.all([
      supabase
        .from('crm_leads')
        .select('id, status, heat, score, assigned_user_id, created_at, updated_at, last_activity_at, channel')
        .eq('tenant_id', tenantId)
        .limit(7000),
      supabase
        .from('crm_triage_items')
        .select('id, status, assigned_user_id, updated_at, created_at')
        .eq('tenant_id', tenantId)
        .limit(7000),
      supabase
        .from('crm_users')
        .select('id, name, role')
        .eq('tenant_id', tenantId)
    ]);

    if (leadsErr) throw leadsErr;

    const allLeads = leads || [];
    const triage = triageItems || [];
    const staleLeads = allLeads.filter(l => (l.last_activity_at || l.updated_at || l.created_at || '') < fourteenDaysAgo);
    const onFireUnassigned = allLeads.filter(l => String(l.heat || '').toUpperCase() === 'ON_FIRE' && !l.assigned_user_id);
    const hotUnassigned = allLeads.filter(l => ['HOT', 'ON_FIRE'].includes(String(l.heat || '').toUpperCase()) && !l.assigned_user_id);
    const wonLeads = allLeads.filter(l => String(l.status || '').toUpperCase() === 'WON');
    const lostLeads = allLeads.filter(l => String(l.status || '').toUpperCase() === 'LOST');
    const newLast7 = allLeads.filter(l => (l.created_at || '') >= sevenDaysAgo);
    const newPrev7 = allLeads.filter(l => (l.created_at || '') >= previousSevenDaysAgo && (l.created_at || '') < sevenDaysAgo);
    const openPipeline = allLeads.filter(l => !['WON', 'LOST'].includes(String(l.status || '').toUpperCase()));

    const highRiskChurn = allLeads.filter(l => {
      const heat = String(l.heat || '').toUpperCase();
      const status = String(l.status || '').toUpperCase();
      const idle = (l.last_activity_at || l.updated_at || l.created_at || '') < thirtyDaysAgo;
      return ['HOT', 'ON_FIRE', 'WARM'].includes(heat) && !['WON', 'LOST'].includes(status) && idle;
    });

    const staleOpenTriage = triage.filter(t => {
      const status = String(t.status || '').toUpperCase();
      return ['OPEN', 'ASSIGNED'].includes(status) && (t.updated_at || t.created_at || '') < sevenDaysAgo;
    });

    const unownedTriage = triage.filter(t => {
      const status = String(t.status || '').toUpperCase();
      return status === 'OPEN' && !t.assigned_user_id;
    });

    const avgResponseHours = (() => {
      const durations = [];
      for (const lead of allLeads) {
        const created = lead.created_at ? new Date(lead.created_at).getTime() : null;
        const touched = lead.last_activity_at ? new Date(lead.last_activity_at).getTime() : null;
        if (created && touched && touched > created) {
          durations.push((touched - created) / (1000 * 60 * 60));
        }
      }
      if (!durations.length) return 0;
      return Number((durations.reduce((sum, h) => sum + h, 0) / durations.length).toFixed(1));
    })();

    let overdueFollowupsCount = 0;
    try {
      const { count } = await supabase
        .from('conversations_new')
        .select('*', { count: 'exact', head: true })
        .eq('tenant_id', tenantId)
        .not('follow_up_at', 'is', null)
        .is('follow_up_completed_at', null)
        .lt('follow_up_at', now.toISOString());
      overdueFollowupsCount = count || 0;
    } catch (_) {
      overdueFollowupsCount = 0;
    }

    const winRate = allLeads.length > 0 ? Number(((wonLeads.length / allLeads.length) * 100).toFixed(2)) : 0;
    const lossRate = allLeads.length > 0 ? Number(((lostLeads.length / allLeads.length) * 100).toFixed(2)) : 0;
    const avgScore = allLeads.length > 0 ? Number((allLeads.reduce((s, l) => s + (Number(l.score) || 0), 0) / allLeads.length).toFixed(1)) : 0;
    const leadVelocityDelta = newPrev7.length > 0
      ? Number((((newLast7.length - newPrev7.length) / newPrev7.length) * 100).toFixed(2))
      : (newLast7.length > 0 ? 100 : 0);

    const channelMix = {};
    allLeads.forEach(l => {
      const key = String(l.channel || 'UNKNOWN').toUpperCase();
      channelMix[key] = (channelMix[key] || 0) + 1;
    });

    const channelMixLast7 = {};
    const channelMixPrev7 = {};
    newLast7.forEach(l => {
      const key = String(l.channel || 'UNKNOWN').toUpperCase();
      channelMixLast7[key] = (channelMixLast7[key] || 0) + 1;
    });
    newPrev7.forEach(l => {
      const key = String(l.channel || 'UNKNOWN').toUpperCase();
      channelMixPrev7[key] = (channelMixPrev7[key] || 0) + 1;
    });

    const channelTrends = Object.keys({ ...channelMixLast7, ...channelMixPrev7 }).map(channel => {
      const current = channelMixLast7[channel] || 0;
      const previous = channelMixPrev7[channel] || 0;
      const deltaPct = previous > 0 ? Number((((current - previous) / previous) * 100).toFixed(2)) : (current > 0 ? 100 : 0);
      return { channel, current, previous, deltaPct };
    }).sort((a, b) => b.current - a.current);

    const teamMap = new Map((users || []).map(u => [u.id, { id: u.id, name: u.name || 'Unknown', role: u.role || null, openLeads: 0, wonLast30: 0 }]));
    openPipeline.forEach(lead => {
      if (!lead.assigned_user_id) return;
      if (!teamMap.has(lead.assigned_user_id)) {
        teamMap.set(lead.assigned_user_id, { id: lead.assigned_user_id, name: 'Unknown', role: null, openLeads: 0, wonLast30: 0 });
      }
      teamMap.get(lead.assigned_user_id).openLeads += 1;
    });
    const wonLast30 = allLeads.filter(l => String(l.status || '').toUpperCase() === 'WON' && (l.updated_at || l.created_at || '') >= thirtyDaysAgo);
    wonLast30.forEach(lead => {
      if (!lead.assigned_user_id) return;
      if (!teamMap.has(lead.assigned_user_id)) {
        teamMap.set(lead.assigned_user_id, { id: lead.assigned_user_id, name: 'Unknown', role: null, openLeads: 0, wonLast30: 0 });
      }
      teamMap.get(lead.assigned_user_id).wonLast30 += 1;
    });

    const teamPressure = Array.from(teamMap.values())
      .map(user => ({
        ...user,
        pressureScore: Number((user.openLeads * 0.7 - user.wonLast30 * 0.3).toFixed(2))
      }))
      .sort((a, b) => b.pressureScore - a.pressureScore)
      .slice(0, 10);

    const redFlags = [];
    if (onFireUnassigned.length > 0) {
      redFlags.push({ type: 'critical', code: 'ON_FIRE_UNASSIGNED', count: onFireUnassigned.length, message: `${onFireUnassigned.length} on-fire leads are unassigned` });
    }
    if (overdueFollowupsCount > 0) {
      redFlags.push({ type: 'high', code: 'OVERDUE_FOLLOWUPS', count: overdueFollowupsCount, message: `${overdueFollowupsCount} follow-ups are overdue` });
    }
    if (highRiskChurn.length > 0) {
      redFlags.push({ type: 'high', code: 'CHURN_RISK', count: highRiskChurn.length, message: `${highRiskChurn.length} warm/hot leads show churn risk (inactive >30 days)` });
    }
    if (staleLeads.length > 0) {
      redFlags.push({ type: 'medium', code: 'STALE_PIPELINE', count: staleLeads.length, message: `${staleLeads.length} leads inactive for >14 days` });
    }
    if (unownedTriage.length > 0) {
      redFlags.push({ type: 'high', code: 'TRIAGE_UNOWNED', count: unownedTriage.length, message: `${unownedTriage.length} triage items are open without owner` });
    }
    if (staleOpenTriage.length > 0) {
      redFlags.push({ type: 'medium', code: 'TRIAGE_STALE', count: staleOpenTriage.length, message: `${staleOpenTriage.length} triage items have no progress in 7+ days` });
    }

    const recommendations = [
      hotUnassigned.length > 0 ? `Assign ${hotUnassigned.length} hot leads immediately using round-robin + capacity rules` : null,
      overdueFollowupsCount > 0 ? `Clear ${overdueFollowupsCount} overdue follow-ups in the next 24 hours` : null,
      highRiskChurn.length > 0 ? `Run reactivation sequence for ${highRiskChurn.length} at-risk leads (WhatsApp + call)` : null,
      avgResponseHours > 24 ? 'Reduce first response SLA below 24h for new leads' : null,
      winRate < 10 && allLeads.length >= 20 ? 'Review qualification criteria and first-response SLA to improve conversion' : null
    ].filter(Boolean);

    return res.json({
      success: true,
      summary: {
        totalLeads: allLeads.length,
        newLast7Days: newLast7.length,
        newPrev7Days: newPrev7.length,
        leadVelocityDeltaPct: leadVelocityDelta,
        winRate,
        lossRate,
        avgScore,
        avgResponseHours,
        overdueFollowups: overdueFollowupsCount,
        highRiskChurn: highRiskChurn.length,
        staleLeads: staleLeads.length,
        unownedTriage: unownedTriage.length
      },
      channelMix,
      channelTrends,
      teamPressure,
      redFlags,
      recommendations
    });
  } catch (e) {
    return res.status(500).json({ success: false, error: 'executive_insights_failed', details: e?.message || String(e) });
  }
});

module.exports = router;
