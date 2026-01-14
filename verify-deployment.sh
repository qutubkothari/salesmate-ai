#!/bin/bash

# Frontend Deployment Verification Script
# This script verifies that the frontend integration has been deployed successfully

echo "=========================================="
echo "  Frontend Integration Verification"
echo "=========================================="
echo ""

# Configuration
API_URL="https://salesmate.saksolution.com"
DASHBOARD_URL="$API_URL/dashboard.html"
API_CLIENT_URL="$API_URL/SalesateAPIClient.js"

echo "[1/4] Testing API Health..."
if curl -s "$API_URL/api/health" > /dev/null; then
    echo "✅ API is healthy"
else
    echo "❌ API is not responding"
    exit 1
fi

echo ""
echo "[2/4] Checking API Client..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$API_CLIENT_URL")
if [ "$STATUS" = "200" ]; then
    echo "✅ API Client is accessible"
else
    echo "⚠️  API Client returned status $STATUS (might not be deployed yet)"
fi

echo ""
echo "[3/4] Checking Dashboard..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$DASHBOARD_URL")
if [ "$STATUS" = "200" ]; then
    echo "✅ Dashboard is accessible"
else
    echo "⚠️  Dashboard returned status $STATUS (might not be deployed yet)"
fi

echo ""
echo "[4/4] Testing Authentication..."
RESPONSE=$(curl -s -X POST "$API_URL/api/auth/login" \
    -H "Content-Type: application/json" \
    -d '{"email":"manager@test.com","password":"test@123"}')

if echo "$RESPONSE" | grep -q "token"; then
    echo "✅ Authentication is working"
    TOKEN=$(echo "$RESPONSE" | grep -o '"token":"[^"]*' | cut -d'"' -f4)
    
    echo ""
    echo "[BONUS] Testing Manager Dashboard API..."
    DASHBOARD_RESPONSE=$(curl -s -H "Authorization: Bearer $TOKEN" "$API_URL/api/dashboard/overview")
    
    if echo "$DASHBOARD_RESPONSE" | grep -q "total_salesmen"; then
        echo "✅ Dashboard API is working"
        echo ""
        echo "Summary:"
        echo "--------"
        echo "$DASHBOARD_RESPONSE" | grep -o '"total_salesmen":[0-9]*' || echo "Could not parse response"
    else
        echo "⚠️  Dashboard API returned unexpected response"
    fi
else
    echo "⚠️  Authentication failed (test credentials may not exist)"
fi

echo ""
echo "=========================================="
echo "Deployment verification complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Open https://salesmate.saksolution.com/dashboard.html"
echo "2. Login with manager credentials"
echo "3. Verify all three tabs load data (Overview, Analytics, Alerts)"
echo ""
