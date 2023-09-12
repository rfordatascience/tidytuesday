# The Global Human Day

The data this week comes from the [The Human Chronome Project](https://www.humanchronome.org/) an initiative based at McGill University in Montreal, from their paper [The global human day in PNAS](https://www.pnas.org/doi/10.1073/pnas.2219564120#sec-2) and the [associated dataset on Zenodo](https://zenodo.org/record/8040631).

> The daily activities of ≈8 billion people occupy exactly 24 h per day, placing a strict physical limit on what changes can be achieved in the world. These activities form the basis of human behavior, and because of the global integration of societies and economies, many of these activities interact across national borders. This project estimates how all humans spend their time using a generalized, physical outcome–based categorization that facilitates the integration of data from hundreds of diverse datasets. 

See their [supplementary materials](https://www.pnas.org/doi/10.1073/pnas.2219564120#supplementary-materials) for details about their methods and additional visualizations. 

The [Zenodo dataset](https://zenodo.org/record/8040631) includes the input data and scripts used to create the datasets used in the paper. The datasets are from the outputData file "all_countries.csv", "global_human_day.csv", "global_economic_activity.csv" and inputData "country_regions.csv". The outputData files are aggregated output data from data collected, created from the scripts in the 'scripts' directory.

h/t [Data is Plural 2023-07-13 newsletter](https://www.data-is-plural.com/archive/2023-07-12-edition/) for the dataset.

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-09-12')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 37)

all_countries <- tuesdata$all_countries
country_regions <- tuesdata$country_regions
global_human_day <- tuesdata$global_human_day
global_economic_activity <- tuesdata$global_economic_activity

# Option 2: Read directly from GitHub

all_countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-12/all_countries.csv')
country_regions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-12/country_regions.csv')
global_human_day <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-12/global_human_day.csv')
global_economic_activity <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-12/global_economic_activity.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `all_countries.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|Category            |character |M24 categories            |
|Subcategory         |character |M24 subcategories         |
|country_iso3        |character |Country code in iso3        |
|region_code         |character |Region code        |
|population          |double    |Population         |
|hoursPerDayCombined |double    |Hours per day combined for the country |
|uncertaintyCombined |double    |Uncertainty combined. Uncertainty is in units variance. |

# `country_regions.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|region_code       |character |Region code       |
|region_name       |character |Region name       |
|country_name      |character |Country name      |
|M49_code          |double    |M49 code      |
|country_iso2      |character |Country code in iso2      |
|country_iso3      |character |Country code in iso3      |
|alt_country_name  |character |Alternative country name  |
|alt_country_name1 |character |Alternative country name 1 |
|alt_country_name2 |character |Alternative country name 2 |
|alt_country_name3 |character |Alternative country name 3 |
|alt_country_name4 |character |Alternative country name 4 |
|alt_country_name5 |character |Alternative country name 5 |
|alt_country_name6 |character |Alternative country name 6 |
|other_code1       |character |Other country code 1       |
|other_code2       |character |Other country code 2       |

# `global_human_day.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|Subcategory |character |M24 subcategory |
|hoursPerDay |double    |Hours per day for all countries |
|uncertainty |double    |Uncertainty in units variance. |

# `global_economic_activity.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|Subcategory |character |M24 subcategory |
|hoursPerDay |double    |Hours per day for all countries. |
|uncertainty |double    |Uncertainty in units variance. |

### Cleaning Script

``` r
library(tidyverse)

# Read in the data file all_countries.csv from https://zenodo.org/record/8040631

all_countries <- read_csv("all_countries.csv")

# Change variable name to be consistent between files

colnames(all_countries)[3] <- "country_iso3"

# Remove columns on data status

all_countries = subset(all_countries, select = -c(dataStatus,dataStatusEconomic))

# write out data
readr::write_csv(
  all_countries, "all_countries.csv")

```
