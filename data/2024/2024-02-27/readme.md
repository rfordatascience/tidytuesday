# Leap Day

Happy Leap Day! This week's data comes from the [February 29](https://en.wikipedia.org/wiki/February_29) article on Wikipedia.

> February 29 is a leap day (or "leap year day"), an intercalary date added periodically to create leap years in the Julian and Gregorian calendars.

One event that's missing from Wikipedia's list: [R version 1.0 was released on February 29, 2000](https://en.wikipedia.org/wiki/R_(programming_language)#History).

Which cohort of leap day births is most represented in Wikipedia's data? Are any years surprisingly underrepresented compared to nearby years? What other patterns can you find in the data?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-02-27')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 9)

events <- tuesdata$events
births <- tuesdata$births
deaths <- tuesdata$deaths

# Option 2: Read directly from GitHub

events <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/events.csv')
births <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/births.csv')
deaths <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-27/deaths.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `events.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|year     |integer   |Year of the event. |
|event    |character |A short, free-text description of the event. |

# `births.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|year_birth  |integer   |Year in which this person was born. |
|person      |character |The name of the person. |
|description |character |A short description of the person. |
|year_death  |integer   |Year in which this person died. |

# `deaths.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|year_death  |integer   |Year in which this person died. |
|person      |character |The name of the person. |
|description |character |A short description of the person. |
|year_birth  |integer   |Year in which this person was born. |

### Cleaning Script

``` r
library(tidyverse)
library(rlang)
library(rvest)
library(here)

working_dir <- here::here("data", "2024", "2024-02-27")

feb29 <- "https://en.wikipedia.org/wiki/February_29"

# Read the HTML once so we don't have to keep hitting it.
feb29_html <- rvest::read_html(feb29)

# Find the headers. We'll use these to figure out which bullets are "inside"
# each header, since nothing "contains" them to make it easy.
h2s <- feb29_html |> 
  rvest::html_elements("h2") |> 
  rvest::html_text2() |> 
  stringr::str_remove("\\[edit\\]")

# We'll get all bullets that are after each header. We can then subtract out
# later lists to figure out what's under a particular header.
bullets_after_headers <- purrr::map(
  h2s,
  \(this_header) {
    this_selector <- glue::glue("h2:contains('{this_header}') ~ ul > li")
    feb29_html |> 
      rvest::html_elements(this_selector) |> 
      rvest::html_text2() |> 
      # Remove footnotes.
      stringr::str_remove_all("\\[\\d+\\]")
  }
) |> 
  rlang::set_names(h2s)

# Subtract subsequent bullets from each set.
bullets_in_headers <- purrr::map2(
  bullets_after_headers[-length(h2s)],
  bullets_after_headers[-1],
  setdiff
)

# The three sets we care about (Events, Births, Deaths) each have their own
# format.
events <- tibble::tibble(events = bullets_in_headers[["Events"]]) |> 
  tidyr::separate_wider_regex(
    "events",
    patterns = c(
      year = "^\\d+",
      " – ",
      event = ".*"
    )
  )
births <- tibble::tibble(births = bullets_in_headers[["Births"]]) |> 
  tidyr::separate_wider_regex(
    "births",
    patterns = c(
      year_birth = "^\\d+",
      " – ",
      person = ".*"
    )
  ) |> 
  tidyr::separate_wider_regex(
    "person",
    patterns = c(
      person = "[^(]*",
      "\\(d\\. ",
      "(?:February 29, )*",
      year_death = "\\d+",
      "\\)\\.?"
    ),
    too_few = "align_start"
  ) |> 
  tidyr::separate_wider_regex(
    "person",
    patterns = c(
      person = "[^,]*",
      ", ",
      description = ".*"
    ),
    too_few = "align_start"
  )

deaths <- tibble::tibble(deaths = bullets_in_headers[["Deaths"]]) |> 
  tidyr::separate_wider_regex(
    "deaths",
    patterns = c(
      year_death = "^\\d+",
      " – ",
      person = ".*"
    )
  ) |> 
  tidyr::separate_wider_regex(
    "person",
    patterns = c(
      person = "[^(]*",
      "\\(b\\. ",
      "(?:February 29, )*",
      year_birth = "\\d+",
      "\\)\\.?"
    ),
    too_few = "align_start"
  ) |> 
  tidyr::separate_wider_regex(
    "person",
    patterns = c(
      person = "[^,]*",
      ", ",
      description = ".*"
    ),
    too_few = "align_start"
  )

readr::write_csv(
  events,
  fs::path(working_dir, "events.csv")
)
readr::write_csv(
  births,
  fs::path(working_dir, "births.csv")
)
readr::write_csv(
  deaths,
  fs::path(working_dir, "deaths.csv")
)
```
