// grapeminds Wine API – Swift examples
// Requires: Swift 5.5+, macOS 12+ / iOS 15+ (uses async/await + URLSession)
// Set your API key in the apiKey constant below, then:
//   swift examples/swift/examples.swift
//
// Base URL: https://api.grapeminds.eu/public/v1

import Foundation

let baseURL = "https://api.grapeminds.eu/public/v1"
let apiKey  = ProcessInfo.processInfo.environment["API_KEY"] ?? "YOUR_API_KEY"

// MARK: – HTTP helper

func apiGet(_ path: String) async throws -> Any {
    guard let url = URL(string: baseURL + path) else {
        throw URLError(.badURL)
    }
    var request        = URLRequest(url: url)
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json",  forHTTPHeaderField: "Accept")

    let (data, response) = try await URLSession.shared.data(for: request)
    guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
        let code = (response as? HTTPURLResponse)?.statusCode ?? 0
        throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "HTTP \(code) – \(path)"])
    }
    return try JSONSerialization.jsonObject(with: data)
}

func show(_ label: String, _ data: Any) {
    let pretty = (try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted))
        .flatMap { String(data: $0, encoding: .utf8) } ?? "(could not serialize)"
    print("=== \(label) ===")
    print(pretty)
    print()
}

// MARK: – Examples

func main() async throws {
    // Ping – verify authentication and API availability
    show("GET /ping", try await apiGet("/ping"))

    // Wines – list
    let wines  = try await apiGet("/wines?per_page=5") as! [String: Any]
    show("GET /wines", wines)
    let wineId = ((wines["data"] as? [[String: Any]])?.first?["id"] as? Int) ?? 0

    // Wines – full-text search (fuzzy, typo-tolerant)
    show("GET /wines/search?q=Barolo", try await apiGet("/wines/search?q=Barolo&limit=5"))

    // Wines – details for a single wine
    show("GET /wines/\(wineId)", try await apiGet("/wines/\(wineId)"))

    // Drinking period – optimal drinking window for a wine
    show("GET /drinking-periods/\(wineId)", try await apiGet("/drinking-periods/\(wineId)?lang=en"))

    // Producers – list
    let producers  = try await apiGet("/producers?per_page=5") as! [String: Any]
    show("GET /producers", producers)
    let producerId = ((producers["data"] as? [[String: Any]])?.first?["id"] as? Int) ?? 0

    // Producers – details for a single producer (including wines)
    show("GET /producers/\(producerId)?include_wines=true",
         try await apiGet("/producers/\(producerId)?include_wines=true"))

    // Regions – list
    let regions  = try await apiGet("/regions?per_page=5") as! [String: Any]
    show("GET /regions", regions)
    let regionId = ((regions["data"] as? [[String: Any]])?.first?["id"] as? Int) ?? 0

    // Regions – details for a single region (including wines)
    show("GET /regions/\(regionId)?include_wines=true",
         try await apiGet("/regions/\(regionId)?include_wines=true"))

    // Region insights – climate, terroir, signature styles, key grapes
    show("GET /region-insights/\(regionId)", try await apiGet("/region-insights/\(regionId)?lang=en"))
}

// Entry point
Task {
    do {
        try await main()
    } catch {
        fputs("Error: \(error.localizedDescription)\n", stderr)
        exit(1)
    }
}

// Keep the process alive until the async task completes
RunLoop.main.run(until: Date(timeIntervalSinceNow: 30))
