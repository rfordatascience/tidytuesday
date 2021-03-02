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

