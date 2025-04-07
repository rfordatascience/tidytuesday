# Data downloaded manually from https://data.cms.gov/provider-data/dataset/apyc-v239
library(tidyverse)
library(here)
library(janitor)

care_state <- readr::read_csv(
  here::here("Timely_and_Effective_Care-State.csv")
) |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    score = dplyr::na_if(score, "Not Available") |> 
      as.double(),
    dplyr::across(
      dplyr::ends_with("_date"),
      lubridate::mdy
    )
  )
