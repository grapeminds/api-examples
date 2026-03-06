# grapeminds Wine API – Python examples
# Requires: pip install requests
# Set your API key:  API_KEY=your_key python examples/python/examples.py
#
# Base URL: https://grapeminds.eu/api/public/v1

import json
import os
import requests

BASE_URL = "https://grapeminds.eu/api/public/v1"
API_KEY = os.environ.get("API_KEY", "YOUR_API_KEY")

session = requests.Session()
session.headers.update({"Authorization": f"Bearer {API_KEY}"})


def get(path: str) -> dict:
    response = session.get(f"{BASE_URL}{path}")
    response.raise_for_status()
    return response.json()


def show(label: str, data: dict) -> None:
    print(f"=== {label} ===")
    print(json.dumps(data, indent=2))
    print()


def main() -> None:
    # Ping – verify authentication and API availability
    show("GET /ping", get("/ping"))

    # Wines – list
    wines = get("/wines?per_page=5")
    show("GET /wines", wines)
    wine_id = wines["data"][0]["id"]

    # Wines – full-text search (fuzzy, typo-tolerant)
    show("GET /wines/search?q=Barolo", get("/wines/search?q=Barolo&limit=5"))

    # Wines – details for a single wine
    show(f"GET /wines/{wine_id}", get(f"/wines/{wine_id}"))

    # Drinking period – optimal drinking window for a wine
    show(f"GET /drinking-periods/{wine_id}", get(f"/drinking-periods/{wine_id}?lang=en"))

    # Producers – list
    producers = get("/producers?per_page=5")
    show("GET /producers", producers)
    producer_id = producers["data"][0]["id"]

    # Producers – details for a single producer (including wines)
    show(f"GET /producers/{producer_id}?include_wines=true", get(f"/producers/{producer_id}?include_wines=true"))

    # Regions – list
    regions = get("/regions?per_page=5")
    show("GET /regions", regions)
    region_id = regions["data"][0]["id"]

    # Regions – details for a single region (including wines)
    show(f"GET /regions/{region_id}?include_wines=true", get(f"/regions/{region_id}?include_wines=true"))

    # Region insights – climate, terroir, signature styles, key grapes
    show(f"GET /region-insights/{region_id}", get(f"/region-insights/{region_id}?lang=en"))


if __name__ == "__main__":
    main()
