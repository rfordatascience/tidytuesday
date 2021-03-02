![](https://projects.fivethirtyeight.com/super-bowl-ads/images/SUPER-BOWL-ADS-Topper.png?v=7e5791e9)

# Superbowl commercials

The data this week comes from [FiveThirtyEight](https://github.com/fivethirtyeight/superbowl-ads). They have a corresponding [article](https://projects.fivethirtyeight.com/super-bowl-ads/) on the topic. Note that the original source was [superbowl-ads.com](https://superbowl-ads.com/). You can watch all the ads via the FiveThirtyEight article above.

> Like millions of viewers who tune into the big game year after year, we at FiveThirtyEight LOVE Super Bowl commercials. We love them so much, in fact, that we wanted to know everything about them … by analyzing and categorizing them, of course. We dug into the defining characteristics of a Super Bowl ad, then grouped commercials based on which criteria they shared — and let me tell you, we found some really weird clusters of commercials.
> 
> We watched 233 ads from the 10 brands that aired the most spots in all 21 Super Bowls this century, according to superbowl-ads.com.1 While we watched, we evaluated ads using seven specific criteria, marking every spot as a "yes" or "no" for each:

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-02')
tuesdata <- tidytuesdayR::tt_load(2021, week = 10)

youtube <- tuesdata$youtube

# Or read in the data manually

youtube <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-02/youtube.csv')

```
### Data Dictionary

# `youtube.csv`

|variable                  |class     |description |
|:-------------------------|:---------|:-----------|
|year                      |double    | Superbowl year |
|brand                     |character | Brand for commercial |
|superbowl_ads_dot_com_url |character | Superbowl ad URL |
|youtube_url               |character | Youtube URL |
|funny                     |logical   | Contains humor |
|show_product_quickly      |logical   | Shows product quickly |
|patriotic                 |logical   | Patriotic |
|celebrity                 |logical   | Contains celebrity |
|danger                    |logical   | Contains danger |
|animals                   |logical   | Contains animals |
|use_sex                   |logical   | Uses sexuality |
|id                        |character | Youtube ID |
|kind                      |character | Youtube Kind |
|etag                      |character | Youtube etag |
|view_count                |integer   | Youtube view count |
|like_count                |integer   | Youtube like count |
|dislike_count             |integer   | Youtube dislike count |
|favorite_count            |integer   | Youtube favorite count |
|comment_count             |integer   | Youtube comment count |
|published_at              |character | Youtube when published |
|title                     |character | Youtube title |
|description               |character | Youtube description |
|thumbnail                 |character | Youtube thumbnail |
|channel_title             |character | Youtube channel name |
|category_id               |character | Youtube content category id |

### Cleaning Script

Note this is optional, and NOT required. I downloaded the youtube data via `httr` from the youtube API and an API key.

```{r}
library(tidyverse)
library(tuber)
library(rvest)
library(httr)

raw_data <- read_csv("https://raw.githubusercontent.com/fivethirtyeight/superbowl-ads/main/superbowl-ads.csv")

all_ids <-raw_data$youtube_url %>% 
  str_remove_all("https://www.youtube.com/watch") %>% 
  str_remove("\\?v=") %>% 
  str_subset("NA", negate = TRUE)

all_ids

api_key = "SUPER_SECRET_API"

get_youtube_data <- function(ids_in, query_type = "statistics"){
  
  url_in <- modify_url("https://www.googleapis.com/youtube/v3/videos", 
                     query = list(
                       "part" = query_type,
                       "id" = paste(ids_in, collapse=","),
                       "key" = api_key)
  )
  out_content <- content(GET(url_in), as = "parsed", type = "application/json")
  
  if(query_type == "statistics"){
    out_content$items %>% 
      enframe() %>% 
      unnest_wider(value) %>% 
      unnest_wider(statistics) %>% 
      janitor::clean_names()
    
  }
}

get_youtube_details <- function(ids_in){
  
  url_in <- modify_url("https://www.googleapis.com/youtube/v3/videos", 
                       query = list(
                         "part" = "snippet",
                         "id" = paste(ids_in, collapse=","),
                         "key" = api_key)
  )
  out_content <- content(GET(url_in), as = "parsed", type = "application/json")
  
  out_content$items %>% 
    enframe() %>% 
    unnest_wider(value) %>% 
    unnest_wider(snippet) %>% 
    janitor::clean_names()
}

all_vid_stats <- list(
  all_ids[1:50],
  all_ids[51:100],
  all_ids[101:150],
  all_ids[151:200],
  all_ids[200:length(all_ids)]
) %>% 
  map_dfr(get_youtube_data)

all_vid_details <- list(
    all_ids[1:50],
    all_ids[51:100],
    all_ids[101:150],
    all_ids[151:200],
    all_ids[200:length(all_ids)]
    ) %>% 
  map_dfr(get_youtube_details)

clean_details <- all_vid_details %>% 
  hoist(thumbnails, 
        thumbnail = list("standard", "url")) %>% 
  select(id, published_at, title:category_id, -tags, -thumbnails)

combo_vid <- all_vid_stats %>% 
  left_join(clean_details) %>% 
  select(-name)

all_youtube <- raw_data %>% 
  mutate(id = str_remove(youtube_url, "https://www.youtube.com/watch") %>% 
           str_remove("\\?v=")) %>% 
  left_join(combo_vid) %>% 
  mutate(across(view_count:comment_count, as.integer)) 

write_csv(all_youtube, "2021/2021-03-02/youtube.csv")

all_youtube %>% 
  glimpse()


```