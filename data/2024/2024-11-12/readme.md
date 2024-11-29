# ISO Country Codes

We've referenced countries and country codes in many past datasets, but we've never looked closely at the ISO 3166 standard that defines these codes.

Wikipedia says:

> ISO 3166 is a standard published by the International Organization for 
> Standardization (ISO) that defines codes for the names of countries, dependent 
> territories, special areas of geographical interest, and their principal 
> subdivisions (e.g., provinces or states). The official name of the standard 
> is Codes for the representation of names of countries and their subdivisions.

The dataset this week comes from the {[ISOcodes](https://cran.r-project.org/package=ISOcodes)} R package. It consists of three tables:

- `countries`: Country codes from ISO 3166-1.
- `country_subdivisions`: Country subdivision code from ISO 3166-2.
- `former_countries`: Code for formerly used names of countries from ISO 3166-3.

Tip: Try the [`quick_map()` function in the {countries} package](https://fbellelli.github.io/countries/reference/quick_map.html) to produce maps colored by country.

Some questions to consider:

- When did ISO 3166-3 begin to log the date withdrawn as a full date, rather than just a year?
- Which countries have the most subdivisions identified by the International Organization for Standardization (ISO)? 
- Is there a pattern to which countries have sub-subdivisions (subdivisions with a `parent`) and which don't?

You can use this code to explore past datasets that have mentioned countries and/or country codes:

```r
# install.packages("pak")
# pak::pak("r4ds/ttmeta")
ttmeta::tt_datasets_metadata |> 
  dplyr::mutate(
    has_country = purrr::map_lgl(variable_details, function(var_details) {
      "country_code" %in% tolower(var_details$variable) ||
        any(stringr::str_detect(tolower(var_details$variable), "country"))
    })
  ) |> 
  dplyr::filter(has_country)
```

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-11-12')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 46)

countries <- tuesdata$countries
country_subdivisions <- tuesdata$country_subdivisions
former_countries <- tuesdata$former_countries

# Option 2: Read directly from GitHub

countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-12/countries.csv')
country_subdivisions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-12/country_subdivisions.csv')
former_countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-12/former_countries.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `countries.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|alpha_2       |character |2-letter country code. |
|alpha_3       |character |3-letter country code. |
|numeric       |integer   |3-digit country code. |
|name          |character |Name of the country (in English). |
|official_name |character |Official name of the country (in English). |
|common_name   |character |Alternate common name for the country (in English). |

# `country_subdivisions.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|code     |character |Code for the subdivision, consisting of a country's alpha_2 code, then a dash, then a code for this subdivision. |
|name     |character |Name of this subdivision. |
|type     |character |Type of subdivision, such as "Province", "Municipality", or "District". |
|parent   |character |Code for the subdivision in which this subdivision is found, if it is not a direct subdivision of the country. |
|alpha_2  |character |The parent country's alpha_2 code (extracted from code). |

# `former_countries.csv`

|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|alpha_4        |character |4-letter country code. Only used for these former countries. |
|alpha_3        |character |3-letter country code. |
|numeric        |character |3-digit country code. |
|name           |character |Name of the former country (in English). |
|date_withdrawn |character |Year or date on which the code was withdrawn from use. |
|comment        |character |An optional comment explaining why the code was withdrawn. |

### Cleaning Script

```r
# Mostly clean data from the ISOcodes package

# install.packages("ISOcodes")
library(ISOcodes)
library(tidyverse)
library(janitor)

countries <- 
  ISOcodes::ISO_3166_1 |> 
  tibble::as_tibble() |> 
  dplyr::mutate(Numeric = as.integer(Numeric)) |> 
  janitor::clean_names()
country_subdivisions <- 
  ISOcodes::ISO_3166_2 |> 
  tibble::as_tibble() |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    alpha_2 = stringr::str_extract(code, "^[^-]+(?=-)")
  )
former_countries <-
  ISOcodes::ISO_3166_3 |> 
  tibble::as_tibble() |> 
  janitor::clean_names()
```
