![](https://cdn.vox-cdn.com/thumbor/VJSeiE_04-2L8OnIalSFerfonbA=/0x0:1000x666/1200x800/filters:focal(420x253:580x413)/cdn.vox-cdn.com/uploads/chorus_image/image/67324005/NUP_187464_0178.0.jpg)

# Ninja Warrior

The data this week comes from [Data.World](https://data.world/ninja/anw-obstacle-history) and originally from [sasukepedia](https://sasukepedia.fandom.com/wiki/List_of_American_Ninja_Warrior_obstacles). Ninja Warrior and the continuation as [American Ninja Warrior](https://en.wikipedia.org/wiki/American_Ninja_Warrior):  

> is an American sports entertainment competition based on the Japanese television series Sasuke. It features hundreds of competitors attempting to complete series of obstacle courses of increasing difficulty in various cities across the United States, in hopes of advancing to the national finals on the Las Vegas Strip and becoming the season's "American Ninja Warrior."

A description of each obstacle and pictures of them can be found at: 
[sasukepedia](https://sasukepedia.fandom.com/wiki/List_of_American_Ninja_Warrior_Obstacles_(Description)).


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-12-15')
tuesdata <- tidytuesdayR::tt_load(2020, week = 51)

ninja_warrior <- tuesdata$ninja_warrior

# Or read in the data manually

ninja_warrior <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-15/ninja_warrior.csv')

```
### Data Dictionary

# `ninja_warrior.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|season         |double    | Season Number |
|location       |character | Season location |
|round_stage    |character | Round stage |
|obstacle_name  |character | Name of obstacle |
|obstacle_order |double    | Obstacle Order (number) |

### Cleaning Script


```{r}
library(tidyverse)
library("httr")
library("readxl")

GET("https://query.data.world/s/satoodylrno77fbjmxxenx7nrehbkd", write_disk(tf <- tempfile(fileext = ".xlsx")))
df <- read_excel(tf)

out_df <- df %>% 
  janitor::clean_names()

write_csv(out_df, "2020/2020-12-15/ninja_warrior.csv")
```
