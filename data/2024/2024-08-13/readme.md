# World's Fairs

We're in Seattle this week for [posit::conf](https://posit.co/conference/), so we're exploring [World's Fairs](https://en.wikipedia.org/wiki/World%27s_fair)! 

> A world's fair, also known as a universal exhibition or an expo, is a large global exhibition designed to showcase the achievements of nations. These exhibitions vary in character and are held in different parts of the world at a specific site for a period of time, typically between three and six months.

The data was scraped from [Wikipedia's list of world expositions](https://en.wikipedia.org/wiki/List_of_world_expositions).

Does the length of a Fair depend on the month in which the fair begins?
How has the cost per month changed over time?
How about the cost per visitor?

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-08-13')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 33)

worlds_fairs <- tuesdata$worlds_fairs

# Option 2: Read directly from GitHub

worlds_fairs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-13/worlds_fairs.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `worlds_fairs.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|start_month         |integer   |Month in which the fair began |
|start_year          |integer   |Year in which the fair began |
|end_month           |integer   |Month in which the fair ended |
|end_year            |integer   |Year in which the fair ended |
|name_of_exposition  |character |Name used to describe the fair |
|country             |character |Country in which the fair was held |
|city                |character |City in which the fair was held |
|category            |character |Whether the fair was a "World Expo" ("Bureau International des Expositions (BIE)-registered exhibitions that take place every five years and last up to 6 months; All exhibitions in this category which took place before 1928 were subsequently recognized by the BIE") or a "Specialised Expo" ("BIE-International Recognised exhibitions that take place between two World Expos and last up to 3 months; This definition was adopted after 1988; prior to that, some longer running ones, including 1988 Brisbane, were classified as Specialised Expos")|
|theme               |character |The stated theme of the fair |
|notables            |character |Notable buildings, inventions, or events at the fair |
|visitors            |double    |Number of visitors in millions |
|cost                |double    |Cost in millions of USD (or millions of another currency, as noted in exceptions); exceptions: Brussels International Exposition (1935) and Brussels World's Fair (1958) are in BEF, Paris International Exposition (1937) is in FRF, Expo '67 (1967) is in CAD, Expo '86 (1986) is listed as having a "311 CAD deficit", Expo '88 (1988) is in AUD, Expo 2000 (2000) is in DEM |
|area                |double    |Area of the fair in hectares |
|attending_countries |integer   |Number of countries which officially attended |

### Cleaning Script

```r
library(tidyverse)
library(rvest)
library(polite)
library(janitor)

session <- polite::bow(
  "https://en.wikipedia.org/wiki/List_of_world_expositions",
  user_agent = "TidyTuesday (https://tidytues.day, jonthegeek+tidytuesday@gmail.com)",
  delay = 0
)

worlds_fair_tables <- 
  session |> 
  polite::scrape() |> 
  rvest::html_table()

worlds_fairs <-
  worlds_fair_tables[[2]] |>
  janitor::clean_names() |>
  dplyr::rename(
    country = "country_2",
    city = "city_2",
    theme = "theme_3",
    visitors = "visitorsin_millions_4",
    cost = "costin_millions_usd_unless_specified",
    area = "area_ha",
    attending_countries = "attendingcountries"
  ) |> 
  tidyr::separate_wider_delim(
    "dates",
    " – ",
    names = c("start", "end")
  ) |> 
  tidyr::separate_wider_delim(
    c("start", "end"),
    "/",
    names = c("month", "year"),
    names_sep = "_"
  ) |> 
  dplyr::mutate(
    dplyr::across(
      dplyr::everything(),
      \(x) {
        stringr::str_remove_all(x, "\\[\\d+\\]") |> 
          stringr::str_squish()
      }
    ),
    dplyr::across(
      c("start_month", "start_year", "end_month", "end_year", "attending_countries"),
      as.integer
    ),
    notables = stringr::str_replace_all(notables, "([a-z])([A-Z])", "\\1, \\2"),
    visitors = as.double(visitors),
    # One expo has two costs, we'll use the first one
    cost = dplyr::case_when(
      name_of_exposition == "Expo 2010" ~ "4200",
      .default = cost
    ) |>
      stringr::str_remove_all("[^0-9]*") |>
      as.double(),
    area = as.double(area)
  )
```
