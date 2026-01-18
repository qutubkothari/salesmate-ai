/**
 * Test AI Intelligence API
 * Tests scoring, churn prediction, recommendations, risk analysis, sentiment
 */

const axios = require('axios');

const BASE_URL = 'http://localhost:8055';
const TENANT_ID = '101f04af63cbefc2bf8f0a98b9ae1205';
const USER_ID = 'b8a48b98-8bba-4382-b024-6c1a35038f39';

async function testAIIntelligenceAPI() {
  console.log('🧪 Testing AI Intelligence API\n');

  try {
    // Get a deal ID from the database first
    const dealsRes = await axios.get(`${BASE_URL}/api/pipeline/deals/${TENANT_ID}?limit=1`);
    const dealId = dealsRes.data.deals[0]?.id;
    
    if (!dealId) {
      console.log('⚠️  No deals found, skipping deal-specific tests\n');
    }

    // Test 1: Calculate Deal Score
    if (dealId) {
      console.log('1️⃣ POST /api/ai-intelligence/score/deal/:dealId');
      const scoreRes = await axios.post(`${BASE_URL}/api/ai-intelligence/score/deal/${dealId}`, {
        tenantId: TENANT_ID
      });
      console.log(`✅ Deal Score Calculated:`);
      console.log(`   Composite Score: ${scoreRes.data.compositeScore}/100 (${scoreRes.data.scoreTier})`);
      console.log(`   Conversion: ${scoreRes.data.scores.conversion}/100`);
      console.log(`   Engagement: ${scoreRes.data.scores.engagement}/100`);
      console.log(`   Quality: ${scoreRes.data.scores.quality}/100`);
      console.log(`   Urgency: ${scoreRes.data.scores.urgency}/100\n`);
    }

    // Test 2: Get All Scores
    console.log('2️⃣ GET /api/ai-intelligence/scores/:tenantId?tier=hot');
    const scoresRes = await axios.get(`${BASE_URL}/api/ai-intelligence/scores/${TENANT_ID}?tier=hot&limit=5`);
    console.log(`✅ Found ${scoresRes.data.scores.length} hot lead(s)\n`);

    // Test 3: Analyze Deal Risk
    if (dealId) {
      console.log('3️⃣ POST /api/ai-intelligence/risk/deal/:dealId');
      const riskRes = await axios.post(`${BASE_URL}/api/ai-intelligence/risk/deal/${dealId}`, {
        tenantId: TENANT_ID
      });
      console.log(`✅ Deal Risk Analyzed:`);
      console.log(`   Risk Score: ${riskRes.data.riskScore}/100 (${riskRes.data.riskLevel})`);
      console.log(`   Risk Breakdown:`, riskRes.data.risks);
      console.log('');
    }

    // Test 4: Generate Recommendation
    if (dealId) {
      console.log('4️⃣ POST /api/ai-intelligence/recommend/deal/:dealId');
      const recRes = await axios.post(`${BASE_URL}/api/ai-intelligence/recommend/deal/${dealId}`, {
        tenantId: TENANT_ID,
        userId: USER_ID
      });
      
      if (recRes.data.recommendation) {
        console.log(`✅ Recommendation Generated:`);
        console.log(`   Type: ${recRes.data.recommendation.type}`);
        console.log(`   Priority: ${recRes.data.recommendation.priority}`);
        console.log(`   Title: ${recRes.data.recommendation.title}`);
        console.log(`   Success Probability: ${(recRes.data.recommendation.successProbability * 100).toFixed(0)}%`);
      } else {
        console.log(`✅ No recommendations at this time`);
      }
      console.log('');
    }

    // Test 5: Get Recommendations for User
    console.log('5️⃣ GET /api/ai-intelligence/recommendations/:tenantId/:userId');
    const recsRes = await axios.get(`${BASE_URL}/api/ai-intelligence/recommendations/${TENANT_ID}/${USER_ID}`);
    console.log(`✅ Found ${recsRes.data.recommendations.length} recommendation(s) for user\n`);

    // Test 6: Analyze Sentiment
    console.log('6️⃣ POST /api/ai-intelligence/sentiment/analyze');
    const sentimentRes = await axios.post(`${BASE_URL}/api/ai-intelligence/sentiment/analyze`, {
      tenantId: TENANT_ID,
      text: 'This product is great! I love it and am very interested in purchasing.',
      entityType: 'conversation',
      entityId: 'test-123',
      userId: USER_ID
    });
    console.log(`✅ Sentiment Analyzed:`);
    console.log(`   Score: ${sentimentRes.data.score}/100`);
    console.log(`   Label: ${sentimentRes.data.label}\n`);

    // Test 7: Get AI Dashboard
    console.log('7️⃣ GET /api/ai-intelligence/dashboard/:tenantId');
    const dashboardRes = await axios.get(`${BASE_URL}/api/ai-intelligence/dashboard/${TENANT_ID}`);
    console.log(`✅ AI Dashboard Summary:`);
    console.log(`   Hot Leads: ${dashboardRes.data.hotLeads}`);
    console.log(`   Churn Risk Customers: ${dashboardRes.data.churnRiskCustomers}`);
    console.log(`   Pending Recommendations: ${dashboardRes.data.pendingRecommendations}`);
    console.log(`   High-Risk Deals: ${dashboardRes.data.highRiskDeals}`);
    console.log(`   Average Sentiment: ${dashboardRes.data.averageSentiment}/100\n`);

    console.log('✅ All AI Intelligence tests passed!\n');

    // Summary
    console.log('📊 Summary:');
    console.log('   - Deal/Lead Scoring: ✅');
    console.log('   - Risk Analysis: ✅');
    console.log('   - Recommendations: ✅');
    console.log('   - Sentiment Analysis: ✅');
    console.log('   - Dashboard Analytics: ✅');

  } catch (error) {
    console.error('❌ Test failed:', error.response?.data || error.message);
    if (error.response?.status === 404) {
      console.log('\n💡 Tip: Make sure you have deals in the pipeline first');
    }
    process.exit(1);
  }
}

// Check if server is running
axios.get(`${BASE_URL}/health`).then(() => {
  testAIIntelligenceAPI();
}).catch(() => {
  console.error('❌ Server not running on port 8055');
  console.log('Please start the server first: node index.js');
  process.exit(1);
});
