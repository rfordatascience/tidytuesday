# James Beard Awards

This week we're exploring the [James Beard Awards](https://www.jamesbeard.org/awards)! [Wikipedia tells us](https://en.wikipedia.org/wiki/James_Beard_Foundation_Award):

> The James Beard Foundation Awards are annual awards presented by the James Beard Foundation to recognize chefs, restaurateurs, authors and journalists in the United States.

Thank you to [PythonCoderUnicorn](https://github.com/PythonCoderUnicorn) for the dataset suggestion!

- How have the subcategories of the various awards changed over time?
- Has anybody won in multiple categories?
- Which restaurants have the most winners? Which newspapers or networks?

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-12-31')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 53)

book <- tuesdata$book
broadcast_media <- tuesdata$broadcast_media
journalism <- tuesdata$journalism
leadership <- tuesdata$leadership
restaurant_and_chef <- tuesdata$restaurant_and_chef

# Option 2: Read directly from GitHub

book <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/book.csv')
broadcast_media <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/broadcast_media.csv')
journalism <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/journalism.csv')
leadership <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/leadership.csv')
restaurant_and_chef <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-31/restaurant_and_chef.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `book.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|subcategory |character |The type of book. These subcategories have changed over time, and many appear to overlap. |
|rank        |character |Whether the person is a "Winner" or "Nominee". |
|year        |character |The year of the award. |
|name        |character |The name of the award winner or nominee. |
|title       |character |The title of the book. |
|publisher   |character |The publisher of the book, if supplied. Some publishers are listed multiple times with slightly different names. |

# `broadcast_media.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|subcategory |character |The type of media. These subcategories have changed over time, and many appear to overlap. |
|rank        |character |Whether the person is a "Winner" or "Nominee". |
|year        |character |The year of the award. |
|name        |character |The name of the award winner or nominee. |
|show        |character |The name of the show, if applicable. |
|affiliation |character |Where to find the show. |
|title       |character |Title of the specific episode. |

# `journalism.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|subcategory |character |The type of journalism. These subcategories have changed over time, and many appear to overlap. |
|rank        |character |Whether the person is a "Winner" or "Nominee". |
|year        |character |The year of the award. |
|name        |character |The name of the award winner or nominee. |
|affiliation |character |The publication or network on which the journalist appeared. |
|title       |character |The title of the specific piece of reporting. |

# `leadership.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|rank        |character |Whether the person is a "Winner" or "Nominee". For this dataset, all rows are "Winner". |
|year        |character |The year of the award. |
|name        |character |The name of the award winner. |
|affiliation |character |The group or restaurant with which the winner is affiliated. |

# `restaurant_and_chef.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|subcategory |character |The type of restaurant or cooking. These subcategories have changed over time, and many appear to overlap. |
|rank        |character |Whether the person is a "Winner", "Semifinalist", or "Nominee". |
|year        |character |The year of the award. |
|name        |character |The name of the award winner or nominee. |
|restaurant  |character |The name of the restaurant, when applicable. |
|city        |character |The city or other location of the restaurant. |

### Cleaning Script

```r
# Based on data by PythonCoderUnicorn:
# https://github.com/PythonCoderUnicorn/JamesBeardAward/tree/main)
library(tidyverse)
library(httr2)

url <- "https://www.jamesbeard.org/awards/search"

all_categories <- c(
  "Book",
  "Broadcast Media",
  "Humanitarian of the Year",
  "Journalism",
  "Leadership",
  "Lifetime Achievement",
  "Restaurant & Chef",
  "Who's Who of Food & Beverage in America"
)
# Only certain categories appear to be searchable. I may come back to dig for
# the hidden ones, though.
categories <- c(
  "Book",
  "Broadcast Media",
  "Journalism",
  "Leadership",
  "Restaurant & Chef"
)

next_page <- function(resp, req) {
  next_url <- httr2::resp_body_html(resp) |> 
    rvest::html_element('a[rel="next"]') |> 
    rvest::html_attr("href")
  if (is.na(next_url)) {
    return(NULL)
  }
  return(httr2::request(next_url))
}

# Data can be different by category, and a few individual cases are laid out
# incorrectly, unfortunately. So fetch data by category, and then we'll process
# that data differently, and semi-manually correct strange cases.

all_data <- purrr::map(
  categories,
  \(category) {
    query <- rlang::set_names(
      1,
      paste0("categories[", category, "]")
    )

    resps <- httr2::request(url) |>
      httr2::req_url_query(!!!query) |>
      httr2::req_perform_iterative(next_req = next_page, max_reqs = 1000)

    resps |>
      httr2::resps_data(\(resp) {
        recipients <- httr2::resp_body_html(resp) |>
          rvest::html_elements(".c-award-recipient")
        purrr::map(recipients, \(recipient) {
          extraction <- recipient |>
            rvest::html_elements(
              ".c-award-recipient__award, .c-award-recipient__text"
            ) |>
            rvest::html_text2()
          tibble::tibble(
            category = category,
            name = recipient |>
              rvest::html_element(".c-award-recipient__name") |>
              rvest::html_text2(),
            extraction = list(extraction[nchar(extraction) > 0])
          )
        }) |>
          purrr::list_rbind()
      })
  },
  .progress = TRUE
) |>
  purrr::list_rbind()

# saveRDS(all_data, "data/curated/jamesbeard/all_data.rds")
# all_data <- readRDS("data/curated/jamesbeard/all_data.rds")

# Other variables and functions for cleaning ----
years <- 1967:lubridate::year(lubridate::today())
ranks <- c("Winner", "Nominee", "Semifinalist")

find_values <- function(df, values) {
  cols <- purrr::map(
    df, \(col) {
      col[!(col %in% values)] <- NA_character_
      col
    }
  )
  dplyr::coalesce(!!!cols)
}

use_values <- function(data, new_col, cols, values) {
  df <- dplyr::select(data, {{ cols }})
  new_vals <- find_values(df, values)
  
  data |> 
    dplyr::mutate(
      {{new_col}} := new_vals,
      dplyr::across(
        {{ cols }},
        \(col) {
          blank_values(col, values)
        }
      )
    ) |> 
    janitor::remove_empty("cols")
}

blank_values <- function(col, values) {
  col[col %in% values] <- NA_character_
  col
}

# Leadership ----
leadership <- 
  all_data |> 
  dplyr::filter(category == "Leadership") |> 
  tidyr::unnest_wider(extraction, names_sep = "_") |> 
  use_values("rank", tidyselect::starts_with("extraction_"), values = ranks) |> 
  use_values("year", tidyselect::starts_with("extraction_"), values = years) |> 
  dplyr::select(
    "rank",
    "year",
    "name",
    "affiliation" = "extraction_2"
  )

# Journalism ----
journalism <- 
  all_data |> 
  dplyr::filter(category == "Journalism") |> 
  tidyr::unnest_wider(extraction, names_sep = "_") |> 
  # Find where "Journalism" is so we can get rid of those values.
  use_values(
    "full_category_name",
    tidyselect::starts_with("extraction_"),
    values = "Journalism"
  ) |> 
  use_values("rank", tidyselect::starts_with("extraction_"), values = ranks) |> 
  use_values("year", tidyselect::starts_with("extraction_"), values = years) |> 
  # The newspaper, etc, appears to be the second-to-last thing that's left.
  dplyr::mutate(
    affiliation = dplyr::coalesce(extraction_3, extraction_2),
    extraction_3 = dplyr::na_if(extraction_3, affiliation),
    extraction_2 = dplyr::na_if(extraction_2, affiliation),
  ) |> 
  dplyr::select(
    "subcategory" = "extraction_1",
    "rank",
    "year",
    "name",
    "affiliation",
    "title" = "extraction_2"
  )

# Broadcast Media ----
broadcast_media <-
  all_data |> 
  dplyr::filter(category == "Broadcast Media") |> 
  tidyr::unnest_wider(extraction, names_sep = "_") |> 
  # Find where the category is so we can get rid of those values.
  use_values(
    "full_category_name",
    tidyselect::starts_with("extraction_"),
    values = "Broadcast Media"
  ) |> 
  use_values("rank", tidyselect::starts_with("extraction_"), values = ranks) |> 
  use_values("year", tidyselect::starts_with("extraction_"), values = years) |> 
  # The affiliation appears to be the second-to-last thing that's left.
  dplyr::mutate(
    affiliation = dplyr::coalesce(extraction_4, extraction_3, extraction_2),
    extraction_4 = dplyr::na_if(extraction_4, affiliation),
    extraction_3 = dplyr::na_if(extraction_3, affiliation),
    extraction_2 = dplyr::na_if(extraction_2, affiliation),
  ) |> 
  dplyr::mutate(
    title = dplyr::coalesce(extraction_3, extraction_2),
    extraction_3 = dplyr::na_if(extraction_3, title),
    extraction_2 = dplyr::na_if(extraction_2, title),
  ) |> 
  dplyr::select(
    "subcategory" = "extraction_1",
    "rank",
    "year",
    "name",
    "show" = "extraction_2",
    "affiliation",
    "title"
  )

# Book ----
book <-
  all_data |> 
  dplyr::filter(category == "Book") |> 
  tidyr::unnest_wider(extraction, names_sep = "_") |> 
  # Find where the category is so we can get rid of those values.
  use_values(
    "full_category_name",
    tidyselect::starts_with("extraction_"),
    values = "Book"
  ) |> 
  use_values("rank", tidyselect::starts_with("extraction_"), values = ranks) |> 
  use_values("year", tidyselect::starts_with("extraction_"), values = years) |> 
  dplyr::select(
    "subcategory" = "extraction_1",
    "rank",
    "year",
    "name",
    "title" = "extraction_2",
    "publisher" = "extraction_3"
  )

# Restaurant & Chef ----
restaurant_and_chef <-
  all_data |> 
  dplyr::filter(category == "Restaurant & Chef") |> 
  tidyr::unnest_wider(extraction, names_sep = "_") |> 
  # Find where the category is so we can get rid of those values.
  use_values(
    "full_category_name",
    tidyselect::starts_with("extraction_"),
    values = "Restaurant & Chef"
  ) |> 
  use_values("rank", tidyselect::starts_with("extraction_"), values = ranks) |> 
  use_values("year", tidyselect::starts_with("extraction_"), values = years) |>
  # dplyr::glimpse()
  dplyr::select(
    "subcategory" = "extraction_1",
    "rank",
    "year",
    "name",
    "restaurant" = "extraction_2",
    "city" = "extraction_3"
  )
```
