library(tidyverse)
library(rvest)

ts_url <- "https://en.wikipedia.org/wiki/Taylor_Swift_discography"

raw_ts_html <- ts_url %>% 
  read_html()

ts_raw <- raw_ts_html %>% 
  html_node("#mw-content-text > div.mw-parser-output > table:nth-child(10)") %>% 
  html_table(fill = TRUE) %>% 
  data.frame() %>% 
  janitor::clean_names() %>% 
  tibble() %>% 
  slice(-1, -nrow(.)) %>% 
  mutate(album_details = str_split(album_details, "\n"),
         sales = str_split(sales, "\n"),
  ) %>% 
  select(-certifications) %>% 
  unnest_longer(album_details)  %>% 
  separate(album_details, into = c("album_detail_type", "album_details"), sep = ": ") %>% 
  mutate(album_detail_type = if_else(album_detail_type == "Re-edition", "Re-release", album_detail_type)) %>% 
  pivot_wider(names_from = album_detail_type, values_from = album_details) %>% 
  select(-`na`) %>% 
  janitor::clean_names() 

ts_sales <- ts_raw %>% 
  unnest_longer(sales) %>% 
  separate(sales, into = c("country", "sales"), sep = ": ") %>% 
  mutate(sales = str_trim(sales),
         sales = parse_number(sales)) %>% 
  select(title, country, sales, released:formats) %>% 
  mutate(artist = "Taylor Swift", .before = title)


ts_chart <- ts_raw %>% 
  select(title, released:formats, contains("peak_chart")) %>% 
  pivot_longer(cols = contains("peak_chart"), names_to = "chart", values_to = "chart_position") %>% 
  mutate(
    chart = str_remove(chart, "peak_chart_positions"),
  chart = case_when(
    chart == "" ~ "US",
    chart == "_1" ~ "AUS",
    chart == "_2" ~ "CAN",
    chart == "_3" ~ "FRA",
    chart == "_4" ~ "GER",
    chart == "_5" ~ "IRE",
    chart == "_6" ~ "JPN",
    chart == "_7" ~ "NZ",
    chart == "_8" ~ "SWE",
    chart == "_9" ~ "UK",
    TRUE ~ NA_character_
  )
  )  %>% 
  mutate(artist = "Taylor Swift", .before = title)


# Beyonce -----------------------------------------------------------------


bey_url <- "https://en.wikipedia.org/wiki/Beyonc%C3%A9_discography"

raw_bey_html <- bey_url %>% 
  read_html()

bey_raw <- raw_bey_html %>% 
  html_node("#mw-content-text > div.mw-parser-output > table:nth-child(14)") %>% 
  #mw-content-text > div.mw-parser-output > table:nth-child(14) > tbody > tr:nth-child(3) > th > i > a
  html_table(fill = TRUE) %>% 
  data.frame() %>% 
  janitor::clean_names() %>% 
  tibble() %>% 
  slice(-1, -nrow(.)) %>% 
  mutate(album_details = str_split(album_details, "\n"),
         sales = str_split(sales, "\n"),
  ) %>% 
  select(-certifications) %>% 
  unnest_longer(album_details)  %>% 
  separate(album_details, into = c("album_detail_type", "album_details"), sep = ": ") %>% 
  mutate(album_detail_type = if_else(album_detail_type == "Re-edition", "Re-release", album_detail_type)) %>% 
  pivot_wider(names_from = album_detail_type, values_from = album_details) %>% 
  janitor::clean_names() 

bey_sales <- bey_raw %>% 
  unnest_longer(sales) %>% 
  separate(sales, into = c("country", "sales"), sep = ": ") %>% 
  mutate(sales = str_trim(sales),
         sales = parse_number(sales)) %>% 
  select(title, country, sales, released:label, formats = format)  %>% 
  mutate(artist = "Beyoncé", .before = title)

bey_chart <- bey_raw %>% 
  select(title, released:label, formats = format, contains("peak_chart")) %>% 
  pivot_longer(cols = contains("peak_chart"), names_to = "chart", values_to = "chart_position") %>% 
  mutate(
    chart = str_remove(chart, "peak_chart_positions"),
    chart = case_when(
      chart == "" ~ "US",
      chart == "_1" ~ "AUS",
      chart == "_2" ~ "CAN",
      chart == "_3" ~ "FRA",
      chart == "_4" ~ "GER",
      chart == "_5" ~ "IRE",
      chart == "_6" ~ "JPN",
      chart == "_7" ~ "NZ",
      chart == "_8" ~ "SWE",
      chart == "_9" ~ "UK",
      TRUE ~ NA_character_
    )
  ) %>% 
  mutate(artist = "Beyoncé", .before = title)

all_sales <- bind_rows(ts_sales, bey_sales)
all_charts <- bind_rows(ts_chart, bey_chart)


# Albums ------------------------------------------------------------------

song_url <- "https://en.wikipedia.org/wiki/List_of_songs_recorded_by_Beyonc%C3%A9"

raw_song <- song_url %>% 
  read_html() %>% 
  html_table(fill = TRUE)

albums <- raw_song[[2]] %>% 
  tibble() %>% 
  janitor::clean_names() %>% 
  mutate(song = str_extract(song, '(?<=").*?(?=")')) %>% 
  select(song, artist = artist_s, album = 4) %>% 
  mutate(artist = "Beyoncé") %>% 
  # filter(str_detect(album, paste0(c("Dangerously in Love", "B'Day", "I Am... Sasha Fierce", "4", "Beyoncé", "Lemonade"), collapse = "|"))) %>% 
  # filter(str_detect(album, ":|2004", negate = TRUE)) %>% 
  mutate(album = str_remove(album, "\\*"))

raw_lyrics <- read_csv("https://gist.githubusercontent.com/sastoudt/cdc16a5a19cf9ae34db0231782231f27/raw/aa274f6c29273942dee5da34cb6c6a23ec67c8c8/beyLyricsNice.csv")

raw_lyrics %>% 
  left_join(albums, by = c("artist_name" = "artist", "song_name" = "song"))

