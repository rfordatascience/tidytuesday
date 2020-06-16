# New Zealand Bird of the Year

This week's data is from the [New Zealand Forest and Bird Orginization](https://www.forestandbird.org.nz/) courtesy of [Dragonfly Data Science](https://www.dragonfly.co.nz/news/2019-11-12-boty.html) by way of [Nathan Moore](https://twitter.com/nmoorenz).

Full details around voting can be found at the [Bird of the Year site](https://www.birdoftheyear.org.nz/voting).

I have uploaded the raw data and the clean data, was a quick `dplyr::pivot_longer()` call!

Full details around voting are below - please note that votes are ranked 1-5 (1 is best, 5 is worst), and the voters do not need to submit all 5 votes.

> This year, voting is based on the instant runoff (IRV) voting system, which is similar to the system you might have seen in local elections. When you vote, you can rank up to five of your favourite birds, with #1 indicating your favourite bird, #2 indicating your second favourite bird, and so on. It’s no problem if you want to vote for less than five birds.

> How the winner is decided

> In the IRV voting system, the first preferences of all the votes cast are tallied in a first round of counting. If no bird has more than half of the votes, new rounds of counting are held until one bird has a majority.

> In each of these rounds the bird with the lowest number of votes is eliminated and the next ranked choice of those who voted for that bird are added to the totals of the remaining birds.

> This process continues until one bird has a majority of votes and is crowned Bird of the Year.

# Get the data!

```
nz_bird <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-19/nz_bird.csv")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!
# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load("2019-11-19")
tuesdata <- tidytuesdayR::tt_load(2019, week = 47)

nz_bird <- tuesdata$nz_bird
```

# Data Dictionary

## `nz_bird`

|variable  |class     |description |
|:---------|:---------|:-----------|
|date      | date    | Date of vote (ISO 8601) |
|hour      |double    | Hour of vote (numeric)|
|vote_rank |character | Vote rank, 1-5, where 1 is highest, and 5 is lowest |
|bird_breed |character | Bird breed |


# Scripts

```{r}
library(tidyverse)
library(here)

df <- read_csv(here("2019", "2019-11-19", "BOTY-votes-2019.csv")) %>% 
  select(-country)

clean_df <- df %>% 
  pivot_longer(cols = vote_1:vote_5, names_to = "vote_rank", values_to = "bird_breed")

clean_df %>% 
  write_csv(here("2019", "2019-11-19", "nz_bird.csv"))

```
