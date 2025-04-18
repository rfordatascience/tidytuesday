# Draft cleaning script provided by @Rmadillo at
# https://github.com/Rmadillo/Harper_and_Palayew/blob/1aaf1333e8fb6a8f3aa7f169a12943c17b3487da/Load_Data_and_Clean.R
# Script cleaned and modernized by @jonthegeek (the script was submitted as a
# TidyTuesday issue in 2019!).

#### Load packages -------------------------------------------------------------

library(haven)
library(tidyverse)
library(fs)

#### Acquire raw data ----------------------------------------------------------

# Crash data (from Harper and Palayew)
dl_path <- withr::local_tempfile(fileext = ".zip")
download.file("https://osf.io/kj7ub/download", dl_path, mode = "wb")
unzip_path <- withr::local_tempdir()
unzip(dl_path, exdir = unzip_path)

dta_files <- fs::dir_ls(unzip_path, glob = "*.dta")

fars <- purrr::map(dta_files, haven::read_dta) |> 
  purrr::list_rbind(names_to = "id") |> 
  dplyr::mutate(id = basename(id))

# Geographic lookup
geog <- readr::read_csv(
  "https://www2.census.gov/geo/docs/reference/codes/files/national_county.txt",
  col_names = c(
    "state_name",
    "state_code",
    "county_code",
    "county_name",
    "FIPS_class_code"
  )
) |> 
  dplyr::mutate(
    state = as.numeric(state_code),
    count = as.numeric(county_code),
    FIPS = paste0(state_code, county_code)
  )

#### Data wrangling ------------------------------------------------------------
# Used https://osf.io/drbge/ Stata code as a guide for cleaning

# All data
# This might take a while... go get a coffee
all_accidents <- fars |> 
  # What are state and county codes/look ups?
  dplyr::select(
    "id", "state", "county", 
    "month", "day", "hour", "minute", 
    "st_case", "per_no", "veh_no", "per_typ", 
    "age", "sex", 
    "death_da", "death_mo", "death_yr", "death_hr", "death_mn", "death_tm",
    "inj_sev", "mod_year", "lag_hrs", "lag_mins"
  ) |> 
  dplyr::mutate(
    dplyr::across(
      c("month", "day", "hour", "minute"),
      ~ na_if(.x, 99)
    ),
    year = readr::parse_number(id)
  ) |> 
  dplyr::filter(
    .data$per_typ == 1,
    !is.na(.data$year),
    !is.na(.data$month),
    !is.na(.data$day)
  ) |> 
  dplyr::mutate(
    crashtime = .data$hour * 100 + .data$minute,
    date = as.Date(paste(.data$year, .data$month, .data$day, sep = "-")),
    time = paste(.data$hour, .data$minute, sep = ":"),
    timestamp = as.POSIXct(
      paste(.data$date, .data$time),
      format = "%Y-%m-%d %H:%M"
    ),
    e420 = .data$month == 4 & .data$day == 20 & 
      .data$crashtime >= 1620 & .data$crashtime <= 2359,
    e420_control = .data$month == 4 & (.data$day == 20 | .data$day == 27) & 
      .data$crashtime >= 1620 & .data$crashtime < 2359,
    d420 = .data$crashtime >= 1620 & .data$crashtime <= 2359,
    sex = factor(
      dplyr::case_when(
        .data$sex == 2 ~ "F",
        .data$sex == 1 ~ "M",
        .default = NA_character_
      )
    ),
    period = factor(
      dplyr::case_when(
        .data$year < 2004  ~ "Remote (1992-2003)",
        .data$year >= 2004 ~ "Recent (2004-2016)",
        .default = NA_character_
      )
    ),
    age_group = factor(
      dplyr::case_when(
        .data$age <= 20 ~ "<20y",
        .data$age <= 30 ~ "21-30y",
        .data$age <= 40 ~ "31-40y",
        .data$age <= 50 ~ "41-50y",
        .data$age <= 97 ~ "51-97y",
        .default = NA_character_
      )
    )
  )

# Daily final working data
# Only use data starting in 1992
daily_accidents <- all_accidents |> 
  dplyr::filter(.data$year > 1991) |> 
  summarize(fatalities_count = dplyr::n(), .by = "date")

# Daily+Time Group final working data
daily_accidents_420 <- all_accidents |> 
  dplyr::filter(.data$year > 1991) |> 
  dplyr::summarize(fatalities_count = dplyr::n(), .by = c("date", "d420"))
