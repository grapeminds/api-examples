<?php
// Grapeminds Wine API – PHP examples
// Requires PHP 7+
// Base URL: https://grapeminds.eu/api/public/v1

define('BASE_URL', 'https://grapeminds.eu/api/public/v1');

function apiGet(string $endpoint): mixed {
    $url = BASE_URL . $endpoint;
    $context = stream_context_create([
        'http' => ['method' => 'GET'],
    ]);
    $response = file_get_contents($url, false, $context);
    if ($response === false) {
        throw new RuntimeException("Request failed for endpoint: $endpoint");
    }
    return json_decode($response, true);
}

echo "=== GET /ping ===" . PHP_EOL;
print_r(apiGet('/ping'));
echo PHP_EOL;

echo "=== GET /wines ===" . PHP_EOL;
print_r(apiGet('/wines'));
echo PHP_EOL;

echo "=== GET /regions ===" . PHP_EOL;
print_r(apiGet('/regions'));
echo PHP_EOL;

echo "=== GET /grapes ===" . PHP_EOL;
print_r(apiGet('/grapes'));
echo PHP_EOL;
