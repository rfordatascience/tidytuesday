---
editor_options: 
  markdown: 
    wrap: 72
---

### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> \### Chart type It's helpful for people with partial sight to know
> what chart type it is and gives context for understanding the rest of
> the visual. Example: Line graph \### Type of data What data is
> included in the chart? The x and y axis labels may help you figure
> this out. Example: number of bananas sold per day in the last year
> \### Reason for including the chart Think about why you're including
> this visual. What does it show that's meaningful. There should be a
> point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales \### Link to data or
> source Don't include this in your alt text, but it should be included
> somewhere in the surrounding text. People should be able to click on a
> link to view the source data or dig further into the visual. This
> provides transparency about your source and lets people explore the
> data. Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

# European Flights

The data this week comes from [Eurocontrol](https://ansperformance.eu/data/). A brief article covers this data at [ec.europa.eu](https://ec.europa.eu/eurostat/web/products-eurostat-news/-/ddn-20210914-1). Hattip to [Data is Plural](https://www.data-is-plural.com/archive/2022-07-06-edition/).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-07-12')
tuesdata <- tidytuesdayR::tt_load(2022, week = 28)

flights <- tuesdata$flights

# Or read in the data manually

flights <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-07-12/flights.csv')

```

### Data Dictionary

# `flights.csv`

| **Column name** | **Data Source**  | **Label**                       | **Description**                                     | **Example** |
|-----------------|------------------|---------------------------------|-----------------------------------------------------|-------------|
| YEAR            | Network Manager  | YEAR                            | Reference year                                      | 2014        |
| MONTH_NUM       | Network Manager  | MONTH                           | Month (numeric)                                     | 1           |
| MONTH_MON       | Network Manager  | MONTH_MON                       | Month (3-letter code)                               | JAN         |
| FLT_DATE        | Network Manager  | DATE_FLT                        | Date of flight                                      | 01-Jan-2014 |
| APT_ICAO        | Network Manager  | APT_ICAO                        | ICAO 4-letter airport designator                    | EDDM        |
| APT_NAME        | PRU              | APT_NAME                        | Airport name                                        | Munich      |
| STATE_NAME      | PRU              | STATE_NAME                      | Name of the country in which the airport is located | Germany     |
| FLT_DEP_1       | Network Manager  | Departures - (NM)               | Number of IFR departures                            | 278         |
| FLT_ARR_1       | Network Manager  | IFR arrivals - (NM)             | Number of IFR arrivals                              | 241         |
| FLT_TOT_1       | Network Manager  | IFR flights (arr + dep) - (NM)  | Number total IFR movements                          | 519         |
| FLT_DEP_IFR_2   | Airport Operator | IFR departures - (APT)          | Number of IFR departures                            | 278         |
| FLT_ARR_IFR_2   | Airport Operator | IFR arrivals - (APT)            | Number of IFR arrivals                              | 241         |
| FLT_TOT_IFR_2   | Airport Operator | IFR flights (arr + dep) - (APT) | Number total IFR movements                          | 519         |

### Cleaning Script
