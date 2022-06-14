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

# Drought Conditions in the US

The data this week comes from the [National Integrated Drought Information System](https://www.drought.gov/). 

This [web page](https://www.drought.gov/historical-information?dataset=1&selectedDateUSDM=20110301&selectedDateSpi=19580901) provides more information about the drought conditions data.

> The Standardized Precipitation Index (SPI) is an index to characterize meteorological drought on a range of timescales, ranging from 1 to 72 months, for the lower 48 U.S. states. The SPI is the number of standard deviations that observed cumulative precipitation deviates from the climatological average. NOAA's National Centers for Environmental Information produce the 9-month SPI values below on a monthly basis, going back to 1895.*

Credit: [Spencer Schien](https://twitter.com/MrPecners)

Additional data from the [Drought Monitor](https://droughtmonitor.unl.edu/DmData/DataDownload/DSCI.aspx) with API access from: https://droughtmonitor.unl.edu/DmData/DataDownload/WebServiceInfo.aspx#comp

> The Drought Severity and Coverage Index is an experimental method for converting drought levels from the U.S. Drought Monitor map to a single value for an area. DSCI values are part of the U.S. Drought Monitor data tables. Possible values of the DSCI are from 0 to 500. Zero means that none of the area is abnormally dry or in drought, and 500 means that all of the area is in D4, exceptional drought.

This dataset was covered by the [NY Times](https://www.nytimes.com/interactive/2021/06/11/climate/california-western-drought-map.html) and [CNN](https://www.cnn.com/2021/06/17/weather/west-california-drought-maps/index.html).

The dataset for today ranges from 2001 to 2021, but again more data is available at the [Drought Monitor](https://droughtmonitor.unl.edu/DmData/DataDownload/ComprehensiveStatistics.aspx).

Drought classification can be found on the [US Drought Monitor site](https://droughtmonitor.unl.edu/About/AbouttheData/DroughtClassification.aspx).

Please [reference the data](https://droughtmonitor.unl.edu/About/Permission.aspx) as seen below:

> The U.S. Drought Monitor is jointly produced by the National Drought Mitigation Center at the University of Nebraska-Lincoln, the United States Department of Agriculture, and the National Oceanic and Atmospheric Administration. Map courtesy of NDMC.

Some maps and other interesting summaries can be found on the [Drought Monitor site](https://droughtmonitor.unl.edu/ConditionsOutlooks/CurrentConditions.aspx) and their [Map Collection](https://droughtmonitor.unl.edu/Maps.aspx).

Some limitations of the data expanded on the [Drought Monitor site](https://droughtmonitor.unl.edu/About/AbouttheData/PopulationStatistics.aspx).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-06-14')
tuesdata <- tidytuesdayR::tt_load(2022, week = 24)

drought <- tuesdata$drought

# Or read in the data manually

drought <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-14/drought.csv')
drought_fips <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-14/drought-fips.csv')

```
### Data Dictionary

# `drought.csv`

|variable         |class     |description |
|:----------------|:---------|:-----------|
|0                |double    |  |
|DATE             |character | Date |
|D0               |double    | Abnormally dry |
|D1               |double    | Moderate drought |
|D2               |double    | Severe drought|
|D3               |double    | Extreme drought |
|D4               |double    | Exceptional drought |
|-9               |double    |  |
|W0               |double    | Abnormally wet |
|W1               |double    | Moderate wet |
|W2               |double    | Severe wet |
|W3               |double    | Extreme wet |
|W4               |double    | Exceptional wet |
|state            |character | State |

# `drought-fips.csv`

FIPS can be processed via `tidycensus` or `tigris` R packages. Note that the FIPS code needs to be split for processing.

See: https://walker-data.com/tidycensus/reference/fips_codes.html

|variable |class     |description |
|:--------|:---------|:-----------|
|State    |character |State name    |
|FIPS     |character | FIPS id (first two digits = state, last 3 digits = county)    |
|DSCI     |double    | Drought Score (0 to 500) Zero means that none of the area is abnormally dry or in drought, and 500 means that all of the area is in D4, exceptional drought.    |
|date     |double    | date in ISO    |

### Cleaning Script

