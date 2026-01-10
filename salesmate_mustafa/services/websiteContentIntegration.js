/**
 * Website Content Integration for Customer Queries
 * This module extends the AI assistant to search website content for product info
 */

const { searchWebsiteContent, findProductInfo } = require('./websiteSearchService');

async function getQueryExpansionsWithAI(query) {
    try {
        const q = String(query || '').trim();
        if (!q) return [];

        const { openai } = require('./config');
        const resp = await openai.chat.completions.create({
            model: 'gpt-4o-mini',
            messages: [
                {
                    role: 'system',
                    content:
                        'Generate up to 2 alternative website-search queries for the user question. ' +
                        'Expand acronyms, add common synonyms, and keep queries short. ' +
                        'Do NOT invent product names or brands not present in the user query. ' +
                        'Return ONLY JSON: {"queries": ["..."]}.'
                },
                { role: 'user', content: q }
            ],
            response_format: { type: 'json_object' },
            temperature: 0.2,
            max_tokens: 120
        });

        const parsed = JSON.parse(resp?.choices?.[0]?.message?.content || '{}');
        const queries = Array.isArray(parsed.queries) ? parsed.queries : [];
        return queries
            .map(x => String(x || '').trim())
            .filter(Boolean)
            .slice(0, 2);
    } catch (e) {
        return [];
    }
}

/**
 * Search website content and enhance AI response
 * @param {string} query - Customer's query
 * @param {string} tenantId - Tenant ID
 * @param {string} productCode - Optional product code if known
 * @returns {Promise<Object>} Search results and formatted context
 */
async function searchWebsiteForQuery(query, tenantId, productCode = null) {
    try {
        let results = [];

        // If product code is known, search for that specific product
        if (productCode) {
            results = await findProductInfo(productCode, tenantId);
        } else {
            // General semantic search
            results = await searchWebsiteContent(query, tenantId, {
                limit: 3,
                minSimilarity: 0.25  // Lower threshold for better recall (25%)
            });
        }

        if (!results || results.length === 0) {
            // Optional AI query expansion to improve recall for acronyms / short queries.
            const expansions = await getQueryExpansionsWithAI(query);
            if (expansions.length) {
                const combined = [];
                const seen = new Set();

                for (const q2 of [query, ...expansions]) {
                    const r2 = await searchWebsiteContent(q2, tenantId, {
                        limit: 3,
                        minSimilarity: 0.25
                    });
                    for (const r of (r2 || [])) {
                        const key = r?.id ?? `${r?.url || ''}::${r?.chunk_index || ''}`;
                        if (seen.has(key)) continue;
                        seen.add(key);
                        combined.push(r);
                    }
                }

                results = combined;
            }
        }

        if (!results || results.length === 0) {
            console.log('[WebsiteContentIntegration] No results found');
            return null;
        }

        console.log('[WebsiteContentIntegration] Found', results.length, 'results');
        console.log('[WebsiteContentIntegration] First result keys:', Object.keys(results[0]));

        // Format results for AI context
        const context = results.map((result, idx) => 
            `[Source ${idx + 1}: ${result.pageTitle || result.page_title}]\n${result.content || result.chunk_text}`
        ).join('\n\n---\n\n');

        const sources = results.map(result => ({
            title: result.pageTitle || result.page_title,
            url: result.url,
            relevance: result.relevanceScore || Math.round(result.similarity * 100)
        }));

        return {
            found: true,
            context,
            sources,
            count: results.length
        };

    } catch (error) {
        console.error('[WebsiteContentIntegration] Search error:', error);
        return null;
    }
}

/**
 * Enhance AI system prompt with website content
 * @param {string} basePrompt - Base system prompt
 * @param {Object} websiteContext - Website search results
 * @returns {string} Enhanced prompt
 */
function enhancePromptWithWebsiteContent(basePrompt, websiteContext) {
    if (!websiteContext || !websiteContext.found) {
        return basePrompt;
    }

    const websiteSection = `

## Additional Information from Website

I found relevant information from our website that may help answer the customer's question:

${websiteContext.context}

Please use this information to provide accurate and detailed answers about our products, specifications, and pricing. Always prioritize this official website information when available.

Sources: ${websiteContext.sources.map(s => `${s.title} (${s.relevance}% relevant)`).join(', ')}
`;

    return basePrompt + websiteSection;
}

/**
 * Check if query is likely asking for product information
 * @param {string} query - Customer query
 * @returns {boolean}
 */
function isProductInfoQuery(query) {
    const infoKeywords = [
        'spec', 'specification', 'technical', 'details', 'feature',
        'support', 'supports', 'integration', 'integrate', 'api', 'webhook',
        'price', 'cost', 'rate', 'pricing',
        'about', 'information', 'tell me', 'what is',
        'how much', 'available', 'describe'
    ];

    const queryLower = query.toLowerCase();
    return infoKeywords.some(keyword => queryLower.includes(keyword));
}

/**
 * Extract product code from query if present
 * @param {string} query - Customer query
 * @returns {string|null} Product code if found
 */
function extractProductCodeFromQuery(query) {
    // Pattern for common product codes (customize for your products)
    const patterns = [
        /\b[A-Z]{2,4}[-\s]?\d{1,4}[-\s]?[A-Z0-9]{0,4}\b/gi, // e.g., NFF-640, ABC 123
        /\b\d{4,6}\b/g, // Simple numeric codes
    ];

    for (const pattern of patterns) {
        const matches = query.match(pattern);
        if (matches && matches.length > 0) {
            return matches[0].trim();
        }
    }

    return null;
}

module.exports = {
    searchWebsiteForQuery,
    enhancePromptWithWebsiteContent,
    isProductInfoQuery,
    extractProductCodeFromQuery
};
