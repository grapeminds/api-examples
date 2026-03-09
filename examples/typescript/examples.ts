// grapeminds Wine API – TypeScript examples (Node 18+ built-in fetch)
// Set your API key:  API_KEY=your_key npx ts-node examples/typescript/examples.ts
//
// Base URL: https://api.grapeminds.eu/public/v1

const BASE_URL = "https://api.grapeminds.eu/public/v1";
const API_KEY = process.env.API_KEY ?? "YOUR_API_KEY";

async function get<T>(path: string): Promise<T> {
    const response = await fetch(`${BASE_URL}${path}`, {
        headers: { Authorization: `Bearer ${API_KEY}` },
    });
    if (!response.ok) {
        throw new Error(`${response.status} ${response.statusText} – ${path}`);
    }
    return response.json() as Promise<T>;
}

function show(label: string, data: unknown): void {
    console.log(`=== ${label} ===`);
    console.log(JSON.stringify(data, null, 2));
    console.log();
}

interface PaginatedResponse<T> {
    data: T[];
    meta: {
        current_page: number;
        last_page: number;
        per_page: number;
        total: number;
    };
}

interface Wine {
    id: number;
    display_name: string;
    color: string;
    sub_type: string;
    residual_sugar: string;
    producer: { id: number; name: string; display_name: string };
    region: { id: number; name: string; country: string };
}

interface Producer {
    id: number;
    name: string;
    title: string | null;
    display_name: string;
}

interface Region {
    id: number;
    name: string;
    country: string;
    language: string;
}

async function main(): Promise<void> {
    // Ping – verify authentication and API availability
    show("GET /ping", await get("/ping"));

    // Wines – list
    const wines = await get<PaginatedResponse<Wine>>("/wines?per_page=5");
    show("GET /wines", wines);
    const wineId = wines.data[0]?.id;

    // Wines – full-text search (fuzzy, typo-tolerant)
    show("GET /wines/search?q=Barolo", await get("/wines/search?q=Barolo&limit=5"));

    // Wines – details for a single wine
    show(`GET /wines/${wineId}`, await get(`/wines/${wineId}`));

    // Drinking period – optimal drinking window for a wine
    show(`GET /drinking-periods/${wineId}`, await get(`/drinking-periods/${wineId}?lang=en`));

    // Producers – list
    const producers = await get<PaginatedResponse<Producer>>("/producers?per_page=5");
    show("GET /producers", producers);
    const producerId = producers.data[0]?.id;

    // Producers – details for a single producer (including wines)
    show(
        `GET /producers/${producerId}?include_wines=true`,
        await get(`/producers/${producerId}?include_wines=true`)
    );

    // Regions – list
    const regions = await get<PaginatedResponse<Region>>("/regions?per_page=5");
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

main().catch((err: Error) => {
    console.error(err.message);
    process.exit(1);
});
