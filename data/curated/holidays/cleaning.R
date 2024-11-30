library(tidyverse)
library(withr)

url <- "https://data.worldpop.org/GIS/Holiday_Data/public_holidays/public_holidays_2010_2019.zip"
path <- withr::local_tempfile(fileext = ".zip")
download.file(url, path)
global_holidays <- readr::read_csv(path) |> 
  dplyr::mutate(Date = lubridate::dmy(Date))


url <- "https://data.worldpop.org/GIS/Flight_Data/monthly_volume_of_airline_passengers/monthly_vol_of_airline_pass_in_90_countries_2010_2018.zip"
path <- withr::local_tempfile(fileext = ".zip")
download.file(url, path)
monthly_passengers <- readr::read_csv(path) |>
  dplyr::mutate(
    dplyr::across(c(Year, Month), as.integer)
  )
