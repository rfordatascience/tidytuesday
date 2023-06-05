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

# Weather Forecast Accuracy

The data this week comes from the [USA National Weather Service](https://www.weather.gov/), as emailed by the University of Illinois list server and [processed by Sai Shreyas Bhavanasi, Harrison Lanier, Lauren Schmiedeler, and Clayton Strauch at the Saint Louis University Department of Mathematics and Statistics](https://github.com/speegled/weather_forecasts). Thank you to [Darrin Speegle](https://github.com/speegled) for bringing the data to our attention!

> The goal of this data science capstone project has been to acquire national weather data to learn which areas of the U.S. struggle with weather prediction and the possible reasons why. Specifically, we focused on the error in high and low temperature forecasting.

The data includes 16 months of forecasts and observations from 167 cities, as well as a separate data.frame of information about those cities and some other American cities.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-12-20')
tuesdata <- tidytuesdayR::tt_load(2022, week = 51)

weather_forecasts <- tuesdata$weather_forecasts
cities <- tuesdata$cities
outlook_meanings <- tuesdata$outlook_meanings

# Or read in the data manually

weather_forecasts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-20/weather_forecasts.csv')
cities <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-20/cities.csv')
outlook_meanings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-20/outlook_meanings.csv')
```

### Data Dictionary

# `weather_forecasts.csv`

|variable              |class     |description           |
|:---------------------|:---------|:---------------------|
|date                  |date      |date described by the forecast and observation|
|city                  |factor    |city                  |
|state                 |factor    |state or territory    |
|high_or_low           |factor    |weather the forecast is for the high temperature of the low temperature|
|forecast_hours_before |integer   |the number of hours before the observation (one of 12, 24, 36, or 48)|
|observed_temp         |integer   |the actual observed temperature on that date (high or low)|
|forecast_temp         |integer   |the predicted temperature on that date (high or low)|
|observed_precip       |double    |the observed precipitation on that date, in inches; note that some observations lack an indication of precipitation, while others explicitly report 0|
|forecast_outlook      |factor    |an abbreviation for the general outlook, such as precipitation type|
|possible_error        |factor    |either (1) "none" if the row contains no potential errors or (2) the name of the variable that is the cause of the potential error|

# `cities.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|city                   |character |city                   |
|state                  |character |state or territory     |
|lon                    |double    |longitude              |
|lat                    |double    |latitude               |
|koppen                 |character |Köppen climate classification|
|elevation              |double    |elevation in meters    |
|distance_to_coast      |double    |distance_to_coast in miles|
|wind                   |double    |mean wind speed|
|elevation_change_four  |double    |greatest elevation change in meters out of the four closest points to this city in a collection of elevations used by the team at Saint Louis University|
|elevation_change_eight |double    |greatest elevation change in meters out of the eight closest points to this city in a collection of elevations used by the team at Saint Louis University|
|avg_annual_precip      |double    |average annual precipitation in inches|

# `outlook_meanings.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|forecast_outlook |character |an abbreviation for the general outlook, such as precipitation type|
|meaning          |character |the meaning of that abbreviation|

### Cleaning Script

```r
# Grab the data, then add some additional information.

library(tidyverse)
library(here)

weather_forecasts <- read_csv("https://raw.githubusercontent.com/speegled/weather_forecasts/main/data/email_data_expanded.csv")
glimpse(weather_forecasts)
cities <- read_csv("https://raw.githubusercontent.com/speegled/weather_forecasts/main/data/cities.csv")

# Translate outlooks from https://www.nws.noaa.gov/directives/sym/pd01005004curr.pdf

some_translations <- c(
  BLGSNO = "Blowing Snow",
  BLZZRD = "Blizzard",
  DRZL = "Drizzle",
  FLRRYS = "Snow Flurries",
  FZDRZL = "Freezing Drizzle",
  FZRAIN = "Freezing Rain",
  MOCLDY = "Mostly Cloudy",
  PTCLDY = "Partly Cloudy",
  RNSNOW = "Rain and Snow",
  SHWRS = "Rain Showers",
  SNOSHW = "Snow Showers" ,
  TSTRMS = "Thunderstorms",
  VRYHOT = "Very Hot",
  VRYCLD = "Very Cold" 
)

# The ones that aren't in that list are the same as their code.
  
outlook_meanings <- weather_forecasts |> 
  distinct(forecast_outlook) |> 
  dplyr::filter(!is.na(forecast_outlook)) |> 
  dplyr::mutate(
    meaning = dplyr::if_else(
      forecast_outlook %in% names(some_translations),
      some_translations[forecast_outlook],
      stringr::str_to_title(forecast_outlook)
    )
  )

weather_forecasts |> write_csv(
  here(
    "data",
    "2022",
    "2022-12-20",
    "weather_forecasts.csv"
  )
)

cities |> write_csv(
  here(
    "data",
    "2022",
    "2022-12-20",
    "cities.csv"
  )
)

outlook_meanings |> write_csv(
  here(
    "data",
    "2022",
    "2022-12-20",
    "outlook_meanings.csv"
  )
)
```
