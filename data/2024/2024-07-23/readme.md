# American Idol data

This week we're exploring American Idol data! This is a [comprehensive dataset](https://github.com/kkakey/American_Idol/tree/main) put together by [kkakey](https://github.com/kkakey).

There's so much data! What do you want to know about American Idol? Song choices, TV ratings, characteristics of winners?

>Data in this dataset comes from [Wikipedia](https://www.wikipedia.org/). Data collected on seasons 1-18 of American Idol.

>The Datasets
> * `songs.csv` - songs that contestants sang and competed with on American Idol from seasons 1-18
> * `auditions.csv` - audition, cities, dates, and venues
> * `elimination_chart.csv` - eliminations by week. Data availability varies season-to-season based on season length and number of finalists competing
> * `finalists.csv` - information on top contestants, including birthday, hometown, and description
> * `ratings.csv` - episode ratings and views.
> * `seasons.csv` - season-level information, including season winner, runner-up, release dates, and judges



## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-07-23')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 30)

auditions <- tuesdata$auditions
eliminations <- tuesdata$eliminations
finalists <- tuesdata$finalists
ratings <- tuesdata$ratings
seasons <- tuesdata$seasons
songs <- tuesdata$songs

# Option 2: Read directly from GitHub

auditions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/auditions.csv')
eliminations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/eliminations.csv')
finalists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/finalists.csv')
ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/ratings.csv')
seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/seasons.csv')
songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-23/songs.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `auditions.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|season               |double    |Season               |
|audition_date_start  |double    |Start date of audition  |
|audition_date_end    |double    |End date of audition   |
|audition_city        |character |City where audition took place  |
|audition_venue       |character |Preliminary location where auditions took place   |
|episodes             |character |Episode numbers at this audition location     |
|episode_air_date     |character |Date episode aired    |
|callback_venue       |character |Filming and callback location where auditions took place |
|callback_date_start  |double    |Start date of callback audition  |
|callback_date_end    |double    |End date of callback audition |
|tickets_to_hollywood |double    |Number of contestants selected from audition to go to Hollywood week |
|guest_judge          |character |Name of guest judge at audition   |

# `eliminations.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|season     |double    |Season Number      |
|place      |character |Place (or place range) contestant finished in competition     |
|gender     |character |Gender of contestant   |
|contestant |character |Competitor name |
|top_36     |character |Top 36 eliminations    |
|top_36_2   |character |Top 36 eliminations (week 2)  |
|top_36_3   |character |Top 36 eliminations (week 3) |
|top_36_4   |character |Top 36 eliminations (week 4) |
|top_32     |character |Top 32 eliminations |
|top_32_2   |character |Top 32 eliminations (week 2) |
|top_32_3   |character |Top 32 eliminations (week 3)  |
|top_32_4   |character |Top 32 eliminations (week 4)  |
|top_30     |character |Top 30 eliminations   |
|top_30_2   |character |Top 30 eliminations (week 2) |
|top_30_3   |character |Top 30 eliminations (week 3) |
|top_25     |character |Top 25 eliminations |
|top_25_2   |character |Top 25 eliminations (week 2)  |
|top_25_3   |character |Top 25 eliminations (week 3) |
|top_24     |character |Top 24 eliminations |
|top_24_2   |character |Top 24 eliminations (week 2)  |
|top_24_3   |character |Top 24 eliminations (week 3)|
|top_20     |character |Top 20 eliminations |
|top_20_2   |character |Top 20 eliminations (week 2) |
|top_16     |character |Top 16 eliminations  |
|top_14     |character |Top 14 eliminations |
|top_13     |character |Top 13 eliminations  |
|top_12     |character |Top 12 eliminations |
|top_11     |character |Top 11 eliminations |
|top_11_2   |character |Top 11 eliminations (week 2)  |
|wildcard   |character |Wildcard week eliminations |
|comeback   |logical   |Comeback week eliminations |
|top_10     |character |Top 10 eliminations  |
|top_9      |character |Top 9 eliminations |
|top_9_2    |character |Top 9 eliminations (week 2) |
|top_8      |character |Top 8 eliminations |
|top_8_2    |character |Top 8 eliminations (week 2) |
|top_7      |character |Top 7 eliminations |
|top_7_2    |character |Top 7 eliminations (week 2) |
|top_6      |character |Top 6 eliminations  |
|top_6_2    |character |Top 6 eliminations (week 2) |
|top_5      |character |Top 5 eliminations  |
|top_5_2    |character |Top 5 eliminations (week 2)|
|top_4      |character |Top 4 eliminations |
|top_4_2    |character |Top 4 eliminations (week 2) |
|top_3      |character |Top 3 eliminations   |
|finale     |character |Finale eliminations  |

# `finalists.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|Contestant  |character |Name of contestant |
|Birthday    |character |Contestant's birthday  |
|Birthplace  |character |Contestant's city of birth |
|Hometown    |character |Contestant's hometown  |
|Description |character |Description of contestant |
|Season      |double    |Season      |

# `ratings.csv`

|variable                |class     |description             |
|:-----------------------|:---------|:-----------------------|
|season                  |double    |Season                  |
|show_number             |double    |Episode number in season     |
|episode                 |character |Episode name                 |
|airdate                 |character |Date episode aired          |
|18_49_rating_share      |character |Percentage of adults aged 18-49 estimated to have watched the episode (Nielsen TV ratings). |
|viewers_in_millions     |double    |Number (in millions) that watched the episode |
|timeslot_et             |character |Episode timeslot in Eastern Time     |
|dvr_18_49               |character |Percentage of adults aged 18-19 estimated to have watched the episode on DVR     |
|dvr_viewers_millions    |character |Number (in millions) that watched the episode on DVR  |
|total_18_49             |character |Total percentage of adults aged 18-49 estimated to have watched the episode    |
|total_viewers_millions  |character |Total number of viewers (in millions). |
|weekrank                |character |Ranking of episode performance by season            |
|ref                     |logical   |Reference                    |
|share                   |character |share  (unused)   |
|nightlyrank             |double    |Nightly ranking        |
|rating_share_households |character |Ranking per share of households. |
|rating_share            |character |Ratings share.         |

# `seasons.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|season           |double    |Season           |
|winner           |character |Name of winner           |
|runner_up        |character |Name of runner_up        |
|original_release |character |Original air dates |
|original_network |character |Network aired on |
|hosted_by        |character |Host's name        |
|judges           |character |Name of judges           |
|no_of_episodes   |double    |Episode name   |
|finals_venue     |character |Venue of finale     |
|mentor           |character |Name of season mentor           |

# `songs.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|season     |character |Season Number    |
|week       |character |Week date and week description        |
|order      |double    |Order contestants sang in |
|contestant |character |Competitor name |
|song       |character |Name of song sung     |
|artist     |character |Name of song's artist (imputed if not explicitly listed)  |
|song_theme |character |Week theme for songs sung |
|result     |character |Contestant's elimination status for the week |

### Cleaning Script

```r
# Clean data provided by <https://github.com/kkakey/American_Idol>. No cleaning was necessary.
auditions <- readr::read_csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/metadata/auditions.csv")
eliminations <- readr::read_csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/metadata/elimination_chart.csv")
finalists <- readr::read_csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/metadata/finalists.csv")
ratings <- readr::read_csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/metadata/ratings.csv")
seasons <- readr::read_csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/metadata/seasons.csv")
songs <- readr::read_csv("https://raw.githubusercontent.com/kkakey/American_Idol/main/Songs/songs_all.csv")




```
