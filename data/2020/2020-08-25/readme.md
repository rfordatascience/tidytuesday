![](http://choppedcasting.com/images/logo.jpg)

# Chopped

The data this week comes from [Kaggle](https://www.kaggle.com/jeffreybraun/chopped-10-years-of-episode-data) courtesy of Jeffrey Braun with a h/t to: [Nick Wan](https://twitter.com/nickwan/status/1291586894145490944?s=20).

Chopped season ratings from [IMDB](https://www.imdb.com/title/tt1353281/episodes?ref_=tt_eps_sn_mr) and meta-info on [Wikipedia](https://en.wikipedia.org/wiki/Chopped_(TV_series)).

> Chopped is an American reality-based cooking television game show series. It is hosted by Ted Allen. The series pits four chefs against each other as they compete for a chance to win $10,000.
>
> In each episode, four chefs compete in a three-round contest, where they attempt to incorporate unusual combinations of ingredients into dishes that are later evaluated by a panel of three judges. At the beginning of each round (typically "Appetizer", "Entrée", and "Dessert", but with occasional exceptions), the chefs are each given a basket containing four mystery ingredients and are expected to create dishes that use all of them in some way. Although failing to use an ingredient is not an automatic disqualification, the judges do take such omissions into account when making their decisions. The ingredients are often not commonly prepared together. The chefs are given unlimited access to a pantry and refrigerator stocked with a wide variety of other ingredients, and each chef has his/her own stations for preparing and cooking food. The kitchen also includes a variety of specialized tools and equipment for the chefs' use, such as a deep fryer, a blast chiller, and an ice cream machine.
>
> Each round has a time limit, typically 20 minutes for Appetizer, and 30 minutes each for Entrée and Dessert. These limits have been extended on occasion for special-format episodes and for rounds in which one or more mystery ingredients require additional preparation/cooking time. The chefs must cook their dishes and complete four platings (three for the judges and one "beauty plate") before time runs out. Once time has expired, the judges critique the dishes based on presentation, taste and creativity and select one chef to be "chopped" - eliminated from the competition with no winnings. Allen reveals the judges' decision by lifting a cloche on their table to show the losing chef's dish, and one of the judges comments on the reason for their choice to the eliminated chef. In the Dessert round, the judges consider not only the dishes created by the two chefs during that round, but also their overall performance throughout the competition. The winner receives $10,000, although in special competitions, winners can earn anywhere between $20,000 to $50,000.

Note the data was joined from two different sources, and there are episodes where the ratings are missing from IMBD.


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-08-25')
tuesdata <- tidytuesdayR::tt_load(2020, week = 35)

chopped <- tuesdata$chopped

# Or read in the data manually

chopped <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-25/chopped.tsv')

```
### Data Dictionary

# `chopped.tsv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|season           |double    | Season Number |
|season_episode   |double    | Episode number within a season |
|series_episode   |double    | Episode number as part of the entire series |
|episode_rating   |double    | IMDB sourced episode rating 0-10 scale |
|episode_name     |character | Episode Name|
|episode_notes    |character | Episode notes |
|air_date         |character | Episode air date|
|judge1           |character | Judge 1 Name|
|judge2           |character | Judge 2 Name |
|judge3           |character | Judge 3 Name |
|appetizer        |character | Appetizer ingredients|
|entree           |character | Entree ingredients|
|dessert          |character | Dessert ingredients |
|contestant1      |character | Contestant 1 name |
|contestant1_info |character | Contestant 1 Info|
|contestant2      |character | Contestant 2 name |
|contestant2_info |character | Contestant 2 Info|
|contestant3      |character | Contestant 3 name |
|contestant3_info |character | Contestant 3 Info|
|contestant4      |character | Contestant 4 name |
|contestant4_info |character | Contestant 4 Info|

### Cleaning Script

```{r}
library(glue)
library(tidyverse)
library(rvest)

create_tidytuesday_folder()

raw_df <- read_csv("2020/2020-08-25/chopped-raw.csv") %>% 
  mutate(episode_name = str_remove_all(episode_name, '"'))

raw_df

# Scrape IMDB -------------------------------------------------------------


test_url <- "https://www.imdb.com/title/tt1353281/episodes?season=1"


get_imdb_data <- function(season){
  
  # be nice
  Sys.sleep(1)
  cat(
    glue::glue("Scraping S{season}!"),
    "\n"
    )
  
  raw_url <- glue::glue("https://www.imdb.com/title/tt1353281/episodes?season={season}&ref_=ttep_ep_sn_nx")
  
  raw_html <- raw_url %>% 
    read_html()
  
  raw_eps <- raw_html %>% 
    html_nodes("#episodes_content > div.clear > div.list.detail.eplist") %>% 
    html_nodes("div.list_item")
  
  ep_ct <- if (season != 1) {
    1:(length(raw_eps))
  } else {
    2:(length(raw_eps))
  } 
  
  get_airdate <- function(scrape_number){
    raw_eps[[scrape_number]] %>% 
      html_node("div.airdate") %>% 
      html_text() %>% 
      str_squish() %>% 
      str_remove_all("\n")
  }
  
  get_title <- function(scrape_number){
    raw_eps[[scrape_number]] %>% 
      html_node("div.info > strong > a") %>%
      html_attr("title")
  }
  
  get_rating <- function(scrape_number){
    raw_eps[[scrape_number]] %>% 
      html_node("span.ipl-rating-star__rating") %>% 
      html_text() %>% 
      as.double()
  }
  
  get_description <- function(scrape_number){
    raw_eps[[scrape_number]] %>% 
      html_node("div.item_description") %>% 
      html_text() %>% 
      str_remove_all("\n") %>% 
      str_squish()
  }
  
  get_episode <- function(scrape_number){
    raw_eps[[scrape_number]] %>% 
      html_node("div.image") %>% 
      html_text() %>% 
      str_remove_all("\n") %>% 
      str_remove("Add Image ") %>% 
      str_squish()
  }
  
  tibble(
    scrape_number = ep_ct
  ) %>% 
    mutate(
      air_date = map_chr(scrape_number, get_airdate),
      episode_title = map_chr(scrape_number, get_title),
      episode_rating = map_dbl(scrape_number, get_rating),
      episode_description = map_chr(scrape_number, get_description),
      ep_num = map_chr(scrape_number, get_episode)
    ) %>% 
    separate(ep_num, into = c("season_num", "episode_num"), sep = ", Ep") %>% 
    mutate(season = str_remove(season_num, "S") %>% as.integer(),
           episode = as.integer(episode_num),
           air_date = lubridate::dmy(air_date)) %>% 
    select(season, episode, air_date:episode_description)

}

# scrape all the IMDB data
all_ep_ratings <- map_dfr(1:45, get_imdb_data)

joined_df <- raw_df %>% 
  left_join(all_ep_ratings %>% 
              select(season, season_episode = episode, episode_rating),
            by = c("season", "season_episode")) %>% 
  mutate(episode_rating = if_else(episode_rating == 0, NA_real_, episode_rating)) %>% 
  select(season:series_episode, episode_rating, everything())

joined_df %>% 
  write_tsv("2020/2020-08-25/chopped.tsv")

glimpse(joined_df)

joined_df %>% 
  ggplot(aes(x = series_episode, y = season_episode)) +
  geom_point()

joined_df %>% 
  ggplot(aes(x = series_episode, y = episode_rating)) +
  geom_point() +
  geom_smooth()

```