# Doctor Who Episodes

Doctor Who is an extremely long-running British television program.
The show was revived in 2005, and has proven very popular since then.
To celebrate this year's 60th anniversary of Doctor Who, we have three datasets.

The data this week comes from Wikipedia's [List of Doctor Who episodes](https://en.wikipedia.org/wiki/List_of_Doctor_Who_episodes_(2005%E2%80%93present) via the [{datardis} package](https://cran.r-project.org/package=datardis) by [Jonathan Kitt](https://github.com/KittJonathan/datardis).
Thank you to Jonathan for compiling and sharing this data!

As of 2023-11-24, the data only includes episodes from the "revived" era.
For an added challenge, consider submitting a pull request to the {datardis} package to update the [data-extraction scripts](https://github.com/KittJonathan/datardis/tree/main/misc) to also fetch the "classic" era data!

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-11-28')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 48)

drwho_episodes <- tuesdata$drwho_episodes
drwho_directors <- tuesdata$drwho_directors
drwho_writers <- tuesdata$drwho_writers

# Option 2: Read directly from GitHub

drwho_episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-28/drwho_episodes.csv')
drwho_directors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-28/drwho_directors.csv')
drwho_writers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-28/drwho_writers.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `drwho_episodes.csv`

|variable        |class     |description     |
|:---------------|:---------|:---------------|
|era             |character |Whether the episode is in the "classic" or "revived" era. All data in this dataset is within the "revived" era.|
|season_number   |double    |The season number within the era. Note that some episodes are outside of a season.|
|serial_title    |character |Serial title if available |
|story_number    |character |Story number|
|episode_number  |double    |Episode number in season|
|episode_title   |character |Episode title|
|type            |character |"episode" or "special"|
|first_aired     |double    |Date the episode first aired in the U.K.|
|production_code |character |Episode's production code if available|
|uk_viewers      |double    |Number of U.K. viewers (millions)|
|rating          |double    |Episode's rating|
|duration        |double    |Episode's duration in minutes|

# `drwho_directors.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|story_number |character |Story number|
|director     |character |Episode's director|

# `drwho_writers.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|story_number |character |Story number|
|writer       |character |Episode's writer|

### Cleaning Script

Clean data from the [{datardis} package](https://github.com/KittJonathan/datardis).

``` r
library(tidyverse)
library(here)
library(fs)
# pak::pak("datardis")
library(datardis)

working_dir <- here::here("data", "2023", "2023-11-28")

readr::write_csv(
  datardis::drwho_episodes,
  fs::path(working_dir, "drwho_episodes.csv")
)
readr::write_csv(
  datardis::drwho_directors,
  fs::path(working_dir, "drwho_directors.csv")
)
readr::write_csv(
  datardis::drwho_writers,
  fs::path(working_dir, "drwho_writers.csv")
)
```

