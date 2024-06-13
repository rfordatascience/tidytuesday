# US Federal Holidays

This week we're celebrating Juneteenth!

> [Juneteenth National Independence Day] Commemorates the emancipation of enslaved people in the United States on the anniversary of the 1865 date when emancipation was announced in Galveston, Texas. Celebratory traditions often include readings of the Emancipation Proclamation, singing traditional songs, rodeos, street fairs, family reunions, cookouts, park parties, historical reenactments, and Miss Juneteenth contests.

Juneteenth became a federal holiday in the United States on June 17, 2021.
To commemorate this newest U.S. Federal Holiday, we're exploring the Wikipedia page about [Federal holidays in the United States](https://en.wikipedia.org/wiki/Federal_holidays_in_the_United_States).

Which days of the week do federal holidays fall on this year?
What is the longest gap between holidays this year? Is it different in other years?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-06-18')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 25)

federal_holidays <- tuesdata$federal_holidays
proposed_federal_holidays <- tuesdata$proposed_federal_holidays

# Option 2: Read directly from GitHub

federal_holidays <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-18/federal_holidays.csv')
proposed_federal_holidays <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-18/proposed_federal_holidays.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `federal_holidays.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|date             |character |The month and day or days when the holiday is celebrated. |
|date_definition  |character |Whether the date is a "fixed date" or follows some other pattern. |
|official_name    |character |The official name of the holiday. |
|year_established |numeric   |The year in which the holiday was officially established as a federal holiday. |
|date_established |Date      |The date on which the holiday was officially established as a federal holiday, if known. |
|details          |character |Additional details about the holiday, from the Wikipedia article. |

# `proposed_federal_holidays.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|date            |character |The month and day or days when the holiday would be celebrated. |
|date_definition |character |Whether the date is a "fixed date" or follows some other pattern. |
|official_name   |character |The proposed official name of the holiday. |
|details         |character |Additional details about the holiday, from the Wikipedia article. |


### Cleaning Script

```{r}
library(tidyverse)
library(janitor)
library(here)
library(fs)
library(rvest)
library(polite)

working_dir <- here::here("data", "2024", "2024-06-18")
session <- polite::bow(
  "https://en.wikipedia.org/wiki/Federal_holidays_in_the_United_States",
  user_agent = "TidyTuesday (https://tidytues.day, jonthegeek+tidytuesday@gmail.com)",
  delay = 0
)
holiday_tables <- session |> 
  polite::scrape() |> 
  rvest::html_table()
  
federal_holidays <- holiday_tables[[2]] |>
  janitor::clean_names() |> 
  dplyr::rename(official_name = "official_name_2") |> 
  tidyr::separate_wider_regex(
    "date",
    patterns = c(
      date = "^[^(]+",
      "\\(",
      date_definition = "[^)]+",
      "\\)$"
    )
  ) |> 
  dplyr::mutate(
    date_definition = tolower(date_definition),
    details = stringr::str_remove_all(details, "\\[\\d+\\]")
  ) |> 
  dplyr::mutate(
    year_established = stringr::str_extract(date_established, "\\d{4}") |> 
      as.integer(),
    date_established = stringr::str_extract(
      date_established,
      "^[A-Za-z]+ \\d{1,2}, \\d{4}"
    ) |> 
      lubridate::mdy(),
    .before = date_established,
    .keep = "unused"
  )
  
proposed_federal_holidays <- holiday_tables[[3]] |>
  janitor::clean_names() |> 
  tidyr::separate_wider_regex(
    "date",
    patterns = c(
      date = "^[^(]+",
      "\\(",
      date_definition = "[^)]+",
      "\\)$"
    )
  ) |> 
  dplyr::mutate(
    date_definition = tolower(date_definition) |> 
      stringr::str_remove_all("\\[\\d+\\]"),
    details = stringr::str_remove_all(details, "\\[\\d+\\]")
  ) 
  
# Save -------------------------------------------------------------------------
readr::write_csv(
  federal_holidays,
  fs::path(working_dir, "federal_holidays.csv")
)
readr::write_csv(
  proposed_federal_holidays,
  fs::path(working_dir, "proposed_federal_holidays.csv")
)
```
