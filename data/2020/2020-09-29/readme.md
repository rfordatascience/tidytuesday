![](https://akns-images.eonline.com/eol_images/Entire_Site/2019721/rs_1024x759-190821125112-1024.taylor-swift-beyonce-2009-mtv-vmas.ct.082119.jpg?fit=around|1024:auto&output-quality=90&crop=1024:auto;center,top)

# Beyoncé and Taylor Swift Lyrics

The data this week comes from [Rosie Baillie](https://twitter.com/Rosie_Baillie_) and [Dr. Sara Stoudt](https://twitter.com/sastoudt).

Beyoncé's top 100 - [Billboard](https://www.billboard.com/articles/business/chart-beat/9432973/beyonce-albums-biggest-hits).
Taylor Swift's top 100 - [Billboard](https://www.billboard.com/articles/columns/pop/9429647/taylor-swift-highest-charting-hot-100-hit-every-album).

Rosie put together a wonderful analysis of [Taylor Swift lyrics](https://rpubs.com/RosieB/taylorswiftlyricanalysis)! Can you do some similar work with Beyoncé's work?

Text analysis guides in [`tidytext`](https://www.tidytextmining.com/tidytext.html) or [`Supervised Machine Learning for Text Analysis in R`](https://smltar.com/).

The [beyonce palettes R pkg](https://github.com/dill/beyonce).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-29')
tuesdata <- tidytuesdayR::tt_load(2020, week = 40)

beyonce_lyrics <- tuesdata$beyonce_lyrics

# Or read in the data manually

beyonce_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/beyonce_lyrics.csv')
taylor_swift_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/taylor_swift_lyrics.csv')
sales <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/sales.csv')
charts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/charts.csv')

```
### Data Dictionary

# `beyonce_lyrics.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|line        |character |Lyric line |
|song_id     |double    | Song ID |
|song_name   |character | Song Name|
|artist_id   |double    | Artist ID |
|artist_name |character | Artist Name |
|song_line   |double    | Song line number |

# `taylor_swift_lyrics.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|Artist   |character | Artist|
|Album    |character | Album name |
|Title    |character | Title of song|
|Lyrics   |character | Lyrics |

# `sales.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|artist     |character |Artist name |
|title      |character | Song title |
|country    |character | Country for sales |
|sales      |double    | Sales in dollars |
|released   |character | released date |
|re_release |character | Re-released date |
|label      |character | Label released under |
|formats    |character | Formats released as |

# `charts.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|artist     |character |Artist name |
|title      |character | Song title |
|released   |character | released date |
|re_release |character | Re-released date |
|label      |character | Label released under |
|formats    |character | Formats released as |
|chart          |character | Country Chart|
|chart_position |character | Highest Chart position|

### Cleaning Script

```{r}
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

write_csv(all_sales, "2020/2020-09-29/sales.csv")
write_csv(all_charts, "2020/2020-09-29/charts.csv")
```