# Holiday Episodes

Happy holidays!
Last week we explored ["holiday" movies](../2023-12-12/readme.md).
This week we're exploring "holiday" TV episodes: individual episodes of TV shows with "holiday", "Christmas", "Hanukkah", or "Kwanzaa" (or variants thereof) in their title!

The data this week again comes from the [Internet Movie Database](https://developer.imdb.com/non-commercial-datasets/).
We don't have an article using exactly this dataset, but you might get inspiration from the TVTropes [Holiday Episode](https://tvtropes.org/pmwiki/pmwiki.php/Main/HolidayEpisode) article.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-12-19')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 51)

holiday_episodes <- tuesdata$holiday_episodes
holiday_episode_genres <- tuesdata$holiday_episode_genres

# Option 2: Read directly from GitHub

holiday_episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-12-19/holiday_episodes.csv')
holiday_episode_genres <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-12-19/holiday_episode_genres.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `holiday_episodes.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|tconst                 |character |alphanumeric unique identifier of the individual episode|
|parent_tconst          |character |alphanumeric unique identifier of the parent TV series|
|season_number          |double    |season number the episode belongs to|
|episode_number         |double    |episode number of the tconst in the TV series|
|primary_title   |character |the more popular title / the title used by the filmmakers on promotional materials at the point of release |
|original_title  |character |original title, in the original language |
|year            |double    |the release year of a title |
|runtime_minutes |double    |primary runtime of the title, in minutes |
|genres          |character |includes up to three genres associated with the title (comma-delimited) |
|simple_title    |character |the title in lowercase, with punctuation removed, for easier filtering and grouping |
|average_rating  |double    |weighted average of all the individual user ratings on IMDb |
|num_votes       |double    |number of votes the title has received on IMDb (titles with fewer than 10 votes were not included in this dataset) |
|parent_title_type      |character |the type/format of the title ("tvMiniSeries" or "tvSeries"|
|parent_primary_title   |character |the more popular title / the title used by the filmmakers on promotional materials at the point of release (for the parent TV series)|
|parent_original_title  |character |original title, in the original language (for the parent TV series) |
|parent_start_year      |double    |the series start year|
|parent_end_year        |double    |the series end year|
|parent_runtime_minutes |double    |primary runtime of the TV series, in minutes |
|parent_genres          |character |includes up to three genres associated with the TV series|
|parent_simple_title    |character |the title in lowercase, with punctuation removed, for easier filtering and grouping (for the parent TV series)|
|parent_average_rating  |double    |weighted average of all the individual user ratings on IMDb (for the parent TV series) |
|parent_num_votes       |double    |number of votes the title has received on IMDb (for the parent TV series; titles with fewer than 10 votes were not included in this dataset) |
|christmas       |logical   |whether the episode title includes "christmas", "xmas", "x mas", etc|
|hanukkah        |logical   |whether the episode title includes "hanukkah", "chanukah", etc|
|kwanzaa         |logical   |whether the episode title includes "kwanzaa"|
|holiday         |logical   |whether the episode title includes the word "holiday"|

# `holiday_episode_genres.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|tconst   |character |alphanumeric unique identifier of the episode title |
|genres   |character |genres associated with the episode, one row per genre |


### Cleaning Script

``` r
library(tidyverse)
library(here)
library(fs)
library(janitor)

working_dir <- here::here("data", "2023", "2023-12-19")

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

imdb_episodes <- readr::read_tsv(
  "https://datasets.imdbws.com/title.episode.tsv.gz",
  na = c("", "NA", "\\N")
) |> 
  janitor::clean_names()

holiday_episodes <- imdb_episodes |> 
  dplyr::inner_join(rated_titles, by = "tconst") |> 
  dplyr::select(-"title_type", -"end_year") |>
  dplyr::rename("year" = "start_year") |>
  dplyr::inner_join(
    dplyr::rename_with(rated_titles, ~ paste0("parent_", .x)),
    by = "parent_tconst"
  ) |> 
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

holiday_episode_genres <- holiday_episodes |> 
  dplyr::select(tconst, genres) |> 
  tidyr::separate_longer_delim(genres, ",")

readr::write_csv(
  holiday_episodes,
  fs::path(working_dir, "holiday_episodes.csv")
)
readr::write_csv(
  holiday_episode_genres,
  fs::path(working_dir, "holiday_episode_genres.csv")
)
```
