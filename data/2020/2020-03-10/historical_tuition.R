library(rvest)
library(tidyverse)

url <- "https://nces.ed.gov/fastfacts/display.asp?id=76"

raw_nces <- url %>% 
  read_html() %>% 
  html_table(fill = TRUE) %>% 
  .[[1]] %>% 
  janitor::clean_names() %>% 
  as_tibble() %>% 
  slice(4:n()) %>% 
  set_names(nm = c("year", "All Constant", "4 Year Constant", "2 Year Constant",
                   "All Current", "4 Year Current", "2 Year Current")) %>% 
  mutate(year = str_replace(year, "1985–862", "1985-86"),
         year = str_replace(year, "–", "-"))

all_school <- raw_nces %>% 
  slice(2:20) %>% 
  mutate(type = "All Institutions") %>% 
  pivot_longer(names_to = "tuition_type", values_to = "tuition_cost", `All Constant`:`2 Year Current`) %>% 
  select(type, year, everything()) %>% 
  mutate(tuition_cost = parse_number(tuition_cost))


public_school <- raw_nces %>% 
  slice(22:34) %>% 
  mutate(year = if_else(year == "2015-16" & `All Constant` == "17,237",
                        "2016-17", year),
         type = "Public") %>% 
  pivot_longer(names_to = "tuition_type", values_to = "tuition_cost", `All Constant`:`2 Year Current`) %>% 
  select(type, year, everything()) %>% 
  mutate(tuition_cost = parse_number(tuition_cost))

  

private_school <- raw_nces %>% 
  slice(37:n()-1) %>% 
  mutate(type = "Private") %>% 
  pivot_longer(names_to = "tuition_type", values_to = "tuition_cost", `All Constant`:`2 Year Current`) %>% 
  select(type, year, everything()) %>% 
  mutate(tuition_cost = parse_number(tuition_cost))
  

bind_rows(all_school, public_school, private_school) %>% 
  write_csv(here::here("2020", "2020-03-10", "historical_tuition.csv"))
