# Chess Game Dataset (Lichess)

The chess dataset this week comes from Lichess.org via [Kaggle/Mitchell J](https://www.kaggle.com/datasets/datasnaek/chess/data).

> This is a set of just over 20,000 games collected from a selection of users on the site Lichess.org.

Use the data to explore -

1. What the common opening moves? By ranks?
2. How many turns does a game last based on player ranking?
3. What move patterns explain the game outcome?

Thank you to [Havisha Khurana](https://github.com/havishak) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-10-01')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 40)

chess <- tuesdata$chess

# Option 2: Read directly from GitHub

chess <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-01/chess.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `chess.csv`

|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|game_id        |character |Game ID |
|rated          |logical   |Rated (T/F) |
|start_time     |double    |Start time |
|end_time       |double    |End time |
|turns          |double    |Number of turns |
|victory_status |character |Game status |
|winner         |character |Winner |
|time_increment |character |Time increment |
|white_id       |character |White player id |
|white_rating   |double    |White player rating |
|black_id       |character |Black player id |
|black_rating   |double    |Black player rating |
|moves          |character |All Moves in Standard Chess Notation |
|opening_eco    |character |Opening Eco  (Standardised Code for any given opening, list [here](https://www.365chess.com/eco.php))|
|opening_name   |character |Opening Name |
|opening_ply    |double    |Number of moves in the opening phase |

### Cleaning Script

```r
# Source: Clean data provided by Kaggle Mitchell J.
# https://www.kaggle.com/datasets/datasnaek/chess/data

library(tidyverse)

# Data saved from Kaggle as "chess_game_dataset/chess_games.csv"

chess <- readr::read_csv("chess_game_dataset/chess_games.csv") %>%
  rename("game_id" = "id",
         "start_time" = "created_at",
         "end_time" = "last_move_at",
         "time_increment" = "increment_code")
```
