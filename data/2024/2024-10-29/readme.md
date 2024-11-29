# Monster Movies

This week we're exploring "monster" movies: movies with "monster" in their title!

The data this week comes from the [Internet Movie Database](https://developer.imdb.com/non-commercial-datasets/).
Check out ["Why Do People Like Horror Films? A Statistical Analysis"](https://www.statsignificant.com/p/why-do-people-like-horror-films-a) for an exploration of "the unique appeal of scary movies".

What are the most common combinations of genres for "monster" movies?
How do "monster" movies compare to ["summer" movies](https://tidytues.day/2024/2024-07-30) or ["holiday" movies](https://tidytues.day/2023/2023-12-12)?
What words are joined with "monster" in popular "monster" movies?

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-10-29')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 44)

monster_movie_genres <- tuesdata$monster_movie_genres
monster_movies <- tuesdata$monster_movies

# Option 2: Read directly from GitHub

monster_movie_genres <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-29/monster_movie_genres.csv')
monster_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-29/monster_movies.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `monster_movie_genres.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|tconst   |character |alphanumeric unique identifier of the title |
|genres   |character |genres associated with the title, one row per genre |

# `monster_movies.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
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

monster_movies <- rated_titles |> 
  dplyr::filter(title_type %in% c("movie", "video", "tvMovie")) |> 
  # "end_year" is only relevant for series.
  dplyr::select(-"end_year") |>
  dplyr::rename("year" = "start_year") |> 
  dplyr::filter(stringr::str_detect(simple_title, "monster")) |> 
  dplyr::mutate(
    dplyr::across(
      c("year", "runtime_minutes", "num_votes"),
      as.integer
    )
  )

monster_movie_genres <- monster_movies |> 
  dplyr::select(tconst, genres) |> 
  tidyr::separate_longer_delim(genres, ",")
```
