<?php

// grapeminds Wine API – PHP examples
// Requires PHP 7.4+ with the cURL extension enabled
// Set your API key:  API_KEY=your_key php examples/php/examples.php
//
// Base URL: https://api.grapeminds.eu/public/v1

define('BASE_URL', 'https://api.grapeminds.eu/public/v1');
$apiKey = getenv('API_KEY') ?: 'YOUR_API_KEY';

function apiGet(string $path, string $apiKey): array
{
    $ch = curl_init(BASE_URL . $path);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER     => [
            'Accept: application/json',
            "Authorization: Bearer $apiKey",
        ],
        CURLOPT_TIMEOUT        => 10,
    ]);

    $body   = curl_exec($ch);
    $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($body === false || $status < 200 || $status >= 300) {
        throw new RuntimeException("Request to $path failed with HTTP $status");
    }

    return json_decode($body, associative: true);
}

function show(string $label, array $data): void
{
    printf("=== %s ===\n%s\n\n", $label, json_encode($data, JSON_PRETTY_PRINT));
}

// Ping – verify authentication and API availability
show('GET /ping', apiGet('/ping', $apiKey));

// Wines – list
$wines  = apiGet('/wines?per_page=5', $apiKey);
$wineId = $wines['data'][0]['id'];
show('GET /wines', $wines);

// Wines – full-text search (fuzzy, typo-tolerant)
show('GET /wines/search?q=Barolo', apiGet('/wines/search?q=Barolo&limit=5', $apiKey));

// Wines – details for a single wine
show("GET /wines/$wineId", apiGet("/wines/$wineId", $apiKey));

// Drinking period – optimal drinking window for a wine
show("GET /drinking-periods/$wineId", apiGet("/drinking-periods/$wineId?lang=en", $apiKey));

// Producers – list
$producers  = apiGet('/producers?per_page=5', $apiKey);
$producerId = $producers['data'][0]['id'];
show('GET /producers', $producers);

// Producers – details for a single producer (including wines)
show("GET /producers/$producerId?include_wines=true", apiGet("/producers/$producerId?include_wines=true", $apiKey));

// Regions – list
$regions  = apiGet('/regions?per_page=5', $apiKey);
$regionId = $regions['data'][0]['id'];
show('GET /regions', $regions);

// Regions – details for a single region (including wines)
show("GET /regions/$regionId?include_wines=true", apiGet("/regions/$regionId?include_wines=true", $apiKey));

// Region insights – climate, terroir, signature styles, key grapes
show("GET /region-insights/$regionId", apiGet("/region-insights/$regionId?lang=en", $apiKey));
