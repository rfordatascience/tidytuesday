library(tidyverse)
library(rvest)

season <- 1

get_imdb <- function(season){
  url <- glue::glue("https://www.imdb.com/title/tt0436992/episodes?season={season}")
  
  raw_html <- read_html(url)
  
  raw_div <- raw_html %>% 
    html_elements("div.list.detail.eplist") %>% 
    html_elements("div.info")
  
  ep_num <- raw_div %>% 
    html_elements("meta") %>% 
    html_attr("content")
  
  air_date <- raw_div %>% 
    html_elements("div.airdate") %>% 
    html_text() %>% 
    str_squish()
  
  ratings <- raw_div %>% 
    html_elements("div.ipl-rating-star.small > span.ipl-rating-star__rating") %>% 
    html_text()
  rate_ct <- raw_div %>% 
    html_elements("div.ipl-rating-star.small > span.ipl-rating-star__total-votes")%>% 
    html_text() %>% 
    str_remove_all("\\(|\\)|,")
  
  descrip <- raw_div %>% 
    html_elements("div.item_description") %>% 
    html_text() %>% 
    str_squish()
  
  tibble(
    season = season,
    ep_num = ep_num,
    air_date = air_date,
    rating = ratings, rating_n = rate_ct, desc = descrip)
  
}

all_season <- 1:12 %>% 
  map_dfr(get_imdb)

clean_season <- all_season %>% 
  type_convert()
