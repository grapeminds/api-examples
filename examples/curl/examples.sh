#!/usr/bin/env bash
# Grapeminds Wine API – curl examples
# Base URL: https://grapeminds.eu/api/public/v1

BASE_URL="https://grapeminds.eu/api/public/v1"

echo "=== GET /ping ==="
curl -s "$BASE_URL/ping"
echo -e "\n"

echo "=== GET /wines ==="
curl -s "$BASE_URL/wines"
echo -e "\n"

echo "=== GET /regions ==="
curl -s "$BASE_URL/regions"
echo -e "\n"

echo "=== GET /grapes ==="
curl -s "$BASE_URL/grapes"
echo -e "\n"
