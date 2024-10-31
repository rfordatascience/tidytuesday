# Mostly clean data from the ISOcodes package

# install.packages("ISOcodes")
library(ISOcodes)
library(tidyverse)
library(janitor)

countries <- 
  ISOcodes::ISO_3166_1 |> 
  tibble::as_tibble() |> 
  dplyr::mutate(Numeric = as.integer(Numeric)) |> 
  janitor::clean_names()
country_subdivisions <- 
  ISOcodes::ISO_3166_2 |> 
  tibble::as_tibble() |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    alpha_2 = stringr::str_extract(code, "^[^-]+(?=-)")
  )
former_countries <-
  ISOcodes::ISO_3166_3 |> 
  tibble::as_tibble() |> 
  janitor::clean_names()
