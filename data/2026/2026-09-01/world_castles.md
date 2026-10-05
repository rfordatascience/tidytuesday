|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|qid         |character |Wikidata item ID, e.g. `Q1067425`. |
|name        |character |Landmark name, in English where available, e.g. `Neuschwanstein Castle`. |
|category    |character |Type of landmark: `castle`, `fortress`, `palace` or `ruin`. |
|country     |character |Country the landmark is in, e.g. `France`. The UK constituent countries are listed separately, e.g. `Scotland`. |
|iso         |character |ISO 3166-1 alpha-2 country code, e.g. `FR`. The UK constituent countries use ISO 3166-2 subdivision codes, e.g. `GB-SCT`. |
|lat         |double    |Latitude in WGS84 decimal degrees, e.g. `48.80472`. |
|lon         |double    |Longitude in WGS84 decimal degrees, e.g. `2.12028`. |
|year        |double    |Founding year, e.g. `1661`. Negative for BC dates, e.g. `-3000`. |
|year_approx |double    |Whether the founding year is an estimate, `1`, or a documented date, `0`. |
|century     |character |Century the founding year falls in, e.g. `17th century` or `30th century BC`. |
|wikipedia   |character |URL of the Wikipedia article, e.g. `https://en.wikipedia.org/wiki/Palace_of_Versailles`. |
|image       |character |URL of a Wikimedia Commons photo, e.g. `https://commons.wikimedia.org/wiki/Special:FilePath/Alhambra%20detail.jpg?width=1280`. |
|sitelinks   |double    |Number of Wikipedia language editions with an article on the landmark, e.g. `95`. |
|pageviews   |double    |Wikipedia pageviews over the trailing 365 days, e.g. `756430`. |
|fame_rank   |double    |Global fame rank, blending `sitelinks` and `pageviews`, where `1` is the most famous. |

