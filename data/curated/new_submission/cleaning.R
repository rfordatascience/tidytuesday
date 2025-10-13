library(tidyverse)
library(rvest)
library(janitor)

# list station data urls

links <-
  rvest::read_html(
    "https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data"
  ) |>
  rvest::html_elements("a") |>
  rvest::html_attr("href") |>
  (\(x) x[grepl("stationdata", x)])()

# function to read files from met office website
read_met_office_fwf <- function(file) {
  # read all lines of data
  x <- readr::read_lines(file)

  # get station name
  station <- basename(file) |> stringr::str_remove_all("data.txt")

  # focus on data
  x <- x[which(grepl("yyyy", x)):length(x)]

  # read data
  data <-
    readr::read_fwf(
      I(x),
      na = "---",
      show_col_types = FALSE,
      col_positions = readr::fwf_widths(c(7, 4, 8, 8, 8, 8, 8))
    ) |>
    janitor::row_to_names(1) |>
    # lets not use most recent data
    dplyr::filter(yyyy != "2025") |>
    # drop units row
    dplyr::slice_tail(n = -1) |>
    # add station
    dplyr::mutate(station = station, .before = 0) |>
    dplyr::rename(
      year = yyyy,
      month = mm
    )

  # return
  return(data)
}

# read all urls
raw_data <- purrr::map(links, read_met_office_fwf, .progress = TRUE)

# clean data
historic_station_met <-
  raw_data |>
  dplyr::bind_rows() |>
  dplyr::filter(month != "osed") |>
  dplyr::mutate(
    sun = stringr::str_remove_all(sun, "a|C| |\\*|\\#|---|\\||\\$"),
    sun = ifelse(sun == "", NA, sun),
    sun = as.numeric(sun)
  ) |>
  dplyr::mutate(
    dplyr::across(c(tmax:rain), \(x) gsub("\\*|\\#", "", x) |> as.numeric()),
    dplyr::across(c(year, month), as.integer)
  )

# get metadata
station_meta <-
  rvest::read_html(
    "https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data"
  ) |>
  rvest::html_table() |>
  purrr::pluck(1) |>
  tidyr::separate_wider_delim(
    Location,
    delim = ", ",
    names = c("lng", "lat")
  ) |>
  dplyr::mutate(
    dplyr::across(c(lng, lat), as.numeric),
    station = stringr::str_remove_all(
      links,
      "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/|data.txt"
    )
  ) |>
  dplyr::select(station, station_name = Name, opened = Opened, lng, lat)
