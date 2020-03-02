# Measles

The data this week comes from [The Wallstreet Journal](https://github.com/WSJ/measles-data). They recently published an [article](https://www.wsj.com/graphics/school-measles-rate-map/) around 46,412 schools across 32 US States.

> "This repository contains immunization rate data for schools across the U.S., as compiled by The Wall Street Journal. The dataset includes the overall and MMR-specific vaccination rates for 46,412 schools in 32 states. As used in “What’s the Measles Vaccination Rate at Your Child’s School?“.

> Vaccination rates are for the 2017-18 school year for Colorado, Connecticut, Minnesota, Montana, New Jersey, New York, North Dakota, Pennsylvania, South Dakota, Utah and Washington. Rates for other states are 2018-19."

Additional data sources are available at:
* [CDC Child immunization](https://www.cdc.gov/vaccines/imz-managers/coverage/childvaxview/data-reports/mmr/trend/index.html)  
* [World Bank](https://data.worldbank.org/indicator/SH.IMM.MEAS?end=2018&locations=IT&start=1990&view=chart)   
* [CDC General Immunization](https://www.cdc.gov/nchs/fastats/immunize.htm)  
* [WSJ Measles](https://raw.githubusercontent.com/WSJ/measles-data/master/all-measles-rates.csv)  

### Get the data here

```{r}
# Get the Data

measles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-25/measles.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-02-25')
tuesdata <- tidytuesdayR::tt_load(2020, week = 9)


measles <- tuesdata$measles
```
### Data Dictionary

# `measles.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|index    |double    | Index ID |
|state    |character | School's state |
|year     |character | School academic year|
|name     |character | School name|
|type     |character | Whether a school is public, private, charter |
|city     |character | City |
|county   |character | County |
|district |logical   | School district |
|enroll   |double    | Enrollment |
|mmr      |double    | School's Measles, Mumps, and Rubella (MMR) vaccination rate |
|overall  |double    | School's overall vaccination rate|
|xrel     |logical   | Percentage of students exempted from vaccination for religious reasons |
|xmed     |double    | Percentage of students exempted from vaccination for medical reasons |
|xper     |double    | Percentage of students exempted from vaccination for personal reasons |

### Cleaning Script

```{r}
library(tidyverse)
library(rvest)

url_wsj <- "https://raw.githubusercontent.com/WSJ/measles-data/master/all-measles-rates.csv"

wsj <- read_csv(url_wsj)

list_of_urls <- "https://github.com/WSJ/measles-data/tree/master/individual-states"

raw_states <- list_of_urls %>% 
  read_html() %>% 
  html_table() %>% 
  .[[1]] %>% 
  select(Name) %>% 
  mutate(Name = str_remove(Name, "\\.csv")) %>% 
  filter(str_length(Name) > 3, str_length(Name) < 20) %>% 
  pull(Name)

all_states <- glue::glue("https://raw.githubusercontent.com/WSJ/measles-data/master/individual-states/{raw_states}.csv") %>% 
  map(read_csv)

clean_states <- all_states %>% 
  map(~select(., state, name, lat, lng)) %>% 
  map(~mutate_at(., vars(lat, lng), as.numeric)) %>% 
  bind_rows() %>% 
  filter(!is.na(lat))

wsj %>% 
  left_join(clean_states, by = c("name", "state")) %>% 
  write_csv(here::here("2020","2020-02-25","measles.csv"))
  
```
