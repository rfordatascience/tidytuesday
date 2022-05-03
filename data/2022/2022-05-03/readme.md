### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# US Solar/Wind

The data this week comes from the [Berkeley Lab](https://emp.lbl.gov/utility-scale-solar). See the technical brief on the [emp.lbl.gov site](https://emp.lbl.gov/sites/default/files/utility-scale_solar_2021_technical_brief.pdf).

hatttip to [Data is Plural](https://www.data-is-plural.com/archive/2022-04-20-edition/)

> Berkeley Lab’s “Utility-Scale Solar, 2021 Edition” presents analysis of empirical plant-level data from the U.S. fleet of ground-mounted photovoltaic (PV), PV+battery, and concentrating solar-thermal power (CSP) plants with capacities exceeding 5 MWAC. While focused on key developments in 2020, this report explores trends in deployment, technology, capital and operating costs, capacity factors, the levelized cost of solar energy (LCOE), power purchase agreement (PPA) prices, and wholesale market value.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-05-03')
tuesdata <- tidytuesdayR::tt_load(2022, week = 18)

capacity <- tuesdata$capacity

# Or read in the data manually

capacity <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-03/capacity.csv')
wind <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-03/wind.csv')
solar <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-03/solar.csv')
average_cost <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-03/average_cost.csv')

```
### Data Dictionary

# `capacity.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|type             |character | Type of power (solar, nuclear, wind, etc) |
|year             |double    | Year |
|standalone_prior |double    | Standalone prior gigawatts |
|hybrid_prior     |double    | Hybrid prior gigagwatts |
|standalone_new   |double    | Standalone new gigawatts |
|hybrid_new       |double    | Hybrid new gigawatts |
|total_gw         |double    | Total gigawatts |

# `average_cost.csv`

Average cost for each type of power in dollars/MWh

|variable  |class  |description |
|:---------|:------|:-----------|
|year      |double | Year |
|gas_mwh   |double | Average Gas sourced dollars/MWh |
|solar_mwh |double | average Solar sourced dollars/MWh           |
|wind_mwh  |double | Average Wind sourced dollars MWh|

# `wind.csv`

|variable      |class  |description |
|:-------------|:------|:-----------|
|date          |double | ISO date|
|wind_mwh      |double | Wind projected price in $/MWh |
|wind_capacity |double | Wind projected capacity in Gigawatts |

# `solar.csv`

|variable      |class  |description |
|:-------------|:------|:-----------|
|date          |double | ISO date|
|solar_mwh      |double | solar projected price in $/MWh |
|solar_capacity |double | Solar projected capacity in Gigawatts |

### Cleaning Script

```{r}
library(tidyverse)
library(readxl)

util_df <- read_excel(
  "2022/2022-05-03/2021_utility-scale_solar_data_update_0.xlsm", sheet = "PV & Wind PPAs vs. Gas",
  skip = 26)

yr_avg <- util_df |> 
  select(1:4) |> 
  set_names(nm = c("year", "gas_mwh", "solar_mwh", "wind_mwh")) |> 
  filter(!is.na(year))

yr_avg |> 
  write_csv("2022/2022-05-03/average_cost.csv")

wind_df <- util_df |> 
  select(6:8) |> 
  set_names(nm = c("date", "wind_mwh", "wind_capacity")) |> 
  filter(!is.na(date)) |> 
  mutate(date = as.Date(date))

wind_df |> 
  write_csv("2022/2022-05-03/wind.csv")

solar_df <- util_df |> 
  select(10:12) |> 
  set_names(nm = c("date", "solar_mwh", "solar_capacity")) |> 
  filter(!is.na(date)) |> 
  mutate(date = as.Date(date))

solar_df |> 
  write_csv("2022/2022-05-03/solar.csv")

gen_df <- read_excel(
  "2022/2022-05-03/2021_utility-scale_solar_data_update_0.xlsm", sheet = "All Capacity in Queues",
  skip = 25)

gen_capacity <- gen_df |> 
  select(1, 3:8) |> 
  set_names(nm = c("type", "year", "standalone_prior", "hybrid_prior", "standalone_new", "hybrid_new", "total_gw")) |> 
  filter(!is.na(year)) |> 
  fill(type)

gen_capacity |> 
  write_csv("2022/2022-05-03/capacity.csv")
```