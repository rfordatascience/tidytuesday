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
