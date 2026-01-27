#!/bin/bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: waha_salesmate_2024" \
  -d '{"url": "http://localhost:8057/webhook", "events": ["message"]}' \
  http://localhost:3001/api/sessions/default/webhooks
