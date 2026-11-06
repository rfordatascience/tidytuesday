|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|production_id |character |Wikidata item ID of the film or series, e.g. `Q23572` (Game of Thrones). Joins to `productions`. |
|location_id   |character |Wikidata item ID of a place it was filmed at, e.g. `Q1722` (Dubrovnik). Joins to `locations`. Each row is one Wikidata filming location (P915) statement. |
