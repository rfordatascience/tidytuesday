library(tidyverse)

raw_data <- read_csv("https://datacatalogfiles.worldbank.org/ddh-published/0037996/8/DR0046108/SPI_index.csv")

spi_indicators <- raw_data |>
  select(
    iso3c, country, region, income, date, population,
    SPI.INDEX, starts_with("SPI.INDEX.")
  ) |>
  rename(
    year = date,
    overall_score = SPI.INDEX,
    data_use_score = SPI.INDEX.PIL1,
    data_services_score = SPI.INDEX.PIL2,
    data_products_score = SPI.INDEX.PIL3,
    data_sources_score = SPI.INDEX.PIL4,
    data_infrastructure_score = SPI.INDEX.PIL5
  )
