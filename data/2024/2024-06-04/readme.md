# Cheese

The data this week comes from [cheese.com](https://cheese.com), inspired by the examples in the [{polite}](https://dmi3kno.github.io/polite/) package.

> Cheese is nutritious food made mostly from the milk of cows but also other mammals, including sheep, goats, buffalo, reindeer, camels and yaks. Around 4000 years ago people have started to breed animals and process their milk. That's when the cheese was born.

> Explore this site to find out about different kinds of cheese from all around the world.

248 cheeses have listed fat content. 
Is there a relationship between fat content and cheese type?
What about texture, flavor, or aroma?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-06-04')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 23)

cheeses <- tuesdata$cheeses

# Option 2: Read directly from GitHub

cheeses <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-04/cheeses.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `cheeses.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|cheese          |character |Name of the cheese. |
|url             |character |Location of the cheese's description at cheese.com |
|milk            |character |The type of milk used for the cheese, when known. |
|country         |character |The country or countries of origin of the cheese. |
|region          |character |The region in which the cheese is produced, either within the country of origin, or as a wider description of multiple countries. |
|family          |character |The family to which the cheese belongs, if any. |
|type            |character |The broad type or types to describe the cheese. |
|fat_content     |character |The fat content of the cheese, as a percent or range of percents. |
|calcium_content |character |The calcium content of the cheese, when known. Values include units. |
|texture         |character |The texture of the cheese. |
|rind            |character |The type of rind used in producing the cheese. |
|color           |character |The color of the cheese. |
|flavor          |character |Characteristic(s) of the taste of the cheese. |
|aroma           |character |Characteristic(s) of the smell of the cheese. |
|vegetarian      |logical   |Whether cheese.com considers the cheese to be vegetarian. |
|vegan           |logical   |Whether cheese.com considers the cheese to be vegan. |
|synonyms        |character |Alternative names of the cheese. |
|alt_spellings   |character |Alternative spellings of the name of the cheese (likely overlaps with synonyms). |
|producers       |character |Known producers of the cheese. |


### Cleaning Script

```{r}
library(tidyverse)
library(here)
library(fs)
library(rvest)
library(polite)
library(glue)

working_dir <- here::here("data", "2024", "2024-06-04")
session <- polite::bow("https://www.cheese.com/")

# Get the full list of cheeses. ------------------------------------------------
cheeses <- purrr::map(
  letters,
  \(letter) {
    this_path <- glue::glue("alphabetical/{letter}")
    session <- polite::nod(session, this_path)
    pages <- polite::scrape(session, query = list(per_page = 100)) |>
      rvest::html_elements(".page-link") |>
      rvest::html_text2() |>
      readr::parse_integer()
    purrr::map(
      pages,
      \(page) {
        cheeses <- polite::scrape(session, query = list(per_page = 100, page = page)) |>
          rvest::html_elements(".cheese-item h3 a")
        tibble::tibble(
          cheese = rvest::html_text2(cheeses),
          url = rvest::html_attr(cheeses, "href") |>
            rvest::url_absolute(base = session$url)
        )
      }
    ) |>
      purrr::list_rbind()
  }
) |>
  purrr::list_rbind()

# Functions for two types of cleaning. -----------------------------------------
fetch_summary_item <- function(summary_block, css) {
  summary_block |> 
    rvest::html_element(css) |> 
    rvest::html_text2()
}

fetch_summary_items <- function(summary_block, css) {
  summary_block |> 
    rvest::html_elements(css) |> 
    rvest::html_text2() |> 
    stringr::str_flatten_comma(na.rm = TRUE)
}

# Fetch details page-by-page ---------------------------------------------------
# This took a very long time to process.
cheese_details <- purrr::map(
  cheeses$url,
  \(cheese_url) {
    session <- polite::nod(session, cheese_url)
    summary_block <- polite::scrape(session) |> 
      rvest::html_elements(".summary-points")
    tibble::tibble(
      url = cheese_url,
      milk = summary_block |> 
        fetch_summary_items(".summary_milk a"),
      country = summary_block |>
        fetch_summary_items(".summary_country a"),
      region = summary_block |> 
        fetch_summary_item(".summary_region"),
      family = summary_block |> 
        fetch_summary_item(".summary_family"),
      type = summary_block |> 
        fetch_summary_item(".summary_moisture_and_type"),
      fat_content = summary_block |> 
        fetch_summary_item(".summary_fat"),
      calcium_content = summary_block |> 
        fetch_summary_item(".summary_calcium"),
      texture = summary_block |> 
        fetch_summary_items(".summary_texture a"),
      rind = summary_block |> 
        fetch_summary_item(".summary_rind"),
      color = summary_block |> 
        fetch_summary_item(".summary_tint"),
      flavor = summary_block |> 
        fetch_summary_item(".summary_taste"),
      aroma = summary_block |> 
        fetch_summary_item(".summary_smell"),
      vegetarian = summary_block |> 
        fetch_summary_item(".summary_vegetarian"),
      vegan = summary_block |> 
        fetch_summary_item(".summary_vegan"),
      synonyms = summary_block |> 
        fetch_summary_item(".summary_synonym"),
      alt_spellings = summary_block |> 
        fetch_summary_item(".summary_alt_spelling"),
      producers = summary_block |> 
        fetch_summary_item(".summary_producer")
    )
  }
) |> 
  purrr::list_rbind()

cheese_details <- cheese_details |> 
  dplyr::mutate(
    dplyr::across(
      c(region:calcium_content, rind:producers),
      ~ stringr::str_remove(.x, "^[^:]+: ")
    ),
    dplyr::across(
      c(vegetarian, vegan),
      ~ dplyr::case_match(
        .x,
        "no" ~ FALSE,
        "yes" ~ TRUE,
        .default = NA
      )
    )
  )

cheeses <- cheeses |> 
  dplyr::left_join(cheese_details, by = dplyr::join_by(url))

# Save -------------------------------------------------------------------------
readr::write_csv(
  cheeses,
  fs::path(working_dir, "cheeses.csv")
)
```
