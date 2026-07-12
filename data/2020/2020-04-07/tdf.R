library(tidytuesdaymeta)
library(tidyverse)
library(tdf)

winners <- tdf::editions %>% 
  select(-stage_results)

all_years <- tdf::editions %>% 
  unnest_longer(stage_results) %>% 
  mutate(stage_results = map(stage_results, ~ mutate(.x, rank = as.character(rank)))) %>% 
  unnest_longer(stage_results) 

stage_all <- all_years %>% 
  select(stage_results) %>% 
  flatten_df()

combo_df <- bind_cols(all_years, stage_all) %>% 
  select(-stage_results)

stage_clean <- combo_df %>% 
  select(edition, start_date,stage_results_id:last_col()) %>% 
  mutate(year = lubridate::year(start_date)) %>% 
  rename(age = age...25) %>% 
  select(edition, year, everything(), -start_date)

winners %>% 
  write_csv(here::here("2020", "2020-04-07", "tdf_winners.csv"))

stage_clean %>% 
  write_csv(here::here("2020", "2020-04-07", "stage_data.csv"))
