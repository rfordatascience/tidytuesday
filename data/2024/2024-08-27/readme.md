# The Power Rangers Franchise

This week's dataset comes from Kaggle's [Power Rangers Dataset](https://www.kaggle.com/datasets/karetnikovn/power-rangers-dataset/data)!

> In 1993, five ordinary teenagers exploded on the pop-culture scene with the launch of Mighty Morphin Power Rangers. Together they broke down barriers. They defeated evil by demonstrating teamwork, inclusivity, and diversity to people of all ages. Today, this grand tradition continues as new Ranger teams and new generations of fans discover these essential values again.

The series, created by Haim Saban, has one of the most popular taglines in history, "It's Morphin Time!" The TV series "Mighty Morphin Power Rangers" (MMPR) launched on August 28, 1993. Power Rangers quickly became the #1 kids action brand and a global phenomenon. With its current 25th season, "Power Rangers Super Ninja Steel," the show is now the second-longest-running, non-soap-opera, scripted program on American TV (after "The Simpsons"). There are also over 830 episodes in its library. Currently, Power Rangers is seen in more than 150 markets around the world. It's also translated into numerous languages and is a favorite on many indispensable children's programming blocks around the world. Go Go Power Rangers on 8.28!

Source: [NationalDayCalendar.com](https://www.nationaldaycalendar.com/national-day/national-power-rangers-day-august-28)

What can you and your data analysis skills tell us about the Power Rangers' Franchise?

What were the most popular seasons? Which season of rangers lasted the longest on screen? Which was your favourite ranger and why?

Thank you to Tinashe M. Tapera for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-08-27')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 35)

power_rangers_episodes <- tuesdata$power_rangers_episodes
power_rangers_seasons <- tuesdata$power_rangers_seasons

# Option 2: Read directly from GitHub

power_rangers_episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-27/power_rangers_episodes.csv')
power_rangers_seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-27/power_rangers_seasons.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `power_rangers_episodes.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|season_title  |character |title of the overall season  |
|episode_num   |double    |number of this episode within this season |
|episode_title |character |title of this episode |
|air_date      |double    |date on which this episode first aired in the U.S. |
|IMDB_rating   |double    |average rating among IMDB users |
|total_votes   |double    |total votes on IMDB |
|desc          |character |free-text description of this episode |

# `power_rangers_seasons.csv`

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|season_title       |character |title of this season |
|season_num         |double    |season number |
|number_of_episodes |double    |number of episodes in this season |
|air_date_first_ep  |double    |date on which the first episode in this season first aired in the U.S. |
|air_date_last_ep   |character |date on which the last episode in this season first aired in the U.S. |
|producer           |character |the company that produced this season |
|IMDB_rating        |double    |average rating of this seasons among IMDB users |

### Cleaning Script

```r
library(tidyverse)
# source for seasons
"https://www.kaggle.com/datasets/karetnikovn/power-rangers-dataset/data"

# Source for episodes
"https://www.kaggle.com/datasets/karetnikovn/power-rangers-dataset/data"

power_rangers_seasons <- readr::read_csv("data/curated/power_rangers/seasons.csv")

power_rangers_episodes <- readr::read_csv("data/curated/power_rangers/episodes.csv") %>%
  mutate(air_date = mdy(air_date))
```
