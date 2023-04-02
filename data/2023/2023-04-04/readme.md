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

# Premier League Match Data 2021-2022

The data this week comes from the [Premier League Match Data 2021-2022](https://www.kaggle.com/datasets/evangower/premier-league-match-data) via [Evan Gower](https://github.com/evangower) on Kaggle.

You can explore match day statistics of every game and every team during the 2021-22 season of the English Premier League Data.

Data includes teams playing, date, referee, and stats for home and away side such as fouls, shots, cards, and more! Also included is a dataset of the weekly rankings for the season.

The data was collected from the official website of the Premier League. Evan then cleaned the data using google sheets.

Evan did an analysis of [Who wins the EPL if games end at half time?](https://www.kaggle.com/code/evangower/who-wins-the-epl-if-games-end-at-half-time/) and there's [an article from the Athletic](https://theathletic.com/3459766/2022/07/29/liverpool-manchester-city-premier-league-fouls-yellow-card/) about fouls conceded per yellow card article.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-04-04')
tuesdata <- tidytuesdayR::tt_load(2023, week = 14)

soccer <- tuesdata$soccer

# Or read in the data manually

soccer <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-04/soccer21-22.csv')
```

### Data Dictionary

# `soccer21-22.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|Date     |character |The date when the match was played  |
|HomeTeam |character |The home team    |
|AwayTeam |character |The away team    |
|FTHG     |double    |Full time home goals        |
|FTAG     |double    |Full time away goals        |
|FTR      |character |Full time result         |
|HTHG     |double    |Halftime home goals        |
|HTAG     |double    |Halftime away goals        |
|HTR      |character |Halftime results         |
|Referee  |character |Referee of the match    |
|HS       |double    |Number of shots taken by the home team          |
|AS       |double    |Number of shots taken by the away team          |
|HST      |double    |Number of shots on target by the home team   |
|AST      |double    |Number of shots on target by the away team   |
|HF       |double    |Number of fouls by the home team   |
|AF       |double    |Number of fouls by the away team    |
|HC       |double    |Number of corners taken by the home team |
|AC       |double    |Number of corners taken by the away team |
|HY       |double    |Number of yellow cards received by the home team |
|AY       |double    |Number of yellow cards received by the away team  |
|HR       |double    |Number of red cards received by the home team  |
|AR       |double    |Number of red cards received by the away team  |

### Cleaning Script

No data cleaning
