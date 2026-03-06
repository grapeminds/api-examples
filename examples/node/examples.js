// Grapeminds Wine API – Node.js examples (built-in fetch, Node 18+)
// Base URL: https://grapeminds.eu/api/public/v1

const BASE_URL = "https://grapeminds.eu/api/public/v1";

async function get(endpoint) {
  const response = await fetch(`${BASE_URL}${endpoint}`);
  if (!response.ok) {
    throw new Error(`HTTP error ${response.status} for ${endpoint}`);
  }
  const data = await response.json();
  return data;
}

async function main() {
  console.log("=== GET /ping ===");
  console.log(await get("/ping"));

  console.log("\n=== GET /wines ===");
  console.log(await get("/wines"));

  console.log("\n=== GET /regions ===");
  console.log(await get("/regions"));

  console.log("\n=== GET /grapes ===");
  console.log(await get("/grapes"));
}

main().catch(console.error);
