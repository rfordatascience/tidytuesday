# Anime Dataset

This week's data comes from [Tam Nguyen](https://github.com/tamdrashtri) and [MyAnimeList.net via Kaggle](https://www.kaggle.com/aludosan/myanimelist-anime-dataset-as-20190204). [According to Wikipedia](https://en.wikipedia.org/wiki/MyAnimeList) - "MyAnimeList, often abbreviated as MAL, is an anime and manga social networking and social cataloging application website. The site provides its users with a list-like system to organize and score anime and manga. It facilitates finding users who share similar tastes and provides a large database on anime and manga. The site claims to have 4.4 million anime and 775,000 manga entries. In 2015, the site received 120 million visitors a month."

Anime without rankings or popularity scores were excluded. Producers, genre, and studio were converted from lists to tidy observations, so there will be repetitions of shows with multiple producers, genres, etc. The raw data is also uploaded.

Lots of interesting ways to explore the data this week!

# Get the Data

```
tidy_anime <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-23/tidy_anime.csv")

```

# Data Dictionary

Heads up the dataset is about 97 mb - if you want to free up some space, drop the synopsis and background, they are long strings, or broadcast, premiered, related as they are redundant or less useful.

|variable       |class     |description |
|:--------------|:---------|:-----------|
|animeID        |double    | Anime ID (as in https://myanimelist.net/anime/animeID)          |
|name           |character |anime title - extracted from the site.           |
|title_english  |character | title in English (sometimes is different, sometimes is missing)          |
|title_japanese |character | title in Japanese (if Anime is Chinese or Korean, the title, if available, in the respective language)          |
|title_synonyms |character | other variants of the title         |
|type           |character | anime type (e.g. TV, Movie, OVA)          |
|source         |character | source of anime (i.e original, manga, game, music, visual novel etc.)         |
|producers      |character | producers          |
|genre          |character | genre         |
|studio         |character | studio           |
|episodes       |double    | number of episodes           |
|status         |character | Aired or not aired      |
|airing         |logical   | True/False is still airing          |
|start_date     |double    | Start date (ymd)        |
|end_date       |double    | End date (ymd)        |
|duration       |character | Per episode duration or entire duration, text string        |
|rating         |character | Age rating         |
|score          |double    | Score (higher = better)       |
|scored_by      |double    | Number of users that scored          |
|rank           |double    | Rank - weight according to MyAnimeList formula          |
|popularity     |double    |  based on how many members/users have the respective anime in their list          |
|members        |double    | number members that added this anime in their list         |
|favorites      |double    | number members that favorites these in their list          |
|synopsis       |character | long string with anime synopsis          |
|background     |character | long string with production background and other things          |
|premiered      |character | anime premiered on season/year          |
|broadcast      |character | when is (regularly) broadcasted         |
|related        |character | dictionary: related animes, series, games etc.         |

### Cleaning Script

```
library(tidyverse)
library(here)

raw_df <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-23/raw_anime.csv")

clean_df <- raw_df %>% 
  # Producers
  mutate(producers = str_remove(producers, "\\["),
         producers = str_remove(producers, "\\]")) %>% 
  separate_rows(producers, sep = ",") %>% 
  mutate(producers = str_remove(producers, "\\'"),
         producers = str_remove(producers, "\\'"),
         producers = str_trim(producers)) %>% 
  # Genre
  mutate(genre = str_remove(genre, "\\["),
         genre = str_remove(genre, "\\]")) %>% 
  separate_rows(genre, sep = ",") %>% 
  mutate(genre = str_remove(genre, "\\'"),
         genre = str_remove(genre, "\\'"),
         genre = str_trim(genre)) %>% 
  # Studio
  mutate(studio = str_remove(studio, "\\["),
         studio = str_remove(studio, "\\]")) %>% 
  separate_rows(studio, sep = ",") %>% 
  mutate(studio = str_remove(studio, "\\'"),
         studio = str_remove(studio, "\\'"),
         studio = str_trim(studio)) %>% 
  # Aired
  mutate(aired = str_remove(aired, "\\{"),
         aired = str_remove(aired, "\\}"),
         aired = str_remove(aired, "'from': "),
         aired = str_remove(aired, "'to': "),
         aired = word(aired, start = 1, 2, sep = ",")) %>% 
  separate(aired, into = c("start_date", "end_date"), sep = ",") %>% 
  mutate(start_date = str_remove_all(start_date, "'"),
         start_date = str_sub(start_date, 1, 10),
         end_date = str_remove_all(start_date, "'"),
         end_date = str_sub(end_date, 1, 10)) %>%
  mutate(start_date = lubridate::ymd(start_date),
         end_date = lubridate::ymd(end_date)) %>% 
  # Drop unranked or unpopular series
  filter(rank != 0,
         popularity != 0)

write_csv(clean_df, here("2019", "2019-04-22", "tidy_anime.csv"))
raw_df %>% write_csv(here("2019", "2019-04-22", "raw_anime.csv"))
```
