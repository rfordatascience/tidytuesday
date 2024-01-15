# US Polling Places 2012-2020

This week we're honoring the legacy of Martin Luther King Jr. by exploring the US Polling Places.

The [dataset](https://github.com/PublicI/us-polling-places) comes from [The Center for Public Integrity](https://publicintegrity.org/).
You can read more about the data and how it was collected in their September 2020 article ["National data release sheds light on past polling place changes"](https://publicintegrity.org/politics/elections/ballotboxbarriers/data-release-sheds-light-on-past-polling-place-changes/).
Thank you [Kelsey E Gonzalez](https://github.com/kelseygonzalez) for the dataset suggestion back in 2020!

Note: Some states do not have data in this dataset. Several states (Colorado, Hawaii, Oregon, Washington and Utah) vote primarily by mail and have little or no data in this colletion, and others were not available for other reasons.

For states with data for multiple elections, how have polling location counts per county changed over time?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-01-16')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 3)

polling_places <- tuesdata$polling_places

# Option 2: Read directly from GitHub

polling_places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-16/polling_places.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `polling_places.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|election_date     |date      |date of the election as YYYY-MM-DD |
|state             |character |2-letter abbreviation of the state |
|county_name       |character |county name, if available |
|jurisdiction      |character |jurisdiction, if available |
|jurisdiction_type |character |type of jurisdiction, if available; one of "county", "borough", "town", "municipality", "city", "parish", or "county_municipality" |
|precinct_id       |character |unique ID of the precinct, if available |
|precinct_name     |character |name of the precinct, if available |
|polling_place_id  |character |unique ID of the polling place, if available |
|location_type     |character |type of polling location, if available; one of "early_vote", "early_vote_site", "election_day", "polling_location", "polling_place", or "vote_center" |
|name              |character |name of the polling place, if available |
|address           |character |address of the polling place, if available |
|notes             |character |optional notes about the polling place |
|source            |character |source of the polling place data; one of "ORR", "VIP", "website", or "scraper" |
|source_date       |date      |date that the source was compiled |
|source_notes      |character |optional notes about the source |

### Cleaning Script

``` r
library(tidyverse)
library(here)
library(fs)
library(gh)

working_dir <- here::here("data", "2024", "2024-01-16")

polling_places <- 
  # Get the list of states that have data.
  gh::gh("/repos/PublicI/us-polling-places/contents/data") |> 
  purrr::map_chr("name") |> 
  # For each state, get the list of CSV URLs.
  purrr::map(
    \(state) {
      gh::gh(
        glue::glue("/repos/PublicI/us-polling-places/contents/data/{state}/output")
      ) |> 
        purrr::map_chr("download_url")
    }
  ) |> 
  unlist() |> 
  readr::read_csv(
    col_types = readr::cols(.default = readr::col_character())
  ) |> 
  # Some rows are duplicated.
  dplyr::distinct() |> 
  dplyr::mutate(
    election_date = lubridate::ymd(election_date),
    source_date = lubridate::ymd(source_date)
  )

readr::write_csv(
  polling_places,
  fs::path(working_dir, "polling_places.csv")
)
```
