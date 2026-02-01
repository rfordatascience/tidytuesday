library(tidyverse)
library(withr)
library(curl)
library(glue)
library(cli)
library(fs)

# Setup ----

# Create a handle with user agent to avoid 403 errors
handle <- curl::new_handle()
curl::handle_setheaders(
  handle,
  "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
)

# Function to download one year of data
download_tariff_year <- function(year, handle, cache_dir) {
  url <- glue::glue(
    "https://www.usitc.gov/tariff_affairs/documents/tariff_data/tariff_data_{year}.zip"
  )

  zip_file <- fs::path(cache_dir, glue::glue("tariff_data_{year}.zip"))

  # Only download if not already cached
  if (!fs::file_exists(zip_file)) {
    cli::cli_inform("Downloading year {year}...")
    curl::curl_download(url, zip_file, handle = handle)
  }

  return(zip_file)
}

# Function to read one year of data from downloaded file
read_tariff_year <- function(year, cache_dir) {
  zip_file <- fs::path(cache_dir, glue::glue("tariff_data_{year}.zip"))
  extract_dir <- fs::path(cache_dir, glue::glue("extracted_{year}"))

  if (!dir.exists(extract_dir)) {
    cli::cli_inform("Extracting year {year}...")
    fs::dir_create(extract_dir, recurse = TRUE)
    utils::unzip(zip_file, exdir = extract_dir)
  }

  txt_file <- fs::dir_ls(extract_dir, glob = "*.txt")
  if (length(txt_file) != 1) {
    cli::cli_abort("Year {year} has something wrong with its files.")
  }
  cli::cli_inform("Fixing year {year}...")

  # Detect delimiter (some years use pipe, others use comma)
  first_line <- readLines(txt_file, n = 1)
  delim <- ifelse(stringr::str_detect(first_line, "\\|"), "|", ",")
  expected_cols <- stringr::str_count(first_line, stringr::fixed(delim)) + 1

  # Some files (e.g., 2011) have embedded newlines in text fields
  # Read all lines and fix malformed rows before parsing
  all_lines <- readLines(txt_file)
  header <- all_lines[[1]]
  data_lines <- all_lines[-1]

  # Fix rows that don't have the expected number of delimiters
  # by joining them with the next row(s) until we have the right count
  fixed_lines <- character()
  i <- 1
  while (i <= length(data_lines)) {
    current_line <- data_lines[i]
    delim_count <- stringr::str_count(current_line, stringr::fixed(delim))

    # If line has too few delimiters, append next lines until we have enough
    while (delim_count < (expected_cols - 1) && (i + 1) <= length(data_lines)) {
      i <- i + 1
      current_line <- paste(current_line, data_lines[i])
      delim_count <- stringr::str_count(current_line, stringr::fixed(delim))
    }

    fixed_lines <- c(fixed_lines, current_line)
    i <- i + 1
  }

  # Save it as a locally-temporary tempfile because we want to re-process if we
  # change this function.
  fixed_file <- withr::local_tempfile(fileext = ".txt")
  writeLines(c(header, fixed_lines), fixed_file)

  cli::cli_inform("Reading year {year}...")
  data <- readr::read_delim(
    fixed_file,
    delim = delim,
    col_types = readr::cols(.default = "c"),
    show_col_types = FALSE
  )
  return(data)
}

# Setup cache directory. Hard-code the path so we use the same dir if we rerun.
cache_dir <- fs::path(tempdir(), "tariff_cache")
on.exit(unlink(cache_dir), add = TRUE)
fs::dir_create(cache_dir, recurse = TRUE)

years <- 1997:2025

zip_files <- purrr::map(
  years,
  download_tariff_year,
  handle = handle,
  cache_dir = cache_dir
)

tariff_raw <- purrr::map_dfr(
  years,
  read_tariff_year,
  cache_dir = cache_dir
)

# Convert date columns after combining all years
# Handle both "MM/DD/YYYY HH:MM:SS" and "MM/DD/YYYY" formats

tariff_raw <- tariff_raw |>
  dplyr::rename(
    begin_effective_date = "begin_effect_date"
  ) |>
  dplyr::mutate(
    dplyr::across(
      tidyselect::ends_with("_effective_date"),
      \(date_col) {
        stringr::str_extract(date_col, "^\\S+") |>
          lubridate::mdy()
      }
    )
  ) |>
  dplyr::distinct()

# Clean and create tidy datasets

# Dataset 1: HTS Code lookup table ----

# Contains product descriptions and units for each HTS code
tariff_codes <- tariff_raw |>
  dplyr::select(
    "begin_effective_date",
    "hts8",
    description = "brief_description",
    "quantity_1_code",
    "quantity_2_code",
    "wto_binding_code"
  ) |>
  dplyr::arrange(.data$hts8, .data$begin_effective_date) |>
  dplyr::distinct(
    .data$hts8,
    .data$description,
    .data$quantity_1_code,
    .data$quantity_2_code,
    .data$wto_binding_code,
    .keep_all = TRUE
  ) |>
  dplyr::rename(earliest_effective_date = "begin_effective_date")

# Dataset 2: Quantity codes lookup table ----
# Extracted from USITC Tariff Database Code Key
td_codes_file <- withr::local_tempfile(fileext = ".pdf")
curl::curl_download(
  "https://www.usitc.gov/applications/dataweb/td-codes.pdf",
  td_codes_file,
  handle = handle
)

# Extract quantity codes table from PDF
pdf_text <- pdftools::pdf_text(td_codes_file)

# Quantity codes span pages 3-5
quantity_code_text <- paste(pdf_text[3:5], collapse = "\n")
lines <- strsplit(quantity_code_text, "\n")[[1]]

# Find table start (after header and column names)
start_idx <- which(stringr::str_detect(
  lines,
  "Description of quantity codes"
)) +
  2

# Extract and clean table lines
table_lines <- lines[start_idx:length(lines)] |>
  stringr::str_trim()
table_lines <- table_lines[nzchar(table_lines)]

# Most lines have format: CODE  description (with 2+ spaces)
# One entry (NA) has its description split across 3 lines
# Identify lines without the standard 2-space separator (these are extra pieces)
line_numbers_to_merge <- stringr::str_which(table_lines, "  ", negate = TRUE)
extra_pieces <- table_lines[line_numbers_to_merge]

# Extract codes and descriptions from normal lines
normal_pieces <- stringr::str_subset(table_lines, "  ")
codes <- stringr::str_extract(normal_pieces, "^\\S+")
descriptions <- stringr::str_extract(normal_pieces, "\\s{2}(\\S.+$)", 1)

# Merge the multi-line description for NA code
na_line_number <- line_numbers_to_merge[[1]]
descriptions[[na_line_number]] <- paste(
  extra_pieces[[1]],
  descriptions[[na_line_number]],
  extra_pieces[[2]]
)

quantity_codes <- tibble::tibble(
  code = codes,
  description = descriptions
)

# Dataset 3: Agreements lookup table ----

# Manually constructed from
# https://www.usitc.gov/applications/dataweb/td-fields.pdf
agreements <- tibble::tribble(
  ~agreement,
  ~agreement_full,
  ~agreement_notes,
  "agoa",
  "African Growth and Opportunity Act (AGOA)",
  NA_character_,
  "apta",
  "Automotive Products Trade Act (APTA)",
  "Duty-free",
  "atpa",
  "Andean Trade Preference Act (ATPA)",
  "Program expired",
  "atpa*",
  "Andean Trade Preference Act (ATPA)",
  "Certain products excluded; program expired",
  "atpdea",
  "Andean Trade Promotion and Drug Eradication Act (ATPDEA)",
  "Program expired",
  "australia",
  "Australia-United States Free Trade Agreement",
  NA_character_,
  "bahrain",
  "Bahrain-United States Free Trade Agreement",
  NA_character_,
  "canada",
  "North American Free Trade Agreement (NAFTA)",
  "Canada",
  "cbi",
  "Caribbean Basin Initiative (CBI)",
  NA_character_,
  "cbi*",
  "Caribbean Basin Initiative (CBI)",
  "Certain products or countries excluded",
  "cbtpa",
  "Caribbean Basin Trade Partnership Act (CBTPA)",
  NA_character_,
  "chile",
  "Chile-United States Free Trade Agreement",
  NA_character_,
  "civil_air",
  "Agreement on Trade in Civil Aircraft",
  "Duty-free",
  "col2",
  "Column 2 Rates",
  "Non-market economy countries",
  "colombia",
  "Colombia-United States Trade Promotion Agreement",
  NA_character_,
  "dr_cafta",
  "Dominican Republic-Central America Free Trade Agreement (DR-CAFTA)",
  NA_character_,
  "dr_cafta_plus",
  "Dominican Republic-Central America Free Trade Agreement (DR-CAFTA)",
  "Plus rate",
  "dyes",
  "Uruguay Round Concessions on Intermediate Chemicals for Dyes",
  "Duty-free",
  "gsp",
  "Generalized System of Preferences (GSP)",
  "Duty-free for eligible beneficiary countries",
  "israel_fta",
  "Israel-United States Free Trade Agreement",
  "Duty-free",
  "japan",
  "United States-Japan Trade Agreement",
  NA_character_,
  "jordan",
  "Jordan-United States Free Trade Agreement",
  NA_character_,
  "korea",
  "Korea-United States Free Trade Agreement (KORUS)",
  NA_character_,
  "mexico",
  "North American Free Trade Agreement (NAFTA)",
  "Mexico",
  "mfn",
  "Most Favored Nation (MFN) / Normal Trade Relations (NTR)",
  "Standard rates for WTO members",
  "morocco",
  "Morocco-United States Free Trade Agreement",
  NA_character_,
  "nepal",
  "Nepal Trade Preference Program",
  NA_character_,
  "oman",
  "Oman-United States Free Trade Agreement",
  NA_character_,
  "panama",
  "Panama-United States Trade Promotion Agreement",
  NA_character_,
  "peru",
  "Peru-United States Trade Promotion Agreement",
  NA_character_,
  "pharmaceutical",
  "Agreement on Trade in Pharmaceutical Products",
  "Duty-free",
  "singapore",
  "Singapore-United States Free Trade Agreement",
  NA_character_,
  "usmca",
  "United States-Mexico-Canada Agreement (USMCA)",
  NA_character_,
  "usmca+",
  "United States-Mexico-Canada Agreement (USMCA)",
  "Plus rate"
)

# Dataset 4: Tariff rates in long format ----

# Each row represents one agreement's rate for an HTS code during a time period
# This includes MFN (Most Favored Nation) and COL2 (Column 2) as agreement types

# Step 1: Pivot all rate data to long format
tariff_rates_long <- tariff_raw |>
  dplyr::select(
    "hts8",
    "begin_effective_date",
    "end_effective_date",
    tidyselect::ends_with("_rate_type_code"),
    tidyselect::ends_with("_ad_val_rate"),
    tidyselect::ends_with("_specific_rate"),
    tidyselect::ends_with("_indicator")
  ) |>
  tidyr::pivot_longer(
    cols = c(
      tidyselect::ends_with("_rate_type_code"),
      tidyselect::ends_with("_ad_val_rate"),
      tidyselect::ends_with("_specific_rate"),
      tidyselect::ends_with("_indicator")
    ),
    names_to = c("agreement", ".value"),
    names_pattern = "^(.+)_(rate_type_code|ad_val_rate|specific_rate|indicator)$"
  ) |>
  dplyr::filter(
    !is.na(.data$ad_val_rate) |
      !is.na(.data$specific_rate) |
      !is.na(.data$rate_type_code)
  ) |>
  dplyr::mutate(
    dplyr::across(
      c("ad_val_rate", "specific_rate"),
      as.numeric
    )
  ) |>
  # Merge "agreement" and "indicator"
  dplyr::mutate(
    agreement = dplyr::case_when(
      .data$agreement == "atpa" & .data$indicator == "J*" ~ "atpa*",
      .data$agreement == "cbi" & .data$indicator == "E*" ~ "cbi*",
      .data$agreement == "usmca" & .data$indicator == "S+" ~ "usmca+",
      TRUE ~ .data$agreement
    )
  ) |>
  dplyr::select(-"indicator") |>
  dplyr::mutate(
    chapter = as.integer(substr(.data$hts8, 1, 2))
  ) |>
  dplyr::distinct()

# Step 2: Split by HTS chapter groups to stay under size limits
tariff_agricultural <- tariff_rates_long |>
  dplyr::filter(.data$chapter < 25) |>
  dplyr::select(-"chapter")
