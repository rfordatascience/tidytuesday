# Wreck Inventory of Ireland

This week we are exploring Irish shipwreck data. The [Wreck Inventory of Ireland Database (WIID)](https://www.archaeology.ie/advice-and-support/locate-a-monument-or-wreck/wreck-viewer/) holds records of over 18,000 known and potential wreck sites in Irish waters, with data going back all the way to the 1300s.

> The Wreck Inventory of Ireland Database (WIID) holds records of over
> 18,000 known and potential wreck sites in the marine and inland waterways of
> Ireland. The WIID includes all known wrecks dating to pre-1946 but some later
> wrecks are also included. The database also includes records of aircraft
> wrecks where these have come to attention.

- How many wrecks still have not been found?
- Where are shipwrecks more likely to occur around Ireland?

Thank you to [Cormac Monaghan](https://github.com/C-Monaghan) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-06-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 26)

wreck_inventory <- tuesdata$wreck_inventory

# Option 2: Read directly from GitHub

wreck_inventory <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-30/wreck_inventory.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-06-30')

# Option 2: Read directly from GitHub and assign to an object

wreck_inventory = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-30/wreck_inventory.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-06-30")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

wreck_inventory = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-30/wreck_inventory.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
wreck_inventory = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-30/wreck_inventory.csv", DataFrame)
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

### `wreck_inventory.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|date                  |date      |Standardised date of the shipwreck event, where an exact date could be determined. |
|year                  |double    |Calendar year of the shipwreck event (but see `descriptive_date`). |
|wreck_name            |character |Recorded name of the wrecked vessel. |
|wreck_no              |character |Unique identifier assigned to the shipwreck record. |
|classification        |character |Vessel type or classification. |
|description           |character |Historical description of the vessel. |
|descriptive_date      |character |Original date information as recorded in the source material, including approximate or uncertain dates. |
|place_of_loss         |character |Recorded location where the vessel was lost. |
|latitude              |double    |Latitude of the shipwreck location (where available). |
|longitude             |double    |Longitude of the shipwreck location (where available). |
|source_of_co_ordinate |character |Source or method used to obtain the geographic coordinates. |

## Cleaning Script

```r
################################################################################
# National Monuments service - Wreck Inventory of Ireland
# https://www.arcgis.com/sharing/rest/content/items/d4b084c880b546fabe38345461b563d2/data
# Accessed 2026-06-10
# Curator: Cormac Monaghan
# A couple of notes ↓
# 1. Accessing the data initially returns a warning message because some of the 
#    dates and years values of the csv file are not consistent. Instead of all 
#    rows being in dym format some of them are written as "19th century" or "the 
#    1800s". I could probably try some fancy regex to better format all the 
#    dates nicely but I'm really bad at stuff like that. Instead I plan to set 
#    these dates as NA but leave in a "descriptive date" column for those 
#    potentially interested in these dates.
# 2. Additionally, many of the older wreaks (pre 1945) do not have accurate
#    coordinates and are hardcoded as zeros. However, the National Monuments
#    service is still searching for information on such wreaks. As such rather
#    than removing these I'm just going to recode them as NA as I think it could
#    still lead to some interesting analysis.
################################################################################

# Packages ---------------------------------------------------------------------
library(readr)
library(janitor)
library(dplyr)
library(lubridate)

# Accessing and tidying dataset ------------------------------------------------
wreck_inventory <- readr::read_csv(
  "https://www.arcgis.com/sharing/rest/content/items/d4b084c880b546fabe38345461b563d2/data",
  locale = readr::locale(encoding = "latin1")
) |>
  janitor::clean_names() |>
  dplyr::select(
    date = date_of_loss,
    year = date_of_loss_year_only,
    wreck_name,
    wreck_no,
    classification,
    description,
    descriptive_date = date_of_loss,
    place_of_loss,
    latitude = dd_lat,
    longitude = dd_long,
    source_of_co_ordinate
  ) |>
  # Turning inconsistent dates & years into NA values by making remaking
  # everything to be dmy format.
  # Additionally, setting hardcoded coordinates to be NA
  dplyr::mutate(
    date = lubridate::dmy(date),
    year = lubridate::year(date),
    latitude = ifelse(latitude == 0, NA, latitude),
    longitude = ifelse(longitude == 0, NA, longitude)
  )

```
