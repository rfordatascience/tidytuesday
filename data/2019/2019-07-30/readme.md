# Video Games Dataset

This week's data comes courtesy of [Liza Wood](https://twitter.com/brightcdns/status/1154140218154352640?s=20) via [Steam Spy](https://steamspy.com/year/). She recently published a [blog post](https://cruiseofdimensionality.home.blog/2019/07/24/pc-video-games-we-still-play/) on her data analysis of this video game data.

She was kind enough to provide a fairly clean dataset, and I have done some small additional clean up seen below.

There is time played, ownership, release date, publishing information, and for some a metascore! Lots of ways to slice and dice this data!

### Warning 

Please be advised that the average and median playtime is over the last two weeks, as such there are many many games where playtime is low or zero.

# Get the data!


```
video_games <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-30/video_games.csv")

```

# Data Dictionary

### `video_games.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|number           |double    | Game number |
|game             |character | Game Title |
|release_date     |character | Release date |
|price            |double    | US Dollars + Cents |
|owners           |character | Estimated number of people owning this game.|
|developer      |character | Group that developed the game |
|publisher      |character | Group that published the game |
|average_playtime |double    | Average playtime in minutes |
|median_playtime  |double    | Median playtime in minutes |
|metascore        |double    | Metascore rating |

```{r}
library(tidyverse)

# clean dataset from lizawood's github
url <- "https://raw.githubusercontent.com/lizawood/apps-and-games/master/PC_Games/PCgames_2004_2018_raw.csv"

# read in raw data
raw_df <- url %>% 
  read_csv() %>% 
  janitor::clean_names() 

# clean up some of the factors and playtime data
clean_df <- raw_df %>% 
  mutate(price = as.numeric(price),
         score_rank = word(score_rank_userscore_metascore, 1),
         average_playtime = word(playtime_median, 1),
         median_playtime = word(playtime_median, 2),
         median_playtime = str_remove(median_playtime, "\\("),
         median_playtime = str_remove(median_playtime, "\\)"),
         average_playtime = 60 * as.numeric(str_sub(average_playtime, 1, 2)) +
           as.numeric(str_sub(average_playtime, 4, 5)),
         median_playtime = 60 * as.numeric(str_sub(median_playtime, 1, 2)) +
           as.numeric(str_sub(median_playtime, 4, 5)),
         metascore = as.double(str_sub(score_rank_userscore_metascore, start = -4, end = -3))) %>% 
  select(-score_rank_userscore_metascore, -score_rank, -playtime_median) %>% 
  rename(publisher = publisher_s, developer = developer_s)

```

