### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
>
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

![Background splash art for Mario Kart, highlighting Mario driving a small kart in front of Peach and Bowser also driving karts on a rainbow-colored racetrack](https://i.insider.com/5c7d3a192628983f8f717b1f)

# Mario Kart 64 World Records

Credit: [Benedikt Claus](https://github.com/benediktclaus)

The data this week comes from [Mario Kart World Records](https://mkwrs.com/) and contains world records for the classic
(if you’re a 90’s kid) racing game on the Nintendo 64.

This [Video](https://www.youtube.com/watch?v=D6cpa-TvKn8&ab_channel=SummoningSalt) talks about the history of Mario Kart 64 World Records in greater detail. Despite it’s release back in 1996 (1997 in Europe and North America), it is still actiely played by many and new world records are achieved every month.

The game consists of 16 individual tracks and world records can be
achieved for the fastest *single lap* or the fastest completed race
(**three laps**). Also, through the years, players discovered
**shortcuts** in many of the tracks. Fortunately, shortcut and
non-shortcut world records are listed separately.

Furthermore, the Nintendo 64 was released for NTSC- and PAL-systems. On
PAL-systems, the game runs a little slower. All times in this dataset
are PAL-times, but they can be converted back to NTSC-times.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-05-25')
tuesdata <- tidytuesdayR::tt_load(2021, week = 22)

records <- tuesdata$records

# Or read in the data manually

records <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-25/records.csv')
drivers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-25/drivers.csv')

```

## Data Dictionary

### `world-records.csv`

> Current world records in Mario Kart 64 with date achieved and player’s
> name

| variable         | class     | description                     |
|:-----------------|:----------|:--------------------------------|
| track            | character | Track name                      |
| type             | factor    | Single or three lap record      |
| shortcut         | factor    | Shortcut or non-shortcut record |
| player           | character | Player’s name                   |
| system_played   | character | Used system (NTSC or PAL)       |
| date             | date      | World record date               |
| time_period     | period    | Time as `hms` period            |
| time             | double    | Time in seconds                 |
| record_duration | double    | Record duration in days         |

### `drivers.csv`

> Player’s data. Except nationality, this could be constructed with the
> above dataset.

| variable | class     | description                            |
|:---------|:----------|:---------------------------------------|
| position | integer   | Player’s current leader board position |
| player   | character | Player’s name                          |
| total    | integer   | Total world records                    |
| year     | double    | Year                                   |
| records  | integer   | Number of world records                |
| nation   | character | Player’s nationality                   |

## Some fun questions to explore

-   How did the world records develop over time?
-   Which track is the fastest?
-   For which track did the world record improve the most?
-   For how many tracks have shortcuts been discovered?
-   When were shortcuts discovered?
-   On which track does the shortcut save the most time?
-   Which is the longest standing world record?
-   Who is the player with the most world records?
-   Who are recent players?

Credit: [Benedikt Claus](https://github.com/benediktclaus)

Cleaning script on Benedikt's [GitHub](https://github.com/benediktclaus/tidytuesday-mario-kart).