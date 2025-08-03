#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Coolify domains
RASA_DOMAIN="gccgccg040ogc0808cso8ckg.bizfloe.com"  # Rasa service domain
ACTIONS_DOMAIN="gccgccg040ogc0808cso8ckg.bizfloe.com"  # Actions service domain

# Function to check if a request was successful
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Success${NC}"
    else
        echo -e "${RED}✗ Failed${NC}"
    fi
}

echo "Testing Rasa Deployment..."

echo -e "\n1. Checking Rasa server status..."
curl -s "https://$RASA_DOMAIN/status" | jq '.'
check_status

echo -e "\n2. Checking Actions server health..."
curl -s "https://$ACTIONS_DOMAIN/webhook/health"
check_status

echo -e "\n3. Testing model status..."
curl -s "https://$RASA_DOMAIN/model/status" | jq '.'
check_status

echo -e "\n4. Testing basic conversation..."
echo "Sending: hello"
curl -s -X POST "https://$RASA_DOMAIN/webhooks/rest/webhook" \
  -H "Content-Type: application/json" \
  -d '{"message": "hello"}' | jq '.'
check_status

echo -e "\nSending: how are you?"
curl -s -X POST "https://$RASA_DOMAIN/webhooks/rest/webhook" \
  -H "Content-Type: application/json" \
  -d '{"message": "how are you?"}' | jq '.'
check_status
curl -s -X POST "https://$DOMAIN/webhooks/rest/webhook" \
  -H "Content-Type: application/json" \
  -d '{"message": "what time is it?"}' | jq '.'

echo -e "\nSending: my name is John"
curl -s -X POST "https://$DOMAIN/webhooks/rest/webhook" \
  -H "Content-Type: application/json" \
  -d '{"message": "my name is John"}' | jq '.'

echo -e "\n4. Testing weather intent..."
curl -s -X POST "https://$DOMAIN/webhooks/rest/webhook" \
  -H "Content-Type: application/json" \
  -d '{"message": "what is the weather like?"}' | jq '.'

echo -e "\nTest complete!"
