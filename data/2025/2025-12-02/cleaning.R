libary(tidyverse)

## burn duration ----
# https://github.com/philshem/Sechselaeuten-data
burn_duration <- readr::read_csv(
  file = "https://raw.githubusercontent.com/philshem/Sechselaeuten-data/refs/heads/master/boeoegg_burn_duration.csv"
) |>
  dplyr::mutate(duration = round(burn_duration_seconds / 60, digits = 2)) |>
  dplyr::select(year, duration)

## variable selection ----
variable_selection <- c(
  "tre200m0",
  "tre200mn",
  "tre200mx",
  "sre000m0",
  "sremaxmv",
  "rre150m0"
)

## climate data ----
climate_data <- readr::read_delim(
  file = "https://data.geo.admin.ch/ch.meteoschweiz.ogd-smn/sma/ogd-smn_sma_m.csv",
  delim = ";"
) |>
  dplyr::select(
    date = reference_timestamp,
    dplyr::any_of(variable_selection)
  ) |>
  dplyr::mutate(
    date = lubridate::dmy_hm(date),
    year = lubridate::year(date),
    month = lubridate::month(date)
  ) |>
  dplyr::filter(month %in% 6:8) |>
  dplyr::group_by(year) |>
  dplyr::summarise(dplyr::across(.cols = -c(date, month), .fns = \(x) {
    mean(x, na.rm = TRUE)
  })) |>
  dplyr::ungroup() |>
  dplyr::mutate(sre000m0 = sre000m0 / 60) |>
  dplyr::mutate(dplyr::across(.cols = -c(year), .fns = \(x) {
    round(x, digits = 2)
  })) |>
  dplyr::mutate(dplyr::across(.cols = -c(year), .fns = \(x) {
    ifelse(is.nan(x), NA, x)
  }))

## combine datasets ----
sechselaeuten <- dplyr::left_join(
  x = burn_duration,
  y = climate_data,
  by = dplyr::join_by(year)
) |>
  dplyr::mutate(record = ifelse(tre200m0 >= 19, TRUE, FALSE))

