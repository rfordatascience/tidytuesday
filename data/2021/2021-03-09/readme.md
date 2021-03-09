![Walmart shelf with DVD of Hunger Games movie](https://fivethirtyeight.com/wp-content/uploads/2014/04/477092007.jpg)

# Bechdel Test

The data this week comes from [FiveThirtyEight](https://github.com/fivethirtyeight/data/tree/master/bechdel) and the corresponding article from [FiveThirtyEight](https://fivethirtyeight.com/features/the-dollar-and-cents-case-against-hollywoods-exclusion-of-women/).

> Audiences and creators know that on one level or another, there’s an inherent gender bias in the movie business — whether it’s the disproportionately low number of films with female leads, the process of pigeonholing actresses into predefined roles (action chick, romantic interest, middle-aged mother, etc.), or the lack of serious character development for women on screen compared to their male counterparts. What’s challenging is quantifying this dysfunction, putting numbers to a trend that is — at least anecdotally — a pretty clear reality.
> 
> One of the most enduring tools to measure Hollywood’s gender bias is a test originally promoted by cartoonist [Alison Bechdel](http://dykestowatchoutfor.com/) in a 1985 strip from her “Dykes To Watch Out For” series. Bechdel said that if a movie can satisfy three criteria — there are at least two named women in the picture, they have a conversation with each other at some point, and that conversation isn’t about a male character — then it passes “The Rule,” whereby female characters are allocated a bare minimum of depth. You can see a [copy of that strip here](http://www.npr.org/templates/story/story.php?storyId=94202522).

* [Bechdel Test data](http://bechdeltest.com/) sourced via Bechdeltest.com API.

`raw_bechdel.csv` includes data from 1970 - 2020, for ONLY bechdel testing, while the `movies.csv` includes IMDB scores, budget/gross revenue, and ratings but only from 1970 - 2013.


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-09')
tuesdata <- tidytuesdayR::tt_load(2021, week = 11)

bechdel <- tuesdata$bechdel

# Or read in the data manually

raw_bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')
movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv')

```
### Data Dictionary

# `raw_bechdel.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|year     |integer   | Year of release |
|id       |integer   | ID of film |
|imdb_id  |character | IMDB ID|
|title    |character | Title of film |
|rating   |integer   | Rating (0-3), 0 = unscored, 1. It has to have at least two [named] women in it, 2. Who talk to each other, 3. About something besides a man |

# `movies.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|year          |double    | Year |
|imdb          |character | IMDB|
|title         |character |Title of movie |
|test          |character | Bechdel Test outcome|
|clean_test    |character | Bechdel Test cleaned |
|binary        |character | Binary pass/fail of bechdel |
|budget        |double    | Budget as of release year |
|domgross      |character | Domestic gross in release year |
|intgross      |character | International gross in release year |
|code          |character | Code |
|budget_2013   |double    | Budget normalized to 2013 |
|domgross_2013 |character | Domestic gross  normalized to 2013 |
|intgross_2013 |character | International gross normalized to 2013 |
|period_code   |double    | Period code |
|decade_code   |double    | Decade Code |
|imdb_id       |character | IMDB ID |
|plot          |character | Plot of movie |
|rated         |character | Rating of movie |
|response      |character | Response? |
|language      |character | Language of film |
|country       |character | Country produced in |
|writer        |character | Writer of film |
|metascore     |double    | Metascore rating (0-100) |
|imdb_rating   |double    | IMDB Rating 0-10|
|director      |character | Director of movie |
|released      |character | Released date |
|actors        |character | Actors |
|genre         |character | Genre |
|awards        |character | Awards |
|runtime       |character | Runtime |
|type          |character | Type of film |
|poster        |character | Poster image |
|imdb_votes    |character | IMDB Votes |
|error         |character | Error? |


### Cleaning Script

```{r}
library(tidyverse)
library(jsonlite)

raw_json <- jsonlite::parse_json(url("http://bechdeltest.com/api/v1/getAllMovies"))

all_movies <- raw_json %>% 
  map_dfr(~as.data.frame(.x, stringsAsFactors = FALSE)) %>% 
  rename(imdb_id = imdbid) %>% 
  tibble()

all_movies %>% 
  filter(year >= 1970) 



cleaned_bechdel <- all_movies %>% 
  mutate(title = case_when(
    str_detect(title, ", The") ~ str_remove(title, ", The") %>% paste("The", .),
    TRUE ~ str_replace(title, "&#39;", "’")
  ))

cleaned_bechdel %>% 
  write_csv("2021/2021-03-09/raw_bechdel.csv")

# IMDB data ---------------------------------------------------------------


imdb_json <- jsonlite::parse_json(url("https://raw.githubusercontent.com/brianckeegan/Bechdel/master/imdb_data.json"))

all_imdb <- imdb_json %>%
  map_dfr(~as.data.frame(.x, stringsAsFactors = FALSE))

cleaned_imdb <- all_imdb %>% 
  janitor::clean_names() %>% 
  mutate(metascore = parse_number(metascore),
         imdb_rating = parse_number(imdb_rating),
         year = as.integer(year)) %>% 
  mutate(imdb_id = str_remove(imdb_id, "tt")) %>% 
  tibble()

all_imdb

# 538 Data ----------------------------------------------------------------

movies <- read_csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/bechdel/movies.csv")

cleaned_movies <- movies %>% 
  mutate(imdb_id = str_remove(imdb, "tt")) 

combo_movies <- cleaned_movies %>% 
  left_join(cleaned_imdb) %>% 
  janitor::clean_names() 

combo_movies

combo_movies %>% 
  write_csv("2021/2021-03-09/movies.csv")

```