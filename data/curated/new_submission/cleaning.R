# Clean data *and* sample instructions for use in R provided by Our World in
# Data via https://ourworldindata.org/income-inequality-before-and-after-taxes.
# Minimal cleaning applied.

library(tidyverse)
library(jsonlite)

income_inequality_raw <- readr::read_csv(
  "https://ourworldindata.org/grapher/inequality-of-incomes-before-and-after-taxes-and-transfers-scatter.csv?v=1&csvType=full&useColumnShortNames=true"
) |>
  dplyr::mutate(
    Year = as.integer(Year)
  )

income_inequality_processed <- readr::read_csv(
  "https://ourworldindata.org/grapher/gini-coefficient-before-and-after-tax-lis.csv?v=1&csvType=full&useColumnShortNames=true"
) |>
  dplyr::mutate(
    Year = as.integer(Year)
  )

# Download metadata for use in construction of data dictionaries.
metadata_raw <- jsonlite::fromJSON(
  "https://ourworldindata.org/grapher/inequality-of-incomes-before-and-after-taxes-and-transfers-scatter.metadata.json?v=1&csvType=full&useColumnShortNames=true"
)

metadata_processed <- jsonlite::fromJSON(
  "https://ourworldindata.org/grapher/gini-coefficient-before-and-after-tax-lis.metadata.json?v=1&csvType=full&useColumnShortNames=true"
)
