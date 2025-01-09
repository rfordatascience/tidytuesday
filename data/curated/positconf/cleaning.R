library(tidyverse)
library(googlesheets4)

# Mostly clean data provided by Posit.
conf2023_raw <- googlesheets4::read_sheet("<REDACTED>")
conf2023 <- conf2023_raw |> 
  dplyr::mutate(
    session_date = lubridate::ymd(session_date),
    session_start = lubridate::ymd_hm(
      paste(session_date, session_start),
      tz = "America/Chicago"
    ),
    session_length = as.integer(session_length)
  )

conf2024 <- googlesheets4::read_sheet("<REDACTED>") |> 
  janitor::clean_names()
