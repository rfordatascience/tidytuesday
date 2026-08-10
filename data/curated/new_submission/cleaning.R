# Shared by James Hoffmann in a YouTube video titled 'The Surprising Things We Discovered In The Cost Of A Cappuccino' shared on 6 August 2026
# James Hoffmann encouraged us to explore the figures ourselves and shared the full dataset in a public google sheet
# Below is the cleaning process preparing the data for TidyTuesday

library(tidyverse)
library(janitor)

cafe <- readr::read_csv(
  "https://docs.google.com/spreadsheets/d/1l3nitpsActIEqjaHk0wQNno8FDStYLsG_amSvAbuI3w/export?format=csv",
  show_col_types = FALSE
) |>
  janitor::clean_names() |>
  dplyr::mutate(
    urban = stringr::str_detect(urban_classification, "Urban"),
    suburban = stringr::str_detect(urban_classification, "Suburban"),
    rural = stringr::str_detect(urban_classification, "Rural")
  ) |>
  dplyr::select(
    country,
    city,
    urban,
    suburban,
    rural,
    hourly_wage_gbp = hourly_wage_in_gbp,
    price_gbp = price_per_cappuccino_in_gbp,
    original_currency = currency,
    price = price_per_small_cappuccino,
    hourly_wage = hourly_wage
  )

cappuccino_index <- cafe |>
  summarise(index = sum(price_gbp)/sum(hourly_wage_gbp)*60, n=n(), .by=country) |>
  arrange(index) |>
  mutate(minutes = floor(index), seconds = floor((index - floor(index))*60)) |>
  mutate(index_as_time = paste0(minutes,":",stringr::str_pad(seconds, width = 2, pad = "0"))) |>
  readr::write_csv("cappuccino_index.csv")

