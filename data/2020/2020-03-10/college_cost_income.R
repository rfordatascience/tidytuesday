library(tidyverse)
library(janitor)
library(glue)

raw_df <- read_csv(here::here("2020", "2020-03-10", "all-schools.csv")) %>% 
  janitor::clean_names()

raw_cost <- raw_df %>% 
  select(name = institution_name, state = state_abbreviation_hd2017,
         contains("total_price_for_in_state_students")) %>% 
  pivot_longer(names_to = "category", values_to = "total_price", total_price_for_in_state_students_living_on_campus_2007_08_drvic2007:total_price_for_in_state_students_living_off_campus_not_with_family_2020_21_drvic2020) %>% 
  mutate(year = as.double(str_sub(category, -4)),
         category = str_remove(category, "total_price_for_in_state_students_living_"),
         campus = if_else(str_detect(category, "on_campus"), "On Campus", "Off Campus")) %>% 
  filter(!is.na(total_price)) %>% 
  select(-category)

net_cost <- raw_df %>% 
  select(name = institution_name, state = state_abbreviation_hd2017,
         starts_with("average_net_price_income")) %>% 
  pivot_longer(names_to = "category", values_to = "net_cost", 
               average_net_price_income_0_30_000_students_awarded_title_iv_federal_financial_aid_2016_17_sfa1617:average_net_price_income_over_110_000_students_receiving_title_iv_federal_financial_aid_2008_09_sfa0809) %>% 
  filter(!is.na(net_cost)) %>% 
  mutate(year = str_sub(category, -4, -3),
         year = glue::glue("20{year}"),
         year = as.double(year),
         category = str_remove(category, "average_net_price_income_"),
         category = str_remove(category, str_sub(category, -16)),
         income_lvl = str_remove(category, "_students_awarded_title_iv_federal_financial_aid"),
         income_lvl = case_when(
           str_detect(income_lvl, "30_000") ~ "0 to 30,000",
           str_detect(income_lvl, "30_001") ~ "30,001 to 48,000",
           str_detect(income_lvl, "48_001") ~ "48_001 to 75,000",
           str_detect(income_lvl, "75_001") ~ "75,001 to 110,000",
           str_detect(income_lvl, "110_000") ~ "Over 110,000",
           TRUE ~ NA_character_)
         ) %>% 
  select(-category)

full_dataset <- left_join(raw_cost, net_cost, by = c("name", "year", "state")) %>% 
  filter(!is.na(net_cost))

full_dataset %>% 
  write_csv(here::here("2020", "2020-03-10", "tuition_income.csv"))
