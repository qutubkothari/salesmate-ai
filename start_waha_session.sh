#!/bin/bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: waha_salesmate_2024" \
  http://localhost:3001/api/sessions/start \
  -d '{"name":"default"}'
