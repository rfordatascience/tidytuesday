# Objects Launched into Space 

This week we're exploring the [annual number of objects launched into outer space](https://ourworldindata.org/grapher/yearly-number-of-objects-launched-into-outer-space)! Our World in Data processed the data from the [Online Index of Objects Launched into Outer Space](https://www.unoosa.org/oosa/osoindex/search-ng.jspx), maintained by the United Nations Office for Outer Space Affairs since 1962. h/t [Data is Plural](https://www.data-is-plural.com/archive/2024-04-10-edition/).

> What you should know about this indicator

> Objects are defined here as satellites, probes, landers, crewed spacecrafts, and space station flight elements launched into Earth orbit or beyond.

> This data is based on national registers of launches submitted to the UN by participating nations. According to UN estimates, the data captures around 88% of all objects launched.

> When an object is marked by the source as launched by a country on behalf of another one, the launch is attributed to the latter country.

> When a launch is made jointly by several countries, it is recorded in each of these countries' time series but only once in the 'World' series.

Data Page: Annual number of objects launched into space”, part of the following publication: Edouard Mathieu and Max Roser (2022) - “Space Exploration and Satellites”. Data adapted from United Nations Office for Outer Space Affairs. Retrieved from [https://ourworldindata.org/grapher/yearly-number-of-objects-launched-into-outer-space](https://ourworldindata.org/grapher/yearly-number-of-objects-launched-into-outer-space)

Dataset: United Nations Office for Outer Space Affairs (2024) – with major processing by Our World in Data. “Annual number of objects launched into space – UNOOSA” [dataset]. United Nations Office for Outer Space Affairs, “Online Index of Objects Launched into Outer Space” [original data]. Retrieved April 21, 2024 from [https://ourworldindata.org/grapher/yearly-number-of-objects-launched-into-outer-space](https://ourworldindata.org/grapher/yearly-number-of-objects-launched-into-outer-space)

When did each entity start launching objects into space? What years saw the biggest increase in space object launches?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-04-23')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 17)

outer_space_objects <- tuesdata$outer_space_objects


# Option 2: Read directly from GitHub

outer_space_objects <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-23/outer_space_objects.csv')


```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `outer_space_objects`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|Entity      |character |Entity, country or other entity      |
|Code        |character |Entity code        |
|Year        |integer   |Year        |
|num_objects |integer   |Annual number of objects launched into outer space |


### Cleaning Script

```{r}
library(tidyverse)
library(here)

working_dir <- here::here("data", "2024", "2024-04-23")

# File downloaded from https://ourworldindata.org/grapher/yearly-number-of-objects-launched-into-outer-space on April 21, 2024
space_objects <- read.csv("yearly-number-of-objects-launched-into-outer-space.csv")

colnames(space_objects)

space_objects <- space_objects |>
  rename(num_objects = Annual.number.of.objects.launched.into.outer.space)


readr::write_csv(
  space_objects,
  fs::path(working_dir, "outer_space_objects.csv")
)

```
