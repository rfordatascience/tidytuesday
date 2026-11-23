# Average share of green areas across cities

This week we are exploring the average share of green areas in cities and urban
areas and green area per capita around the world. The dataset this week comes
from [UN Habitat Urban Indicators Dataset](https://data.unhabitat.org/pages/open-spaces-and-green-areas). 

> The data referenced herein is calculated using urban boundaries defined using the Degree of Urbanization approach to defining cities and urban areas, which may be larger or smaller than the official municipality boundaries. Within each city/urban area, the green areas are extracted using satellite imagery analysis for five time periods 1990, 2000, 2010,2020 and 2025 based on the Normalized Difference Vegetation Index (NDVI), which assesses the level of greenness from satellite imagery. In this analysis, green areas are defined as parts of the city that are green for most parts of the year, and include individual trees, forests or forested areas, shrubs, perennial grasses and such other types of long-term vegetation. Waterbodies are not considered as green areas in this assessment. 

- Which city has the most green area per capita in each year?
- Which city has lost the largest percentage of its green area since 1990?
- Which city has gained the largest percentage of green area since 1990?

Thank you to [Gabriela Palomo-Munoz](https://github.com/GabsPalomo) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-09-22')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 38)

urban <- tuesdata$urban

# Option 2: Read directly from GitHub

urban <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-22/urban.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-09-22')

# Option 2: Read directly from GitHub and assign to an object

urban = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-22/urban.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-09-22")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

urban = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-22/urban.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
urban = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-22/urban.csv", DataFrame)
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

### `urban.csv`

|variable                                  |class     |description                           |
|:-----------------------------------------|:---------|:-------------------------------------|
|countryOrTerritoryName                    |character |Name of the country or territory. |
|cityCode                                  |character |Code used to refer to a city. It may include the country. E.g., US_SAN_DIEGO, US_TULSA_OK. |
|cityName                                  |character |The name of the city. |
|sdgSubRegion                              |character |Name of the subregion where the city is located. E.g., Northern America, Western Asia. |
|sdgRegion                                 |character |Name of the region where the city is located. E.g., Northern America and Europe, Latin America and the Caribbean.|
|dataSource                                |character |Source is always "UN-Habitat Urban Indicators Database". |
|footNote                                  |character |Information on how they calculated the values. |
|year                                      |integer   |Year in which the average share of green area or green area per capita was calculated. It can be 1990, 2000, 2010, 2020 or 2025. |
|averageShareOfGreenAreaInCityUrbanAreaPct |double    |Average share of green area in each city in percentage. |
|greenAreaPerCapitaM2                      |double    |Amount of green area per capita in square meters per city. |

## Cleaning Script

```r
# Packages 
library(readxl)
library(janitor)
library(dplyr)
library(tidyr)
library(withr)

# Download the dataset from the UN-Habitat website and save it as a local file.
xlsx_url <- "https://guo-un-habitat.maps.arcgis.com/sharing/rest/content/items/4350427c2e3341f69de14cb00c8d3ef3/data"
xlsx_file <- withr::local_tempfile(fileext = ".xlsx")
download.file(xlsx_url, xlsx_file, mode = "wb")

# Clean dataset 
# Ignore the first sheet because it has metadata and info 
# Then we will fix the columns that are in wide format and leave 
# the entire dataset in long format 
urban <- readxl::read_excel(xlsx_file, 
                            sheet = 2, 
                            na = '-') |> 
  janitor::clean_names(case = "small_camel") |> 
  tidyr::pivot_longer(
    cols = matches("^(averageShareOfGreenAreaInCityUrbanArea|greenAreaPerCapita)\\d{4}"),
    names_to = c(".value", "year"),
    names_pattern = "^(averageShareOfGreenAreaInCityUrbanArea|greenAreaPerCapita)(\\d{4})"
  ) |>
  rename(
    averageShareOfGreenAreaInCityUrbanAreaPct = averageShareOfGreenAreaInCityUrbanArea,
    greenAreaPerCapitaM2 = greenAreaPerCapita
  ) |>
  mutate(year = as.integer(year))

```
