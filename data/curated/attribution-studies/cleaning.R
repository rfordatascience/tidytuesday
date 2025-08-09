# Data provided by Carbon Brief
# Data available at https://interactive.carbonbrief.org/attribution-studies/data/papers-download.csv

library(tidyverse)
library(here)
library(janitor)

# Import Carbon Brief's Climate attribution studies dataset
attribution_studies_raw <- readr::read_csv(
  "https://interactive.carbonbrief.org/attribution-studies/data/papers-download.csv"
) |>
  janitor::clean_names()


# Helper functions -------------------------------------------------------

# Function to standardize year spans to consistent yyyy-yyyy format
clean_yearspan <- function(match) {
  # Split the span using "-" as a delimiter
  parts <- stringr::str_split(match, "-")[[1]]
  start_year <- as.numeric(parts[1])
  # Extract century from start year (e.g. 20 from 2020)
  century <- start_year %/% 100
  # Combine the years
  glue::glue("{parts[1]}-{century}{parts[2]}")
}

# Function to clean and standardize data strings
clean_date_string <- function(col) {
  col |>
    stringr::str_replace_all("–", "-") |>
    # Find yyyy-yy patters and convert to yyyy-yyyy
    stringr::str_replace_all("(\\d{4})-(\\d{2}$)", \(match) {
      clean_yearspan(match)
    }) |>
    stringr::str_replace_all(" & ", ", ")
}

# Data Cleaning ----------------------------------------------------------

attribution_studies <- attribution_studies_raw |>
  janitor::clean_names() |>
  # Separate event names from time periods
  # and split them into separate 'event_name' and 'event_period' columns
  tidyr::separate_wider_regex(
    name,
    patterns = c(
      event_name = ".*",
      ", ",
      event_period = ".*",
      "\\s\\(.*"
    ),
    too_few = "align_start"
  ) |>
  # Create standardized variables
  dplyr::mutate(
    event_year_trend = clean_date_string(event_year_trend),
    event_period = dplyr::case_when(
      is.na(event_period) & event_year_trend != "Trend" ~
        dplyr::coalesce(event_period, event_year_trend),
      TRUE ~ event_period
    ) |>
      clean_date_string(),
    event_year = dplyr::case_when(
      event_year_trend != "Trend" ~ event_year_trend,
      TRUE ~ NA_character_
    ),
    study_focus = dplyr::case_when(
      event_year_trend == "Trend" ~ "Trend",
      TRUE ~ "Event",
    ),
    .before = iso_country_code
  ) |>
  dplyr::select(!event_year_trend)
