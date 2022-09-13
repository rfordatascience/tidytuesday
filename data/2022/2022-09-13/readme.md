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

# Bigfoot

The data this week comes from [Bigfoot Field Researchers Organization (BFRO)](https://data.world/timothyrenner/www.bfro.net) by way of [Data.World](https://data.world/timothyrenner/bfro-sightings-data).

A [bigfoot article](https://timothyrenner.github.io/datascience/2017/06/30/finding-bigfoot.html) by Timothy Renner.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-09-13')
tuesdata <- tidytuesdayR::tt_load(2022, week = 37)

bigfoot <- tuesdata$bigfoot

# Or read in the data manually

bigfoot <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-13/bigfoot.csv')

```
### Data Dictionary

# `bigfoot.csv`

|variable           |class     |description |
|:------------------|:---------|:-----------|
|observed           |character |observed              |
|location_details   |character |location_details      |
|county             |character |county                |
|state              |character |state                 |
|season             |character |season                |
|title              |character |title                 |
|latitude           |double    |latitude              |
|longitude          |double    |longitude             |
|date               |double    |date                  |
|number             |double    |number                |
|classification     |character |classification        |
|geohash            |character |geohash               |
|temperature_high   |double    |temperature_high      |
|temperature_mid    |double    |temperature_mid       |
|temperature_low    |double    |temperature_low       |
|dew_point          |double    |dew_point             |
|humidity           |double    |humidity              |
|cloud_cover        |double    |cloud_cover           |
|moon_phase         |double    |moon_phase            |
|precip_intensity   |double    |precip_intensity      |
|precip_probability |double    |precip_probability    |
|precip_type        |character |precip_type           |
|pressure           |double    |pressure              |
|summary            |character |summary               |
|uv_index           |double    |uv_index              |
|visibility         |double    |visibility            |
|wind_bearing       |double    |wind_bearing          |
|wind_speed         |double    |wind_speed            |

### Cleaning Script

