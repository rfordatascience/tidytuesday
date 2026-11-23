# US companies worth $1 billion or more that delisted, October 2021 - October 2026
# Source CSV: https://github.com/quotelinks/us-delisted-companies (CC BY 4.0; SEC EDGAR fields are public domain)

library(tidyverse)

delisted_companies <- readr::read_csv(
  "https://raw.githubusercontent.com/quotelinks/us-delisted-companies/main/delisted_companies.csv",
  col_types = readr::cols(
    year = readr::col_integer(),
    deal_value_usd_bn = readr::col_double(),
    closed = readr::col_date(),
    form25_date = readr::col_date(),
    .default = readr::col_character()
  )
) |>
  dplyr::mutate(
    outcome = factor(
      outcome,
      levels = c("acquired", "taken_private", "merged", "left_us_exchange", "other")
    ),
    payment = dplyr::na_if(payment, "")
  )
