# Coastal Ocean Temperature by Depth

This week we're exploring over 7 years of daily coastal ocean temperatures at 7 depths from a location in Nova Scotia, Canada. The data was collected through the Centre for Marine Applied Research's [Coastal Monitoring Program](https://cmar.ca/coastal-monitoring-program/). This and related data sets can be downloaded from the [Nova Scotia Open Data Portal](https://data.novascotia.ca/browse?tags=coastal+monitoring+program&sortBy=last_modified&pageSize=20).

> The Province of Nova Scotia recognizes the importance of coastal waters, which are critical to the prosperity and sustainability of rural and coastal communities. To bridge the gap between science and decision making, the Nova Scotia Department of Fisheries and Aquaculture (NSDFA) partners with the Centre for Marine Applied Research (CMAR) to measure the environmental conditions of Nova Scotia’s coastal waters.

Have fun exploring this ocean data set (and be wary of days with no data)! Here are a few questions to get you started:

-   How are temperatures changing over time? Is the change more pronounced at a different time of year or a specific depth?

-   How does temperature change with depth? Does the relationship change over time?

Thank you to [Danielle Dempsey and Rachel Woodside, Centre for Marine Applied Research](https://github.com/dempsey-CMAR) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-03-31')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 13)

ocean_temperature <- tuesdata$ocean_temperature
ocean_temperature_deployments <- tuesdata$ocean_temperature_deployments

# Option 2: Read directly from GitHub

ocean_temperature <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature.csv')
ocean_temperature_deployments <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature_deployments.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-03-31')

# Option 2: Read directly from GitHub and assign to an object

ocean_temperature = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature.csv')
ocean_temperature_deployments = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature_deployments.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-03-31")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

ocean_temperature = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature.csv")
ocean_temperature_deployments = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature_deployments.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
ocean_temperature = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature.csv", DataFrame)
ocean_temperature_deployments = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-31/ocean_temperature_deployments.csv", DataFrame)
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

### `ocean_temperature.csv`

|variable                   |class   |description                           |
|:--------------------------|:-------|:-------------------------------------|
|date                       |date    |Date the temperature observations were recorded. |
|sensor_depth_at_low_tide_m |integer |Estimated depth of the temperature sensor at low tide in metres.|
|mean_temperature_degree_c  |double  |Average of the temperature observations recorded at the corresponding date and depth. Units are degrees Celsius. |
|sd_temperature_degree_c    |double  |Standard deviation of the temperature observations recorded at the corresponding date and depth. Units are degrees Celsius. |
|n_obs                      |integer |The number of temperature observations recorded at the corresponding date and depth. |

### `ocean_temperature_deployments.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|deployment_id |character |Unique identifier for each deployment (a set of sensors recording at one location for a given time). |
|start_date    |date      |The day the sensors were deployed. |
|end_date      |date      |The day the sensors were retrieved. |
|latitude      |double    |Deployment latitude (decimal degrees). |
|longitude     |double    |Deployment longitude (decimal degrees). |

## Cleaning Script

```r
library(data.table)
library(dplyr)
library(here)
library(lubridate)
library(tidyr)

# downloaded manually to tt_submission/Lunenburg_County_Water_Quality_Data_20260312.csv from
# https://data.novascotia.ca/Nature-and-Environment/Lunenburg-County-Water-Quality-Data/eda5-aubu/explore/query/SELECT%0A%20%20%60waterbody%60%2C%0A%20%20%60station%60%2C%0A%20%20%60lease%60%2C%0A%20%20%60latitude%60%2C%0A%20%20%60longitude%60%2C%0A%20%20%60deployment_range%60%2C%0A%20%20%60string_configuration%60%2C%0A%20%20%60sensor_type%60%2C%0A%20%20%60sensor_serial_number%60%2C%0A%20%20%60timestamp_utc%60%2C%0A%20%20%60sensor_depth_at_low_tide_m%60%2C%0A%20%20%60depth_crosscheck_flag%60%2C%0A%20%20%60dissolved_oxygen_percent_saturation%60%2C%0A%20%20%60dissolved_oxygen_uncorrected_mg_per_l%60%2C%0A%20%20%60salinity_psu%60%2C%0A%20%20%60sensor_depth_measured_m%60%2C%0A%20%20%60temperature_degree_c%60%2C%0A%20%20%60qc_flag_dissolved_oxygen_percent_saturation%60%2C%0A%20%20%60qc_flag_dissolved_oxygen_uncorrected_mg_per_l%60%2C%0A%20%20%60qc_flag_salinity_psu%60%2C%0A%20%20%60qc_flag_sensor_depth_measured_m%60%2C%0A%20%20%60qc_flag_temperature_degree_c%60%0AWHERE%20caseless_one_of%28%60station%60%2C%20%22Birchy%20Head%22%29/page/filter
# this is a large file: 385 MB
# it is ~2x faster to import using data.table::fread compared to readr::read_csv
dat_all <- data.table::fread(
  here("tt_submission/Lunenburg_County_Water_Quality_Data_20260312.csv"),
  data.table = FALSE,
  na.strings = c("NA", "")
)

# note on qc_flag_* columns -----------------------------------------------

# The qc_flag_** columns are quality control flags for each variable.
# Possible values are:
## Pass: observation passed all QC tests.
## Not Evaluated: observation could not be evaluated by at least one test.
## Suspect/Of Interest: observation is either poor quality or part of an unusual 
### event. In this dataset, most Suspect/Of Interest temperature measurements 
### are considered "Of Interest" and may be included in analyses.
## Fail: observation failed at least one QC test and should not be included in
### most analyses.

# temperature dataset -----------------------------------------------------

# filter to exclude observations that failed QC tests
# calculate daily average temperature to reduce size of the csv file to 537 kb
ocean_temperature <- dat_all %>% 
  dplyr::filter(
    station == "Birchy Head",
    !(is.na(temperature_degree_c) & qc_flag_temperature_degree_c == ""),
    qc_flag_temperature_degree_c != "Fail"
  ) %>% 
  dplyr::mutate(date = lubridate::as_date(timestamp_utc)) %>% 
  group_by(date, sensor_depth_at_low_tide_m) %>% 
  summarise(
    mean_temperature_degree_c = mean(temperature_degree_c),
    sd_temperature_degree_c = sd(temperature_degree_c),
    n_obs = n()
  ) %>% 
  ungroup()

# deployment details dataset ---------------------------------------------

# extract the dates that sensors were removed and replaced and the 
# deployment coordinates
# assign an id to each deployment 
ocean_temperature_deployments <- dat_all %>% 
  dplyr::distinct(deployment_range, latitude, longitude) %>% 
  tidyr::separate(
    deployment_range, into = c("start_date", "end_date"), sep = " to "
  ) %>% 
  dplyr::mutate(
    start_date = lubridate::as_date(start_date),
    end_date = lubridate::as_date(end_date)
  ) %>% 
  dplyr::arrange(start_date) %>% 
  dplyr::mutate(
    deployment_id = paste0("depl_", sprintf("%02d", row_number()))
  ) %>% 
  dplyr::select(deployment_id, dplyr::everything())

```
