library(tidyverse)
library(countrycode)
library(janitor)

raw_mobile <- read_csv("2020/2020-11-10/mobile-phone-subscriptions-vs-gdp-per-capita.csv")

raw_landline <- read_csv("2020/2020-11-10/fixed-landline-telephone-subscriptions-vs-gdp-per-capita.csv")

mobile_df <- raw_mobile %>% 
  janitor::clean_names() %>% 
  rename(
    total_pop = 4,
    "gdp_per_cap" = 6,
    "mobile_subs" = 7
  ) %>% 
  filter(year >= 1990) %>% 
  select(-continent) %>% 
  
  mutate(continent = countrycode::countrycode(
    entity,
    origin = "country.name",
    destination = "continent"
  )) %>% 
  filter(!is.na(continent))

landline_df <- raw_landline %>% 
  janitor::clean_names() %>% 
  rename(
    total_pop = 4,
    "gdp_per_cap" = 6,
    "landline_subs" = 7
  ) %>% 
  filter(year >= 1990) %>% 
  select(-continent) %>% 
  mutate(continent = countrycode::countrycode(
    entity,
    origin = "country.name",
    destination = "continent"
  )) %>% 
  filter(!is.na(continent))

mobile_df %>% 
  write_csv("2020/2020-11-10/mobile.csv")

landline_df %>% 
  write_csv("2020/2020-11-10/landline.csv")
