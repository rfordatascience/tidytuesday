# Extreme Weather Attribution Studies

This week we're exploring extreme weather attribution studies. The dataset comes
from [Carbon Brief](https://carbonbrief.org)'s article [Mapped: How climate change affects extreme weather around the world](https://interactive.carbonbrief.org/attribution-studies/index.html). An in-depth exploration of the evolution of extreme weather attribution science can be found in this [Q & A article](https://carbonbrief.org/qa-the-evolving-science-of-extreme-weather-attribution/).

The data was last updated in November 2024 and single studies that cover multiple events or locations are separated out into individual entries when possible.

> Attribution studies calculate whether, and by how much, climate change affected the intensity, frequency or impact of extremes - from wildfires in the US and drought in South Africa through to record-breaking rainfall in Pakistan and typhoons in Taiwan.

Some questions you might explore:

- How do attribution study publications evolve over time? What about rapid attribution studies?
- What type of extreme event is more frequently the subject of an attribution study?
- In which regions are most studies focused?
- Is there a trend in how climate change influences different types of extreme weather?

Thank you to [Rajo](https://github.com/rajodm) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-08-12')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 32)

attribution_studies <- tuesdata$attribution_studies
attribution_studies_raw <- tuesdata$attribution_studies_raw

# Option 2: Read directly from GitHub

attribution_studies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies.csv')
attribution_studies_raw <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies_raw.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-08-12')

# Option 2: Read directly from GitHub and assign to an object

attribution_studies = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies.csv')
attribution_studies_raw = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies_raw.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-08-12')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

attribution_studies = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies.csv")
attribution_studies_raw = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies_raw.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
attribution_studies = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies.csv", DataFrame)
attribution_studies_raw = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-12/attribution_studies_raw.csv", DataFrame)
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

### `attribution_studies.csv`

|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|event_name        |character |The name or description of the extreme weather event studied. |
|event_period      |character |The specific time period when the event occurred (extracted from the raw event name). |
|event_year        |character |The year(s) or year range when the event occurred. |
|study_focus       |character |Whether the study focused on a specific event or long-term trends. |
|iso_country_code  |character |Three-character ISO country code(s), with multiple countries separated by commas for multi-country studies (e.g.: "KEN, SOM"). |
|cb_region         |character |The geographic region classification used by Carbon Brief (Based on UN classification). |
|event_type        |character |The type of extreme weather event or trend discussed in the study. |
|classification    |character |How climate change has affected the studied event: "More severe or more likely to occur", "No discernible human influence", "Insufficient data/inconclusive", "Decrease, less severe or less likely to occur". |
|summary_statement |character |The authors' key findings. |
|publication_year  |double    |The year when the study was published. |
|citation          |character |The full citation for the study. |
|source            |character |The source where the study was published. |
|rapid_study       |character |Whether this was a rapid attribution study or not: analysis completed within days of the event occurring ("yes" or "no"). |
|link              |character |The URL link to the original article. |

### `attribution_studies_raw.csv`

|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|name              |character |The name or description of the extreme weather event studied and period when it occurred if available. |
|event_year_trend  |character |Time period when the event occurred (e.g., "2014", "2004-05", "mid-1990s") or indication if the study focuses on long-term trends. |
|iso_country_code  |character |Three-character ISO country code(s), with multiple countries separated by commas for multi-country studies (e.g.: "KEN, SOM"). |
|cb_region         |character |The geographic region classification used by Carbon Brief (Based on UN classification). |
|event_type        |character |The type of extreme weather event or trend discussed in the study. |
|classification    |character |How climate change has affected the studied event: "More severe or more likely to occur", "No discernible human influence", "Insufficient data/inconclusive", "Decrease, less severe or less likely to occur". |
|summary_statement |character |The authors' key findings. |
|publication_year  |double    |The year when the study was published. |
|citation          |character |The full citation for the study. |
|source            |character |The source where the study was published. |
|rapid_study       |character |Whether this was a rapid attribution study or not: analysis completed within days of the event occurring ("yes" or "no"). |
|link              |character |The URL link to the original article. |

## Cleaning Script

```r
# Data provided by Carbon Brief
# Data available at https://interactive.carbonbrief.org/attribution-studies/data/papers-download.csv

library(tidyverse)
library(here)
library(janitor)

# Import Carbon Brief's Climate attribution studies dataset
attribution_studies_raw <- readr::read_csv(
  "https://interactive.carbonbrief.org/attribution-studies/data/papers-download.csv"
) |>
  janitor::clean_names()


# Helper functions -------------------------------------------------------

# Function to standardize year spans to consistent yyyy-yyyy format
clean_yearspan <- function(match) {
  # Split the span using "-" as a delimiter
  parts <- stringr::str_split(match, "-")[[1]]
  start_year <- as.numeric(parts[1])
  # Extract century from start year (e.g. 20 from 2020)
  century <- start_year %/% 100
  # Combine the years
  glue::glue("{parts[1]}-{century}{parts[2]}")
}

# Function to clean and standardize data strings
clean_date_string <- function(col) {
  col |>
    stringr::str_replace_all("–", "-") |>
    # Find yyyy-yy patters and convert to yyyy-yyyy
    stringr::str_replace_all("(\\d{4})-(\\d{2}$)", \(match) {
      clean_yearspan(match)
    }) |>
    stringr::str_replace_all(" & ", ", ")
}

# Data Cleaning ----------------------------------------------------------

attribution_studies <- attribution_studies_raw |>
  janitor::clean_names() |>
  # Separate event names from time periods
  # and split them into separate 'event_name' and 'event_period' columns
  tidyr::separate_wider_regex(
    name,
    patterns = c(
      event_name = ".*",
      ", ",
      event_period = ".*",
      "\\s\\(.*"
    ),
    too_few = "align_start"
  ) |>
  # Create standardized variables
  dplyr::mutate(
    event_year_trend = clean_date_string(event_year_trend),
    event_period = dplyr::case_when(
      is.na(event_period) & event_year_trend != "Trend" ~
        dplyr::coalesce(event_period, event_year_trend),
      TRUE ~ event_period
    ) |>
      clean_date_string(),
    event_year = dplyr::case_when(
      event_year_trend != "Trend" ~ event_year_trend,
      TRUE ~ NA_character_
    ),
    study_focus = dplyr::case_when(
      event_year_trend == "Trend" ~ "Trend",
      TRUE ~ "Event",
    ),
    .before = iso_country_code
  ) |>
  dplyr::select(!event_year_trend)

```
