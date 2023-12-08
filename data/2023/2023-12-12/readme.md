# Holiday Movies

Happy holidays!
This week we're exploring "holiday" movies: movies with "holiday", "Christmas", "Hanukkah", or "Kwanzaa" (or variants thereof) in their title!

The data this week comes from the [Internet Movie Database](https://developer.imdb.com/non-commercial-datasets/).
We don't have an article using exactly this dataset, but you might get inspiration from this [Christmas Movies](https://networkdatascience.ceu.edu/article/2019-12-16/christmas-movies) blog post by Milán Janosov at Central European University.

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-12-12')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 50)

holiday_movies <- tuesdata$holiday_movies
holiday_movie_genres <- tuesdata$holiday_movie_genres

# Option 2: Read directly from GitHub

holiday_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-12/holiday_movies.csv')
holiday_movie_genres <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-12/holiday_movie_genres.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `holiday_movies.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|tconst          |character |alphanumeric unique identifier of the title |
|title_type      |character |the type/format of the title (movie, video, or tvMovie) |
|primary_title   |character |the more popular title / the title used by the filmmakers on promotional materials at the point of release |
|original_title  |character |original title, in the original language |
|year            |double    |the release year of a title |
|runtime_minutes |double    |primary runtime of the title, in minutes |
|genres          |character |includes up to three genres associated with the title (comma-delimited) |
|simple_title    |character |the title in lowercase, with punctuation removed, for easier filtering and grouping |
|average_rating  |double    |weighted average of all the individual user ratings on IMDb |
|num_votes       |double    |number of votes the title has received on IMDb (titles with fewer than 10 votes were not included in this dataset) |
|christmas       |logical   |whether the title includes "christmas", "xmas", "x mas", etc|
|hanukkah        |logical   |whether the title includes "hanukkah", "chanukah", etc|
|kwanzaa         |logical   |whether the title includes "kwanzaa"|
|holiday         |logical   |whether the title includes the word "holiday"|

# `holiday_movie_genres.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|tconst   |character |alphanumeric unique identifier of the title |
|genres   |character |genres associated with the title, one row per genre |


### Cleaning Script

``` r
library(tidyverse)
library(here)
library(fs)
library(janitor)

working_dir <- here::here("data", "2023", "2023-12-12")

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

holiday_movies <- rated_titles |> 
  dplyr::filter(title_type %in% c("movie", "video", "tvMovie")) |> 
  # "end_year" is only relevant for series.
  dplyr::select(-"end_year") |>
  dplyr::rename("year" = "start_year") |> 
  dplyr::filter(
    stringr::str_detect(simple_title, "holiday") |
      stringr::str_detect(simple_title, "christmas") |
      stringr::str_detect(simple_title, "\\bx mas\\b") |
      stringr::str_detect(simple_title, "xmas") |
      # Let's catch both "Hanukkah" and "Chanukah" (and some other variants
      # while we're at it)
      stringr::str_detect(simple_title, "hanuk") | 
      stringr::str_detect(simple_title, "kwanzaa")
  ) |> 
  dplyr::mutate(
    christmas = stringr::str_detect(simple_title, "christmas") | 
      stringr::str_detect(simple_title, "x *mas"),
    hanukkah = stringr::str_detect(simple_title, "hanuk"),
    kwanzaa = stringr::str_detect(simple_title, "kwanzaa"),
    holiday = stringr::str_detect(simple_title, "holiday")
  )

holiday_movie_genres <- holiday_movies |> 
  dplyr::select(tconst, genres) |> 
  tidyr::separate_longer_delim(genres, ",")

readr::write_csv(
  holiday_movies,
  fs::path(working_dir, "holiday_movies.csv")
)
readr::write_csv(
  holiday_movie_genres,
  fs::path(working_dir, "holiday_movie_genres.csv")
)
```
