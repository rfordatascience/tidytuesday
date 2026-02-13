# The Languages of Africa

This week we're exploring data about popular languages spoken on the African 
continent. The dataset this week comes from the [Languages of Africa](https://en.wikipedia.org/wiki/Languages_of_Africa) page on Wikipedia.

> The number of languages natively spoken in Africa is variously estimated (depending on the delineation of language vs. dialect) at between 1,250 and 2,100 and by some counts at over 3,000.

The dataset is rich with information on the number of languages spoken across 
the continent. Some of the questions that could be thought of include:

- Which country in Africa has the largest number of spoken languages?
- Which family of languages has the highest density of speakers?
- Are there any languages that cut across multiple countries?

Can't wait to see the kind of visualisations that can be created!

Thank you to Robert Muwanga, Data Enthusiast for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-01-13')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 2)

africa <- tuesdata$africa

# Option 2: Read directly from GitHub

africa <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-13/africa.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-01-13')

# Option 2: Read directly from GitHub and assign to an object

africa = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-13/africa.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2026-01-13')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

africa = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-13/africa.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
africa = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-01-13/africa.csv", DataFrame)
```


## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


## Data Dictionary

### `africa.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|language        |character |Name of popular African language. |
|family          |character |Group of languages with similar ancestry, having similar vocabulary, phonetics and grammar. |
|native_speakers |integer   |Number of known native speakers of the language. |
|country         |character |Country where this language is spoken. |

## Cleaning Script

```r
#########################################################################
# Author: Muwanga Robert                                                #
# Date: 24 December 2025                                                #
# License : Creative Commons (CC-BY)                                    #
# Purpose: Scrapes data from Wikipedia on popular languages in Africa.  #
#########################################################################

require(tidyr)
require(stringr)
require(dplyr)
require(purrr)
require(rvest)

# Let's get a list of African countries that we shall use in our data cleaning
# process 

african_countries <- 
  rvest::read_html('https://www.worldometers.info/geography/how-many-countries-in-africa/') |> 
  rvest::html_table() |> 
  purrr::pluck(1) |> 
  pull('Country') %>% 
  c(., 'Ivory Coast', 'Cape Verde')

# Let's extract the table of interest from Wikipedia
dataset <- 
  rvest::read_html("https://en.wikipedia.org/wiki/Languages_of_Africa") |> 
  rvest::html_table() |> 
  purrr::pluck(5) |> 
  dplyr::select(
    language = Language,
    family = Family,
    native_speakers = `Native speakers within Africa (L1)`, 
    country = `Official status per country`
  ) 

# Clean up the family and native speaker columns, and extract the countries
# from the country column
dt <- dataset |> 
  mutate(
    family = str_split_i(family, " ", 1), 
    native_speakers = str_split_i(native_speakers, " ", 1),
    country = str_extract_all(
      country, str_c(african_countries, collapse = "|"), simplify = TRUE))

# From the country column, we "expand" the cells that have vectors, creating 
# a "wider" tibble
countries <- 
  dataset |> 
  select(country) |> 
  map(.f = function(x) str_extract_all(
    x, str_c(
      african_countries, collapse = "|"), 
    simplify = TRUE)) |> 
  as.data.frame()

# We binding columns between the two datasets, make the dataset longer, and 
# remove rows that have blank entries in the country column
africa <- bind_cols(dt, countries) |> 
  select(-country) |> 
  pivot_longer(
    cols = contains("country"),
    names_to = 'country_index', values_to = 'country') |> 
  mutate(
    country = na_if(country, "")) |> 
  drop_na()

# We then clean up the native_speakers column and prepare our final dataset 
# by removing the unwanted country_index column
africa <- africa |> 
  mutate(native_speakers = str_split_i(native_speakers, pattern = '\\[|-', i = 1), 
         native_speakers = str_remove_all(native_speakers, pattern = ','), 
         native_speakers = as.integer(native_speakers)) |> 
  filter(!is.na(native_speakers)) |> 
  select(-country_index)

```
