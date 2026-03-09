# grapeminds Wine API – Ruby examples
# Requires: Ruby 2.7+, no external gems needed (uses net/http from stdlib)
# Set your API key:  API_KEY=your_key ruby examples/ruby/examples.rb
#
# Base URL: https://api.grapeminds.eu/public/v1

require "net/http"
require "json"
require "uri"

BASE_URL = "https://api.grapeminds.eu/public/v1"
API_KEY  = ENV.fetch("API_KEY", "YOUR_API_KEY")

def api_get(path)
  uri = URI("#{BASE_URL}#{path}")
  req = Net::HTTP::Get.new(uri)
  req["Authorization"] = "Bearer #{API_KEY}"
  req["Accept"]        = "application/json"

  response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }

  raise "Request failed: #{response.code} #{response.message} – #{path}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def show(label, data)
  puts "=== #{label} ==="
  puts JSON.pretty_generate(data)
  puts
end

# Ping – verify authentication and API availability
show "GET /ping", api_get("/ping")

# Wines – list
wines   = api_get("/wines?per_page=5")
show "GET /wines", wines
wine_id = wines.dig("data", 0, "id")

# Wines – full-text search (fuzzy, typo-tolerant)
show "GET /wines/search?q=Barolo", api_get("/wines/search?q=Barolo&limit=5")

# Wines – details for a single wine
show "GET /wines/#{wine_id}", api_get("/wines/#{wine_id}")

# Drinking period – optimal drinking window for a wine
show "GET /drinking-periods/#{wine_id}", api_get("/drinking-periods/#{wine_id}?lang=en")

# Producers – list
producers   = api_get("/producers?per_page=5")
show "GET /producers", producers
producer_id = producers.dig("data", 0, "id")

# Producers – details for a single producer (including wines)
show "GET /producers/#{producer_id}?include_wines=true", api_get("/producers/#{producer_id}?include_wines=true")

# Regions – list
regions   = api_get("/regions?per_page=5")
show "GET /regions", regions
region_id = regions.dig("data", 0, "id")

# Regions – details for a single region (including wines)
show "GET /regions/#{region_id}?include_wines=true", api_get("/regions/#{region_id}?include_wines=true")

# Region insights – climate, terroir, signature styles, key grapes
show "GET /region-insights/#{region_id}", api_get("/region-insights/#{region_id}?lang=en")
