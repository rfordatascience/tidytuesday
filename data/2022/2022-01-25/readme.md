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

# Board Games

The data this week comes from [Kaggle](https://www.kaggle.com/jvanelteren/boardgamegeek-reviews/version/3?select=2022-01-08.csv) by way of [Board Games Geek](https://www.boardgamegeek.com/), with a hattip to [David and Georgios ](https://github.com/rfordatascience/tidytuesday/issues/382#issuecomment-1020305849).

Note that the two datasets can be joined on the id column.

This data contains an overview of many games and their user ratings. There is even more data available on [kaggle](https://www.kaggle.com/jvanelteren/boardgamegeek-reviews/version/3?select=2022-01-08.csv) but it is too large for TidyTuesday (user text reviews data > 1 Gb, around 15-19 million reviews!)

Nice overview of the data:

In [Python](https://jvanelteren.github.io/blog/2022/01/19/boardgames.html) and in [R](https://theparttimeanalyst.com/2019/04/21/tidy-tuesday-board-games-xgboost-model/) and another [R](https://rpubs.com/thewiremonkey/476630).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-01-25')
tuesdata <- tidytuesdayR::tt_load(2022, week = 4)

ratings <- tuesdata$ratings

# Or read in the data manually

ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-25/ratings.csv')
details <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-25/details.csv')

```
### Data Dictionary

# `ratings.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|num           |double    | Game number |
|id            |double    | Game ID |
|name          |character | Game name |
|year          |double    | Game year |
|rank          |double    | Game rank |
|average       |double    | Average rating  |
|bayes_average |double    | Bayes average rating|
|users_rated   |double    | Users rated |
|url           |character | Game url |
|thumbnail     |character | Game thumbnail  |

# `details.csv`

|variable                |class     |description |
|:-----------------------|:---------|:-----------|
|num                     |double    | Game number |
|id                      |double    | Game ID |
|primary                 |character | Primary name  |
|description             |character | Description of game |
|yearpublished           |double    | Year published |
|minplayers              |double    | Min n of players|
|maxplayers              |double    | Max n of players |
|playingtime             |double    | Playing time in minutes |
|minplaytime             |double    | Min play time |
|maxplaytime             |double    | Max plat tome |
|minage                  |double    | minimum age|
|boardgamecategory       |character | Category |
|boardgamemechanic       |character | Mechanic   |
|boardgamefamily         |character | Board game family   |
|boardgameexpansion      |character | Expansion |
|boardgameimplementation |character | Implementation  |
|boardgamedesigner       |character | Designer |
|boardgameartist         |character | Artist  |
|boardgamepublisher      |character | Publisher     |
|owned                   |double    | Num owned  |
|trading                 |double    | Num trading  |
|wanting                 |double    | Num wanting |
|wishing                 |double    | Num wishing |



### Cleaning Script

