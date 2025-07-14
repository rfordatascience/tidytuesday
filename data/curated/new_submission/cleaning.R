# Data provided by Andy Jackson. See
# https://anjackson.net/2024/11/27/updating-the-data-on-british-library-funding/
# Minimal cleaning required.

library(tidyverse)
library(googlesheets4)
library(janitor)

# Call the auth function to make things run without prompts.
googlesheets4::gs4_auth("jonthegeek@gmail.com")
bl_funding <- googlesheets4::read_sheet(
  "1uxjiuWYZrALF2mthmiYbUPieu1dEdEwv9GB8dEAizso"
) |>
  janitor::clean_names() |>
  dplyr::mutate(
    year = as.integer(.data$year)
  )
