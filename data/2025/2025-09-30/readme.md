# Crane Observations at Lake Hornborgasjön, Sweden (1994–2024)

This week we are exploring [crane observations at Lake Hornborgasjön in Sweden](https://www.hornborga.com/naturen/transtatistik/).
For more than 30 years, cranes stopping at the Lake Hornborgasjön ('Lake Hornborga') in Västergötland, Sweden have been counted from the 
[Hornborgasjön field station](https://www.hornborga.com/naturen/tranor/) in the spring and the fall as they pass by during their yearly migration.  

> Thanks to crane counters from the Hornborgasjön field station, we know approximately how many cranes there are at Hornborgasjön during the spring. 
> When there are the most cranes depends on whether spring is early or late. It also depends on when the winds from the south are suitable for crane flight.

- Has the crane population at Lake Hornborgasjön grown over the past 30 years?
- If you wanted to see thousands of cranes, when is the best time of year to visit?
- Is it possible to predict the arrival of the cranes from weather patterns?

Thank you to [Carl Borstell](https://github.com/borstell) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-09-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 39)

cranes <- tuesdata$cranes

# Option 2: Read directly from GitHub

cranes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-30/cranes.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-09-30')

# Option 2: Read directly from GitHub and assign to an object

cranes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-30/cranes.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-09-30')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

cranes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-30/cranes.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
cranes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-30/cranes.csv", DataFrame)
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

### `cranes.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|date               |date      |Date of counting observations |
|observations       |double    |Number of observations |
|comment            |character |Comments added by counting officials (only kept if comment indicated one of "Bad weather", "Canceled/No count", "First count of season", "Last count of season", "Record observation", "Severe interference", or "Uncertain count"; NA otherwise)|
|weather_disruption |logical   |Whether original comments indicate a weather disruption by mentioning fog, rain, snow, thunder, or weather |

## Cleaning Script

```r
# Download the full CSV from the bottom of
# https://www.hornborga.com/naturen/transtatistik/ as "Transtatistik.csv".
#
# Cleaning code extracts comments in English, adds a variable related to weather
# disruption, selects relevant columns and filters the data to include only 30
# years (1994-2024).

# Read CSV (update path as needed)
csv_path <- "Transtatistik.csv"
cranes <- readr::read_csv(csv_path)

# Extract information from comments (relevant labels into English)
cranes <- cranes |>
  dplyr::mutate(
    comment = dplyr::case_when(
      stringr::str_detect(
        Anteckning,
        "[Ii]nga siffror|[Ii]ngen siffra|[Ii]ngen räkn|[Ii]nst[.ä]|[Ii]nat"
        # no numbers, no number, no count, cancelled, innumerable
      ) ~
        "Canceled/No count",
      stringr::str_detect(Anteckning, "[Ss]vårräkn|[Oo]säk") ~
        "Uncertain count",
      stringr::str_detect(Anteckning, "[Rr]ekord") ~ "Record observation",
      stringr::str_detect(Anteckning, "[Ff]örsta") ~ "First count of season",
      stringr::str_detect(Anteckning, "[Ss]ista|[Aa]vslut") ~
        "Last count of season",
      stringr::str_detect(Anteckning, "[Dd]åligt [Vv]äder") ~ "Bad weather",
      stringr::str_detect(Anteckning, "[Kk]raftig [Ss]törning") ~
        "Severe interference"
    )
  ) |>
  # Extract weather-related disruptions from comments into logical column
  dplyr::mutate(
    weather_disruption = dplyr::case_when(
      stringr::str_detect(
        Anteckning,
        "[Rr]egn|[Vv]äd|[Ss]nö|[Dd]imma|[Åå]ska"
        # rain, weather, snow, fog, thunder
      ) ~
        TRUE,
      .default = FALSE
    )
  ) |>
  # Rename to English lowercase
  dplyr::rename(date = Datum, observations = Antal) |>
  # Select relevant columns
  dplyr::select(date, observations, comment, weather_disruption) |>
  # Filter to dates before 2025 (to get 30-year anniversary data, 1994—2024)
  dplyr::filter(date < "2025-01-01")

```
