# Historic UK Meteorological & Climate Data

This week we're exploring [historic meteorological
data](https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data)
from the [UK Met Office](https://www.metoffice.gov.uk/).

The UK Met Office is the United Kingdom’s national weather and climate service,
providing forecasts, severe weather warnings, and climate science expertise. It
helps people, businesses, and governments make informed decisions to stay safe
and plan for the future. It was first established in 1854, making it one of the
oldest weather services in the world.

Data has been scraped straight from the Met Office website and cleaned in a
basic way. The few flags for "estimated" data and changing sunlight monitoring
techniques have been removed for simplicity, but are available from the raw
data. Also available is simple site metadata which includes the opening date and
[latitude and longitude](https://epsg.io/4326) of each station.

> Monthly Historical information for 37 UK Meteorological Stations. Most go back
to the early 1900s, but some go back as far as 1853. Station data files are
updated on a rolling monthly basis, around 10 days after the end of the month.
No allowances have been made for small site changes and developments in
instrumentation.

You could consider:

- Which are the rainiest/sunniest/hottest regions of the UK? Has that changed over time?

- Were there any historic years that were particularly rainy/sunny/hot? Did that apply to all regions of the UK?

- Have monthly patterns in the meteorological variables changed year-on-year?

- Can you forecast future meteorology?

Thank you to [Jack Davison](https://github.com/jack-davison) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-10-21')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 42)

historic_station_met <- tuesdata$historic_station_met
station_meta <- tuesdata$station_meta

# Option 2: Read directly from GitHub

historic_station_met <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/historic_station_met.csv')
station_meta <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/station_meta.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-10-21')

# Option 2: Read directly from GitHub and assign to an object

historic_station_met = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/historic_station_met.csv')
station_meta = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/station_meta.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-10-21')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

historic_station_met = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/historic_station_met.csv")
station_meta = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/station_meta.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
historic_station_met = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/historic_station_met.csv", DataFrame)
station_meta = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-21/station_meta.csv", DataFrame)
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

### `historic_station_met.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|station  |character |Station ID; for binding with metadata.|
|year     |integer   |Year. |
|month    |integer   |Numeric month (1-12). |
|tmax     |double    |Mean daily maximum temperature (Degrees C). |
|tmin     |double    |Mean daily minimum temperature (Degrees C). |
|af       |double    |Days of air frost. |
|rain     |double    |Total rainfall (mm). |
|sun      |double    |Total sunshine duration (hours). |

### `station_meta.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|station      |character |Station ID; for binding with measurement data. |
|station_name |character |Station name. |
|opened       |integer   |Year in which station opened. |
|lng          |double    |Decimal longitude. |
|lat          |double    |Decimal latitude. |

## Cleaning Script

```r
library(tidyverse)
library(rvest)
library(janitor)

# list station data urls

links <-
  rvest::read_html(
    "https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data"
  ) |>
  rvest::html_elements("a") |>
  rvest::html_attr("href") |>
  (\(x) x[grepl("stationdata", x)])()

# function to read files from met office website
read_met_office_fwf <- function(file) {
  # read all lines of data
  x <- readr::read_lines(file)

  # get station name
  station <- basename(file) |> stringr::str_remove_all("data.txt")

  # focus on data
  x <- x[which(grepl("yyyy", x)):length(x)]

  # read data
  data <-
    readr::read_fwf(
      I(x),
      na = "---",
      show_col_types = FALSE,
      col_positions = readr::fwf_widths(c(7, 4, 8, 8, 8, 8, 8))
    ) |>
    janitor::row_to_names(1) |>
    # lets not use most recent data
    dplyr::filter(yyyy != "2025") |>
    # drop units row
    dplyr::slice_tail(n = -1) |>
    # add station
    dplyr::mutate(station = station, .before = 0) |>
    dplyr::rename(
      year = yyyy,
      month = mm
    )

  # return
  return(data)
}

# read all urls
raw_data <- purrr::map(links, read_met_office_fwf, .progress = TRUE)

# clean data
historic_station_met <-
  raw_data |>
  dplyr::bind_rows() |>
  dplyr::filter(month != "osed") |>
  dplyr::mutate(
    sun = stringr::str_remove_all(sun, "a|C| |\\*|\\#|---|\\||\\$"),
    sun = ifelse(sun == "", NA, sun),
    sun = as.numeric(sun)
  ) |>
  dplyr::mutate(
    dplyr::across(c(tmax:rain), \(x) gsub("\\*|\\#", "", x) |> as.numeric()),
    dplyr::across(c(year, month), as.integer)
  )

# get metadata
station_meta <-
  rvest::read_html(
    "https://www.metoffice.gov.uk/research/climate/maps-and-data/historic-station-data"
  ) |>
  rvest::html_table() |>
  purrr::pluck(1) |>
  tidyr::separate_wider_delim(
    Location,
    delim = ", ",
    names = c("lng", "lat")
  ) |>
  dplyr::mutate(
    dplyr::across(c(lng, lat), as.numeric),
    station = stringr::str_remove_all(
      links,
      "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/|data.txt"
    )
  ) |>
  dplyr::select(station, station_name = Name, opened = Opened, lng, lat)

```
