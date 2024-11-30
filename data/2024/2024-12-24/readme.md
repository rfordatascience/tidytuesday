# Global Holidays and Travel

This week we're exploring how global holidays impact seasonal human mobility. We found the data via the article ["Global holiday datasets for understanding seasonal human mobility and population dynamics" by Shengjie Lai (et al)](https://www.nature.com/articles/s41597-022-01120-z) (thank you to @lgibson7 for finding the dataset).

> Public and school holidays have important impacts on population mobility and dynamics across multiple spatial and temporal scales, subsequently affecting the transmission dynamics of infectious diseases and many socioeconomic activities. However, worldwide data on public and school holidays for understanding their changes across regions and years have not been assembled into a single, open-source and multitemporal dataset. To address this gap, an open access archive of data on public and school holidays in 2010–2019 across the globe at daily, weekly, and monthly timescales was constructed. Airline passenger volumes across 90 countries from 2010 to 2018 were also assembled to illustrate the usage of the holiday data for understanding the changing spatiotemporal patterns of population movements.

Sources:

Lai S., Sorichetta A. and WorldPop (2020). Global Public and School Holidays 2010-2019. Mapping seasonal denominator dynamics in low- and middle-income settings, and Exploring the seasonality of COVID-19, funded by The Bill and Melinda Gates Foundation.

Lai S., Sorichetta A. and WorldPop (2020). Monthly volume of airline passengers in 90 countries 2010-2018. Mapping seasonal denominator dynamics in low- and middle-income settings, and Exploring the seasonality of COVID-19, funded by The Bill and Melinda Gates Foundation.

The source article contains a number of data visualizations. 

- Can you reproduce them? 
- Can you find better ways to show the same information?

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-12-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 52)

global_holidays <- tuesdata$global_holidays
monthly_passengers <- tuesdata$monthly_passengers

# Option 2: Read directly from GitHub

global_holidays <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-24/global_holidays.csv')
monthly_passengers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-24/monthly_passengers.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `global_holidays.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|ADM_name |character |Name of the administering location (country or other political subdivision). |
|ISO3     |character |3-letter ISO code for this location (see [TidyTuesday 2024-11-12: ISO Country Codes](https://tidytues.day/2024/2024-11-12)). |
|Date     |date      |Date of the observance. |
|Name     |character |Name of the observance. |
|Type     |character |Type of the observance. One of "Half-day holiday", "Local holiday", "Local observance", "Observance", "Public holiday", "Special holiday", or "Working day (replacement)". |

# `monthly_passengers.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|ISO3          |character |3-letter ISO code for this location (see [TidyTuesday 2024-11-12: ISO Country Codes](https://tidytues.day/2024/2024-11-12)). |
|Year          |integer   |Year of the flights. |
|Month         |integer   |Month of the flights. |
|Total         |double    |Total number of air passengers in thousands, obtained from official statistics. |
|Domestic      |double    |Number of internal air passengers in thousands for a country, obtained from official statistics. |
|International |double    |Number of international air passengers in thousands, obtained from official statistics. |
|Total_OS      |double    |Total number of air passengers in thousands, obtained from other openly available data sources. |

### Cleaning Script

```r
library(tidyverse)
library(withr)

url <- "https://data.worldpop.org/GIS/Holiday_Data/public_holidays/public_holidays_2010_2019.zip"
path <- withr::local_tempfile(fileext = ".zip")
download.file(url, path)
global_holidays <- readr::read_csv(path) |> 
  dplyr::mutate(Date = lubridate::dmy(Date))


url <- "https://data.worldpop.org/GIS/Flight_Data/monthly_volume_of_airline_passengers/monthly_vol_of_airline_pass_in_90_countries_2010_2018.zip"
path <- withr::local_tempfile(fileext = ".zip")
download.file(url, path)
monthly_passengers <- readr::read_csv(path) |>
  dplyr::mutate(
    dplyr::across(c(Year, Month), as.integer)
  )
```
