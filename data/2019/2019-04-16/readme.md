# Economist's ["Mistakes, we’ve drawn a few"](https://medium.economist.com/mistakes-weve-drawn-a-few-8cdd8a42d368)

Sarah Leo from The Economist went through the Economist's archives and found 7 examples of charts that were in need of improvement.

"I grouped our crimes against data visualisation into three categories: charts that are (1) misleading, (2) confusing and (3) failing to make a point. For each, I suggest an improved version that requires a similar amount of space — an important consideration when drawing charts to be published in print."

She was nice enough to include the raw data as .csv files, where I have included both the raw and tidied formats for your graphing fun!

## Get the data!

```
brexit <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/brexit.csv")

corbyn <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/corbyn.csv")

dogs <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/dogs.csv")

eu_balance <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/eu_balance.csv")

pensions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/pensions.csv")

trade <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/trade.csv")

women_research <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/women_research.csv")
```


# Data Dictionaries

### brexit.csv
|variable                 |class     |description |
|:------------------------|:---------|:-----------|
|date                     | date | Date of poll          |
|percent_responding_right |character | Percent who said Britain vote to leave EU was right           |
|percent_responding_wrong |character | Percent who said Britain vote to leave EU was wrong           |

### corbyn.csv 
|variable           |class     |description |
|:------------------|:---------|:-----------|
|political_group    |character | Political identity or group           |
|avg_facebook_likes |double    | Average number of facebook likes per Facebook post in 2016 |

### dogs.csv
|variable   |class     |description |
|:----------|:---------|:-----------|
|year       | integer | Year registered with UK's kennel club           |
|avg_weight |character | Average body weight in kg |
|avg_neck   |double    | Average neck size diameter in cm           |

### eu_balance.csv
|variable     |class     |description |
|:------------|:---------|:-----------|
|country      |character | Country         |
|account_type |character | Budget balances or current-account balances           |
|year         | integer | Year           |
|value        |double    | Value in billion of euros           |

### pensions.csv
|variable              |class     |description |
|:---------------------|:---------|:-----------|
|country               |character | Country           |
|pop_65_percent        |double    | Percent of population aged 65 or older           |
|gov_spend_percent_gdp |double    | Percent of government spending on pension benefits as percent of GDP           |

### trade.csv
|variable               |class     |description |
|:----------------------|:---------|:-----------|
|year                   | integer | Year        |
|trade_deficit          |double    | US Trade deficit with China in goods in dollars          |
|manufacture_employment |double    | Manufacturing employment in the US           |

### women_research.csv
|variable      |class     |description |
|:-------------|:---------|:-----------|
|country       |character | country         |
|field         |character | Field of study           |
|percent_women |character | Women among researchers with papers published 2011-15 as % of total by field of study |

### Cleaning Spoilers

```
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



```
