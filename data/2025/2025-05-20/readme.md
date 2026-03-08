# Water Quality at Sydney Beaches

This week we're exploring the water quality of Sydney's iconic beaches. The data is 
available at the New South Wales State Government [Beachwatch 
website](https://www.beachwatch.nsw.gov.au/waterMonitoring/waterQualityData). 

> Beachwatch and our partners monitor water quality at swim sites to ensure 
> that recreational water environments are managed as safely as possible so that 
> as many people as possible can benefit from using the water.

[Sydney beaches were in the news](https://www.abc.net.au/news/2025-01-10/pollution-risks-in-sydney-beaches-contaminated-waterways-rain/104790856.) 
this summer with high rainfall causing concerns about the safety of the water.

The dataset this week includes both water quality and [historical weather data](https://open-meteo.com/) from 1991 until 2025. 

- Has the water quality declined over this period?
- How does rainfall impact E-coli bacteria levels? 
- Are some swimming sites particularly prone to high bacteria levels following rain?


Thank you to [Jen Richmond (R-Ladies Sydney)](https://github.com/jenrichmondPhD) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-05-20')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 20)

water_quality <- tuesdata$water_quality
weather <- tuesdata$weather

# Option 2: Read directly from GitHub

water_quality <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/water_quality.csv')
weather <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/weather.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-05-20')

# Option 2: Read directly from GitHub and assign to an object

water_quality = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/water_quality.csv')
weather = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/weather.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-05-20')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

water_quality = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/water_quality.csv")
weather = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/weather.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
water_quality = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/water_quality.csv", DataFrame)
weather = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-20/weather.csv", DataFrame)
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

### `water_quality.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|region                |character |Area of Sydney City |
|council               |character |City council responsible for water quality |
|swim_site             |character |Name of beach/swimming location |
|date                  |date      |Date |
|time                  |time      |Time of day |
|enterococci_cfu_100ml |integer   |Enterococci bacteria levels in colony forming units (CFU) per 100 millilitres of water |
|water_temperature_c   |integer   |Water temperature in degrees Celsius |
|conductivity_ms_cm    |integer   |Conductivity in microsiemens per centimetre |
|latitude              |double    |Latitude |
|longitude             |double    |Longitude |

### `weather.csv`

|variable         |class  |description                           |
|:----------------|:------|:-------------------------------------|
|date             |date   |Date |
|max_temp_C       |double |Maximum temperature in degrees Celsius |
|min_temp_C       |double |Minimum temperature in degrees Celsius |
|precipitation_mm |double |Rainfall in millimetres |
|latitude         |double |Latitude |
|longitude        |double |Longitude |

## Cleaning Script

```r
library(tidyverse)
library(here)
library(janitor)

# Historical weather data for Sydney provided by https://open-meteo.com/ API. 

weather <- readr::read_csv(here::here("data_raw", "open-meteo-33.85S151.20E51m.csv")) |>
  dplyr::select(date = latitude, 
         max_temp_C = longitude, 
         min_temp_C  = elevation, 
         precipitation_mm = utc_offset_seconds) |>
  dplyr::slice(-(1:2)) |>
  dplyr::mutate(date = ymd(date)) |>
  dplyr::mutate(latitude = -33.848858, 
         longitude = 151.19551) 
  
# Water quality data for Sydney beaches provided by https://www.beachwatch.nsw.gov.au/waterMonitoring/waterQualityData

water_quality <- readr::read_csv(here::here("data_raw", "Water quality-1746064496936.csv")) |>
  janitor::clean_names() |>
  rename(enterococci_cfu_100ml = enterococci_cfu_100m_l, conductivity_ms_cm = conductivity_m_s_cm) |>
  dplyr::mutate(date = dmy(date)) |>
  dplyr::mutate(
    dplyr::across(
      c("enterococci_cfu_100ml", "water_temperature_c", "conductivity_ms_cm"),
      as.integer
    )
  )

```
