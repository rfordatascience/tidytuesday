|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|name         |character |Upper-case product name that matches the place (`EKTORP`), the key for joining to `ikea_seating`. |
|place        |character |Place name as written in OpenStreetMap (`Ektorp`, `Södra Esseboda`). |
|municipality |character |Swedish municipality (kommun) the place lies in (`Nacka kommun`). |
|county       |character |Swedish county (län) the place lies in (`Stockholms län`). |
|place_type   |character |OpenStreetMap feature type (`hamlet`, `village`, `isolated_dwelling`, `lake`, `islet`). |
|latitude     |double    |Latitude in decimal degrees (WGS 84). |
|longitude    |double    |Longitude in decimal degrees (WGS 84). |
|osm_id       |character |OpenStreetMap object (`node/7455615607`), viewable at `openstreetmap.org/<osm_id>`. Missing for the three places located by hand. |

