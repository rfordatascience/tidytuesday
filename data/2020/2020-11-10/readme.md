![](https://images.unsplash.com/photo-1525598912003-663126343e1f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80)

# Historical Phone Usage

The data this week comes from [OurWorldInData.org](https://ourworldindata.org/technology-adoption).

> Hannah Ritchie (2017) - "Technology Adoption". Published online at OurWorldInData.org. Retrieved from: 'https://ourworldindata.org/technology-adoption' [Online Resource]

Pew research also has a [nice article](https://www.pewresearch.org/global/2019/02/05/smartphone-ownership-is-growing-rapidly-around-the-world-but-not-always-equally/) about the adoption of mobile phones by country.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-11-10')
tuesdata <- tidytuesdayR::tt_load(2020, week = 46)

mobile <- tuesdata$mobile

# Or read in the data manually

mobile <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-10/mobile.csv')
landline <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-10/landline.csv')

```
### Data Dictionary

# `mobile.csv`

|variable                           |class     |description |
|:----------------------------------|:---------|:-----------|
|entity                             |character |Country         |
|code                               |character | Country code |
|year                               |double    | Year |
|total_pop |double    | Gapminder total population |
|gdp_per_cap                        |double    | GDP per capita, PPP (constant 2011 international $) |
|mobile_subs                      |double    | Fixed mobile subscriptions (per 100 people)|
|continent                          |character | Continent |

# `landline.csv`

|variable                           |class     |description |
|:----------------------------------|:---------|:-----------|
|entity                             |character |Country         |
|code                               |character | Country code |
|year                               |double    | Year |
|total_pop |double    | Gapminder total population |
|gdp_per_cap                        |double    | GDP per capita, PPP (constant 2011 international $) |
|landline_subs                      |double    | Fixed telephone subscriptions (per 100 people)|
|continent                          |character | Continent |

### Cleaning Script

```{r}
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


```
