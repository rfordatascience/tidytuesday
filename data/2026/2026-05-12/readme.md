# Twinned Cities

This week we're exploring data about links between cities! Twinned towns (also known as sister cities) are a form of legal or social agreement between two geographically and politically distinct localities for the purpose of promoting cultural and commercial ties. This dataset looks at links specifically between cities, i.e. it does not include towns, villages or other geographic entities..
 
Wikipedia states:

> While there are early examples of international links between municipalities akin to what are now known as sister cities dating back to the 9th century, the modern concept was first established and adopted worldwide during World War II.

* Is every country connected through a chain of twin city links?
* Which city is the most connected?
* Which countries are the most connected to each other?

Thank you to @bothness for [curating the original dataset](https://bothness.github.io/twin-cities/) and [suggesting it on Bluesky](https://bsky.app/profile/bothness.bsky.social/post/3mkmroqdulk24)!

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-05-12')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 19)

cities <- tuesdata$cities
links <- tuesdata$links

# Option 2: Read directly from GitHub

cities <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/cities.csv')
links <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/links.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-05-12')

# Option 2: Read directly from GitHub and assign to an object

cities = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/cities.csv')
links = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/links.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-05-12")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

cities = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/cities.csv")
links = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/links.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
cities = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/cities.csv", DataFrame)
links = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-12/links.csv", DataFrame)
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

### `cities.csv`

|variable  |class     |description                           |
|:---------|:---------|:-------------------------------------|
|id        |character |City ID from Wikidata entity ID. Join with `links` data. |
|name      |character |City name. |
|lng       |double    |Longitude. |
|lat       |double    |Latitude. |
|country   |character |Country name. |
|countrycd |character |Two letter country code. Note that Taiwan has a code in the form XX-XX, and some entries as `NA` indicating a missing country code. |
|continent |character |Continent name. |

### `links.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|source   |character |ID of source city (from Wikidata entity ID), denoting link between source and target. The order of source and target does not matter. |
|target   |character |ID of target city (from Wikidata entity ID). |

## Cleaning Script

```r
# Clean data provided by https://github.com/bothness/twin-cities. No cleaning was necessary.
cities <- readr::read_tsv("https://raw.githubusercontent.com/bothness/twin-cities/refs/heads/main/public/data/nodes.tsv")
links <- readr::read_tsv("https://raw.githubusercontent.com/bothness/twin-cities/refs/heads/main/public/data/links.tsv")

```
