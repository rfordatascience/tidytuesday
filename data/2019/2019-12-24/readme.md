# Christmas Music Billboards

This week's data is about Christmas songs on the hot-100 list! Clean data comes from [Kaggle](https://www.kaggle.com/sharkbait1223/billboard-top-100-christmas-carol-dataset) and originally from [data.world](https://data.world/kcmillersean/billboard-hot-100-1958-2017).

The lyrics come courtest of Josiah Parry's [`genius`](https://github.com/josiahparry/genius) R package. It has several useful functions, mainly built around grabbing lyrics for specific artists, songs, or albums.

# Get the Data

```
christmas_songs <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-24/christmas_songs.csv")

christmas_lyrics <- readr::read_tsv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-24/christmas_lyrics.tsv")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!
# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load("2019-12-24")
tuesdata <- tidytuesdayR::tt_load(2019, week = 52)

christmas_songs <- tuesdata$christmas_songs
```

# Dictionary


### `christmas_songs.csv`

|variable               |class     |description |
|:----------------------|:---------|:-----------|
|url                    |character | URL of billboard chart|
|weekid                 |date | Date, Month Day Year|
|week_position          |double    | Week position (higher = better)|
|song                   |character |Song Title|
|performer              |character | Artist |
|songid                 |character | Song ID|
|instance               |double    | Instances on billboard |
|previous_week_position |double    | Previous week's position on billboard |
|peak_position          |double    | Highest position |
|weeks_on_chart         |double    | Number of weeks on billboard charts |
|year                   |double    | year|
|month                  |double    | month|
|day                    |double    | day |

### `christmas_lyrics.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|title       |character | Song title (same as song) |
|artist      |character | Artist (same as performer) |
|songid      |character | songid - join via this column |
|weekid      |date | date|
|track_title |character | Track title |
|track_n     |integer   | Track number |
|line        |integer   | Line number |
|lyric       |character | Lyric text |

```{r}
library(tidyverse)
library(genius)

df <- read_csv(here("2019", "2019-12-24", "christmas_songs.csv"))

lyric_df <- df %>% 
  select("title" = song,
         "artist" = performer,
         songid,
         weekid) %>% 
  add_genius(artist = artist, title = title) %>% 
  select(-lyrics)

lyric_clean %>% 
  write_tsv(here("2019", "2019-12-24","christmas_lyrics.tsv"))

```
