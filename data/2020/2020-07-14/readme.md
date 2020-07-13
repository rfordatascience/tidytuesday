![NASA Astronaut at the International Space Station](https://images.unsplash.com/photo-1447433865958-f402f562b843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80)

# Astronaut database

The data this week comes from [Mariya Stavnichuk and Tatsuya Corlett](https://data.mendeley.com/datasets/86tsnnbv2w/1). 

This [article](https://www.sciencedirect.com/science/article/abs/pii/S2214552420300444) talks about the data set in greater detail.

> This database contains publically available information about all astronauts who participated in space missions before 15 January 2020 collected from NASA, Roscosmos, and fun-made websites. The provided information includes full astronaut name, sex, date of birth, nationality, military status, a title and year of a selection program, and information about each mission completed by a particular astronaut such as a year, ascend and descend shuttle names, mission and extravehicular activity (EVAs) durations.

Credit for preparing the dataset: [Georgios Karamanis](https://twitter.com/geokaramanis)

It may be interesting to also use the [Space Launches dataset](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-01-15) from TidyTuesday 2019, week 3.

There is also a [Wikipedia Article](https://en.wikipedia.org/wiki/List_of_cumulative_spacewalk_records) on cumulative spacewalk records - you should be able to create the same dataset with the astronaut database and the `eva_hrs_mission` column.

To get that data in, use `tidytuesdayR::tt_load("2019", week = 3)`.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-07-14')
tuesdata <- tidytuesdayR::tt_load(2020, week = 29)

astronauts <- tuesdata$astronauts

# Or read in the data manually

astronauts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-14/astronauts.csv')

```
### Data Dictionary

# `astronauts.csv`

| variable                 | class     | description                                               |
| :----------------------- | :-------- | --------------------------------------------------------- |
| id                       | double    | ID                                                        |
| number                   | double    | Number                                                    |
| nationwide_number        | double    | Number within country                                     |
| name                     | character | Full  name                                                |
| original_name            | character | Name in original language                                 |
| sex                      | character | Sex                                                       |
| year_of_birth            | double    | Year of birth                                             |
| nationality              | character | Nationality                                               |
| military_civilian        | character | Military status                                           |
| selection                | character | Name of selection program                                 |
| year_of_selection        | double    | Year of selection program                                 |
| mission_number           | double    | Mission number                                            |
| total_number_of_missions | double    | Total number of missions                                  |
| occupation               | character | Occupation                                                |
| year_of_mission          | double    | Mission year                                              |
| mission_title            | character | Mission title                                             |
| ascend_shuttle           | character | Name of ascent shuttle                                    |
| in_orbit                 | character | Name of spacecraft used in orbit                          |
| descend_shuttle          | character | Name of descent shuttle                                   |
| hours_mission            | double    | Duration of mission in hours                              |
| total_hrs_sum            | double    | Total duration of all missions in hours                   |
| field21                  | double    | ?                                                         |
| eva_hrs_mission          | double    | Duration of extravehicular activities  during the mission |
| total_eva_hrs            | double    | Total duration of all extravehicular activities in hours  |


### Cleaning Script

```{r}
library(tidyverse)
library(janitor)
library(knitr)

astronauts <- read_csv("data/astronauts.csv") %>% 
  clean_names() %>% 
  filter(!is.na(number)) %>%  # remove last row (all values are NA)
  mutate(
    sex = if_else(sex == "M", "male", "female"),
    military_civilian = if_else(military_civilian == "Mil", "military", "civilian")
  )
```