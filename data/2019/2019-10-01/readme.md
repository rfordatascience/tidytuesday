# Pizza Party!

This week's data is from [Jared Lander](https://twitter.com/jaredlander/status/1178122846419193858?s=20) and Barstool Sports via [Tyler Richards](https://github.com/tylerjrichards/Barstool_Pizza).

Credit for this week's concept goes to [Ludmila](https://twitter.com/ludmila_janda) who did a recent dataviz presentation and gave shoutouts to both `#tidytuesday` and a pizza dataset!

Check out her DataViz video and slides at her [GitHub](https://github.com/ljanda/nyhackr_talk_2019_09_19)

Jared's data is from top NY pizza restaurants, with a 6 point likert scale survey on ratings. The Barstool sports dataset has critic, public, and the Barstool Staff's rating as well as pricing, location, and geo-location. There are 22 pizza places that overlap between the two datasets.

If you want to look more at geo-location of pizza places, checkout this one from [DataFiniti](https://www.kaggle.com/datafiniti/pizza-restaurants-and-the-pizza-they-sell). This includes 10000 pizza places, their price ranges and geo-locations.

# Get the data!

```
pizza_jared <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-01/pizza_jared.csv")
pizza_barstool <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-01/pizza_barstool.csv")
pizza_datafiniti <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-01/pizza_datafiniti.csv")
```

# Data Dictionary

## `pizza_jared.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|polla_qid   |integer   | Quiz ID |
|answer      |character | Answer (likert scale) |
|votes       |integer   | Number of votes for that question/answer combo |
|pollq_id    |integer   | Poll Question ID |
|question    |character | Question |
|place       |character | Pizza Place |
|time        |integer   | Time of quiz |
|total_votes |integer   | Total number of votes for that pizza place |
|percent     |double    | Vote percent of total for that pizza place |

## `pizza_barstool.csv`

|variable                             |class     |description |
|:------------------------------------|:---------|:-----------|
|name                                 |character | Pizza place name |
|address1                             |character | Pizza place address |
|city                                 |character | City |
|zip                                  |double    | Zip |
|country                              |character | Country |
|latitude                             |double    | Latitude |
|longitude                            |double    | Longitude |
|price_level                          |double    | Price rating (fewer `$` = cheaper, more `$$$` = expensive) |
|provider_rating                      |double    | Provider review score |
|provider_review_count                |double    | Provider review count |
|review_stats_all_average_score       |double    | Average Score |
|review_stats_all_count               |double    | Count of all reviews |
|review_stats_all_total_score         |double    | Review total score |
|review_stats_community_average_score |double    | Community average score |
|review_stats_community_count         |double    | community review count |
|review_stats_community_total_score   |double    | community review total score |
|review_stats_critic_average_score    |double    | Critic average score |
|review_stats_critic_count            |double    | Critic review count|
|review_stats_critic_total_score      |double    | Critic total score |
|review_stats_dave_average_score      |double    | Dave (Barstool) average score|
|review_stats_dave_count              |double    | Dave review count |
|review_stats_dave_total_score        |double    | Dave total score |

## `pizza_datafiniti.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|name            |character | Pizza place |
|address         |character | Address |
|city            |character | City |
|country         |character | Country |
|province        |character | State |
|latitude        |double    | Latitude|
|longitude       |double    | Longitude |
|categories      |character | Restaurant category |
|price_range_min |double    | Price range min |
|price_range_max |double    | Price range max|


# Cleaning Script

```
library(tidyverse)
library(jsonlite)

# Get barstool data off github
pizza_raw <- read_csv("https://raw.githubusercontent.com/tylerjrichards/Barstool_Pizza/master/pizza_data.csv")

pizza_cooked <- pizza_raw %>% 
  select(name, address1, city, zip, country, latitude, longitude, priceLevel, 
         providerRating, providerReviewCount, 
         reviewStats.all.averageScore:reviewStats.dave.totalScore) %>% 
  janitor::clean_names()

# Get jared data off his website (json)

url <- "https://jaredlander.com/data/PizzaPollData.php"

jared_pizza <- fromJSON(readLines(url), flatten = TRUE) %>% 
  as_tibble() %>% 
  janitor::clean_names()

write_csv(jared_pizza, here::here("2019", "2019-10-01", "pizza_jared.csv"))

write_csv(pizza_cooked, here::here("2019", "2019-10-01", "pizza_barstool.csv"))
```
