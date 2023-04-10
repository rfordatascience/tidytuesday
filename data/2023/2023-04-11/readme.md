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

# US Egg Production

The data this week comes from [The Humane League's US Egg Production
dataset](https://thehumaneleague.org/article/E008R01-us-egg-production-data)
by [Samara Mendez](https://samaramendez.github.io/). Dataset and code is available for this project on OSF at [US Egg Production Data Set](https://osf.io/z2gxn/).

This dataset tracks the supply of cage-free eggs in the United States from December 2007 to February 2021. For TidyTuesday we've used data through February 2021, but the full dataset, with data through the present, is available in the [OSF project](https://osf.io/z2gxn/). 


> In this project, they synthesize an analysis-ready data set that
> tracks cage-free hens and the supply of cage-free eggs relative to the
> overall numbers of hens and table eggs in the United States. The data
> set is based on reports produced by the United States Department of
> Agriculture (USDA), which are published weekly or monthly. They
> supplement these data with definitions and a taxonomy of egg products
> drawn from USDA and industry publications. The data include flock size
> (both absolute and relative) and egg production of cage-free hens as
> well as all table-egg-laying hens in the US, collected to understand
> the impact of the industry's cage-free transition on hens. Data
> coverage ranges from December 2007 to February 2021.


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-04-11')
tuesdata <- tidytuesdayR::tt_load(2023, week = 15)

eggproduction <- tuesdata$eggproduction
cagefreepercentages <- tuesdata$cagefreepercentages


# Or read in the data manually

eggproduction  <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-11/egg-production.csv')
cagefreepercentages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-11/cage-free-percentages.csv')

```

### Data Dictionary

# `egg-production.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|observed_month |double    |Month in which report observations are collected,Dates are recorded in ISO 8601 format YYYY-MM-DD |
|prod_type      |character |type of egg product: hatching, table eggs      |
|prod_process   |character |type of production process and housing: cage-free (organic), cage-free (non-organic), all. The value 'all' includes cage-free and conventional housing.   |
|n_hens         |double    |number of eggs produced by hens for a given month-type-process combo   |
|n_eggs         |double    |number of hens producing eggs for a given month-type-process combo     |
|source         |character |Original USDA report from which data are sourced. Values correspond to titles of PDF reports. Date of report is included in title.   |


# `cage-free-percentages.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|observed_month |double    |Month in which report observations are collected,Dates are recorded in ISO 8601 format YYYY-MM-DD |
|percent_hens   |double    |observed or computed percentage of cage-free hens relative to all table-egg-laying hens  |
|percent_eggs   |double    |computed percentage of cage-free eggs relative to all table eggs,This variable is not available for data sourced from the Egg Markets Overview report |
|source         |character |Original USDA report from which data are sourced. Values correspond to titles of PDF reports. Date of report is included in title.  |


### Cleaning Script

This data was already cleaned for the report. Raw data is also available at [US Egg Production Dataset](https://osf.io/z2gxn/).
