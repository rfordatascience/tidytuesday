|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|location_id   |character |Wikidata item ID of the place, e.g. `Q65`. |
|name          |character |Place name, in English where available, e.g. `Los Angeles`. |
|category      |character |Type of place: `city` (a city, town or district), `landmark`, `nature`, `street`, `castle` or `studio`. |
|resolution    |character |`exact` for a specific spot such as a building, street, park or studio; `town` for a whole city, town or district. |
|latitude      |double    |Latitude in WGS84 decimal degrees, e.g. `34.05223`. |
|longitude     |double    |Longitude in WGS84 decimal degrees, e.g. `-118.24368`. |
|country       |character |Country the place is in, e.g. `United States`. Missing for the few places the source puts in no country, such as research stations in Antarctica and ships. |
|country_code  |character |ISO 3166-1 alpha-2 country code, e.g. `US`. |
|n_productions |double    |Number of films and series linked to the place in `production_locations`, e.g. `1113`. |
|wikipedia     |character |URL of the English Wikipedia article on the place, e.g. `https://en.wikipedia.org/wiki/Los_Angeles`. Missing where there is none. |
