# Agricultural Production Statistics in New Zealand

This week we are exploring [agriculture production statistics in New Zealand](https://figure.nz/table/TSQ8lkuKnyzfERF3) using data compiled from [StatsNZ](https://datainfoplus.stats.govt.nz/item/nz.govt.stats/eb7208cf-2f0f-416a-bd77-2fdbb9043255?_ga=2.264735308.2106648024.1715287902-1399521469.1678132138). 

Sheep have long outnumbered people in New Zealand, but the [ratio of sheep to people peaked in the 1980s and has been in steady decline](https://www.rnz.co.nz/news/country/560252/gap-between-people-and-sheep-rapidly-closing)

> The gap between people and sheep in New Zealand is rapidly closing. There's now about 4.5 sheep to every person in New Zealand compared to a peak of 22 sheep per person in the 1980s, that's according to figures released by Stats NZ this week.

- Is sheep production unique in its decline? Do other types of meat production show the same pattern?
- Which agricultural industries have shown the most production growth?

Thank you to [Jen Richmond](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-02-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 7)

dataset <- tuesdata$dataset

# Option 2: Read directly from GitHub

dataset <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-17/dataset.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-02-17')

# Option 2: Read directly from GitHub and assign to an object

dataset = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-17/dataset.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-02-17")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

dataset = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-17/dataset.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
dataset = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-17/dataset.csv", DataFrame)
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

### `dataset.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|year_ended_june |integer    |Year |
|measure         |character |Agricultural production category |
|value           |integer    |Number of units produced |
|value_label     |character |Unit of production |

## Cleaning Script

```r
# Data read from https://figure.nz/table/TSQ8lkuKnyzfERF3/download
# Cleaning to fix column names and remove empty variables

library(tidyverse)
library(janitor)

dataset <- readr::read_csv("https://figure.nz/table/TSQ8lkuKnyzfERF3/download") %>%
  janitor::clean_names() %>%
  dplyr::select(-value_unit, -null_reason, -metadata_1)

```
