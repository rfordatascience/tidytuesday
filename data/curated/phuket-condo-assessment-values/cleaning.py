"""Build the Phuket condominium assessment-rate dataset.

Source: Thailand Treasury Department ``Condominium Valuation`` resource,
distributed through the National Housing Information Center (NHIC).

Python dependencies: pandas.
Install with: python -m pip install pandas

The script pins the official full-dump checksum so that a silent source change
cannot produce a different release under the same description. By default it
downloads the official CKAN DataStore CSV. ``--source`` can point to an exact
local copy of that CSV (plain or gzip-compressed) for an offline rerun.
"""

from __future__ import annotations

import argparse
from io import BytesIO
import gzip
import hashlib
from pathlib import Path
import re
import urllib.request

import pandas as pd


SOURCE_URL = (
    "https://gdcatalognhic.nha.co.th/datastore/dump/"
    "b115b105-58c6-4c3d-8ca8-687f7501e296?format=csv"
)
SOURCE_SHA256 = "89d14f4a0ff577035b843b258f85762f932d750dc2dca46530d61d3458b973a1"
OUTPUT_SHA256 = "42ac4ee27c8aea208094bf0a0d75eee4d9798ddee82f4af584cb773d93c94889"
SOURCE_ROW_COUNT = 122_112
PHUKET_ROW_COUNT = 4_707
CURATED_ROW_COUNT = 4_704
EXACT_CONTENT_DUPLICATE_COUNT = 3
PHUKET_PROVINCE_CODE = 83
VALUE_BASIS = "official_statutory_assessment_rate_not_market_price"

SOURCE_COLUMNS = [
    "_id",
    "CONDO_ID",
    "CONDO_NAME",
    "BUILD_NAME",
    "CHANGWAT_CODE",
    "CHANGWAT_NAME",
    "AMPHUR_CODE",
    "AMPHUR_NAME",
    "TUMBON_CODE",
    "TUMBON_NAME",
    "BRANCH_CODE",
    "BRANCH_NAME",
    "OFLEVEL",
    "USE_CATG",
    "VAL_AMT_P_MET",
]

OUTPUT_COLUMNS = [
    "datastore_row_id",
    "condominium_id",
    "condominium_name_th",
    "building_name_th",
    "province_code",
    "province_name_th",
    "district_code",
    "district_name_th",
    "subdistrict_code_source",
    "subdistrict_name_th_source",
    "land_office_branch_code",
    "land_office_branch_name_th",
    "floor_or_range_source",
    "floor_value_has_thai_month_token",
    "use_category_th",
    "assessed_value_thb_per_sqm",
    "value_basis",
]

RENAME_COLUMNS = {
    "_id": "datastore_row_id",
    "CONDO_ID": "condominium_id",
    "CONDO_NAME": "condominium_name_th",
    "BUILD_NAME": "building_name_th",
    "CHANGWAT_CODE": "province_code",
    "CHANGWAT_NAME": "province_name_th",
    "AMPHUR_CODE": "district_code",
    "AMPHUR_NAME": "district_name_th",
    "TUMBON_CODE": "subdistrict_code_source",
    "TUMBON_NAME": "subdistrict_name_th_source",
    "BRANCH_CODE": "land_office_branch_code",
    "BRANCH_NAME": "land_office_branch_name_th",
    "OFLEVEL": "floor_or_range_source",
    "USE_CATG": "use_category_th",
    "VAL_AMT_P_MET": "assessed_value_thb_per_sqm",
}

INTEGER_SOURCE_COLUMNS = [
    "_id",
    "CONDO_ID",
    "CHANGWAT_CODE",
    "AMPHUR_CODE",
    "BRANCH_CODE",
    "VAL_AMT_P_MET",
]

THAI_MONTH_TOKEN = re.compile(
    r"(?:ม\.ค\.|ก\.พ\.|มี\.ค\.|เม\.ย\.|พ\.ค\.|มิ\.ย\."
    r"|ก\.ค\.|ส\.ค\.|ก\.ย\.|ต\.ค\.|พ\.ย\.|ธ\.ค\.)"
)


def sha256(payload: bytes) -> str:
    """Return a lowercase SHA-256 digest."""
    return hashlib.sha256(payload).hexdigest()


def download_source() -> bytes:
    """Download the complete official CKAN DataStore CSV."""
    request = urllib.request.Request(
        SOURCE_URL,
        headers={"User-Agent": "TidyTuesday-PhuketAssessment/1.0"},
    )
    with urllib.request.urlopen(request, timeout=180) as response:
        if response.status != 200:
            raise RuntimeError(f"Source returned HTTP {response.status}")
        return response.read()


def read_source(path: Path | None) -> bytes:
    """Read a local exact source copy or download the official source."""
    if path is None:
        payload = download_source()
    else:
        payload = path.read_bytes()
        if path.suffix.casefold() == ".gz":
            payload = gzip.decompress(payload)

    actual_hash = sha256(payload)
    if actual_hash != SOURCE_SHA256:
        raise ValueError(
            "Official source checksum changed: "
            f"{actual_hash} != {SOURCE_SHA256}. Review the new source before "
            "updating this curated snapshot."
        )
    return payload


def parse_integer_column(series: pd.Series, name: str) -> pd.Series:
    """Parse a source column as exact integers and reject lossy values."""
    parsed = pd.to_numeric(series, errors="raise")
    if parsed.isna().any() or (parsed % 1 != 0).any():
        raise ValueError(f"{name} contains a missing or non-integral value")
    return parsed.astype("int64")


def build_dataset(source_payload: bytes) -> pd.DataFrame:
    """Filter the official national table to Phuket and add QA flags."""
    source = pd.read_csv(
        BytesIO(source_payload),
        dtype="string",
        keep_default_na=False,
        encoding="utf-8",
    )
    if list(source.columns) != SOURCE_COLUMNS:
        raise ValueError(f"Unexpected source columns: {list(source.columns)!r}")
    if len(source) != SOURCE_ROW_COUNT:
        raise ValueError(
            f"Unexpected source row count: {len(source)} != {SOURCE_ROW_COUNT}"
        )

    # Parse only the fields required to identify and filter rows before the
    # subset is selected. Other provinces contain source missingness in measure
    # fields that is outside this curated Phuket release.
    for column in ["_id", "CHANGWAT_CODE"]:
        source[column] = parse_integer_column(source[column], column)

    if not source["_id"].is_unique or not source["_id"].is_monotonic_increasing:
        raise ValueError("CKAN _id values must be unique and ascending")

    phuket_source = source.loc[source["CHANGWAT_CODE"].eq(PHUKET_PROVINCE_CODE)].copy()
    if len(phuket_source) != PHUKET_ROW_COUNT:
        raise ValueError(
            f"Unexpected Phuket row count: {len(phuket_source)} != {PHUKET_ROW_COUNT}"
        )
    if set(phuket_source["CHANGWAT_NAME"]) != {"ภูเก็ต"}:
        raise ValueError("Province name disagrees with province code 83")

    for column in INTEGER_SOURCE_COLUMNS:
        phuket_source[column] = parse_integer_column(phuket_source[column], column)
    if (phuket_source["CONDO_ID"] <= 0).any():
        raise ValueError("CONDO_ID contains a non-positive value")
    if (phuket_source["VAL_AMT_P_MET"] <= 0).any():
        raise ValueError("VAL_AMT_P_MET contains a non-positive value")

    # Rows are assessment-rate table records, not physical units. The source
    # contains three exact content duplicates when CKAN's internal _id is
    # ignored. Because _id is already verified as ascending, keep the lowest
    # CKAN identifier from each equivalent group and remove later copies.
    content_columns = [name for name in SOURCE_COLUMNS if name != "_id"]
    duplicate_mask = phuket_source.duplicated(
        subset=content_columns,
        keep="first",
    )
    if int(duplicate_mask.sum()) != EXACT_CONTENT_DUPLICATE_COUNT:
        raise ValueError("Unexpected exact-content duplicate count")
    phuket_source = phuket_source.loc[~duplicate_mask].copy()
    if len(phuket_source) != CURATED_ROW_COUNT:
        raise ValueError(
            f"Unexpected curated row count: {len(phuket_source)} != "
            f"{CURATED_ROW_COUNT}"
        )

    phuket_condo_assessment = phuket_source.rename(columns=RENAME_COLUMNS)
    phuket_condo_assessment["floor_value_has_thai_month_token"] = (
        phuket_condo_assessment["floor_or_range_source"]
        .str.contains(THAI_MONTH_TOKEN, regex=True, na=False)
        .astype(bool)
    )
    phuket_condo_assessment["value_basis"] = VALUE_BASIS
    phuket_condo_assessment = (
        phuket_condo_assessment[OUTPUT_COLUMNS]
        .sort_values("datastore_row_id", kind="stable")
        .reset_index(drop=True)
    )

    # Stable data-quality contract for this snapshot.
    if len(phuket_condo_assessment) != CURATED_ROW_COUNT:
        raise ValueError("Unexpected final curated row count")
    if phuket_condo_assessment["condominium_id"].nunique() != 304:
        raise ValueError("Unexpected distinct condominium_id count")
    if phuket_condo_assessment["floor_value_has_thai_month_token"].sum() != 578:
        raise ValueError("Unexpected Thai month-token flag count")
    literal_null = phuket_condo_assessment["subdistrict_code_source"].eq(
        "NULL"
    ) & phuket_condo_assessment["subdistrict_name_th_source"].eq("NULL")
    if literal_null.sum() != 170:
        raise ValueError("Unexpected literal NULL subdistrict count")
    if phuket_condo_assessment["use_category_th"].nunique() != 108:
        raise ValueError("Unexpected raw use-category count")

    return phuket_condo_assessment


def save_dataset(phuket_condo_assessment: pd.DataFrame, output: Path) -> None:
    """Save deterministic UTF-8 CSV and verify the curated release checksum."""
    phuket_condo_assessment.to_csv(
        output,
        index=False,
        encoding="utf-8",
        lineterminator="\n",
    )
    actual_hash = sha256(output.read_bytes())
    if actual_hash != OUTPUT_SHA256:
        raise ValueError(
            f"Curated CSV checksum changed: {actual_hash} != {OUTPUT_SHA256}"
        )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--source",
        type=Path,
        help="Optional exact local copy of the official CSV, plain or .gz.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).with_name("phuket_condo_assessment.csv"),
        help="Output CSV path (default: beside this script).",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    source_payload = read_source(args.source)
    phuket_condo_assessment = build_dataset(source_payload)
    save_dataset(phuket_condo_assessment, args.output)
    print(
        f"Wrote {len(phuket_condo_assessment):,} rows to {args.output} "
        f"(sha256={OUTPUT_SHA256})"
    )


if __name__ == "__main__":
    main()
