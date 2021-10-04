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

# Registered Nurses

The data this week comes from [Data.World](https://data.world/zendoll27/registered-nursing-labor-stats-1998-2020).

The BLS also [wrote about Registered Nurses by state](https://bit.ly/2YkVioc).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-10-05')
tuesdata <- tidytuesdayR::tt_load(2021, week = 41)

nurses <- tuesdata$nurses

# Or read in the data manually

nurses <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-05/nurses.csv')

```
### Data Dictionary

# `nurses.csv`

|variable                                        |class     |description |
|:-----------------------------------------------|:---------|:-----------|
|State                                           |character | State |
|Year                                            |double    | Year|
|Total Employed RN                               |double    | Total Employed Registered Nurses |
|Employed Standard Error (%)                     |double    | Employed standard error (%) |
|Hourly Wage Avg                                 |double    | Hourly wage average|
|Hourly Wage Median                              |double    | Hourly wage median |
|Annual Salary Avg                               |double    | Annual salary average |
|Annual Salary Median                            |double    | Annual salary median |
|Wage/Salary standard error (%)                  |double    | Wage/salary standard error % |
|Hourly 10th Percentile                          |double    | Hourly 10th Percentile               |
|Hourly 25th Percentile                          |double    | Hourly 25th Percentile                         |
|Hourly 75th Percentile                          |double    | Hourly 75th Percentile                         |
|Hourly 90th Percentile                          |double    | Hourly 90th Percentile                         |
|Annual 10th Percentile                          |double    | Annual 10th Percentile                         |
|Annual 25th Percentile                          |double    | Annual 25th Percentile                         |
|Annual 75th Percentile                          |double    | Annual 75th Percentile                         |
|Annual 90th Percentile                          |double    | Annual 90th Percentile                         |
|Location Quotient                               |double    | Location Quotient                              |
|Total Employed (National)_Aggregate             |double    | Total Employed (National)_Aggregate            |
|Total Employed (Healthcare, National)_Aggregate |double    | Total Employed (Healthcare, National)_Aggregate|
|Total Employed (Healthcare, State)_Aggregate    |double    | Total Employed (Healthcare, State)_Aggregate   |
|Yearly Total Employed (State)_Aggregate         |double    | Yearly Total Employed (State)_Aggregate        |

### Cleaning Script

No cleaning script but definitely explore:

[`tidyr::pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html)