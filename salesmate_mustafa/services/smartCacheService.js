/**
 * Enhanced Smart Cache Service for AI Responses
 * Provides intelligent caching with SQLite support
 */

const { supabase } = require('./config');
const crypto = require('crypto');

const SIMILARITY_THRESHOLD = 0.80; // 80% similarity for cache hit
const CACHE_EXPIRY_DAYS = 90;
const AVG_AI_COST = 0.0008;

function isContextDependentQuery(query) {
  const q = String(query || '').toLowerCase().trim();
  if (!q) return true;

  const words = q.split(/\s+/).filter(Boolean);
  const wordCount = words.length;
  if (wordCount <= 3) return true;

  // Common follow-up/ellipsis queries that only make sense with prior context
  const followUpPatterns = [
    /^(tell me more|more details|give me more details|give me more|more info|more information|details|explain more|continue|go on)$/i,
    /^(and\??|then\??|ok\??|okay\??|yes\??|no\??)$/i,
    /^(what about( it| that| this)?|how about( it| that| this)?)$/i,
    /^(أخبرني المزيد|المزيد|تفاصيل أكثر|مزيد من التفاصيل|زيدني تفاصيل|كمل)$/
  ];
  if (followUpPatterns.some((p) => p.test(q))) return true;

  // Short pronoun-heavy queries are usually context-dependent
  if (/(\bit\b|\bthat\b|\bthis\b|\bthem\b)/.test(q) && wordCount <= 6) return true;

  return false;
}

/**
 * Check if similar query exists in cache (simple text matching for SQLite)
 */
async function checkCache(query, tenantId) {
  try {
    if (isContextDependentQuery(query)) {
      console.log('[CACHE] Skipping cache for context-dependent query');
      return null;
    }
    console.log('[CACHE] Checking for cached response...');
    
    const queryHash = crypto.createHash('md5').update(query.toLowerCase().trim()).digest('hex');
    
    // Try exact match first
    const { data: exactMatch } = await supabase
      .from('ai_response_cache')
      .select('*')
      .eq('tenant_id', tenantId)
      .eq('query_hash', queryHash)
      .gt('expires_at', new Date().toISOString())
      .maybeSingle();
    
    if (exactMatch) {
      console.log(`[CACHE] ✅ Exact match found (used ${exactMatch.hit_count} times)`);
      
      // Increment hit count
      await supabase
        .from('ai_response_cache')
        .update({ 
          hit_count: exactMatch.hit_count + 1,
          updated_at: new Date().toISOString()
        })
        .eq('id', exactMatch.id);
      
      // Track usage
      await trackUsage(query, 'cache', exactMatch.id, 0, 0, tenantId, 1.0);
      
      return {
        response: exactMatch.response,
        cacheId: exactMatch.id,
        similarity: 1.0,
        fromCache: true
      };
    }
    
    // Try fuzzy match (similar queries)
    const normalizedQuery = query.toLowerCase().trim();
    const { data: similarQueries } = await supabase
      .from('ai_response_cache')
      .select('*')
      .eq('tenant_id', tenantId)
      .gt('expires_at', new Date().toISOString())
      .limit(20);
    
    if (similarQueries && similarQueries.length > 0) {
      // Simple fuzzy matching
      for (const cached of similarQueries) {
        const cachedQuery = cached.query_text.toLowerCase().trim();
        const similarity = calculateSimilarity(normalizedQuery, cachedQuery);
        
        if (similarity >= SIMILARITY_THRESHOLD) {
          console.log(`[CACHE] ✅ Similar match found (${(similarity * 100).toFixed(1)}% match, used ${cached.hit_count} times)`);
          
          // Increment hit count
          await supabase
            .from('ai_response_cache')
            .update({ 
              hit_count: cached.hit_count + 1,
              updated_at: new Date().toISOString()
            })
            .eq('id', cached.id);
          
          // Track usage
          await trackUsage(query, 'cache', cached.id, 0, 0, tenantId, similarity);
          
          return {
            response: cached.response,
            cacheId: cached.id,
            similarity: similarity,
            fromCache: true
          };
        }
      }
    }
    
    console.log('[CACHE] No similar queries found');
    return null;
    
  } catch (error) {
    console.error('[CACHE] Error in checkCache:', error);
    return null;
  }
}

/**
 * Store AI response in cache
 */
async function storeInCache(query, response, tenantId, intent = null, tokens = 0, cost = 0) {
  try {
    if (isContextDependentQuery(query)) {
      console.log('[CACHE] Not caching context-dependent query');
      return null;
    }
    console.log('[CACHE] Storing response in cache...');
    
    const queryHash = crypto.createHash('md5').update(query.toLowerCase().trim()).digest('hex');
    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + CACHE_EXPIRY_DAYS);
    
    const { data, error } = await supabase
      .from('ai_response_cache')
      .insert({
        tenant_id: tenantId,
        query_hash: queryHash,
        query_text: query,
        query_language: detectLanguage(query),
        response: response,
        response_tokens: tokens,
        intent: intent,
        original_cost: cost,
        hit_count: 1,
        led_to_order: 0,
        expires_at: expiresAt.toISOString()
      })
      .select()
      .single();
    
    if (error) {
      console.error('[CACHE] Error storing in cache:', error);
      return null;
    }
    
    console.log('[CACHE] ✅ Response cached successfully');
    return data;
    
  } catch (error) {
    console.error('[CACHE] Error in storeInCache:', error);
    return null;
  }
}

/**
 * Simple text similarity calculation (Dice coefficient)
 */
function calculateSimilarity(str1, str2) {
  if (str1 === str2) return 1.0;
  if (str1.length < 2 || str2.length < 2) return 0;
  
  const bigrams1 = getBigrams(str1);
  const bigrams2 = getBigrams(str2);
  
  const intersection = bigrams1.filter(x => bigrams2.includes(x)).length;
  const similarity = (2.0 * intersection) / (bigrams1.length + bigrams2.length);
  
  return similarity;
}

function getBigrams(str) {
  const bigrams = [];
  for (let i = 0; i < str.length - 1; i++) {
    bigrams.push(str.substring(i, i + 2));
  }
  return bigrams;
}

/**
 * Detect language
 */
function detectLanguage(text) {
  const arabicPattern = /[\u0600-\u06FF]/;
  const hindiPattern = /[\u0900-\u097F]/;
  
  if (arabicPattern.test(text)) return 'ar';
  if (hindiPattern.test(text)) return 'hi';
  return 'en';
}

/**
 * Track AI usage
 */
async function trackUsage(query, source, cacheId, tokens, cost, tenantId, similarity = null) {
  try {
    const costSaved = source === 'cache' ? AVG_AI_COST : 0;
    
    await supabase
      .from('ai_usage_tracking')
      .insert({
        tenant_id: tenantId,
        query_text: query.substring(0, 500),
        response_source: source,
        cache_id: cacheId,
        tokens_used: tokens,
        cost: cost,
        cost_saved: costSaved,
        cache_similarity_score: similarity
      });
    
  } catch (error) {
    console.error('[CACHE] Error tracking usage:', error);
  }
}

/**
 * Mark response as effective (led to order)
 */
async function markAsEffective(cacheId, customerId, ledToOrder, orderId = null) {
  try {
    await supabase
      .from('ai_response_cache')
      .update({ led_to_order: ledToOrder ? 1 : 0 })
      .eq('id', cacheId);
    
    await supabase
      .from('response_effectiveness')
      .insert({
        cache_query_hash: cacheId,
        customer_profile_id: customerId,
        led_to_order: ledToOrder ? 1 : 0,
        order_id: orderId
      });
    
    console.log('[CACHE] ✅ Marked response as effective');
    
  } catch (error) {
    console.error('[CACHE] Error marking as effective:', error);
  }
}

module.exports = {
  checkCache,
  storeInCache,
  markAsEffective,
  trackUsage
};
