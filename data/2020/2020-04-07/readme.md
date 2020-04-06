![Tour de France logo](https://upload.wikimedia.org/wikipedia/en/thumb/e/eb/Tour_de_France_logo.svg/1200px-Tour_de_France_logo.svg.png)
# Tour de France

> The Tour de France is an annual men's multiple stage bicycle race primarily held in France, while also occasionally passing through nearby countries. Like the other Grand Tours (the Giro d'Italia and the Vuelta a España), it consists of 21 day-long stages over the course of 23 days. It has been described as "the world’s most prestigious and most difficult bicycle race".

The data this week comes from [Alastair Rushworth's Data Package `tdf`](https://github.com/alastairrushworth/tdf) and [Kaggle](https://www.kaggle.com/jaminliu/a-brief-tour-of-tour-de-france-in-numbers/data).

Alastair has a very nice walkthrough of his data package at his [blog](https://alastairrushworth.github.io/Visualising-Tour-de-France-data-in-R/)!

I've added the Kaggle data which goes through 2017 for some additional stage-specific data not captured in his dataset. Please note that for the most part these datasets COULD be joined by year/edition.

Some other stats and records can be found on [Wikipedia](https://alastairrushworth.github.io/Visualising-Tour-de-France-data-in-R/).


### Get the data here

```{r}
# Get the Data

tdf_winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-07/tdf_winners.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-04-07')
tuesdata <- tidytuesdayR::tt_load(2020, week = 15)


tdf_winners <- tuesdata$tdf_winners
```
### Data Dictionary

# `tdf_winners.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|edition       |integer   | Edition of the Tour de France |
|start_date    |double    | Start date of the Tour |
|winner_name   |character | Winner's name|
|winner_team   |character | Winner's team (NA if not on a team) |
|distance      |double    | Distance traveled in KM across the entire race |
|time_overall  |double    | Time in hours taken by the winner to complete the race|
|time_margin   |double    | Difference in finishing time between the race winner and the runner up |
|stage_wins    |double    | Number of stage wins (note that it is possible to win the GC without winning any stages at all) |
|stages_led    |double    | Stages led is the number of stages spent as the race leader (wearing the yellow jersey) by the eventual winner |
|height        |double    | Height in meters|
|weight        |double    | Weight in kg|
|age           |integer   | Age as winner |
|born          |double    | year born |
|died          |double    | Year died|
|full_name     |character | Full name |
|nickname      |character | Nickname |
|birth_town    |character | Birth town|
|birth_country |character | Birth country|
|nationality   |character | Nationality|


# `stage_data.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|edition          |integer   | Race edition |
|year             |double    | Year of race |
|stage_results_id |character | Stage ID |
|rank             |character | Rank of racer for stage |
|time             |double    | Time of racer |
|rider            |character | Rider name |
|age              |integer   | Age of racer |
|team             |character | Team (NA if not on team) |
|points           |integer   | Points for the stage |
|elapsed          |double    | Time elapsed stored as `lubridate::period`|
|bib_number       |integer   | Bib number|


# `tdf_stages.csv`
|variable       |class     |description |
|:--------------|:---------|:-----------|
|Stage          |character | Stage Number|
|Date           |double    | Date of stage|
|Distance       |double    | Distance in KM|
|Origin         |character | Origin city |
|Destination    |character | Destination city|
|Type           |character | Stage Type |
|Winner         |character | Winner of the stage|
|Winner_Country |character | Winner's nationality |

### Cleaning Script

```{r}
library(tidyverse)
library(tdf) # install at: https://github.com/alastairrushworth/tdf

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

```