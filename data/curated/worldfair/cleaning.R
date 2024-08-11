library(tidyverse)
library(rvest)
library(polite)
library(janitor)

session <- polite::bow(
  "https://en.wikipedia.org/wiki/List_of_world_expositions",
  user_agent = "TidyTuesday (https://tidytues.day, jonthegeek+tidytuesday@gmail.com)",
  delay = 0
)

worlds_fair_tables <- 
  session |> 
  polite::scrape() |> 
  rvest::html_table()

worlds_fairs <-
  worlds_fair_tables[[2]] |>
  janitor::clean_names() |>
  dplyr::rename(
    country = "country_2",
    city = "city_2",
    theme = "theme_3",
    visitors = "visitorsin_millions_4",
    cost = "costin_millions_usd_unless_specified",
    area = "area_ha",
    attending_countries = "attendingcountries"
  ) |> 
  tidyr::separate_wider_delim(
    "dates",
    " – ",
    names = c("start", "end")
  ) |> 
  tidyr::separate_wider_delim(
    c("start", "end"),
    "/",
    names = c("month", "year"),
    names_sep = "_"
  ) |> 
  dplyr::mutate(
    dplyr::across(
      dplyr::everything(),
      \(x) {
        stringr::str_remove_all(x, "\\[\\d+\\]") |> 
          stringr::str_squish()
      }
    ),
    dplyr::across(
      c("start_month", "start_year", "end_month", "end_year", "attending_countries"),
      as.integer
    ),
    notables = stringr::str_replace_all(notables, "([a-z])([A-Z])", "\\1, \\2"),
    visitors = as.double(visitors),
    # One expo has two costs, we'll use the first one
    cost = dplyr::case_when(
      name_of_exposition == "Expo 2010" ~ "4200",
      .default = cost
    ) |>
      stringr::str_remove_all("[^0-9]*") |>
      as.double(),
    area = as.double(area)
  )
