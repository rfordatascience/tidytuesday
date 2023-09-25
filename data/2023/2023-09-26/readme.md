# Roy Kent F**k count

For Deepsha Menghani's talk on [Data Viz animation and interactivity in Quarto](https://deepshamenghani.github.io/posit_plotly_crosstalk/#/title-slide), she watched each episode of Ted Lasso at 2X speed and diligently noted down every F*bomb and gesture reference, and then made it into the [richmondway R package](https://github.com/deepshamenghani/richmondway)!

What is Ted Lasso and who is Roy Kent? 

[Ted Lasso](https://en.wikipedia.org/wiki/Ted_Lasso) is a TV show that "follows Ted Lasso, an American college football coach who is hired to coach an English soccer team with the secret intention that his inexperience will lead it to failure, but whose folksy, optimistic leadership proves unexpectedly successful."

[Roy Kent](https://ted-lasso.fandom.com/wiki/Roy_Kent) is one of the main characters who goes from captain of AFC Richmond to one of the coaches. Particularly in early seasons, he's a man of few words, but many of them are f**k, expressed in various moods - mad, sad, happy, amused, loving, surprised, thoughtful, and joyous. 

This dataset includes the number, percentage, and context of f**k used in the show for each episode.

## The Data

```{r}
# Scroll to the end of this code block to see how to recombine the data into a
# graph!

# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-09-26')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 39)

richmondway <- tuesdata$richmondway

# Option 2: Read directly from GitHub

richmondway <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-26/richmondway.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

Source Created by Deepsha Menghani by watching the show and counting the number of F-cks used in sentences and as gestures.

# `richmondway.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|Character         |character |Character single value - Roy Kent         |
|Episode_order     |double    |The order of the episodes from the first to the last    |
|Season            |double    |The season 1, 2 or 3 associated with the count        |
|Episode           |double    |The episode within the season associated with the count          |
|Season_Episode    |character |Season and episode as a combined variable   |
|F_count_RK        |double    |Roy Kent's F-ck count in that season and episode     |
|F_count_total     |double    |Total F-ck count by all characters combined including Roy Kent in that season and episode |
|cum_rk_season     |double    |Roy Kent's cumulative F-ck count within that season    |
|cum_total_season  |double    |Cumulative total F-ck count by all characters combined including Roy Kent within that season |
|cum_rk_overall    |double    |Roy Kent's cumulative F-ck count across all episodes and seasons until that episode  |
|cum_total_overall |double    |Cumulative total F-ck count by all characters combined including Roy Kent across all episodes and seasons until that episode |
|F_score           |double    |Roy Kent's F-count divided by the total F-count in the episode     |
|F_perc            |double    |F-score as percentage  |
|Dating_flag       |character |Flag of yes or no for whether during the episode Roy Kent was dating the characted Keeley     |
|Coaching_flag     |character |Flag of yes or no for whether during the episode Roy Kent was coaching the team  |
|Imdb_rating       |double    |Imdb rating of that episode   |


### Cleaning Script

The data was collected and created as an R package by Deepsha Menghani. 

``` r
library(tidyverse)

devtools::install_github("deepshamenghani/richmondway")
library(richmondway)

write_csv(richmondway, "richmondway.csv")

```
