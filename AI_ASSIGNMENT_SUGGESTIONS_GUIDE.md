# AI Assignment Suggestions - User Guide

## Overview
The AI Assignment Suggestions system analyzes salesman performance and provides intelligent recommendations for optimizing lead distribution.

## Features

### 1. Automatic Performance Analysis
The system continuously monitors:
- ✅ Lead conversion rates
- ✅ Response times
- ✅ Capacity utilization
- ✅ Lead quality scores
- ✅ Monthly targets vs. actuals

### 2. Smart Suggestions
Based on analysis, AI provides:

#### 🔥 **Increase Capacity** (High Priority)
- **When**: High conversion rate + Low utilization
- **Example**: "John has excellent conversion rate (35%) but is only at 60% capacity. Assign more leads!"
- **Action**: Increase monthly target for this salesman

#### ⚡ **Fast Responder** (Medium Priority)
- **When**: Quick response time + Available capacity
- **Example**: "Sarah responds in 12 minutes on average. Ideal for urgent/hot leads."
- **Action**: Route hot leads to fast responders

#### 💡 **Underutilized** (Medium Priority)
- **When**: Low capacity usage + Good performance
- **Example**: "Mike is at 35% capacity but maintains 20% conversion. Assign more leads!"
- **Action**: Balance workload better

#### ⚠️ **Needs Training** (High Priority)
- **When**: Low conversion rate with adequate leads
- **Example**: "Ahmed has 8% conversion with 15 leads. Consider training or coaching."
- **Action**: Provide sales training

#### 🐌 **Slow Response** (High Priority)
- **When**: Long average response time
- **Example**: "Tom takes 75 minutes on average to respond. This may hurt conversion."
- **Action**: Set SLA reminders or redistribute leads

#### 🌟 **Star Performer** (Recognition)
- **When**: Exceeding targets with high conversion
- **Example**: "🌟 Lisa is a star! 120% of target with 40% conversion. Consider rewarding!"
- **Action**: Recognize and retain top talent

## API Endpoints

### GET /api/assignment-suggestions
Get AI suggestions for all salesmen

**Request**:
```bash
curl -X GET https://sak-ai.saksolution.com/api/assignment-suggestions \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

**Response**:
```json
{
  "success": true,
  "suggestions": [
    {
      "salesmanId": "uuid",
      "salesmanName": "John Doe",
      "type": "increase_capacity",
      "priority": "high",
      "message": "John has excellent conversion rate (35%) but is only at 60% capacity. Assign more leads!",
      "metrics": {
        "conversionRate": "35.0",
        "utilizationRate": "60",
        "currentLeads": 12,
        "targetLeads": 20,
        "suggestedTarget": 26
      }
    }
  ],
  "totalSalesmen": 7,
  "month": "2026-01"
}
```

### GET /api/assignment-suggestions/salesman/:salesmanId
Get detailed suggestions for specific salesman

**Request**:
```bash
curl -X GET https://sak-ai.saksolution.com/api/assignment-suggestions/salesman/SALESMAN_ID \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

**Response**:
```json
{
  "success": true,
  "salesmanId": "uuid",
  "stats": {
    "totalLeads": 15,
    "convertedLeads": 5,
    "pendingLeads": 8,
    "hotLeads": 3,
    "conversionRate": "33.3"
  },
  "recommendations": [
    {
      "type": "prioritize_hot",
      "message": "Focus on 3 hot leads first - they have highest conversion potential",
      "actionable": true,
      "leadIds": ["uuid1", "uuid2", "uuid3"]
    },
    {
      "type": "excellent_performance",
      "message": "Excellent work! 33.3% conversion rate is above average",
      "actionable": false
    }
  ]
}
```

## Using in Management Dashboard

### Display Suggestions Widget

Add to your admin dashboard:

```javascript
import { useEffect, useState } from 'react';

function AssignmentSuggestions() {
  const [suggestions, setSuggestions] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/assignment-suggestions', {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      }
    })
    .then(res => res.json())
    .then(data => {
      setSuggestions(data.suggestions);
      setLoading(false);
    });
  }, []);

  if (loading) return <div>Loading suggestions...</div>;

  return (
    <div className="suggestions-panel">
      <h3>🤖 AI Assignment Suggestions</h3>
      {suggestions.map((suggestion, idx) => (
        <div 
          key={idx} 
          className={`suggestion priority-${suggestion.priority}`}
        >
          <span className="badge">{suggestion.type}</span>
          <p>{suggestion.message}</p>
          <div className="metrics">
            {Object.entries(suggestion.metrics).map(([key, value]) => (
              <span key={key}>{key}: {value}</span>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}
```

### Periodic Refresh

Set up automatic refresh (every 5 minutes):

```javascript
useEffect(() => {
  const interval = setInterval(() => {
    fetchSuggestions();
  }, 300000); // 5 minutes

  return () => clearInterval(interval);
}, []);
```

## Suggestion Priority Levels

| Priority | Color | When to Act |
|----------|-------|-------------|
| **High** | 🔴 Red | Immediate action needed |
| **Medium** | 🟡 Yellow | Act within 1-2 days |
| **Low** | 🟢 Green | Informational |

## Best Practices

### 1. Review Daily
Check suggestions every morning to optimize distribution

### 2. Act on High Priority
Address red flags (slow response, low conversion) immediately

### 3. Reward Top Performers
Recognize star performers to boost morale

### 4. Balance Workload
Use "underutilized" suggestions to spread leads evenly

### 5. Coach Low Performers
Use "needs training" alerts to identify coaching opportunities

## Metrics Explained

### Conversion Rate
- **Formula**: (Converted Leads / Total Leads) × 100
- **Good**: > 25%
- **Average**: 15-25%
- **Needs Improvement**: < 15%

### Utilization Rate
- **Formula**: (Current Leads / Target Leads) × 100
- **Optimal**: 80-100%
- **Underutilized**: < 60%
- **Overloaded**: > 120%

### Response Time
- **Formula**: Average time from lead creation to first response
- **Excellent**: < 15 minutes
- **Good**: 15-30 minutes
- **Needs Improvement**: > 60 minutes

## Integration with Auto-Assignment

The suggestions automatically influence future assignments when using **performance-based** mode:

1. Fast responders get more **urgent/hot** leads
2. High converters get **increased capacity**
3. Slow responders get **fewer time-sensitive** leads
4. Underutilized salesmen get **more assignments**

## Example Scenarios

### Scenario 1: Unbalanced Workload
**Suggestion**: "Mike is at 35% capacity while Sarah is at 110%"
**Action**: Redistribute some of Sarah's pending leads to Mike

### Scenario 2: Conversion Drop
**Suggestion**: "Tom's conversion dropped from 25% to 8% this month"
**Action**: Review Tom's approach, provide coaching

### Scenario 3: Star Performer
**Suggestion**: "🌟 Lisa exceeded target with 40% conversion"
**Action**: Increase Lisa's target by 30%, consider bonus

## Troubleshooting

### No suggestions appearing?
- Check if salesmen have targets set
- Ensure enough leads exist (needs 5+ leads for analysis)
- Verify current month has data

### Suggestions seem inaccurate?
- Suggestions are based on current month data
- Need at least 5-10 leads per salesman for accurate analysis
- Check if targets are realistic

### Can't access API?
- Verify JWT token is valid
- Check user has admin role
- Ensure API route is registered in index.js

## Future Enhancements (Coming Soon)

- 📊 Trend analysis (compare month-over-month)
- 🎯 Predictive lead scoring
- 📧 Email alerts for critical suggestions
- 📱 Mobile notifications
- 🤖 Auto-execute suggestions (with approval)

## Support

For questions or issues:
- Check API response for error messages
- Review server logs: `pm2 logs salesmate-ai`
- Test endpoint: `curl /api/assignment-suggestions/test`
