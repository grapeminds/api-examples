// grapeminds Wine API – Node.js examples (Node 18+ built-in fetch)
// Set your API key:  API_KEY=your_key node examples/node/examples.js
//
// Base URL: https://grapeminds.eu/api/public/v1

const BASE_URL = "https://grapeminds.eu/api/public/v1";
const API_KEY = process.env.API_KEY ?? "YOUR_API_KEY";

async function get(path) {
    const response = await fetch(`${BASE_URL}${path}`, {
        headers: { Authorization: `Bearer ${API_KEY}` },
    });
    if (!response.ok) {
        throw new Error(`${response.status} ${response.statusText} – ${path}`);
    }
    return response.json();
}

function show(label, data) {
    console.log(`=== ${label} ===`);
    console.log(JSON.stringify(data, null, 2));
    console.log();
}

async function main() {
    // Ping – verify authentication and API availability
    show("GET /ping", await get("/ping"));

    // Wines – list
    const wines = await get("/wines?per_page=5");
    show("GET /wines", wines);
    const wineId = wines.data[0]?.id;

    // Wines – full-text search (fuzzy, typo-tolerant)
    show("GET /wines/search?q=Barolo", await get("/wines/search?q=Barolo&limit=5"));

    // Wines – details for a single wine
    show(`GET /wines/${wineId}`, await get(`/wines/${wineId}`));

    // Drinking period – optimal drinking window for a wine
    show(`GET /drinking-periods/${wineId}`, await get(`/drinking-periods/${wineId}?lang=en`));

    // Producers – list
    const producers = await get("/producers?per_page=5");
    show("GET /producers", producers);
    const producerId = producers.data[0]?.id;

    // Producers – details for a single producer (including wines)
    show(
        `GET /producers/${producerId}?include_wines=true`,
        await get(`/producers/${producerId}?include_wines=true`)
    );

    // Regions – list
    const regions = await get("/regions?per_page=5");
    show("GET /regions", regions);
    const regionId = regions.data[0]?.id;

    // Regions – details for a single region (including wines)
    show(
        `GET /regions/${regionId}?include_wines=true`,
        await get(`/regions/${regionId}?include_wines=true`)
    );

    // Region insights – climate, terroir, signature styles, key grapes
    show(`GET /region-insights/${regionId}`, await get(`/region-insights/${regionId}?lang=en`));
}

main().catch((err) => {
    console.error(err.message);
    process.exit(1);
});
