# grapeminds Wine API – Developer Examples

Example integrations for the **grapeminds Wine API**, a developer-friendly API that provides structured wine data for applications, services, and AI tools.

Perfect for building **wine apps**, **wine recommendation systems**, **hospitality software**, and **AI assistants**.

The API allows developers to access detailed information about wines, producers, regions, and grape varieties. It is designed for easy integration into apps, POS systems, wine platforms, and recommendation engines.

If you are building a **wine app, hospitality software, AI assistant, or e-commerce platform**, the grapeminds Wine API helps you quickly integrate reliable wine data.

The API can also be used as a **wine dataset API for AI and machine learning applications**.

---

![API](https://img.shields.io/badge/API-Wine-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

---

## Features

The Grapeminds API provides access to:

- wine metadata  
- producers and wineries  
- wine regions  
- grape varieties  
- structured wine information for apps and services  

Typical use cases include:

- wine discovery apps  
- wine cellar management software  
- restaurant POS systems and digital wine lists  
- wine shop integrations  
- recommendation engines  
- AI assistants and chatbots  

---

## Base URL

```
https://grapeminds.eu/api/public/v1
```

All endpoints are relative to this base URL.

---

## Authentication

Every request requires an API key passed as a header:

```
Authorization: Bearer YOUR_API_KEY
```

Alternatively: `X-API-Key: YOUR_API_KEY`

Obtain your API key at https://grapeminds.eu/developers#registration.

Set the key as an environment variable before running the example scripts:

```bash
export API_KEY=your_key_here
```

---

## Quick Start

The fastest way to test the API is using the `/ping` endpoint.

### Ping

```
GET /ping
```

Example request:

```bash
curl -H "Authorization: Bearer $API_KEY" \
     https://grapeminds.eu/api/public/v1/ping
```

Example response:

```json
{
  "status": "ok",
  "service": "grapeminds-api"
}
```

---

## Endpoints

### GET /ping

Health check – verifies authentication and API availability.

---

### GET /wines

List wines with pagination and filtering.

```
GET /wines?color=red&per_page=5
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number |
| `per_page` | integer | 15 | Results per page (max 100) |
| `color` | string | — | Filter: `red`, `white`, `rose` |
| `sub_type` | string | — | Filter: `still`, `sparkling` |
| `producer_id` | integer | — | Filter by producer ID |
| `region_id` | integer | — | Filter by region ID |

Example response:

```json
{
  "data": [
    {
      "id": 42,
      "display_name": "Barolo DOCG 2018",
      "color": "red",
      "sub_type": "still",
      "residual_sugar": "dry",
      "producer": { "id": 10, "name": "Marchesi di Barolo", "display_name": "Marchesi di Barolo" },
      "region": { "id": 5, "name": "Barolo", "country": "IT" }
    }
  ],
  "meta": { "current_page": 1, "last_page": 83, "per_page": 5, "total": 415 }
}
```

---

### GET /wines/search

Full-text search with fuzzy matching and typo tolerance.

```
GET /wines/search?q=Barolo&limit=5
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `q` | string | **yes** | Search query (min. 3 characters) |
| `limit` | integer | no | Max results, max 100 (default: 20) |

---

### GET /wines/{id}

Full wine details: descriptions, grape varieties, food pairings, tasting notes, and flavor profile.

```
GET /wines/42
```

Use the `Accept-Language` header (`de`, `en`, `fr`, `it`) for localized content. If a translation is not yet available, AI enrichment is triggered automatically in the background.

---

### GET /producers

List producers with pagination and optional search.

```
GET /producers?search=Marchesi&per_page=10
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number |
| `per_page` | integer | 15 | Results per page (max 100) |
| `search` | string | — | Name search (min. 2 characters) |

---

### GET /producers/{id}

Producer details, optionally with their wines.

```
GET /producers/10?include_wines=true
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `include_wines` | boolean | false | Include up to 50 wines |

---

### GET /regions

List wine regions with optional country filter and search.

```
GET /regions?country=IT&per_page=10
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number |
| `per_page` | integer | 15 | Results per page (max 100) |
| `country` | string | — | ISO country code (e.g. `IT`, `FR`, `DE`) |
| `search` | string | — | Name search (min. 2 characters) |

Region names are localized via the `Accept-Language` header.

---

### GET /regions/{id}

Region details, optionally with wines from that region.

```
GET /regions/5?include_wines=true
```

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `include_wines` | boolean | false | Include up to 50 wines |

---

### GET /region-insights/{regionId}

AI-generated regional profile: climate, terroir, signature styles, and key grape varieties.

```
GET /region-insights/5?lang=en
```

If the insight is not yet available for the requested language, a `404` is returned with `"generating": true`. Retry after ~30 seconds.

---

### GET /drinking-periods/{wineId}

Optimal drinking window for a wine: year range, young/mature assessments, and storage guidance.

```
GET /drinking-periods/42?lang=en
```

If the content is not yet available for the requested language, a `404` is returned with `"generating": true`. Retry after ~30 seconds.

---

### POST /photo/analyze *(Enterprise)*

Analyze a wine label photo using AI. Returns matched wine candidates from the database. Requires an Enterprise API subscription.

```json
POST /photo/analyze
{ "photo": "<base64-encoded image>", "max_results": 5 }
```

---

## Example Code

This repository provides ready-to-run scripts for calling the grapeminds Wine API in several programming languages.

```
examples/
  curl/examples.sh        – shell script using curl
  node/examples.js        – Node.js 18+ using built-in fetch
  typescript/examples.ts  – TypeScript with type definitions (Node 18+)
  python/examples.py      – Python using requests
  ruby/examples.rb        – Ruby using net/http (stdlib, no gems)
  php/examples.php        – PHP using cURL
  swift/examples.swift    – Swift 5.5+ using URLSession + async/await
  dart/examples.dart      – Dart / Flutter using package:http
```

Each script covers all documented endpoints and prints the JSON responses.

---

## Running the Examples

Make sure your API key is set (see [Authentication](#authentication) above):

```bash
export API_KEY=your_key_here
```

### curl

```bash
bash examples/curl/examples.sh
```

### Node.js (requires Node 18+)

```bash
node examples/node/examples.js
```

### Python (requires Python 3.7+)

```bash
pip install requests
python examples/python/examples.py
```

### PHP (requires PHP 7.4+ with cURL extension)

```bash
php examples/php/examples.php
```

### TypeScript (requires Node 18+ and ts-node)

```bash
npm install -g ts-node typescript
API_KEY=your_key ts-node examples/typescript/examples.ts
```

### Ruby (requires Ruby 2.7+, no gems needed)

```bash
API_KEY=your_key ruby examples/ruby/examples.rb
```

### Swift (requires Swift 5.5+ / Xcode 13+)

```bash
API_KEY=your_key swift examples/swift/examples.swift
```

### Dart (requires Dart SDK 2.17+ or Flutter 3+)

```bash
dart pub add http
API_KEY=your_key dart run examples/dart/examples.dart
```

---

## Minimal Snippets

The quickest way to try a single endpoint in each language (set `API_KEY` first):

**curl**
```bash
curl -H "Authorization: Bearer $API_KEY" \
     https://grapeminds.eu/api/public/v1/wines
```

**Node.js**
```javascript
const res = await fetch("https://grapeminds.eu/api/public/v1/wines", {
  headers: { Authorization: `Bearer ${process.env.API_KEY}` },
});
console.log(await res.json());
```

**Python**
```python
import os, requests
headers = {"Authorization": f"Bearer {os.environ['API_KEY']}"}
print(requests.get("https://grapeminds.eu/api/public/v1/wines", headers=headers).json())
```

**PHP**
```php
$ctx = stream_context_create(['http' => [
    'header' => 'Authorization: Bearer ' . getenv('API_KEY'),
]]);
echo file_get_contents("https://grapeminds.eu/api/public/v1/wines", false, $ctx);
```

**TypeScript**
```typescript
const res = await fetch("https://grapeminds.eu/api/public/v1/wines", {
  headers: { Authorization: `Bearer ${process.env.API_KEY}` },
});
console.log(await res.json());
```

**Ruby**
```ruby
require "net/http"; require "json"
req = Net::HTTP::Get.new(URI("https://grapeminds.eu/api/public/v1/wines"))
req["Authorization"] = "Bearer #{ENV['API_KEY']}"
res = Net::HTTP.start("grapeminds.eu", 443, use_ssl: true) { |h| h.request(req) }
puts JSON.pretty_generate(JSON.parse(res.body))
```

**Swift**
```swift
var req = URLRequest(url: URL(string: "https://grapeminds.eu/api/public/v1/wines")!)
req.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
let (data, _) = try await URLSession.shared.data(for: req)
print(String(data: data, encoding: .utf8)!)
```

**Dart / Flutter**
```dart
final res = await http.get(
  Uri.parse('https://grapeminds.eu/api/public/v1/wines'),
  headers: {'Authorization': 'Bearer $apiKey'},
);
print(res.body);
```

---

## Localization

The API supports multiple languages for wine metadata and descriptions.

Supported languages include:

- English  
- German  
- French  
- Italian  

Example header:

```
Accept-Language: en
```

---

## Documentation

Full developer documentation:

https://grapeminds.eu/developers/endpoints

---

## About grapeminds

grapeminds is a **wine intelligence and cellar management platform** that provides structured wine data and AI-powered wine services.

The platform helps developers, hospitality businesses, and wine enthusiasts manage wine information and build wine-related applications.

Learn more:

https://grapeminds.eu

---

## Contributing

Contributions, improvements, and additional examples are welcome.

Feel free to open issues or submit pull requests.

---

⭐ If you are building a wine app or wine-related project, consider starring this repository.
