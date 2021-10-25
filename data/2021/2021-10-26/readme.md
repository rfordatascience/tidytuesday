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

# Ultra Trail Running

The data this week comes from [Benjamin Nowak](https://twitter.com/BjnNowak) by way of [International Trail Running Association (ITRA)](https://itra.run/Races/FindRaceResults). Their original repo is available on [GitHub](https://github.com/BjnNowak/UltraTrailRunning).

A nice overview of some similar running statistics is available [RunRepeat.com](https://runrepeat.com/state-of-ultra-running).

> In this study, we explore the trends in ultra running over the last 23 years. We have analyzed 5,010,730 results from 15,451 ultra running events, making this the largest study ever done on the sport. 

> ### Key results

> * Female ultra runners are faster than male ultra runners at distances over 195 miles. The longer the distance the shorter the gender pace gap. In 5Ks men run 17.9% faster than women, at marathon distance the difference is just 11.1%, 100-mile races see the difference shrink to just .25%, and above 195 miles, women are actually 0.6% faster than men.

> * Participation has increased by 1676% in the last 23 years from 34,401 to 611,098 yearly participations and 345% in the last 10 years from 137,234 to 611,098. There have never been more ultra runners.

> * More ultra runners are competing in multiple events per year. In 1996, only 14% of runners participated in multiple races a year, now 41% of participants run more than one event per year. There is also a significant increase in the % of people who run 2 races a year, 17.2% (from 7.7% to 24.9%) and 3 races, 6.7% (from 2.8% to 9.5%). 

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-10-26')
tuesdata <- tidytuesdayR::tt_load(2021, week = 44)

ultra_rankings <- tuesdata$ultra_rankings

# Or read in the data manually

ultra_rankings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/ultra_rankings.csv')
race <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-26/race.csv')

```
### Data Dictionary

# `ultra_rankings.csv`

|variable     |class     |description |
|:------------|:---------|:-----------|
|race_year_id |double    | Race ID |
|rank         |double    | Racer rank |
|runner       |character | Runner name |
|time         |double    | Runner time, hour:minute:seconds |
|age          |double    | Runner age |
|gender       |character | Runner gender (Man = M, Woman = W)|
|nationality  |character | Nationality of runner |


# `race.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|race_year_id   |double    | Race ID for join |
|event          |character | Event name |
|race           |character | Race Name |
|city           |character | City name |
|country        |character | Country Name |
|date           |double    | Date |
|start_time     |double    | Start Time |
|participation  |character | Participation type |
|distance       |double    | Distance traveled in Km |
|elevation_gain |double    | Elevation gains in meters |
|elevation_loss |double    | Eleveation loss in meters |
|aid_stations   |double    | Aid station count |
|participants   |double    | Total N of participants |

### Cleaning Script

