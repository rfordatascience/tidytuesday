library(data.table)
library(dplyr)
library(here)
library(lubridate)
library(tidyr)

# downloaded manually to tt_submission/Lunenburg_County_Water_Quality_Data_20260312.csv from
# https://data.novascotia.ca/Nature-and-Environment/Lunenburg-County-Water-Quality-Data/eda5-aubu/explore/query/SELECT%0A%20%20%60waterbody%60%2C%0A%20%20%60station%60%2C%0A%20%20%60lease%60%2C%0A%20%20%60latitude%60%2C%0A%20%20%60longitude%60%2C%0A%20%20%60deployment_range%60%2C%0A%20%20%60string_configuration%60%2C%0A%20%20%60sensor_type%60%2C%0A%20%20%60sensor_serial_number%60%2C%0A%20%20%60timestamp_utc%60%2C%0A%20%20%60sensor_depth_at_low_tide_m%60%2C%0A%20%20%60depth_crosscheck_flag%60%2C%0A%20%20%60dissolved_oxygen_percent_saturation%60%2C%0A%20%20%60dissolved_oxygen_uncorrected_mg_per_l%60%2C%0A%20%20%60salinity_psu%60%2C%0A%20%20%60sensor_depth_measured_m%60%2C%0A%20%20%60temperature_degree_c%60%2C%0A%20%20%60qc_flag_dissolved_oxygen_percent_saturation%60%2C%0A%20%20%60qc_flag_dissolved_oxygen_uncorrected_mg_per_l%60%2C%0A%20%20%60qc_flag_salinity_psu%60%2C%0A%20%20%60qc_flag_sensor_depth_measured_m%60%2C%0A%20%20%60qc_flag_temperature_degree_c%60%0AWHERE%20caseless_one_of%28%60station%60%2C%20%22Birchy%20Head%22%29/page/filter
# this is a large file: 385 MB
# it is ~2x faster to import using data.table::fread compared to readr::read_csv
dat_all <- data.table::fread(
  here("tt_submission/Lunenburg_County_Water_Quality_Data_20260312.csv"),
  data.table = FALSE,
  na.strings = c("NA", "")
)

# note on qc_flag_* columns -----------------------------------------------

# The qc_flag_** columns are quality control flags for each variable.
# Possible values are:
## Pass: observation passed all QC tests.
## Not Evaluated: observation could not be evaluated by at least one test.
## Suspect/Of Interest: observation is either poor quality or part of an unusual 
### event. In this dataset, most Suspect/Of Interest temperature measurements 
### are considered "Of Interest" and may be included in analyses.
## Fail: observation failed at least one QC test and should not be included in
### most analyses.

# temperature dataset -----------------------------------------------------

# filter to exclude observations that failed QC tests
# calculate daily average temperature to reduce size of the csv file to 537 kb
ocean_temperature <- dat_all %>% 
  dplyr::filter(
    station == "Birchy Head",
    !(is.na(temperature_degree_c) & qc_flag_temperature_degree_c == ""),
    qc_flag_temperature_degree_c != "Fail"
  ) %>% 
  dplyr::mutate(date = lubridate::as_date(timestamp_utc)) %>% 
  group_by(date, sensor_depth_at_low_tide_m) %>% 
  summarise(
    mean_temperature_degree_c = mean(temperature_degree_c),
    sd_temperature_degree_c = sd(temperature_degree_c),
    n_obs = n()
  ) %>% 
  ungroup()

# deployment details dataset ---------------------------------------------

# extract the dates that sensors were removed and replaced and the 
# deployment coordinates
# assign an id to each deployment 
ocean_temperature_deployments <- dat_all %>% 
  dplyr::distinct(deployment_range, latitude, longitude) %>% 
  tidyr::separate(
    deployment_range, into = c("start_date", "end_date"), sep = " to "
  ) %>% 
  dplyr::mutate(
    start_date = lubridate::as_date(start_date),
    end_date = lubridate::as_date(end_date)
  ) %>% 
  dplyr::arrange(start_date) %>% 
  dplyr::mutate(
    deployment_id = paste0("depl_", sprintf("%02d", row_number()))
  ) %>% 
  dplyr::select(deployment_id, dplyr::everything())
