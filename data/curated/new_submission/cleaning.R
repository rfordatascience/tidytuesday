library(tidyverse)
library(janitor)
library(another)

states <- state.x77 |>
  tibble::as_tibble(rownames = "state") |>
  janitor::clean_names() |>
  dplyr::mutate(
    dplyr::across(
      c("population", "income", "frost", "area"),
      as.integer
    )
  )
