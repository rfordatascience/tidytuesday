# Water Insecurity

This week we're exploring water insecurity data featured in the article [Mapping water insecurity in R with tidycensus](https://waterdata.usgs.gov/blog/acs-maps/)!

> Water insecurity can be influenced by number of social vulnerability indicators—from demographic characteristics to living conditions and socioeconomic status —that vary spatially across the U.S. This blog shows how the tidycensus package for R can be used to access U.S. Census Bureau data, including the American Community Surveys, as featured in the “Unequal Access to Water ” data visualization from the USGS Vizlab. It offers reproducible code examples demonstrating use of tidycensus for easy exploration and visualization of social vulnerability indicators in the Western U.S.

- How does the lack of complete indoor plumbing compare between the 2023 and 2022 Census data? 
- What counties have the greatest percent of households lacking plumbing?
- Are there differences in indoor plumbing availability between Western U.S and Eastern U.S counties? 

Thank you to [Niha Pereira](https://github.com/nnpereira) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-01-28')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 4)

water_insecurity_2022 <- tuesdata$water_insecurity_2022
water_insecurity_2023 <- tuesdata$water_insecurity_2023

# Option 2: Read directly from GitHub

water_insecurity_2022 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-28/water_insecurity_2022.csv')
water_insecurity_2023 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-28/water_insecurity_2023.csv')

# The geometry columns are saved as text with the code to reproduce them.
water_insecurity_2022 <- water_insecurity_2022 |> 
  dplyr::mutate(
    geometry = purrr::map(geometry, \(geo) {
      eval(parse(text = geo))
    } )
  )
water_insecurity_2023 <- water_insecurity_2023 |> 
  dplyr::mutate(
    geometry = purrr::map(geometry, \(geo) {
      eval(parse(text = geo))
    } )
  )
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `water_insecurity_2022.csv`

|variable                 |class            |description                           |
|:------------------------|:----------------|:-------------------------------------|
|geoid                    |character        |The U.S. Census Bureau ACS county id.  |
|name                     |character        |The U.S. Census Bureau ACS county name. |
|year                     |character        |The year of U.S. Census Bureau ACS sample. |
|geometry                 |sfc_MULTIPOLYGON |The county geographic boundaries. |
|total_pop                |double           |The total population. |
|plumbing                 |double           |The total owner occupied households lacking plumbing facilities. |
|percent_lacking_plumbing |double           |The percent of population lacking plumbing facilities. |

# `water_insecurity_2023.csv`

|variable                 |class            |description                           |
|:------------------------|:----------------|:-------------------------------------|
|geoid                    |character        |The U.S. Census Bureau ACS county id.  |
|name                     |character        |The U.S. Census Bureau ACS county name. |
|year                     |character        |The year of U.S. Census Bureau ACS sample. |
|geometry                 |sfc_MULTIPOLYGON |The county geographic boundaries. |
|total_pop                |double           |The total population. |
|plumbing                 |double           |The total owner occupied households lacking plumbing facilities. |
|percent_lacking_plumbing |double           |The percent of population lacking plumbing facilities. |

### Cleaning Script

```r
# Clean data compiled from code referenced in article (https://waterdata.usgs.gov/blog/acs-maps/). 
# Code was revised to pull data for all US counties for years 2022 - 2023.

# Load packages -----
library(tidycensus)
library(sf) 
library(janitor) 
library(tidyverse)

# Helper functions -----
get_census_data <- function(geography, var_names, year, proj, survey_var) {
  df <- get_acs(
    geography = geography,
    variable = var_names,
    year = year,
    geometry = TRUE,
    survey = survey_var) |>
    clean_names() |>
    st_transform(proj) |>
    mutate(year = year)
  
  return(df) 
}

# Grab relevant variables - B01003_001: total population, B25049_004: households lacking plumbing----
vars <- c("B01003_001", "B25049_004")

# Pull data for 2023 and 2022 for all US counties ------
water_insecurity_2023 <- get_census_data(
  geography = 'county', 
  var_names = vars, 
  year = "2023", 
  proj = "EPSG:5070", 
  survey_var = "acs1"
) |>
  mutate(
    variable_long = case_when(
      variable == "B01003_001" ~ "total_pop",
      variable == "B25049_004" ~ "plumbing",
      .default = NA_character_  
    )
  ) |> 
  select(geoid, name, variable_long, estimate, geometry, year) |> 
  pivot_wider(
    names_from = variable_long,
    values_from = estimate
  ) |> 
  mutate(
    percent_lacking_plumbing = (plumbing / total_pop) * 100
  )

water_insecurity_2022 <- get_census_data(
  geography = 'county', 
  var_names = vars, 
  year = "2022", 
  proj = "EPSG:5070", 
  survey_var = "acs1"
) |>
  mutate(
    variable_long = case_when(
      variable == "B01003_001" ~ "total_pop",
      variable == "B25049_004" ~ "plumbing",
      .default = NA_character_  
    )
  ) |> 
  select(geoid, name, variable_long, estimate, geometry, year) |> 
  pivot_wider(
    names_from = variable_long,
    values_from = estimate
  ) |> 
  mutate(
    percent_lacking_plumbing = (plumbing / total_pop) * 100
  )
```
