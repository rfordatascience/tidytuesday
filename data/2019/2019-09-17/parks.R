library(tidyverse)
library(rvest)

df_raw <- read_csv(here::here("2019/2019-09-17/All National Parks Visitation 1904-2016.csv")) 

df <- df_raw %>% 
  janitor::clean_names() %>%
  mutate(date = lubridate::mdy_hms(year)) %>% 
  select(date, gnis_id, geometry:year_raw)

df %>% 
  write_csv(here::here("2019/2019-09-17/national_parks.csv"))


# Get pop data

url <- "https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_historical_population"

raw_html <- url %>% 
  read_html() %>% 
  html_table()

pop_df <- raw_html %>% 
  chuck(5) %>% 
  gather(key = "state", value = "pop", AL:DC) %>% 
  rename("year" = 1) %>% 
  mutate(pop = str_remove_all(pop, ","),
         pop = as.double(pop))

pop_df %>% 
  write_csv(here::here("2019/2019-09-17", "state_pop.csv"))

# Get gas prices

url2 <- "https://www.energy.gov/eere/vehicles/fact-915-march-7-2016-average-historical-annual-gasoline-pump-price-1929-2015"

raw_gas <- url2 %>% 
  read_html() %>% 
  html_table()

gas <- raw_gas %>% 
  chuck(1) %>% 
  set_names(nm = c("year", "gas_current", "gas_constant")) %>%   
  as_tibble() %>% 
  filter(!str_detect(year, "Source")) %>% 
  mutate(year = as.double(year),
         gas_current = as.double(gas_current),
         gas_constant = as.double(gas_constant))

gas %>% 
  write_csv(here::here("2019/2019-09-17", "gas_price.csv"))
