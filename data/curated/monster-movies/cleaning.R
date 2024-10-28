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
