# Seismic Events at Mount Vesuvius

The dataset this week explores seismic events detected at the famous Mount Vesuvius in Italy. It comes from the [Italian Istituto Nazionale di Geofisica e Vulcanologia (INGV)](https://www.ingv.it/)'s [Data Portal](https://data.ingv.it/en/) and can be explored
along with other seismic areas on [the GOSSIP website](https://terremoti.ov.ingv.it/gossip/vesuvio/index.html). The raw data was saved as individual CSV files from the GOSSIP website and some values were translated from Italian to English.   


> The Open Data Portal of Istituto Nazionale di Geofisica e Vulcanologia (INGV) gives public access to data resulting from institutional research activities in the fields of Seismology, Volcanology, and Environment.  

Some information about Mount Vesuvius [from INGV](https://www.ingv.it/somma-vesuvio):  
- Location: Campania, 40°49′18.01″N, 14°25'33.57” E
- Maximum height: 1281 m above sea level
- Total surface area: ≈115-150 km2
- Type of volcano: stratovolcano
- Start of eruptive activity: <39,000 years
- Last eruption: 1944 (lasted about 10 days)
- Activity status: quiescent (not active, but is still registering seismic activity)

- How has the number and severity of seismic events changed over the last decade?
- Is there a correlation between earthquake depth and magnitude at Vesuvius?
- Do seismic events at Vesuvius follow any seasonal patterns or time-of-day patterns?
- Has the average location of seismic events migrated at all over the course of the data collection period?


Thank you to [Libby Heeren](https://github.com/LibbyHeeren) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-05-13')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 19)

vesuvius <- tuesdata$vesuvius

# Option 2: Read directly from GitHub

vesuvius <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-13/vesuvius.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-05-13')

# Option 2: Read directly from GitHub and assign to an object

vesuvius = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-13/vesuvius.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-05-13')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

vesuvius = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-13/vesuvius.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
vesuvius = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-13/vesuvius.csv", DataFrame)
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

### `vesuvius.csv`

|variable              |class         |description                           |
|:---------------------|:-------------|:-------------------------------------|
|event_id              |integer       |Unique identifier for each seismic event recorded. |
|time                  |datetime<UTC> |Date and time when the seismic event occurred, in UTC format. |
|latitude              |double        |Geographic latitude of the seismic event location in decimal degrees. |
|longitude             |double        |Geographic longitude of the seismic event location in decimal degrees. |
|depth_km              |double        |Depth of the seismic event epicenter in kilometers below the surface. |
|duration_magnitude_md |double        |Duration magnitude (Md) of the seismic event, a measure of its energy release. Md is often used for smaller magnitude events, and negative values can indicate very small events (microearthquakes). |
|md_error              |double        |Estimated error margin ("plus or minus") for the duration magnitude measurement. |
|area                  |character     |Geographic area where the seismic event was recorded. In this case, the Mt. Vesuvius area. |
|type                  |character     |Classification of the seismic event, such as "earthquake" or "eruption." |
|review_level          |character     |Level of review the data has undergone. The data might be raw (preliminary) or revised (reviewed by someone). |
|year                  |integer       |Calendar year when the seismic event occurred. |

## Cleaning Script

```r
# This script was used to clean data saved as 13 csv files 
# from the Italian Istituto Nazionale di Geofisica e Vulcanologia found
# here https://terremoti.ov.ingv.it/gossip/vesuvio/index.html

# Load packages
library(tidyverse)
library(janitor)

# List all vesuvius CSV files in the data_raw folder
file_list <- list.files(path = "data/data_raw", pattern = "^vesuvius_\\d{4}\\.csv$", full.names = TRUE)

# Read and row-bind all CSVs
vesuvius_data <- 
  file_list |> 
  map_dfr(read_csv)

# Clean column names and create year variable from time variable
vesuvius <- 
  vesuvius_data |> 
  clean_names() |> 
  mutate(
    year = year(time)
  )


# Add unit and context to column names
vesuvius <- 
  vesuvius |> 
  rename(duration_magnitude_md = md, 
         depth_km = depth,
         event_id = number_event_id,
         review_level = level)

# Translate some values from Italian to English
# Rivisto is revised (reviewed by humans)
# Bollettino is "bulletin" or the original preliminary source of the data,
# the Italian Seismic Bulletin (Il Bollettino Sismico Italiano)
vesuvius <-
  vesuvius |> 
  mutate(review_level = case_when(
    review_level == "Rivisto" ~ "revised",
    review_level == "Bollettino" ~ "preliminary",
    .default = NA_character_
  ))

# Let's change vesuvio to Mount Vesuvius! (Same value for all rows, but still)
vesuvius <-
  vesuvius |> 
  mutate(area = case_when(
    area == "vesuvio" ~ "Mount Vesuvius",
    .default = NA_character_
  ))

# Make year and event_id into integers, but everything else is a decimal/dbl
vesuvius <-
  vesuvius |> 
  mutate(
    dplyr::across(
      c("event_id", "year"),
      as.integer
    )
  )

```
