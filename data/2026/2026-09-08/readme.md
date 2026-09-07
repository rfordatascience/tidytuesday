# The Cappuccino Index

James Hoffmann is a YouTuber who explores coffee from many different angles. In a recent [video](https://www.youtube.com/watch?v=WtlE3BW9Nqs) he explored how long a barista would need to work to pay for a small cappuccino. 

> Coffee, as a part of our economy, as an industry, is full of these awkward questions that I do think are worth asking.

In the video, James presents the cappuccino index, which answers this at a country level. There are many interesting findings. You may want to watch the whole video as context and entertainment. There are some important caveats, such as tips being excluded.

You might think about:

- Some sample sizes are small. How uncertain is the ranking?
- Which countries have the biggest variability in the price of a small cappuccino?
- Are there any outliers?

Thank you to [Filip Reierson](https://github.com/freierson) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-09-08')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 36)

cafe <- tuesdata$cafe
cappuccino_index <- tuesdata$cappuccino_index

# Option 2: Read directly from GitHub

cafe <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cafe.csv')
cappuccino_index <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cappuccino_index.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-09-08')

# Option 2: Read directly from GitHub and assign to an object

cafe = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cafe.csv')
cappuccino_index = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cappuccino_index.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-09-08")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

cafe = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cafe.csv")
cappuccino_index = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cappuccino_index.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
cafe = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cafe.csv", DataFrame)
cappuccino_index = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-08/cappuccino_index.csv", DataFrame)
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

### `cafe.csv`

|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|country           |character |The country of the cafe. |
|city              |character |The city of the cafe. |
|urban             |logical   |Whether the cafe is in an urban area. |
|suburban          |logical   |Whether the cafe is in a suburban area. |
|rural             |logical   |Whether the cafe is in a rural area. |
|hourly_wage_gbp   |double    |The hourly wage of a barista working in the cafe, converted to British pounds. |
|price_gbp         |double    |The price of a small cappuccino from the cafe, converted to British pounds. |
|original_currency |character |The original currency used by the cafe. |
|price             |double    |The price of a small cappuccino from the cafe, in the original currency. |
|hourly_wage       |double    |The hourly wage of a barista working in the cafe, in the original currency. |

### `cappuccino_index.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|country       |character |Name of country for which cappuccino index was calculated. |
|index         |double    |The cappuccino index: the time in minutes a barista needs to work to afford a small cappuccino in their country. |
|n             |integer   |Number of cafes that were included in the calculation of the index. |
|minutes       |double    |The number of whole minutes in index. |
|seconds       |double    |The remaining number of seconds in index. |
|index_as_time |character |Index formatted as minutes and seconds, i.e., MM:SS. |

## Cleaning Script

```r
# Shared by James Hoffmann in a YouTube video titled 'The Surprising Things We Discovered In The Cost Of A Cappuccino' shared on 6 August 2026
# James Hoffmann encouraged us to explore the figures ourselves and shared the full dataset in a public google sheet
# Below is the cleaning process preparing the data for TidyTuesday

library(tidyverse)
library(janitor)

cafe <- readr::read_csv(
  "https://docs.google.com/spreadsheets/d/1l3nitpsActIEqjaHk0wQNno8FDStYLsG_amSvAbuI3w/export?format=csv",
  show_col_types = FALSE
) |>
  janitor::clean_names() |>
  dplyr::mutate(
    urban = stringr::str_detect(urban_classification, "Urban"),
    suburban = stringr::str_detect(urban_classification, "Suburban"),
    rural = stringr::str_detect(urban_classification, "Rural")
  ) |>
  dplyr::select(
    country,
    city,
    urban,
    suburban,
    rural,
    hourly_wage_gbp = hourly_wage_in_gbp,
    price_gbp = price_per_cappuccino_in_gbp,
    original_currency = currency,
    price = price_per_small_cappuccino,
    hourly_wage = hourly_wage
  )

cappuccino_index <- cafe |>
  summarise(index = sum(price_gbp)/sum(hourly_wage_gbp)*60, n=n(), .by=country) |>
  arrange(index) |>
  mutate(minutes = floor(index), seconds = floor((index - floor(index))*60)) |>
  mutate(index_as_time = paste0(minutes,":",stringr::str_pad(seconds, width = 2, pad = "0"))) |>
  readr::write_csv("cappuccino_index.csv")

```
