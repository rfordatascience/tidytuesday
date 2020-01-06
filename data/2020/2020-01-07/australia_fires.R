library(tidyverse)
library(here)

read_file_list <- list.files(here::here("2020", "2020-01-07")) %>% 
  .[str_detect(., "tmax|tmin")]

read_clean_temp_data <- function(file_name){
  
  temp_descrip <- if_else(str_detect(file_name, "min"), "min", "max")
  
  read_csv(here::here("2020", "2020-01-07", file_name)) %>% 
    janitor::clean_names() %>% 
    fill(site_name, site_number) %>% 
    filter(!is.na(date)) %>% 
    rename(temperature = contains("temp")) %>% 
    mutate(temp_type = temp_descrip)  %>% 
    mutate(city_name = word(site_name, 1)) %>%  
    select(city_name, date, temperature, temp_type, site_name)
  
}


# Get Clean Temp Data -----------------------------------------------------

clean_df <- read_file_list %>% 
  map(read_clean_temp_data) %>% 
  bind_rows()

write_csv(clean_df, here::here("2020", "2020-01-07","temperature.csv"))


##### Prep for Clean Rain Data
#####
#####

name_df <- tribble(
  ~station_code, ~city_name, ~lat, ~long, ~station_name,
  "009151", "Perth", -31.96, 115.79, "Subiaco Wastewater Treatment Plant",
  "023011", "Adelaide", -34.92, 138.6, "North Adelaide",
  "040383", "Brisbane", -27.51, 153.05, "Greenslopes Private Hospital",
  "040913", "Brisbane", -27.48, 153.04, "Brisbane",
  "066062", "Sydney", -33.86, 151.21, "Observatory Hill",
  "070351", "Canberra", -35.31, 149.2, "Canberra Airport",
  "086232", "Melbourne", -37.83, 144.98, "Melbourne Botanical Gardens"
)

read_precip_list <- list.files(here::here("2020", "2020-01-07")) %>% 
  .[str_detect(., "IDCJ")]

read_clean_precip_data <- function(file_name){
  
  read_csv(here::here("2020", "2020-01-07", file_name)) %>% 
    janitor::clean_names() %>% 
    select("station_code" = bureau_of_meteorology_station_number,
           year, month, day,
           "rainfall"= rainfall_amount_millimetres, 
           "period" = period_over_which_rainfall_was_measured_days,
           quality) %>% 
    mutate(station_code = as.character(station_code)) %>% 
    left_join(name_df, by = "station_code") %>% 
    select(station_code, city_name, everything())
  
}


# Get Clean Rain Data -----------------------------------------------------

clean_rain_df <- read_precip_list %>% 
  map(read_clean_precip_data) %>% 
  bind_rows()

write_csv(clean_rain_df, here::here("2020", "2020-01-07","rainfall.csv"))
