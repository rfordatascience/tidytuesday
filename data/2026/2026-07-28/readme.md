# Ecotourism

This week we're exploring ecotourism! The [{ecotourism}](https://vahdatjavad.github.io/ecotourism) R package provides tools to analyse ecological observation data alongside weather conditions and tourism data.

> The goal of `ecotourism` is to provide clean, ready-to-use datasets for example analyses in teaching, demos, and reproducible workflows.

* Under which weather conditions are you most likely to observe a Gouldian finch?
* How does weather affect tourism numbers in each region?
* How do observations of the different animals relate to numbers of tourists?

The [{ecotourism}](https://vahdatjavad.github.io/ecotourism) package provides additional datasets and ideas for analsyis. Remember to cite the package with `citation("ecotourism")`!

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-07-28')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 30)

occurrences <- tuesdata$occurrences
tourism <- tuesdata$tourism
weather <- tuesdata$weather

# Option 2: Read directly from GitHub

occurrences <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/occurrences.csv')
tourism <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/tourism.csv')
weather <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/weather.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-07-28')

# Option 2: Read directly from GitHub and assign to an object

occurrences = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/occurrences.csv')
tourism = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/tourism.csv')
weather = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/weather.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-07-28")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

occurrences = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/occurrences.csv")
tourism = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/tourism.csv")
weather = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/weather.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
occurrences = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/occurrences.csv", DataFrame)
tourism = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/tourism.csv", DataFrame)
weather = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-28/weather.csv", DataFrame)
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

### `occurrences.csv`

|variable      |class          |description                           |
|:-------------|:--------------|:-------------------------------------|
|obs_lat       |double         |Latitude of the observation (decimal degrees). |
|obs_lon       |double         |Longitude of the observation (decimal degrees). |
|date          |date           |Observation date (YYYY-MM-DD). |
|time          |character      |Observation time (HH:MM:SS, character). |
|year          |integer        |Observation year. |
|month         |integer        |Month of the observation. |
|day           |integer        |Day of the month. |
|hour          |integer        |Hour of the day (0–23). |
|weekday       |character      |Day of the week. |
|dayofyear     |integer        |Day of the year (1–366). |
|sci_name      |character      |Scientific name of the observed species. |
|organism_name |character      |Name of the type of animal or plant (e.g. "Orchid"). |
|record_type   |character      |Type of observation (e.g., HUMAN_OBSERVATION). |
|obs_state     |character      |Australian state where the observation occurred. |
|ws_id         |character      |ID of the nearest weather station (e.g., "949610-99999"). |

### `tourism.csv`

|variable  |class     |description                           |
|:---------|:---------|:-------------------------------------|
|year      |integer   |The year of the tourism data. |
|quarter   |integer   |Quarter number (e.g., 1, 2, 3, 4). |
|purpose   |character |Purpose of visit category (e.g. "Business"). |
|trips     |double    |Number of overnight trips (in thousands). |
|region_id |integer   |Unique integer identifier for the region. |
|ws_id     |character |Identifier of the nearest Bureau of Meteorology weather station to the tourism region. |
|region    |character |Name of the tourism region defined by Tourism Research Australia. |
|lon       |double    |Longitude of the tourism region representative point (WGS84). |
|lat       |double    |Latitude of the tourism region representative point (WGS84). |

### `weather.csv`

|variable   |class          |description                           |
|:----------|:--------------|:-------------------------------------|
|ws_id      |character      |Weather station ID (e.g., "948720-99999"). |
|stn_lat    |double         |Latitude of the weather station. |
|stn_lon    |double         |Longitude of the weather station. |
|date       |date           |Observation date (YYYY-MM-DD). |
|year       |integer        |Year of observation. |
|month      |integer        |Month of observation (1–12). |
|day        |integer        |Day of the month. |
|weekday    |character      |Day of the week. |
|dayofyear  |integer        |Day of the year (1–366). |
|temp       |double         |Average temperature (°C). |
|min        |double         |Minimum temperature (°C). |
|max        |double         |Maximum temperature (°C). |
|dewp       |double         |Dew point temperature (°C). |
|rh         |double         |Relative humidity (%). |
|prcp       |double         |Precipitation (mm). |
|rainy      |integer        |Binary flag indicating whether PRCP > 5 mm (1 = rainy day). |
|wind_speed |double         |Average wind speed (m/s). |
|max_speed  |double         |Maximum sustained wind speed (m/s). |

## Cleaning Script

```r
library(dplyr)

manta_rays <- ecotourism::manta_rays |>
  mutate(organism_name = "Manta ray", .after = "sci_name")
gouldian_finch <- ecotourism::gouldian_finch |>
  mutate(organism_name = "Gouldian finch", .after = "sci_name")
orchids <- ecotourism::orchids |>
  mutate(organism_name = "Orchid", .after = "sci_name")
glowworms <- ecotourism::glowworms |>
  mutate(organism_name = "Glowworm", .after = "sci_name")
occurrences <- bind_rows(
  manta_rays, gouldian_finch, orchids, glowworms
)

weather <- ecotourism::weather

tourism <- ecotourism::tourism_quarterly |>
  left_join(tourism_region, by = "region_id") |>
  rename(ws_id = ws_id.x) |>
  select(-ws_id.y)

```
