#!/bin/bash

# grapeminds Wine API – curl examples
# Set your API key before running:
#   export API_KEY=your_key_here
#
# Base URL: https://api.grapeminds.eu/public/v1

BASE_URL="https://api.grapeminds.eu/public/v1"
API_KEY="${API_KEY:-YOUR_API_KEY}"

gm_get() {
    curl -s -H "Authorization: Bearer $API_KEY" "$BASE_URL$1"
}

# ---------------------------------------------------------------------------
# Ping – verify authentication and API availability
# ---------------------------------------------------------------------------
echo "=== GET /ping ==="
gm_get "/ping" | python3 -m json.tool
echo ""

# ---------------------------------------------------------------------------
# Wines – list wines (5 per page)
# ---------------------------------------------------------------------------
echo "=== GET /wines ==="
WINES=$(gm_get "/wines?per_page=5")
echo "$WINES" | python3 -m json.tool
WINE_ID=$(echo "$WINES" | python3 -c "import json,sys; print(json.load(sys.stdin)['data'][0]['id'])" 2>/dev/null)
echo ""

# ---------------------------------------------------------------------------
# Wines – full-text search (fuzzy, typo-tolerant)
# ---------------------------------------------------------------------------
echo "=== GET /wines/search?q=Barolo ==="
gm_get "/wines/search?q=Barolo&limit=5" | python3 -m json.tool
echo ""

# ---------------------------------------------------------------------------
# Wines – details for a single wine
# ---------------------------------------------------------------------------
echo "=== GET /wines/$WINE_ID ==="
gm_get "/wines/$WINE_ID" | python3 -m json.tool
echo ""

# ---------------------------------------------------------------------------
# Drinking period – optimal drinking window for a wine
# ---------------------------------------------------------------------------
echo "=== GET /drinking-periods/$WINE_ID ==="
gm_get "/drinking-periods/$WINE_ID?lang=en" | python3 -m json.tool
echo ""

# ---------------------------------------------------------------------------
# Producers – list wine producers
# ---------------------------------------------------------------------------
echo "=== GET /producers ==="
PRODUCERS=$(gm_get "/producers?per_page=5")
echo "$PRODUCERS" | python3 -m json.tool
PRODUCER_ID=$(echo "$PRODUCERS" | python3 -c "import json,sys; print(json.load(sys.stdin)['data'][0]['id'])" 2>/dev/null)
echo ""

# ---------------------------------------------------------------------------
# Producers – details for a single producer (including wines)
# ---------------------------------------------------------------------------
echo "=== GET /producers/$PRODUCER_ID?include_wines=true ==="
gm_get "/producers/$PRODUCER_ID?include_wines=true" | python3 -m json.tool
echo ""

# ---------------------------------------------------------------------------
# Regions – list wine regions
# ---------------------------------------------------------------------------
echo "=== GET /regions ==="
REGIONS=$(gm_get "/regions?per_page=5")
echo "$REGIONS" | python3 -m json.tool
REGION_ID=$(echo "$REGIONS" | python3 -c "import json,sys; print(json.load(sys.stdin)['data'][0]['id'])" 2>/dev/null)
echo ""

# ---------------------------------------------------------------------------
# Regions – details for a single region (including wines)
# ---------------------------------------------------------------------------
echo "=== GET /regions/$REGION_ID?include_wines=true ==="
gm_get "/regions/$REGION_ID?include_wines=true" | python3 -m json.tool
echo ""

# ---------------------------------------------------------------------------
# Region insights – climate, terroir, signature styles, key grapes
# ---------------------------------------------------------------------------
echo "=== GET /region-insights/$REGION_ID ==="
gm_get "/region-insights/$REGION_ID?lang=en" | python3 -m json.tool
echo ""
