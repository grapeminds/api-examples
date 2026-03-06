# Grapeminds Wine API – Python examples
# Requires: pip install requests
# Base URL: https://grapeminds.eu/api/public/v1

import requests

BASE_URL = "https://grapeminds.eu/api/public/v1"


def get(endpoint):
    response = requests.get(f"{BASE_URL}{endpoint}")
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    print("=== GET /ping ===")
    print(get("/ping"))

    print("\n=== GET /wines ===")
    print(get("/wines"))

    print("\n=== GET /regions ===")
    print(get("/regions"))

    print("\n=== GET /grapes ===")
    print(get("/grapes"))
