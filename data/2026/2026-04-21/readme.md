# Global Health Spending

This week we're exploring global health spending data. The
[WHO Global Health Expenditure Database (GHED)](https://apps.who.int/nha/database)
provides comparable data on health expenditure for 195 countries and territories since 2000.

The data tracks how much countries spend on health care, where the money comes from (government, private,
or external sources), how it is channelled through financing schemes (e.g. government programmes, 
voluntary insurance, out-of-pocket payments), and what it is spent on (e.g. curative care, 
preventive care, medical goods). How health systems are funded and how resources are allocated directly 
shapes health outcomes, progress toward universal health coverage, and whether households face financial 
hardship when accessing care. These indicators are essential to inform health policy decisions.

The data is organised into three datasets:

- **`health_spending`** — Aggregate health spending and its breakdown by funding source (domestic government, domestic private, and external aid).
- **`financing_schemes`** — Health spending by financing scheme (e.g. government schemes, voluntary insurance, out-of-pocket payments).
- **`spending_purpose`** — Health spending by health care function (e.g. curative care, preventive care, medical goods).

Some questions to explore:

- Which countries rely most heavily on out-of-pocket payments for health care?
- How has the balance between government, private, and external aid changed over time?
- What is the split between curative and preventive care spending across countries?
- How did the COVID-19 pandemic impact health spending patterns?

Visit the [GHED portal](https://apps.who.int/nha/database/) or use the open-source [`bblocks-data-importers` Python package](https://github.com/ONEcampaign/bblocks_data_importers)
for additional indicators and data beyond what is included here.

See example visualisations using the same underlying data:

- [Health care spending is not evenly distributed](https://data.one.org/analysis/health-spending-inequality)
- [The hidden fragility of preventive health spending](https://data.one.org/analysis/hidden-fragility-of-prevention-spending)
- [Africa falls short on health spending](https://data.one.org/analysis/african_gov_health-spending-off-track)
- [A turning point in health financing](https://data.one.org/analysis/turning-point-in-health-financing)

The data was processed using [ONE Data](https://data.one.org)'s open-source [`bblocks-data-importers` Python package](https://github.com/ONEcampaign/bblocks_data_importers), and can also be explored interactively through the [Health Financing Agent](https://data.one.org/tools/agents/health-financing).

Thank you to [Luca Picci; ONE Data](https://github.com/lpicci96) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-04-21')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 16)

financing_schemes <- tuesdata$financing_schemes
health_spending <- tuesdata$health_spending
spending_purpose <- tuesdata$spending_purpose

# Option 2: Read directly from GitHub

financing_schemes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/financing_schemes.csv')
health_spending <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/health_spending.csv')
spending_purpose <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/spending_purpose.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-04-21')

# Option 2: Read directly from GitHub and assign to an object

financing_schemes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/financing_schemes.csv')
health_spending = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/health_spending.csv')
spending_purpose = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/spending_purpose.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-04-21")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

financing_schemes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/financing_schemes.csv")
health_spending = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/health_spending.csv")
spending_purpose = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/spending_purpose.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
financing_schemes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/financing_schemes.csv", DataFrame)
health_spending = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/health_spending.csv", DataFrame)
spending_purpose = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-21/spending_purpose.csv", DataFrame)
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

### `financing_schemes.csv`

|variable |class |description |
|:--------|:-----|:-----------|
|country_name |character |Country or territory name as used by WHO. |
|iso3_code |character |ISO 3166-1 alpha-3 country code. |
|year |integer |Year of observation. |
|indicator_code |character |GHED indicator code. Suffix indicates unit: <code>_che</code> = % of CHE, <code>_usd2023</code> = constant 2023 US$. <br><br>Indicators: <br><code>hf1</code> — Government schemes and compulsory contributory health care financing schemes. <br><code>hf2</code> — Voluntary health care payment schemes. <br><code>hf3</code> — Household out-of-pocket payments (OOPS). <br><code>hf4</code> — Rest of the world financing schemes (non-resident). <br><code>hfnec</code> — Unspecified financing schemes (n.e.c.). |
|financing_scheme |character |Health care financing scheme. |
|value |double |Indicator value in the unit specified. |
|unit |character |Unit of measurement: <code>% of current health expenditure</code> or <code>constant 2023 US$</code>. |

### `health_spending.csv`

|variable |class |description |
|:--------|:-----|:-----------|
|country_name |character |Country or territory name as used by WHO. |
|iso3_code |character |ISO 3166-1 alpha-3 country code. |
|year |integer |Year of observation. |
|indicator_code |character |GHED indicator code. Suffix indicates unit: <code>_che</code> = % of CHE, <code>_usd2023</code> = constant 2023 US$. <br><br>Indicators: <br><code>che</code> — Current health expenditure (total, only <code>_usd2023</code>). <br><code>gghed</code> — Domestic general government health expenditure (GGHE-D). <br><code>pvtd</code> — Domestic private health expenditure (PVT-D). <br><code>ext</code> — External health expenditure (EXT). |
|expenditure_type |character |Type of health expenditure. |
|value |double |Indicator value in the unit specified. |
|unit |character |Unit of measurement: <code>% of current health expenditure</code> or <code>constant 2023 US$</code>. |

### `spending_purpose.csv`

|variable |class |description |
|:--------|:-----|:-----------|
|country_name |character |Country or territory name as used by WHO. |
|iso3_code |character |ISO 3166-1 alpha-3 country code. |
|year |integer |Year of observation. |
|indicator_code |character |GHED indicator code. Suffix indicates unit: <code>_che</code> = % of CHE, <code>_usd2023</code> = constant 2023 US$. Data available from 2016 onwards. <br><br>Indicators: <br><code>hc1</code> — Curative care. <br><code>hc2</code> — Rehabilitative care. <br><code>hc3</code> — Long-term care (health). <br><code>hc4</code> — Ancillary services. <br><code>hc5</code> — Medical goods. <br><code>hc6</code> — Preventive care. <br><code>hc7</code> — Governance and health system administration. <br><code>hc9</code> — Other health care services (n.e.c.). |
|spending_purpose |character |Health care function or purpose of spending. |
|value |double |Indicator value in the unit specified. |
|unit |character |Unit of measurement: <code>% of current health expenditure</code> or <code>constant 2023 US$</code>. |

## Cleaning Script

```python
"""Clean data from the WHO Global Health Expenditure Database (GHED).

Python dependencies: bblocks-data-importers, pandas.
Install with: pip install bblocks-data-importers pandas
"""

from __future__ import annotations

import logging
from pathlib import Path

import pandas as pd
from bblocks.data_importers.who.ghed import GHED

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Latest complete year in the GHED source data. Observations from later years
# are excluded because they may be incomplete or provisional.
MAX_YEAR = 2023

# Output columns
COLUMNS: list[str] = [
    "country_name",
    "iso3_code",
    "year",
    "indicator_code",
    "indicator_name",
    "value",
    "unit",
]

# Normalise values to single units based on source unit column
SCALE_FACTORS: dict[str, int] = {
    "Millions": 1_000_000,
    "Thousands": 1_000,
}

# Unit suffixes to append to each indicator prefix
UNIT_SUFFIXES: list[str] = ["_che", "_usd2023"]

# --- Indicator definitions (prefixes only, suffixes added automatically) ---

# Health Spending: aggregate spending & source breakdown
# Note: "che" (total CHE) only produces che_usd2023 — che_che (CHE as % of CHE)
# is trivially 100% and does not exist in the GHED source data.
HEALTH_SPENDING_INDICATORS: list[str] = [
    "che",      # Current health expenditure (CHE)
    "gghed",    # Domestic general government health expenditure (GGHE-D)
    "pvtd",     # Domestic private health expenditure (PVT-D)
    "ext",      # External health expenditure (EXT)
]

# Financing Schemes
FINANCING_SCHEMES_INDICATORS: list[str] = [
    "hf1",      # Government schemes and compulsory contributory HCF
    "hf2",      # Voluntary health care payment schemes
    "hf3",      # Out-of-pocket payments (OOPS)
    "hf4",      # Rest of the world financing schemes
    "hfnec",    # Non-specified financing schemes
]

# Spending Purpose: health care function
SPENDING_PURPOSE_INDICATORS: list[str] = [
    "hc1",      # Curative care
    "hc2",      # Rehabilitative care
    "hc3",      # Long-term care (health)
    "hc4",      # Ancillary services
    "hc5",      # Medical goods
    "hc6",      # Preventive care
    "hc7",      # Governance and health system administration
    "hc9",      # Other health care services (n.e.c.)
]

def _clean_unit(indicator_code: str) -> str:
    """Derive a clean unit label from the indicator code suffix."""
    if indicator_code.endswith("_che"):
        return "% of current health expenditure"
    if indicator_code.endswith("_usd2023"):
        return "constant 2023 US$"
    raise ValueError(f"Unknown unit suffix in indicator code: {indicator_code!r}")

def _expand_indicators(prefixes: list[str]) -> list[str]:
    """Expand indicator prefixes with unit suffixes to get full indicator codes."""
    return [f"{prefix}{suffix}" for prefix in prefixes for suffix in UNIT_SUFFIXES]

def build_dataset(
    df: pd.DataFrame,
    prefixes: list[str],
    *,
    name_column: str = "indicator_name",
) -> pd.DataFrame:
    """Filter data for given indicator prefixes, apply clean units, return tidy long format.

    Args:
        df: Full GHED dataframe.
        prefixes: Indicator code prefixes (e.g. ["hc1", "hc2"]).
        name_column: Name for the indicator_name column in the output.

    Returns:
        Cleaned dataframe with standardised columns and units.
    """
    codes = _expand_indicators(prefixes)
    subset = df[(df["indicator_code"].isin(codes)) & (df["year"] <= MAX_YEAR)].copy()
    # Scale values to single units (e.g. millions -> ones)
    for source_unit, factor in SCALE_FACTORS.items():
        mask = subset["unit"] == source_unit
        subset.loc[mask, "value"] = subset.loc[mask, "value"] * factor
    # Clamp floating-point artifacts (e.g. -1e-12) to zero
    subset["value"] = subset["value"].clip(lower=0)
    # Apply clean unit labels
    subset["unit"] = subset["indicator_code"].map(_clean_unit)
    subset["indicator_name"] = subset["indicator_name"].str.replace(
        r"[, ]+(?:in (?:million|thousand) |as %[ ]?(?:of )?).*$", "", regex=True
    )
    subset = subset.rename(columns={"indicator_name": name_column})
    columns = [name_column if c == "indicator_name" else c for c in COLUMNS]
    subset = subset[columns].dropna(subset=["value"])
    return subset.sort_values(
        ["country_name", "year", "indicator_code"]
    ).reset_index(drop=True)

def main() -> None:
    """Fetch GHED data, build datasets, and save to CSV."""
    output_dir = Path(__file__).parent

    ghed = GHED()
    data = ghed.get_data()

    datasets: dict[str, pd.DataFrame] = {
        "health_spending": build_dataset(data, HEALTH_SPENDING_INDICATORS, name_column="expenditure_type"),
        "financing_schemes": build_dataset(data, FINANCING_SCHEMES_INDICATORS, name_column="financing_scheme"),
        "spending_purpose": build_dataset(data, SPENDING_PURPOSE_INDICATORS, name_column="spending_purpose"),
    }

    for name, df in datasets.items():
        df.to_csv(output_dir / f"{name}.csv", index=False)
        logger.info(f"Successfully saved {name}.csv")

if __name__ == "__main__":
    main()

```
