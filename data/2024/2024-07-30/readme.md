# Summer Movies

This week we're exploring "summer" movies: movies with "summer" in their title!

The data this week comes from the [Internet Movie Database](https://developer.imdb.com/non-commercial-datasets/).
We don't have an article using exactly this dataset, but you might get inspiration from [IMDb's 2023 Summer Movie Guide](https://www.imdb.com/list/ls569932833/).

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-07-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 31)

summer_movie_genres <- tuesdata$summer_movie_genres
summer_movies <- tuesdata$summer_movies

# Option 2: Read directly from GitHub

summer_movie_genres <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-30/summer_movie_genres.csv')
summer_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-30/summer_movies.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `summer_movie_genres.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|tconst   |character |alphanumeric unique identifier of the title |
|genres   |character |genres associated with the title, one row per genre |

# `summer_movies.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|tconst          |character |alphanumeric unique identifier of the title |
|title_type      |character |the type/format of the title (movie, video, or tvMovie) |
|primary_title   |character |the more popular title / the title used by the filmmakers on promotional materials at the point of release |
|original_title  |character |original title, in the original language |
|year            |integer   |the release year of a title |
|runtime_minutes |integer   |primary runtime of the title, in minutes |
|genres          |character |includes up to three genres associated with the title (comma-delimited)  |
|simple_title    |character |the title in lowercase, with punctuation removed, for easier filtering and grouping |
|average_rating  |double    |weighted average of all the individual user ratings on IMDb |
|num_votes       |integer   |number of votes the title has received on IMDb (titles with fewer than 10 votes were not included in this dataset) |

### Cleaning Script

```r
library(tidyverse)
library(janitor)

imdb_ratings <- readr::read_tsv(
  "https://datasets.imdbws.com/title.ratings.tsv.gz",
  na = c("", "NA", "\\N")
) |> 
  janitor::clean_names() |> 
  dplyr::filter(num_votes >= 10)
imdb_titles <- readr::read_tsv(
  "https://datasets.imdbws.com/title.basics.tsv.gz",
  na = c("", "NA", "\\N")
) |> 
  janitor::clean_names() |> 
  # A handful of titles have miscoded data, which can be detected by cases where
  # the "isAdult" field has a value other than 0 or 1. That's convenient,
  # because I want to get rid of anything other than 0.
  dplyr::filter(is_adult == 0) |>
  dplyr::select(-is_adult) |>
  dplyr::mutate(
    # Create a column for easier title searching.
    simple_title = tolower(primary_title) |> 
      stringr::str_remove_all("[[:punct:]]")
  )

rated_titles <- imdb_titles |> 
  dplyr::inner_join(imdb_ratings, by = "tconst")

summer_movies <- rated_titles |> 
  dplyr::filter(title_type %in% c("movie", "video", "tvMovie")) |> 
  # "end_year" is only relevant for series.
  dplyr::select(-"end_year") |>
  dplyr::rename("year" = "start_year") |> 
  dplyr::filter(stringr::str_detect(simple_title, "summer")) |> 
  dplyr::mutate(
    dplyr::across(
      c("year", "runtime_minutes", "num_votes"),
      as.integer
    )
  )

summer_movie_genres <- summer_movies |> 
  dplyr::select(tconst, genres) |> 
  tidyr::separate_longer_delim(genres, ",")
```
