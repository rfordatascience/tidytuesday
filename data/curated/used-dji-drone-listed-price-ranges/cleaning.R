# Load the pinned Q3 2026 public release. The source file is already an
# aircraft model-level aggregate, so no additional row transformation is
# required for this curated copy.
used_dji_drone_prices <- readr::read_csv(
  "https://raw.githubusercontent.com/Reboot-Hub/dji-drone-specs-used-price-index/v0.2.0/model_price_summary_2026_q3.csv",
  show_col_types = FALSE
)

# Publication-boundary checks documented in the source repository.
stopifnot(nrow(used_dji_drone_prices) == 43)
stopifnot(sum(used_dji_drone_prices$configurations_tracked) == 251)
stopifnot(!anyDuplicated(tolower(used_dji_drone_prices$model)))
stopifnot(all(used_dji_drone_prices$listed_price_low_usd <=
  used_dji_drone_prices$median_listed_price_usd))
stopifnot(all(used_dji_drone_prices$median_listed_price_usd <=
  used_dji_drone_prices$listed_price_high_usd))
stopifnot(all(used_dji_drone_prices$quality_status ==
  "passed_publication_gate"))
