# Data provided by WHO Provisional measles and rubella data. Cleaning variable
# names and fixing data types.

library(tidyverse)
library(here)
library(readxl)
library(janitor)

cases_month <- read_xlsx(here("404-table-web-epi-curve-data.xlsx"), 2) %>%
  janitor::clean_names() %>%
  dplyr::mutate(
    dplyr::across(year:discarded, as.numeric)
  )

cases_year <- read_xlsx(here("403-table-web-reporting-data.xlsx"), 2) %>%
  row_to_names(1) %>%
  clean_names() %>%
  rename(
    country = member_state,
    iso3 = iso_country_code,
    measles_total= number_of_measles_cases_by_confirmation_method,
    measles_lab_confirmed = na,
    measles_epi_linked = na_2,
    measles_clinical = na_3,
    rubella_total = number_of_rubella_cases_by_confirmation_method,
    rubella_lab_confirmed = na_4,
    rubella_epi_linked = na_5,
    rubella_clinical = na_6
  ) %>%
  slice(-1)
