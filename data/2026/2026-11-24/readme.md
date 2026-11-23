# Filming Locations

This week we're exploring filming locations: where films and TV series were shot, as recorded on Wikidata. The data comes from [Movie Scene Map](https://moviescenemap.com/), a free map of filming locations that publishes its files under CC0 at [moviescenemap.com/data](https://moviescenemap.com/data/). This cut keeps only Wikidata's "filming location" (P915) statements: 20,283 links between 12,134 films and series and 7,128 places in 130 countries, from Man Walking Around a Corner (1887) to announced releases. Places read from Wikipedia articles, film archives and city permits, which the site keeps in separate columns, are left out, and so are the video games, anime and manga it places where their stories are set.

> A place is not a scene. P915 records that a production filmed at a place and stops there. Which scene was shot where is not in the data, so it is not in these files either, and it must not be inferred from them.

- Which cities have hosted the most productions, and has that changed from decade to decade?
- Do TV series film in more places than films do?
- In which countries are productions filmed at specific spots rather than recorded only at the city level?

Thank you to [Flightmussy, maker of Movie Scene Map](https://github.com/Flightmussy) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-11-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 47)

locations <- tuesdata$locations
production_locations <- tuesdata$production_locations
productions <- tuesdata$productions

# Option 2: Read directly from GitHub

locations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/locations.csv')
production_locations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/production_locations.csv')
productions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/productions.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-11-24')

# Option 2: Read directly from GitHub and assign to an object

locations = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/locations.csv')
production_locations = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/production_locations.csv')
productions = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/productions.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-11-24")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

locations = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/locations.csv")
production_locations = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/production_locations.csv")
productions = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/productions.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
locations = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/locations.csv", DataFrame)
production_locations = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/production_locations.csv", DataFrame)
productions = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-24/productions.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `locations.csv`

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

### `production_locations.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|production_id |character |Wikidata item ID of the film or series, e.g. `Q23572` (Game of Thrones). Joins to `productions`. |
|location_id   |character |Wikidata item ID of a place it was filmed at, e.g. `Q1722` (Dubrovnik). Joins to `locations`. Each row is one Wikidata filming location (P915) statement. |

### `productions.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|production_id |character |Wikidata item ID of the film or series, e.g. `Q23572`. |
|title         |character |Title, in English where Wikidata has an English label, e.g. `Game of Thrones`. |
|kind          |character |`film` or `tv` (a television series). |
|year          |double    |Year of first release, e.g. `2011`. Missing where Wikidata records none. A few are announced releases after 2026. |
|end_year      |double    |Year a series ended, e.g. `2019`. Missing for films, and for series still running or with no end date on Wikidata. |
|sitelinks     |double    |Number of Wikimedia sites (Wikipedia language editions and others) linked to the item, a rough measure of fame, e.g. `139`. |
|n_locations   |double    |Number of places the production is linked to in `production_locations`, e.g. `8`. |

## Cleaning Script

```python
"""Clean the Movie Scene Map open data into three tidy tables of filming locations.

Source: https://moviescenemap.com/data/ (the files are offered under CC0).

Only Wikidata "filming location" (P915) statements on films and TV series are
kept. The source files also hold places read from Wikipedia articles, from two
national film archives and from city filming permits, each in its own columns,
and video games, anime and manga placed where their story is set (P840). None
of those are in these tables.

Python dependencies: pandas, requests.
Install with: pip install pandas requests
"""

from __future__ import annotations

import io

import pandas as pd
import requests

BASE_URL = "https://moviescenemap.com/data/"
HEADERS = {"User-Agent": "tidytuesday-cleaning (+https://github.com/rfordatascience/tidytuesday)"}

def fetch_csv(file_name: str) -> pd.DataFrame:
    """Download one of the source CSV files and read every column as text."""
    response = requests.get(BASE_URL + file_name, headers=HEADERS, timeout=120)
    response.raise_for_status()
    return pd.read_csv(
        io.StringIO(response.content.decode("utf-8")),
        dtype=str,
        keep_default_na=False,
    )

productions_raw = fetch_csv("productions.csv")
locations_raw = fetch_csv("filming-locations.csv")

# Places: the slug in each place's page address is the key the productions
# file uses in its place_slugs column.
locations_raw["slug"] = locations_raw["url"].str.rstrip("/").str.split("/").str[-1]
places = locations_raw[locations_raw["resolution"].isin(["exact", "town"])]

# Films and TV series with at least one Wikidata filming location statement.
films = productions_raw[
    productions_raw["kind"].isin(["film", "tv"])
    & (productions_raw["relation"] == "filmed at")
    & (productions_raw["place_slugs"] != "")
]

# One row per statement: a production and a place it was filmed at.
production_locations = (
    films[["qid", "place_slugs"]]
    .assign(slug=films["place_slugs"].str.split("; "))
    .explode("slug")
    .merge(places[["slug", "qid"]], on="slug", suffixes=("", "_place"))
    .rename(columns={"qid": "production_id", "qid_place": "location_id"})
    [["production_id", "location_id"]]
    .drop_duplicates()
    .sort_values(["production_id", "location_id"])
    .reset_index(drop=True)
)

productions = (
    films.rename(columns={"qid": "production_id", "name": "title"})
    .merge(
        production_locations.groupby("production_id").size().rename("n_locations"),
        on="production_id",
    )
    .assign(
        year=lambda d: pd.to_numeric(d["year"], errors="coerce").astype("Int64"),
        end_year=lambda d: pd.to_numeric(d["end_year"], errors="coerce").astype("Int64"),
        sitelinks=lambda d: pd.to_numeric(d["sitelinks"], errors="coerce").astype("Int64"),
    )
    [["production_id", "title", "kind", "year", "end_year", "sitelinks", "n_locations"]]
    .sort_values("production_id")
    .reset_index(drop=True)
)

locations = (
    places.rename(columns={"qid": "location_id", "iso": "country_code"})
    .merge(
        production_locations.groupby("location_id").size().rename("n_productions"),
        on="location_id",
    )
    .assign(
        latitude=lambda d: pd.to_numeric(d["latitude"]),
        longitude=lambda d: pd.to_numeric(d["longitude"]),
        wikipedia=lambda d: d["wikipedia"].replace("", pd.NA),
    )
    [
        [
            "location_id",
            "name",
            "category",
            "resolution",
            "latitude",
            "longitude",
            "country",
            "country_code",
            "n_productions",
            "wikipedia",
        ]
    ]
    .sort_values("location_id")
    .reset_index(drop=True)
)

# Every statement joins to a production and a place.
assert production_locations["production_id"].isin(productions["production_id"]).all()
assert production_locations["location_id"].isin(locations["location_id"]).all()

if __name__ == "__main__":
    for name, table in {
        "productions": productions,
        "locations": locations,
        "production_locations": production_locations,
    }.items():
        table.to_csv(f"{name}.csv", index=False, lineterminator="\n")

```
