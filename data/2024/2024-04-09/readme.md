# 2023 & 2024 US Solar Eclipses 

This week we're looking at the paths of solar eclipses in the United States. The data comes from [NASA's Scientific Visualization Studio](https://svs.gsfc.nasa.gov/5073).

> On October 14, 2023, an annular solar eclipse [crossed] North, Central, and South America creating a path of annularity. An annular solar eclipse occurs when the Moon passes between the Sun and Earth while at its farthest point from Earth. Because the Moon is farther away from Earth, it does not completely block the Sun. This create[d] a “ring of fire” effect in the sky for those standing in the path of annularity. On April 8, 2024, a total solar eclipse will cross North and Central America creating a path of totality. During a total solar eclipse, the Moon completely blocks the Sun while it passes between the Sun and Earth. The sky will darken as if it were dawn or dusk and those standing in the path of totality may see the Sun’s outer atmosphere (the corona) if weather permits.

Which places are in both the 2023 path of annularity and the 2024 path of totality?
Which place has the longest duration of totality in 2024?

Note: The data is an approximation as of 2023-03-08.
If you are observing the 2024 eclipse within the path of totality, you may want to check times in your exact location.


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-04-09')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 15)

eclipse_annular_2023 <- tuesdata$eclipse_annular_2023
eclipse_total_2024 <- tuesdata$eclipse_total_2024
eclipse_partial_2023 <- tuesdata$eclipse_partial_2023
eclipse_partial_2024 <- tuesdata$eclipse_partial_2024

# Option 2: Read directly from GitHub

eclipse_annular_2023 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-09/eclipse_annular_2023.csv')
eclipse_total_2024 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-09/eclipse_total_2024.csv')
eclipse_partial_2023 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-09/eclipse_partial_2023.csv')
eclipse_partial_2024 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-09/eclipse_partial_2024.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `eclipse_annular_2023.csv`

|variable  |class              |description |
|:---------|:------------------|:-----------|
|state     |character          |2-letter state abbreviation |
|name      |character          |city name |
|lat       |double             |latitude |
|lon       |double             |longitude |
|eclipse_1 |hms                |time at which the moon first contacts the sun in this location|
|eclipse_2 |hms                |time at which the eclipse is at 50% in this location |
|eclipse_3 |hms                |time at which annularity begins in this location |
|eclipse_4 |hms                |time at which annularity ends in this location |
|eclipse_5 |hms                |time at which the eclipse is back to 50% in this location |
|eclipse_6 |hms                |time at which the moon last contacts the sun in this location |

# `eclipse_total_2024.csv`

|variable  |class              |description |
|:---------|:------------------|:-----------|
|state     |character          |2-letter state abbreviation |
|name      |character          |city name |
|lat       |double             |latitude |
|lon       |double             |longitude |
|eclipse_1 |hms                |time at which the moon first contacts the sun in this location|
|eclipse_2 |hms                |time at which the eclipse is at 50% in this location |
|eclipse_3 |hms                |time at which totality begins in this location |
|eclipse_4 |hms                |time at which totality ends in this location |
|eclipse_5 |hms                |time at which the eclipse is back to 50% in this location |
|eclipse_6 |hms                |time at which the moon last contacts the sun in this location |

# `eclipse_partial_2023.csv`

|variable  |class              |description |
|:---------|:------------------|:-----------|
|state     |character          |2-letter state abbreviation |
|name      |character          |city name |
|lat       |double             |latitude |
|lon       |double             |longitude |
|eclipse_1 |hms                |time at which the moon first contacts the sun in this location|
|eclipse_2 |hms                |time at which the eclipse is at 50% of this location's maximum |
|eclipse_3 |hms                |time at which the eclipse reaches 100% of this location's maximum |
|eclipse_4 |hms                |time at which the eclipse is again at 50% of this location's maximum |
|eclipse_5 |hms                |time at which the moon last contacts the sun in this location |

# `eclipse_partial_2024.csv`

|variable  |class              |description |
|:---------|:------------------|:-----------|
|state     |character          |2-letter state abbreviation |
|name      |character          |city name |
|lat       |double             |latitude |
|lon       |double             |longitude |
|eclipse_1 |hms                |time at which the moon first contacts the sun in this location|
|eclipse_2 |hms                |time at which the eclipse is at 50% of this location's maximum |
|eclipse_3 |hms                |time at which the eclipse reaches 100% of this location's maximum |
|eclipse_4 |hms                |time at which the eclipse is again at 50% of this location's maximum |
|eclipse_5 |hms                |time at which the moon last contacts the sun in this location |


### Cleaning Script

```{r}
library(tidyverse)
library(jsonlite)
library(janitor)
library(here)
library(fs)

working_dir <- here::here("data", "2024", "2024-04-09")

eclipse_cities_url_2024 <- "https://svs.gsfc.nasa.gov/vis/a000000/a005000/a005073/cities-eclipse-2024.json"
eclipse_cities_url_2023 <- "https://svs.gsfc.nasa.gov/vis/a000000/a005000/a005073/cities-eclipse-2023.json"

eclipse_cities_2024 <- jsonlite::fromJSON(eclipse_cities_url_2024) |> 
  tibble::as_tibble() |> 
  janitor::clean_names() |> 
  tidyr::unnest_wider(eclipse, names_sep = "_")

eclipse_total_2024 <- eclipse_cities_2024 |> 
  dplyr::filter(!is.na(eclipse_6))

eclipse_partial_2024 <- eclipse_cities_2024 |> 
  dplyr::filter(is.na(eclipse_6)) |> 
  dplyr::select(-eclipse_6)

eclipse_cities_2023 <- jsonlite::fromJSON(eclipse_cities_url_2023) |> 
  tibble::as_tibble() |> 
  janitor::clean_names() |> 
  tidyr::unnest_wider(eclipse, names_sep = "_")

eclipse_annular_2023 <- eclipse_cities_2023 |> 
  dplyr::filter(!is.na(eclipse_6))

eclipse_partial_2023 <- eclipse_cities_2023 |> 
  dplyr::filter(is.na(eclipse_6)) |> 
  dplyr::select(-eclipse_6)

readr::write_csv(
  eclipse_total_2024,
  fs::path(working_dir, "eclipse_total_2024.csv")
)
readr::write_csv(
  eclipse_partial_2024,
  fs::path(working_dir, "eclipse_partial_2024.csv")
)

readr::write_csv(
  eclipse_annular_2023,
  fs::path(working_dir, "eclipse_annular_2023.csv")
)
readr::write_csv(
  eclipse_partial_2023,
  fs::path(working_dir, "eclipse_partial_2023.csv")
)
```
