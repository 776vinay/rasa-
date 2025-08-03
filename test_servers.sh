#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Server URLs
RASA_URL="https://p0w8o4w4wk008k40s004swgs.bizfloe.com"
ACTIONS_URL="https://k0wkcokggwowkkgc8cosw084.bizfloe.com"

echo "Testing Rasa and Actions Servers..."

echo -e "\n1. Testing Rasa Server..."
echo "Checking status endpoint..."
curl -s "${RASA_URL}/status" | jq '.' || echo -e "${RED}Failed to connect to Rasa server${NC}"

echo -e "\n2. Testing Actions Server..."
echo "Checking health endpoint..."
curl -s "${ACTIONS_URL}/health" || echo -e "${RED}Failed to connect to Actions server${NC}"

echo -e "\n3. Testing Rasa-Actions Communication..."
echo "Sending a test message that requires an action..."
curl -s -X POST \
  "${RASA_URL}/webhooks/rest/webhook" \
  -H "Content-Type: application/json" \
  -d '{"message": "what time is it?"}' | jq '.'

echo -e "\nTest complete! Check the responses above for any errors."
