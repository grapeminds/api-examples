// grapeminds Wine API – Dart / Flutter examples
// Requires: Dart SDK 2.17+ or Flutter 3+
//
// Install dependency once:
//   dart pub add http
//   (or add `http: ^1.2.0` to your pubspec.yaml)
//
// Run:
//   API_KEY=your_key dart run examples/dart/examples.dart
//
// Base URL: https://grapeminds.eu/api/public/v1

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://grapeminds.eu/api/public/v1';

String get apiKey => Platform.environment['API_KEY'] ?? 'YOUR_API_KEY';

Map<String, String> get _headers => {
      'Authorization': 'Bearer $apiKey',
      'Accept': 'application/json',
    };

// ---------------------------------------------------------------------------
// HTTP helper
// ---------------------------------------------------------------------------

Future<dynamic> apiGet(String path) async {
  final uri      = Uri.parse('$baseUrl$path');
  final response = await http.get(uri, headers: _headers);

  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception('HTTP ${response.statusCode} – $path');
  }
  return jsonDecode(response.body);
}

void show(String label, dynamic data) {
  const encoder = JsonEncoder.withIndent('  ');
  print('=== $label ===');
  print(encoder.convert(data));
  print('');
}

// ---------------------------------------------------------------------------
// Examples
// ---------------------------------------------------------------------------

Future<void> main() async {
  // Ping – verify authentication and API availability
  show('GET /ping', await apiGet('/ping'));

  // Wines – list
  final wines  = await apiGet('/wines?per_page=5') as Map<String, dynamic>;
  show('GET /wines', wines);
  final wineId = (wines['data'] as List).first['id'] as int;

  // Wines – full-text search (fuzzy, typo-tolerant)
  show('GET /wines/search?q=Barolo', await apiGet('/wines/search?q=Barolo&limit=5'));

  // Wines – details for a single wine
  show('GET /wines/$wineId', await apiGet('/wines/$wineId'));

  // Drinking period – optimal drinking window for a wine
  show('GET /drinking-periods/$wineId', await apiGet('/drinking-periods/$wineId?lang=en'));

  // Producers – list
  final producers  = await apiGet('/producers?per_page=5') as Map<String, dynamic>;
  show('GET /producers', producers);
  final producerId = (producers['data'] as List).first['id'] as int;

  // Producers – details for a single producer (including wines)
  show(
    'GET /producers/$producerId?include_wines=true',
    await apiGet('/producers/$producerId?include_wines=true'),
  );

  // Regions – list
  final regions  = await apiGet('/regions?per_page=5') as Map<String, dynamic>;
  show('GET /regions', regions);
  final regionId = (regions['data'] as List).first['id'] as int;

  // Regions – details for a single region (including wines)
  show(
    'GET /regions/$regionId?include_wines=true',
    await apiGet('/regions/$regionId?include_wines=true'),
  );

  // Region insights – climate, terroir, signature styles, key grapes
  show('GET /region-insights/$regionId', await apiGet('/region-insights/$regionId?lang=en'));
}
