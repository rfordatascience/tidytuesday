# FIDE Chess Player Ratings

This week we're exploring August and September chess player rating data from FIDE (the International Chess Federation). Monthly data files are published on the [FIDE website](https://www.fide.com/fide-september-2025-rating-list-vincent-keymer-debuts-in-top-10-open/).

A chess rating (Elo) is an estimate of a player's strength relative to other players. If a player performs better or worse than expected, their rating increases or decreases accordingly.

> The September 2025 rating list was shaped primarily by results from 
> the Sinquefield Cup, Quantbox Chennai Grand Masters, 61st International Akiba Rubinstein Chess Festival, 
> and the Spanish League Honor Division 2025 – a Swiss team tournament held in Linares.

- Which players showed the greatest improvement from August to September?
- Which federations have the most number of titled players?
- How did the rankings of the top male or female players change?
- Who are the top youth players?

Thank you to [Jessica Moore](https://github.com/jessjep) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-09-23')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 38)

fide_ratings_august <- tuesdata$fide_ratings_august
fide_ratings_september <- tuesdata$fide_ratings_september

# Option 2: Read directly from GitHub

fide_ratings_august <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_august.csv')
fide_ratings_september <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_september.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-09-23')

# Option 2: Read directly from GitHub and assign to an object

fide_ratings_august = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_august.csv')
fide_ratings_september = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_september.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-09-23')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

fide_ratings_august = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_august.csv")
fide_ratings_september = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_september.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
fide_ratings_august = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_august.csv", DataFrame)
fide_ratings_september = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-23/fide_ratings_september.csv", DataFrame)
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

### `fide_ratings_august.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|id       |integer   |Identification number of a player within FIDE database. |
|name     |character |Player name. |
|fed      |character |Federation of player. Similar, but not identical to, IOC country codes. An unofficial list is available [here](https://www.mark-weeks.com/aboutcom/mw15b16.htm) |
|sex      |character |Sex of player (M - male, F - female) |
|title    |character |Title of a player (GM - Grand Master, WGM - Woman Grand Master, IM - International Master, WIM - Woman International Master, FM - FIDE Master, WFM - Woman FIDE Master, CM - Candidate Master, WCM - Woman Candidate Master) |
|wtitle   |character |Woman title of a player (WGM - Woman Grand Master, WIM - Woman International Master, WFM - Woman FIDE Master, WCM - Woman Candidate Master) |
|otitle   |character |Comma-separated list. Other titles of a player (IA - International Arbiter, FA - FIDE Arbiter, NA - National Arbiter, IO - International Organizer, FT - FIDE Trainer, FST - FIDE Senior Trainer, DI - Developmental Instructor, NI - National Instructor) |
|foa      |character |FIDE Online Arena title of a player (AGM - Arena Grand Master, AIM - Arena International Master, AFM - Arena FIDE Master, ACM - Arena Candidate Master) |
|rating   |integer   |Standard chess rating (Elo). |
|games    |integer   |Number of games played in the month. |
|k        |integer   |Rating K factor (Value influencing how much a player's rating changes after a game) |
|bday     |integer   |Year of birth of a player. |

### `fide_ratings_september.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|id       |integer   |Identification number of a player within FIDE database. |
|name     |character |Player name. |
|fed      |character |Federation of player. Similar, but not identical to, IOC country codes. An unofficial list is available [here](https://www.mark-weeks.com/aboutcom/mw15b16.htm) |
|sex      |character |Sex of player (M - male, F - female) |
|title    |character |Title of a player (GM - Grand Master, WGM - Woman Grand Master, IM - International Master, WIM - Woman International Master, FM - FIDE Master, WFM - Woman FIDE Master, CM - Candidate Master, WCM - Woman Candidate Master) |
|wtitle   |character |Woman title of a player (WGM - Woman Grand Master, WIM - Woman International Master, WFM - Woman FIDE Master, WCM - Woman Candidate Master) |
|otitle   |character |Comma-separated list. Other titles of a player (IA - International Arbiter, FA - FIDE Arbiter, NA - National Arbiter, IO - International Organizer, FT - FIDE Trainer, FST - FIDE Senior Trainer, DI - Developmental Instructor, NI - National Instructor) |
|foa      |character |FIDE Online Arena title of a player (AGM - Arena Grand Master, AIM - Arena International Master, AFM - Arena FIDE Master, ACM - Arena Candidate Master) |
|rating   |integer   |Standard chess rating (Elo). |
|games    |integer   |Number of games played in the month. |
|k        |integer   |Rating K factor (Value influencing how much a player's rating changes after a game) |
|bday     |integer   |Year of birth of a player. |

## Cleaning Script

```r
library(tidyverse)
library(withr)
conflicted::conflicts_prefer(dplyr::filter)

# download, unzip and read the file #
august_zipped <- withr::local_tempfile(fileext = ".zip")
september_zipped <- withr::local_tempfile(fileext = ".zip")

download.file(
  "https://ratings.fide.com/download/standard_aug25frl.zip",
  destfile = august_zipped,
  mode = "wb"
)
download.file(
  "https://ratings.fide.com/download/standard_sep25frl.zip",
  destfile = september_zipped,
  mode = "wb"
)

august_unzipped <- unzip(august_zipped, exdir = tempdir())
september_unzipped <- unzip(september_zipped, exdir = tempdir())

fide_ratings_august <- readr::read_fwf(
  file = august_unzipped,
  skip = 1,
  col_types = c("dcccccccdddcc"),
  fwf_widths(
    c(8, 68, 4, 4, 5, 5, 15, 4, 6, 4, 3, 6, 4),
    c(
      "id",
      "name",
      "fed",
      "sex",
      "title",
      "wtitle",
      "otitle",
      "foa",
      "rating",
      "games",
      "k",
      "bday",
      "flag"
    )
  )
) %>%
  # cleaning up player names
  mutate(name = str_remove(name, "^\\d+\\s+")) %>%
  # filter to only players who were active in the last 12 months
  filter(flag %in% c(NA, "w"), bday > 0) %>%
  select(-flag)

fide_ratings_september <- readr::read_fwf(
  file = september_unzipped,
  skip = 1,
  col_types = c("dcccccccdddcc"),
  fwf_widths(
    c(8, 68, 4, 4, 5, 5, 15, 4, 6, 4, 3, 6, 4),
    c(
      "id",
      "name",
      "fed",
      "sex",
      "title",
      "wtitle",
      "otitle",
      "foa",
      "rating",
      "games",
      "k",
      "bday",
      "flag"
    )
  )
) %>%
  # cleaning up player names
  mutate(name = str_remove(name, "^\\d+\\s+")) %>%
  # filter to only players who were active in the last 12 months
  filter(flag %in% c(NA, "w"), bday > 0) %>%
  select(-flag)

```
