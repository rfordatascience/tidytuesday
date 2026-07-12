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

