library(tidyverse)
library(rvest)

url <- "https://en.wikipedia.org/wiki/List_of_highest-grossing_media_franchises"

df <- url %>% 
  read_html() %>% 
  html_table(fill = TRUE) %>% 
  .[[2]]

clean_money <- df %>% 
  set_names(nm = c("franchise", "year_created", "total_revenue", "revenue_items",
                   "original_media", "creators", "owners")) %>% 
  mutate(total_revenue = str_remove(total_revenue, "est."),
         total_revenue = str_trim(total_revenue),
         total_revenue = str_remove(total_revenue, "[$]"),
         total_revenue = word(total_revenue, 1, 1),
         total_revenue = as.double(total_revenue))

clean_category <- clean_money %>% 
  separate_rows(revenue_items, sep = "\\[") %>% 
  filter(str_detect(revenue_items, "illion")) %>% 
  separate(revenue_items, into = c("revenue_category", "revenue"), sep = "[$]") %>% 
  mutate(revenue_category = str_remove(revenue_category, " – "),
         revenue_category = str_remove(revenue_category, regex(".*\\]")),
         revenue_category = str_remove(revenue_category, "\n")) 

clean_df <- clean_category %>% 
  mutate(revenue_category = case_when(
    str_detect(str_to_lower(revenue_category), "box office") ~ "Box Office",
    str_detect(str_to_lower(revenue_category), "dvd|blu|vhs|home video|video rentals|video sales|streaming|home entertainment") ~ "Home Video/Entertainment",
    str_detect(str_to_lower(revenue_category), "video game|computer game|mobile game|console|game|pachinko|pet|card") ~ "Video Games/Games",
    str_detect(str_to_lower(revenue_category), "comic|manga") ~ "Comic or Manga",
    str_detect(str_to_lower(revenue_category), "music|soundtrack") ~ "Music",
    str_detect(str_to_lower(revenue_category), "tv") ~ "TV",
    str_detect(str_to_lower(revenue_category), "merchandise|licens|mall|stage|retail") ~ "Merchandise, Licensing & Retail",
    
    TRUE ~ revenue_category)) %>% 
  mutate(revenue = str_remove(revenue, "illion"),
         revenue = str_trim(revenue),
         revenue = str_remove(revenue, " "),
         revenue = case_when(str_detect(revenue, "m") ~ paste0(str_extract(revenue, "[:digit:]+"), "e-3"),
                             str_detect(revenue, "b") ~ str_extract(revenue, "[:digit:]+"),
                             TRUE ~ NA_character_),
         revenue = format(revenue, scientific = FALSE),
         revenue = parse_number(revenue)) %>%
  mutate(original_media = str_remove(original_media, "\\[.+")) 

sum_df <- clean_df %>%
  group_by(franchise, revenue_category) %>% 
  summarize(revenue = sum(revenue))

total_sum_df <- clean_df %>% 
  group_by(franchise) %>% 
  summarize(revenue = sum(revenue)) %>% 
  arrange(desc(revenue))

metadata_df <- clean_df %>% 
  select(franchise:revenue_category, original_media:owners, -total_revenue)

final_df <- left_join(sum_df, metadata_df, 
                      by = c("franchise", "revenue_category")) %>% 
  distinct(.keep_all = TRUE)

final_df
write_csv(final_df, "media_franchises.csv")
