# The CIA World Factbook

This week we're exploring the [CIA World Factbook](https://www.cia.gov/the-world-factbook/)! 
The dataset this week comes from the [CIA Factbook, Country Comparisons, 2014](https://www.cia.gov/the-world-factbook/references/guide-to-country-comparisons),
via the [{openintro}](https://openintrostat.github.io/openintro/) R package,
via the [{usdatasets}](https://cran.r-project.org/package=usdatasets) R package, 
via [this post on LinkedIn](https://www.linkedin.com/posts/andrescaceresrossi_rstats-rstudio-opensource-activity-7249513444830318592-r395).

> The *World Factbook* provides basic intelligence on the history, people, government, 
> economy, energy, geography, environment, communications, transportation, military, 
> terrorism, and transnational issues for 265 world entities.

Which countries have the highest number of internet users per square kilometer?
Which countries have the highest percentage of internet users?

You might want to join this dataset with past TidyTueday datasets that featured country information!

```r
# pak::pak("r4ds/ttmeta")
library(tidyverse)
library(ttmeta)

country_datasets <- ttmeta::tt_datasets_metadata |> 
  dplyr::mutate(
    has_country = purrr::map_lgl(
      .data$variable_details,
      \(var_dets) {
        !is.null(var_dets) && 
          any(stringr::str_detect(tolower(var_dets$variable), "country"))
      }
    )
  ) |> 
  dplyr::filter(has_country)
```

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-10-22')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 43)

cia_factbook <- tuesdata$cia_factbook

# Option 2: Read directly from GitHub

cia_factbook <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-22/cia_factbook.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `cia_factbook.csv`

|variable                |class   |description                           |
|:-----------------------|:-------|:-------------------------------------|
|country                 |integer |Name of the country (factor with 259 levels). |
|area                    |integer |Total area of the country (in square kilometers). |
|birth_rate              |double  |Birth rate (number of live births per 1,000 people). |
|death_rate              |double  |Death rate (number of deaths per 1,000 people). |
|infant_mortality_rate   |double  |Infant mortality rate (number of deaths of infants under one year old per 1,000 live births). |
|internet_users          |integer |Number of internet users. |
|life_exp_at_birth       |double  |Life expectancy at birth (in years). |
|maternal_mortality_rate |integer |Maternal mortality rate (number of maternal deaths per 100,000 live births). |
|net_migration_rate      |double  |Net migration rate (number of migrants per 1,000 people). |
|population              |integer |Total population of the country. |
|population_growth_rate  |double  |Population growth rate (multiplier). |

### Cleaning Script

```r
# Mostly clean data provided by the {usdatasets} R package
# (https://cran.r-project.org/package=usdatasets). No cleaning was necessary.

# pak::pak("usdatasets")
library(dplyr)
library(usdatasets)
cia_factbook <- usdatasets::cia_factbook_tbl_df |> 
  dplyr::mutate(
    dplyr::across(
      c("area", "internet_users"),
      as.integer
    )
  )
```
