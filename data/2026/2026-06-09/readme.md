# Films Based on Video Games

The dataset this week comes from the Wikipedia article [List of films based on video games](https://en.wikipedia.org/wiki/List_of_films_based_on_video_games). It covers theatrical releases, direct-to-video productions, television films, short films, and documentaries adapted from video games, spanning from the early 1990s to upcoming releases. Each row is a film, with box office figures, critic scores, budgets, and release dates where available.

> The list covers feature films, animated films, live-action films, television films, and short films that are based on or inspired by a video game franchise.

Some questions worth exploring:

- Which video game franchise has generated the most film adaptations, and
  which has earned the most at the box office?
- Which video game publishers have the most film adaptations, and how have they performed at the box office?
- Do audiences and critics agree? Compare CinemaScore grades against
  Rotten Tomatoes scores.

Thank you to [Georgios Karamanis](https://github.com/gkaramanis) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-06-09')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 23)

game_films <- tuesdata$game_films

# Option 2: Read directly from GitHub

game_films <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-09/game_films.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-06-09')

# Option 2: Read directly from GitHub and assign to an object

game_films = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-09/game_films.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-06-09")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

game_films = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-09/game_films.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
game_films = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-09/game_films.csv", DataFrame)
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

### `game_films.csv`

|variable                      |class     |description                           |
|:-----------------------------|:---------|:-------------------------------------|
|category                      |character |Top-level Wikipedia section the film belongs to (e.g. "Theatrical releases", "Direct-to-video", "Television films"). |
|subcategory                   |character |Second-level Wikipedia section within the category (e.g. "English", "Japanese", "Animation"). NA for films with no subsection. |
|title                         |character |Title of the film or production. |
|director                      |character |Director(s) of the film. Multiple directors are separated by " \| ". |
|release_date                  |date      |Parsed release date. For films with regional releases, this is the earliest date. For year-only or month-year entries, the date is set to the first day of that period. TBA and undated entries are NA. |
|release_date_raw              |character |Original release date string as it appeared on Wikipedia before parsing. |
|air_date_raw                  |character |Original air date string for television productions, as it appeared on Wikipedia. NA for non-television entries. |
|worldwide_box_office_currency |character |Currency symbol of the worldwide box office figure (e.g. "$", "¥"). |
|worldwide_box_office          |double    |Worldwide box office gross in the original currency units. See worldwide_box_office_currency. |
|rotten_tomatoes               |double    |Rotten Tomatoes critic score as a percentage (0–100). |
|metacritic                    |double    |Metacritic score out of 100. |
|cinema_score                  |character |CinemaScore audience grade (e.g. "A+", "B−"). |
|distributor                   |character |Film distributor(s). |
|original_game_publisher       |character |Publisher of the video game the film is based on. |
|budget_currency               |character |Currency symbol of the budget figures (e.g. "$", "¥"). |
|budget_low                    |double    |Lower bound of the reported production budget in the original currency units. Equal to budget_high for single-value budgets. |
|budget_high                   |double    |Upper bound of the reported production budget in the original currency units. Equal to budget_low for single-value budgets. |
|domestic_box_office           |character |Domestic box office gross as reported on Wikipedia (documentary sections). |
|subject                       |character |Subject or topic of the documentary (documentary sections only). |
|network                       |character |Broadcasting network for television productions. |

## Cleaning Script

```r
library(rvest)
library(tidyverse)

url <- "https://en.wikipedia.org/wiki/List_of_films_based_on_video_games"

page <- read_html(url)

parse_scaled <- function(x, fn) {
  mult <- case_when(
    str_detect(x, regex("billion", ignore_case = TRUE)) ~ 1e9,
    str_detect(x, regex("million", ignore_case = TRUE)) ~ 1e6,
    .default = 1
  )
  nums <- str_extract_all(x, "[0-9][0-9,]*(?:\\.[0-9]+)?")
  map_dbl(nums, ~ { v <- parse_number(.x); if (length(v) == 0) NA_real_ else fn(v) }) * mult
}

clean_film_table <- function(df, category, subcategory) {
  df |>
    janitor::clean_names() |>
    rename(any_of(c(cinema_score = "cinema_score_1"))) |>
    mutate(across(where(is.character), ~ str_remove_all(., "\\[.*?\\]"))) |>
    (\(d) if ("release_date" %in% names(d))
      d |> mutate(
        release_date_raw = as.character(release_date),
        release_date = release_date_raw |>
          str_remove("\\s*\\(.*") |>       # strip regional suffixes: "... (JP)..."
          str_remove("\\s*[–—-].*") |>     # strip date ranges: "... – end date"
          str_trim() |>
          parse_date_time(orders = c("mdy", "my", "Y"), quiet = TRUE) |>
          as.Date()
      ) |>
      relocate(release_date_raw, .after = release_date)
    else d)() |>
    mutate(across(any_of(c("worldwide_box_office", "budget")),
                  ~ str_extract(., "^[£$€¥₹]"), .names = "{.col}_currency")) |>
    mutate(across(any_of("worldwide_box_office"), parse_number)) |>
    (\(d) if ("budget" %in% names(d))
      d |>
        mutate(budget_low = parse_scaled(budget, first), budget_high = parse_scaled(budget, last)) |>
        select(-budget)
    else d)() |>
    mutate(across(any_of("rotten_tomatoes"), ~ parse_number(str_remove(., "%")))) |>
    mutate(across(any_of("metacritic"), ~ parse_number(str_remove(., "/100")))) |>
    rename(any_of(c(director = "direction", air_date_raw = "original_air_date_s"))) |>
    mutate(category = category, subcategory = subcategory) |>
    relocate(category, subcategory) |>
    relocate(any_of("worldwide_box_office_currency"), .before = any_of("worldwide_box_office")) |>
    relocate(any_of("budget_currency"), .before = any_of("budget_low"))
}

get_heading_text <- function(node) {
  text <- html_text2(html_element(node, ".mw-headline"))
  if (is.na(text) || nchar(str_trim(text)) == 0) text <- html_text2(node)
  str_trim(text)
}

game_films <- local({
  nodes <- xml2::xml_find_all(page, ".//h2 | .//h3 | .//table[contains(@class,'wikitable')]")
  current_h2 <- NA_character_
  current_h3 <- NA_character_
  raw_tables <- list()
  categories <- character()
  subcategories <- character()

  for (i in seq_along(nodes)) {
    node <- nodes[[i]]
    tag <- html_name(node)
    if (tag == "h2") {
      current_h2 <- get_heading_text(node)
      current_h3 <- NA_character_
    } else if (tag == "h3") {
      current_h3 <- get_heading_text(node)
    } else if (tag == "table") {
      tbl <- tryCatch(
        node |>
          as.character() |>
          str_replace_all("<hr\\s*/?\\s*>\\s*", " | ") |>
          read_html() |>
          html_element("table") |>
          html_table(),
        error = function(e) NULL
      )
      if (!is.null(tbl) && nrow(tbl) > 0) {
        raw_tables <- c(raw_tables, list(tbl))
        categories <- c(categories, current_h2)
        subcategories <- c(subcategories, current_h3)
      }
    }
  }

  pmap(list(raw_tables, categories, subcategories), clean_film_table) |>
    bind_rows() |>
    relocate(any_of("air_date_raw"), .after = any_of("release_date_raw"))
})

```
