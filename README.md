# Grapeminds Wine API – Code Examples

This repository contains simple code examples showing how to use the [Grapeminds Wine API](https://grapeminds.eu). The goal is to help developers quickly understand how to integrate the API into their applications.

---

## About the Grapeminds API

The Grapeminds Wine API provides access to a curated database of wines, grape varieties, and wine regions. It is a RESTful API that returns JSON responses and requires no authentication for the public endpoints.

**Base URL:** `https://grapeminds.eu/api/public/v1`

---

## Available Endpoints

| Method | Endpoint   | Description                        |
|--------|------------|------------------------------------|
| GET    | `/ping`    | Health check – confirms the API is up |
| GET    | `/wines`   | Returns a list of wines            |
| GET    | `/regions` | Returns a list of wine regions     |
| GET    | `/grapes`  | Returns a list of grape varieties  |

---

## Example Requests

### Ping
```
GET https://grapeminds.eu/api/public/v1/ping
```

### Wines
```
GET https://grapeminds.eu/api/public/v1/wines
```

### Regions
```
GET https://grapeminds.eu/api/public/v1/regions
```

### Grapes
```
GET https://grapeminds.eu/api/public/v1/grapes
```

---

## Repository Structure

```
examples/
├── curl/
│   └── examples.sh       # curl one-liners for every endpoint
├── node/
│   └── examples.js       # Node.js examples using fetch
├── python/
│   └── examples.py       # Python examples using requests
└── php/
    └── examples.php      # PHP examples using file_get_contents / cURL
```

---

## How to Run the Examples

### curl

```bash
bash examples/curl/examples.sh
```

Or run a single command from the file directly, e.g.:

```bash
curl -s https://grapeminds.eu/api/public/v1/wines | jq .
```

> `jq` is optional but recommended for pretty-printing JSON.

---

### Node.js

Requires **Node.js 18+** (built-in `fetch` is available from v18).

```bash
node examples/node/examples.js
```

---

### Python

Requires **Python 3** and the `requests` library.

```bash
pip install requests
python examples/python/examples.py
```

---

### PHP

Requires **PHP 7+**.

```bash
php examples/php/examples.php
```

---

## License

This repository is provided as-is for demonstration purposes.
