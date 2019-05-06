library(tidyverse)
library(here)
library(janitor)

### Brexit Raw

brexit_raw <- read_csv(here("2019", "2019-04-16", "Economist_brexit.csv"))

brexit_clean <- brexit_raw %>% 
  set_names(nm = .[3,]) %>% 
  clean_names() %>% 
  slice(4:nrow(.))

brexit_clean %>% write_csv(here("2019", "2019-04-16", "brexit.csv"))

### corbyn

corbyn_raw <- read_csv(here("2019", "2019-04-16", "Economist_corbyn.csv"))

corbyn_clean <- corbyn_raw %>% 
  set_names(nm = "political_group", "avg_facebook_likes") %>% 
  na.omit()

corbyn_clean %>% write_csv(here("2019", "2019-04-16", "corbyn.csv"))

### dogs

dogs_raw <- read_csv(here("2019", "2019-04-16", "Economist_dogs.csv"))

dogs_clean <- dogs_raw %>% 
  na.omit() %>% 
  set_names(nm = c("year", "avg_weight", "avg_neck"))

dogs_clean %>% write_csv(here("2019", "2019-04-16", "dogs.csv"))

### EU Balance

eu_balance_raw <- read_csv(here("2019", "2019-04-16", "Economist_eu-balance.csv"))


names_eu <- eu_balance_raw %>% 
  .[1,] %>% 
  as.character()

datapasta::vector_paste_vertical(names_eu)  

clean_names_eu <- c("country",
              "current_2009",
              "current_2010",
              "current_2011",
              "current_2012",
              "current_2013",
              "current_2014",
              "current_2015",
              "budget_2009",
              "budget_2010",
              "budget_2011",
              "budget_2012",
              "budget_2013",
              "budget_2014",
              "budget_2015")

eu_current <- eu_balance_raw %>% 
  set_names(nm = clean_names_eu) %>% 
  filter(country != "Country") %>% 
  gather(year, value, starts_with("current")) %>% 
  select(-starts_with("budget")) %>% 
  separate(year, into = c("account_type", "year"))

eu_budget <- eu_balance_raw %>% 
  set_names(nm = clean_names_eu) %>% 
  filter(country != "Country") %>% 
  gather(year, value, starts_with("budget")) %>% 
  select(-starts_with("current")) %>% 
  separate(year, into = c("account_type", "year"))

eu_balance_clean <- bind_rows(eu_current, eu_budget)

eu_balance_clean %>% write_csv(here("2019", "2019-04-16", "eu_balance.csv"))

### Pensions

pensions_raw <- read_csv(here("2019", "2019-04-16", "Economist_pensions.csv"))

pensions_clean <- pensions_raw %>% 
  na.omit() %>% 
  set_names(nm = c("country", "pop_65_percent", "gov_spend_percent_gdp"))

pensions_clean %>% write_csv(here("2019", "2019-04-16", "pensions.csv"))

### Trade

trade_raw <- read_csv(here("2019", "2019-04-16", "Economist_us-trade-manufacturing.csv"))

trade_clean <- trade_raw %>% 
  set_names(nm = c("year", "trade_deficit", "manufacture_employment")) %>% 
  mutate(trade_deficit = trade_deficit * 1e9,
         manufacture_employment = manufacture_employment * 1e6) %>% 
  na.omit()

trade_clean %>% write_csv(here("2019", "2019-04-16", "trade.csv"))

### Women
women_research_raw <- read_csv(here("2019", "2019-04-16", "Economist_women-research.csv"))

women_research_raw[1,] %>% 
  as.character() %>% 
  datapasta::vector_paste_vertical()

research_names <- c("country",
  "Health sciences",
  "Physical sciences",
  "Engineering",
  "Computer science, maths",
  "Women inventores")

women_research_clean <- women_research_raw %>% 
  na.omit() %>% 
  set_names(nm = research_names) %>% 
  filter(country != "Country") %>% 
  gather(field, percent_women, `Health sciences`:`Women inventores`)

women_research_clean %>% write_csv(here("2019", "2019-04-16", "women_research.csv"))

