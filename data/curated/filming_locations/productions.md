|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|production_id |character |Wikidata item ID of the film or series, e.g. `Q23572`. |
|title         |character |Title, in English where Wikidata has an English label, e.g. `Game of Thrones`. |
|kind          |character |`film` or `tv` (a television series). |
|year          |double    |Year of first release, e.g. `2011`. Missing where Wikidata records none. A few are announced releases after 2026. |
|end_year      |double    |Year a series ended, e.g. `2019`. Missing for films, and for series still running or with no end date on Wikidata. |
|sitelinks     |double    |Number of Wikimedia sites (Wikipedia language editions and others) linked to the item, a rough measure of fame, e.g. `139`. |
|n_locations   |double    |Number of places the production is linked to in `production_locations`, e.g. `8`. |
