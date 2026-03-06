# Grapeminds Wine API – Developer Examples

Example integrations for the **Grapeminds Wine API**, a developer-friendly API that provides structured wine data for applications, services, and AI tools.

The API allows developers to access detailed information about wines, producers, regions, and grape varieties. It is designed for easy integration into apps, POS systems, wine platforms, and recommendation engines.

If you are building a **wine app, hospitality software, AI assistant, or e-commerce platform**, the Grapeminds API helps you quickly integrate reliable wine data.

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

## Quick Start

The fastest way to test the API is using the `/ping` endpoint.

### Ping

```
GET /ping
```

Example request:

```
curl https://grapeminds.eu/api/public/v1/ping
```

Example response:

```json
{
  "status": "ok",
  "service": "grapeminds-api"
}
```

---

## Example Endpoints

### List Wines

Retrieve wines from the Grapeminds database.

```
GET /wines
```

Example:

```
GET /wines?page=1
```

Example response:

```json
{
  "data": [
    {
      "id": 1234,
      "name": "Barolo DOCG",
      "producer": "Marchesi di Barolo",
      "region": "Piedmont",
      "country": "Italy",
      "color": "red"
    }
  ]
}
```

---

### Wine Regions

Retrieve wine regions.

```
GET /regions
```

---

### Grape Varieties

Retrieve grape varieties.

```
GET /grapes
```

---

## Example Code

This repository provides simple examples for calling the Grapeminds API in several programming languages.

```
examples/
  curl/
  node/
  python/
  php/
```

Each example demonstrates how to send a request to the API and print the response.

---

## Example Request (curl)

```
curl https://grapeminds.eu/api/public/v1/wines
```

---

## Example Request (Node.js)

```javascript
const response = await fetch(
  "https://grapeminds.eu/api/public/v1/wines"
);

const data = await response.json();
console.log(data);
```

---

## Example Request (Python)

```python
import requests

response = requests.get(
    "https://grapeminds.eu/api/public/v1/wines"
)

print(response.json())
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

https://grapeminds.de/entwickler/endpunkte

---

## About Grapeminds

Grapeminds is a **wine intelligence and cellar management platform** that provides structured wine data and AI-powered wine services.

The platform helps developers, hospitality businesses, and wine enthusiasts manage wine information and build wine-related applications.

Learn more:

https://grapeminds.de

---

## Contributing

Contributions, improvements, and additional examples are welcome.

Feel free to open issues or submit pull requests.

---

⭐ If you are building a wine app or wine-related project, consider starring this repository.
