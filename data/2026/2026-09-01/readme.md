# World Castles, Fortresses and Palaces

This week we're exploring the [Castlemap](https://thecastlemap.com/data/) dataset of 5,793 castles, fortresses, palaces and ruins in 138 countries. The data comes from Wikidata, and every landmark has verified coordinates, a Wikipedia article and a photo on Wikimedia Commons. Each also has a fame rank, based on how many languages have an article on it and how often that article is read. The Great Wall of China is first.

- Which countries have the most castles?
- Are palaces newer than fortresses?
- Which landmarks have articles in many languages but few readers?

Thank you to [Georgios Karamanis](https://github.com/gkaramanis) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-09-01')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 35)

world_castles <- tuesdata$world_castles

# Option 2: Read directly from GitHub

world_castles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-01/world_castles.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-09-01')

# Option 2: Read directly from GitHub and assign to an object

world_castles = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-01/world_castles.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-09-01")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

world_castles = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-01/world_castles.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
world_castles = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-01/world_castles.csv", DataFrame)
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

### `world_castles.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|qid         |character |Wikidata item ID, e.g. `Q1067425`. |
|name        |character |Landmark name, in English where available, e.g. `Neuschwanstein Castle`. |
|category    |character |Type of landmark: `castle`, `fortress`, `palace` or `ruin`. |
|country     |character |Country the landmark is in, e.g. `France`. The UK constituent countries are listed separately, e.g. `Scotland`. |
|iso         |character |ISO 3166-1 alpha-2 country code, e.g. `FR`. The UK constituent countries use ISO 3166-2 subdivision codes, e.g. `GB-SCT`. |
|lat         |double    |Latitude in WGS84 decimal degrees, e.g. `48.80472`. |
|lon         |double    |Longitude in WGS84 decimal degrees, e.g. `2.12028`. |
|year        |double    |Founding year, e.g. `1661`. Negative for BC dates, e.g. `-3000`. |
|year_approx |double    |Whether the founding year is an estimate, `1`, or a documented date, `0`. |
|century     |character |Century the founding year falls in, e.g. `17th century` or `30th century BC`. |
|wikipedia   |character |URL of the Wikipedia article, e.g. `https://en.wikipedia.org/wiki/Palace_of_Versailles`. |
|image       |character |URL of a Wikimedia Commons photo, e.g. `https://commons.wikimedia.org/wiki/Special:FilePath/Alhambra%20detail.jpg?width=1280`. |
|sitelinks   |double    |Number of Wikipedia language editions with an article on the landmark, e.g. `95`. |
|pageviews   |double    |Wikipedia pageviews over the trailing 365 days, e.g. `756430`. |
|fame_rank   |double    |Global fame rank, blending `sitelinks` and `pageviews`, where `1` is the most famous. |

## Cleaning Script

```r
# Data from <https://thecastlemap.com/castles.csv>, accessed 31 July 2026. No
# cleaning was necessary.
world_castles <- readr::read_csv("https://thecastlemap.com/castles.csv")

```
