# Campus Pride Index

Happy Pride Month! 
Check out the [{gglgbtq}](https://github.com/turtletopia/gglgbtq) package for LGBTQ-related themes and color palettes!

The data this week comes from the [Campus Pride Index](https://campusprideindex.org/).

> Since 2007, the Campus Pride Index has been the premier LGBTQ national benchmarking tool for colleges and universities to create safer, more inclusive campus communities. The free online tool allows prospective students, families/parents and those interested in higher education to search a database of LGBTQ-friendly campuses who have come out to improve the academic experience and quality of campus life.

The website has additional information about each campus, including a more detailed breakdown of their Campus Pride Index rating.

Is there a relationship between the size of a campus or the surrounding community and its rating? 
What about the state in which the campus is located?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-06-11')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 24)

pride_index <- tuesdata$pride_index
pride_index_tags <- tuesdata$pride_index_tags

# Option 2: Read directly from GitHub

pride_index <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index.csv')
pride_index_tags <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-11/pride_index_tags.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `pride_index.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|campus_name     |character |Name of the college or university |
|campus_location |character |Location of the college or university |
|rating          |numeric   |Campus Pride Index star rating from 1 to 5 (including half-star ratings) |
|students        |numeric   |Full-time equivalent student population |
|community_type  |character |Locale where the campus is located. One of "large urban city" (500k+), "medium city" (100k to 500k), "small city" (25k to 100k), "small town" (10k to 25k), "very small town" (5k to 10k), "rural community" (< 5k) |

# `pride_index_tags.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|campus_name            |character |Name of the college or university |
|campus_location        |character |Location of the college or university |
|public                 |logical   |Whether the campus is tagged as public (TRUE or NA) |
|private                |logical   |Whether the campus is tagged as private (TRUE or NA) |
|doctoral               |logical   |Whether the campus is tagged as a doctoral/research university (TRUE or NA) |
|masters                |logical   |Whether the campus is tagged as offering master's degrees (TRUE or NA) |
|baccalaureate          |logical   |Whether the campus is tagged as offering baccalaureate degrees (TRUE or NA) |
|community              |logical   |Whether the campus is tagged as a community college (TRUE or NA) |
|residential            |logical   |Whether the campus is tagged as having a residential campus (TRUE or NA) |
|nonresidential         |logical   |Whether the campus is tagged as having a nonresidential campus (TRUE or NA) |
|liberal_arts           |logical   |Whether the campus is tagged as a liberal arts college (TRUE or NA) |
|technical              |logical   |Whether the campus is tagged as a technical institute (TRUE or NA) |
|religious              |logical   |Whether the campus is tagged as having a religious affiliation (TRUE or NA) |
|military               |logical   |Whether the campus is tagged as a military institute (TRUE or NA) |
|hbcu                   |logical   |Whether the campus is tagged as a historically black college/university (TRUE or NA) |
|hispanic_serving       |logical   |Whether the campus is tagged as a Hispanic-serving institution (TRUE or NA) |
|aapi_serving           |logical   |Whether the campus is tagged as an Asian-American- and Pacific-Islander-serving institution (TRUE or NA) |
|other_minority_serving |logical   |Whether the campus is tagged as an other-minority-serving institution (TRUE or NA) |


### Cleaning Script

```{r}
library(tidyverse)
library(here)
library(fs)
library(rvest)
library(polite)

working_dir <- here::here("data", "2024", "2024-06-11")
session <- polite::bow(
  "https://campusprideindex.org/searchresults/display/0",
  user_agent = "TidyTuesday (https://tidytues.day, jonthegeek+tidytuesday@gmail.com)",
  delay = 0
)
pride_index_rows <- session |> 
  polite::scrape() |> 
  rvest::html_elements(".campus-item")

pride_index_data <- tibble::tibble(
  campus_name = pride_index_rows |> 
    rvest::html_element(".s3 h4 a") |> 
    rvest::html_text2() |> 
    stringr::str_squish(),
  campus_location = pride_index_rows |> 
    rvest::html_element(".s3 p") |> 
    rvest::html_text2() |> 
    stringr::str_squish(),
  rating = pride_index_rows |>
    rvest::html_element(".rating") |>
    purrr::map_dbl(
      \(rating_node) {
        full <- rating_node |> 
          html_elements(".rating-icon-Star-Full") |> 
          length()
        half <- rating_node |> 
          html_elements(".rating-icon-Star-Half") |> 
          length()
        full + half / 2
      }
    ),
  students = pride_index_rows |> 
    rvest::html_element(".s1 .currency") |> 
    rvest::html_text2() |> 
    readr::parse_number() |> 
    as.integer(),
  community_type = pride_index_rows |> 
    rvest::html_element(".s1 + .s2") |> 
    rvest::html_text2() |> 
    stringr::str_remove("\\([^)]+\\)") |> 
    stringr::str_squish() |> 
    tolower(),
  other_data = pride_index_rows |> 
    rvest::html_element(".s3 + .s3") |> 
    rvest::html_text2() |> 
    stringr::str_remove_all("\r\n") |> 
    stringr::str_split("\n")
)

pride_index_tags <- pride_index_data |> 
  dplyr::select(campus_name, campus_location, other_data) |> 
  tidyr::unnest_longer(other_data) |> 
  dplyr::mutate(
    other_data = dplyr::case_match(
      other_data,
      "Doctoral/Research University" ~ "doctoral",
      "Public/State University" ~ "public",
      "Residential Campus" ~ "residential",
      "Asian American and Pacific Islander Serving Institution" ~ "aapi_serving",
      "Master's College/University" ~ "masters",
      "Baccalaureate College/University" ~ "baccalaureate",
      "Nonresidential Campus" ~ "nonresidential",
      "Community College" ~ "community",
      "Hispanic Serving Institution" ~ "hispanic_serving",
      "Liberal Arts College" ~ "liberal_arts",
      "Private Institution" ~ "private",
      "Religious Affiliation" ~ "religious",
      "Historically Black College/University" ~ "hbcu",
      "Military Institution" ~ "military",
      "Technical Institute" ~ "technical",
      "Other Minority Serving Institution" ~ "other_minority_serving"
    ),
    value = TRUE
  ) |> 
  tidyr::pivot_wider(
    names_from = other_data,
    values_from = value
  ) |> 
  dplyr::select(
    campus_name,
    campus_location,
    public, private, 
    doctoral, masters, baccalaureate, community,
    residential, nonresidential,
    liberal_arts, technical,
    religious, military, 
    hbcu, hispanic_serving, aapi_serving, other_minority_serving
  )

pride_index <- pride_index_data |> 
  dplyr::select(-other_data)

# Save -------------------------------------------------------------------------
readr::write_csv(
  pride_index,
  fs::path(working_dir, "pride_index.csv")
)
readr::write_csv(
  pride_index_tags,
  fs::path(working_dir, "pride_index_tags.csv")
)
```
