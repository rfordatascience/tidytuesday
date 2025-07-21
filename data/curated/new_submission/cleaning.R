# Clean data provided by the State of New York's data.ny.gov. No cleaning was
# necessary. We split off the station_lines dataset as a demonstration.

library(tidyverse)
mta_art <- readr::read_csv("https://data.ny.gov/resource/4y8j-9pkd.csv")

station_lines <- mta_art |>
  dplyr::select("agency", "station_name", "line") |>
  dplyr::filter(!is.na(.data$line)) |>
  tidyr::separate_longer_delim("line", ",")
