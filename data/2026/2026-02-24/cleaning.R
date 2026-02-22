################################################################################
# Science Foundation Ireland (SFI) Grants Commitments
# https://www.sfi.ie/about-us/governance/open-data/Open-Data-2024-07-31.csv
# Accessed 2026-02-22
################################################################################

# Packages ---------------------------------------------------------------------
library(readr)
library(dplyr)
library(stringr)

# Loading and tidying dataset --------------------------------------------------
sfi_grants_raw <- readr::read_csv(
  "https://www.sfi.ie/about-us/governance/open-data/Open-Data-2024-07-31.csv"
)
sfi_grants <- sfi_grants_raw |>
  janitor::clean_names() |>
  dplyr::select(
    start_date,
    end_date,
    proposal_id,
    programme_name,
    sub_programme,
    supplement,
    research_body,
    research_body_ror_id,
    funder_name,
    crossref_funder_registry_id,
    proposal_title,
    current_total_commitment
  ) |>
  # 1. Change dates from character format to date format
  # 2. current_total_commitment is currently as character but for some values has
  #   a comma and or () in it. We will remove these before converting to a numeric.
  dplyr::mutate(
    start_date = as.Date(start_date),
    end_date = as.Date(end_date),
    current_total_commitment = stringr::str_remove_all(
      current_total_commitment,
      "\\(|,|\\)"
    ),
    current_total_commitment = as.double(current_total_commitment)
  ) |>
  # 3. A few columns sometimes code NA as "#N/A" rather than "".
  dplyr::mutate(
    dplyr::across(
      c(programme_name, sub_programme, supplement),
      \(x) {
        dplyr::na_if(x, "#N/A")
      }
    )
  )

