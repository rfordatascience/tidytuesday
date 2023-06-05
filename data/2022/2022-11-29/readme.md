### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type
> It's helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you're including this visual. What does it show that's meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don't include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# World Cup

The data this week comes from [FIFA World Cup](https://www.kaggle.com/datasets/evangower/fifa-world-cup).

> As we count down to the start of the FIFA World Cup in Qatar on November 20, this new dataset covers every single World Cup match played in its history from Uruguay in 1930 to Russia in 2018.

> The wcmatches dataset contains every football match played in the World Cup. Columns inside the dataset include city from which city was the match being played in, outcome which team claimed victory or did the match result in a draw, win_condition showing if the winning side need added extra time of penalties to win the game.

> It also includes a summary of each World Cup held, the cups dataset contains columns winners, games, goals_scored, and more.

Some data explorations: https://www.kaggle.com/datasets/evangower/fifa-world-cup/code

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-11-29')
tuesdata <- tidytuesdayR::tt_load(2022, week = 48)

wcmatches <- tuesdata$wcmatches

# Or read in the data manually

wcmatches <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-29/wcmatches.csv')
worldcups <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-29/worldcups.csv')

```
### Data Dictionary

# wcmatches.csv

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|year           |double    |year           |
|country        |character |country        |
|city           |character |city           |
|stage          |character |stage          |
|home_team      |character |home_team      |
|away_team      |character |away_team      |
|home_score     |double    |home_score     |
|away_score     |double    |away_score     |
|outcome        |character |outcome        |
|win_conditions |character |win_conditions |
|winning_team   |character |winning_team   |
|losing_team    |character |losing_team    |
|date           |double    |date           |
|month          |character |month          |
|dayofweek      |character |dayofweek      |

# worldcups.csv

|variable     |class     |description  |
|:------------|:---------|:------------|
|year         |double    |year         |
|host         |character |host         |
|winner       |character |winner       |
|second       |character |second       |
|third        |character |third        |
|fourth       |character |fourth       |
|goals_scored |double    |goals_scored |
|teams        |double    |teams        |
|games        |double    |games        |
|attendance   |double    |attendance   |

### Cleaning Script

Clean data - no script
