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

# Alone

The data this week comes from the [Alone data package](https://github.com/doehm/alone) by Dan Oehm. 

> This dataset contains data from the TV series [Alone](https://www.history.com/shows/alone) collected and shared by [Dan Oehm](https://gradientdescending.com/). As described in Oehm's blog post](https://gradientdescending.com/alone-r-package-datasets-from-the-survival-tv-series/), in the survival TV series ‘Alone,’ 10 survivalists are dropped in an extremely remote area and must fend for themselves. They aim to last 100 days in the Artic winter, living off the land through their survival skills, endurance, and mental fortitude. 

> This package contains four datasets:

> * survivalists.csv: A data frame of survivalists across all 9 seasons detailing name and demographics, location and profession, result, days lasted, reasons for tapping out (detailed and categorised), and page URL.

> * loadouts.csv: The rules allow each survivalist to take 10 items with them. This dataset includes information on each survivalist’s loadout. It has detailed item descriptions and a simplified version for easier aggregation and analysis

> * episodes.csv: This dataset contains details of each episode including the title, number of viewers, beginning quote, and IMDb rating. New episodes are added at the end of future seasons.

> * seasons.csv: The season summary dataset includes location, latitude and longitude, and other season-level information. It includes the date of drop-off where the information exists.

Acknowledging the Alone dataset

> Dan Oehm:
* Alone data package: [https://github.com/doehm/alone](https://github.com/doehm/alone)
* Alone data package blog post: [https://gradientdescending.com/alone-r-package-datasets-from-the-survival-tv-series/](https://gradientdescending.com/alone-r-package-datasets-from-the-survival-tv-series/)

Examples of analyses are included in [Dan Oehm's blog post](https://gradientdescending.com/alone-r-package-datasets-from-the-survival-tv-series/).


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-01-24')
tuesdata <- tidytuesdayR::tt_load(2023, week = 4)

alone <- tuesdata$alone

# Or read in the data manually

survivalists <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/survivalists.csv')
loadouts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/loadouts.csv')
episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/episodes.csv')
seasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-24/seasons.csv')
```
### Data Dictionary


# `survivalists.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|season              |double    |The season number              |
|name                |character |Name of the survivalist                |
|age                 |double    |Age of the survivalist                 |
|gender              |character |Gender              |
|city                |character |City                |
|state               |character |State               |
|country             |character |Country             |
|result              |double    |Place survivalist finished in the season              |
|days_lasted         |double    |The number of days lasted in the game before tapping out or winning         |
|medically_evacuated |logical   |If the survivalist was medically evacuated from the game |
|reason_tapped_out   |character |The reason the survivalist tapped out of the game. NA means they were the winner. Reason being that technically if they won they never tapped out.   |
|reason_category     |character |A simplified category of the reason for tapping out  |
|team                |character |The team they were associated with (only for season 4)            |
|day_linked_up       |double    |Day the team members linked up (only for season 4)       |
|profession          |character |Profession          |
|url                 |character |URL of cast page on the history channel website. Prefix URL with https://www.history.com/shows/alone/cast                 |

# `loadout.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|version       |character |Country code for the version of the show     |
|season        |double    |The season number        |
|name          |character |Name of the survivalist          |
|item_number   |double    |Item number   |
|item_detailed |character |Detailed loadout item description |
|item          |character |Loadout item. Simplified for aggregation          |

# `episodes.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|version                |character |Country code for the version of the show             |
|season                 |double    |The season number                 |
|episode_number_overall |double    |Episode number across seasons |
|episode                |double    |Episode                |
|title                  |character |Episode title                  |
|air_date               |double    |Date the episode originally aired               |
|viewers                |double    |Number of viewers in the US (millions)                |
|quote                  |character |The beginning quote                  |
|author                 |character |Author of the beginning quote                 |
|imdb_rating            |double    |IMDb rating of the episode            |
|n_ratings              |double    |Number of ratings given for the episode              |

# `seasons.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|version       |character |Country code for the version of the show      |
|season        |double    |The season number        |
|location      |character |Location      |
|country       |character |Country       |
|n_survivors   |double    |Number of survivalists in the season. In season 4 there were 7 teams of 2.   |
|lat           |double    |Latitude           |
|lon           |double    |Longitude           |
|date_drop_off |double    |The date the survivalists were dropped off |


### Cleaning Script

No data cleaning
