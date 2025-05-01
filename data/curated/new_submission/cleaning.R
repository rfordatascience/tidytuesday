library(tidyverse)
library(here)
library(janitor)

# Historical weather data for Sydney provided by https://open-meteo.com/ API. 

weather <- readr::read_csv(here::here("data_raw", "open-meteo-33.85S151.20E51m.csv")) |>
  dplyr::select(date = latitude, 
         max_temp_C = longitude, 
         min_temp_C  = elevation, 
         precipitation_mm = utc_offset_seconds) |>
  dplyr::slice(-(1:2)) |>
  dplyr::mutate(date = ymd(date)) |>
  dplyr::mutate(latitude = -33.848858, 
         longitude = 151.19551) 
  
# Water quality data for Sydney beaches provided by https://www.beachwatch.nsw.gov.au/waterMonitoring/waterQualityData

water_quality <- readr::read_csv(here::here("data_raw", "Water quality-1746064496936.csv")) |>
  janitor::clean_names() |>
  rename(enterococci_cfu_100ml = enterococci_cfu_100m_l, conductivity_ms_cm = conductivity_m_s_cm) |>
  dplyr::mutate(date = dmy(date)) |>
  dplyr::mutate(
    dplyr::across(
      c("enterococci_cfu_100ml", "water_temperature_c", "conductivity_ms_cm"),
      as.integer
    )
  )
  

