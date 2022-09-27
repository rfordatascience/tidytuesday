### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Artists in the USA

The data this week comes from [arts.gov](https://www.arts.gov/impact/research/arts-data-profile-series/adp-31/data-tables) by way of [Data is Plural](https://www.data-is-plural.com/archive/2022-09-21-edition/)

[Artists in the Workforce: National and State Estimates for 2015-2019](https://www.arts.gov/impact/research/arts-data-profile-series/adp-31)

> This Arts Data Profile gives national and state-level estimates of artists in the workforce. The figures derive from American Community Survey (ACS) data covering 2015-2019. The ACS is conducted by the U.S. Census Bureau. State-level estimates are available for the total number of artists and for each individual type of artist (workers in any of 13 specific artist occupations).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-09-27')
tuesdata <- tidytuesdayR::tt_load(2022, week = 39)

artists <- tuesdata$artists

# Or read in the data manually

artists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-27/artists.csv')

```
### Data Dictionary

# `artists.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|state             |character | state/territory    |
|race              |character | race    |
|type              |character | type of artists    |
|all_workers_n     |double    | all worker count    |
|artists_n         |double    | artist count    |
|artists_share     |double    | artist share    |
|location_quotient |double    | Location quotients (LQ) measure an artist occupation's concentration in the labor force, relative to the U.S. labor force share. For example, an LQ of 1.2 indicates that the state's labor force in an occupation is 20 percent greater than the occupation's national labor force share. An LQ of 0.8 indicates that the state's labor force in an occupation is 20 percent below the occupation's national labor force share. |

### Cleaning Script

```r
library(tidyverse)
library(readxl)
library(fs)

all_xl <- fs::dir_ls("2022/2022-09-27/ADP-31-artists-in-the-workforce-StateTables/")

all_xl |> 
  str_subset("AllArtists", negate = TRUE)

test_df <- all_xl[2] |> read_xlsx()
test_df |> glimpse()

all_xl

names(test_df)[1] |> 
  str_extract(art_pattern) |> 
  str_to_title()

read_and_clean <- function(file){
  
  raw_full <- read_excel(file)
  
  art_pattern <- "(?<=Number of ).+(?= in the U.S. labor force, for all the states and Puerto Rico: 2015-2019)" 
  
  art_type <- names(raw_full)[1] |> 
    str_extract(art_pattern) |> 
    str_to_title()
  
  races <- c("Hispanic", "White", "African-American", "Asian", "Other")
  
  race_data <- function(sheet, race){
    read_excel(file, sheet = sheet, skip = 3) |> 
      mutate(race = race, .after = 1) |> 
      slice(c(-1,-2)) |> 
      filter(!is.na(State)) |> 
      mutate(across(3:6, as.numeric)) |> 
      select(1:6) |> 
      set_names(
        nm = c(
          "state", "race", "all_workers_n", "artists_n", "artists_share", "location_quotient")
        ) |> 
      mutate(type = art_type, .before = 3)
  }
  
  map2_dfr(2:6, races, race_data)
  
}

test_all <- all_xl[2] |> 
  read_and_clean()

test_all |> glimpse()

all_df <- map_dfr(all_xl[2:length(all_xl)], read_and_clean)

all_df |> 
  glimpse()

all_df |> 
  write_csv("2022/2022-09-27/artists.csv")
```