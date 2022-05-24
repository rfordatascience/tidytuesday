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

# Women's Rugby

The data this week comes from [ScrumQueens](https://www.scrumqueens.com/page/results-dashboard) by way of [Jacquie Tran](https://github.com/rfordatascience/tidytuesday/issues/439).

Scrumqueen can be found on Twitter [@ScrumQueens](https://twitter.com/ScrumQueens)

> We write about women's rugby & women in rugby. Volunteers with a passion for equality in our brilliant sport - by [@alidonnelly](https://twitter.com/alidonnelly) &  [@johnlbirch](https://twitter.com/johnlbirch).

[Per Wikipedia](https://en.wikipedia.org/wiki/World_Rugby_Women%27s_Sevens_Series)

> The series, the women's counterpart to the World Rugby Sevens Series, provides elite-level women's competition between rugby nations. As with the men's Sevens World Series, teams compete for the title by accumulating points based on their finishing position in each tournament.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-05-24')
tuesdata <- tidytuesdayR::tt_load(2022, week = 21)

sevens <- tuesdata$sevens
fifteens <- tuesdata$fifteens

# Or read in the data manually

sevens <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-24/sevens.csv')
fifteens <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-24/fifteens.csv')

```
### Data Dictionary

# `sevens.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|row_id     |double    | Row ID for each observation |
|date       |double    | ISO date|
|team_1     |character | Team 1 |
|score_1    |character | Score for Team 1|
|score_2    |character | Score for team 2 |
|team_2     |character | Team 2 |
|venue      |character | Location of game |
|tournament |character | Tournament name |
|stage      |character | Stage of tournament   |
|t1_game_no |double    | Team 1 game number |
|t2_game_no |double    | Team 2 game number |
|series     |double    | Series number |
|margin     |double    | Margin of victory (diff between score 1/2)|
|winner     |character | Winner of match |
|loser      |character | Loser of match |
|notes      |character | Misc notes|

# `fifteens.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|test_no           |double    | Test number |
|date              |double    | ISO date |
|team_1            |character | Team 1 name  |
|score_1           |double    | Score for team 1  |
|score_2           |double    | Score for team 2|
|team_2            |character | Team 2 name |
|venue             |character | Location of tournament |
|home_test_no      |double    | Home number |
|away_test_no      |double    | Away game number |
|series_no         |double    | Series number |
|tournament        |character | Tournament type |
|margin_of_victory |double    | Margin of victory (diff of score 1/2) |
|home_away_win     |character | Home or away team won |
|winner            |character | Winner name |
|loser             |character | Loser name |

### Cleaning Script

``` r
library(tidyverse)

raw_df <- read_csv("2022/2022-05-24/Scrumqueens-data-2022-05-23.csv")

clean_df <- raw_df |> 
  janitor::clean_names() |> 
  glimpse() |> 
  rename(row_id = x1)

clean_df |> 
  write_csv('2022/2022-05-24/sevens.csv')

raw_15 <- read_csv("2022/2022-05-24/Scrumqueens-data-2022-05-23 (1).csv")

clean_15 <- raw_15 |> 
  janitor::clean_names() 

clean_15 |> 
  write_csv('2022/2022-05-24/fifteens.csv')

create_tidytuesday_dictionary(clean_df)
```
