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

# Ferris Wheels

The data this week comes from [`ferriswheels`](https://github.com/EmilHvitfeldt/ferriswheels) package by [Emil Hvitfeldt](https://twitter.com/Emil_Hvitfeldt/status/1555647916257300480?s=20&t=LTeSzyCQkTznDBqMeXGPOg).

Make sure to tag `@Emil_Hvitfeldt` so he can see all the cute dataviz y'all make!

> The goal of ferriswheels is to provide a fun harmless little data set to play with

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-08-09')
tuesdata <- tidytuesdayR::tt_load(2022, week = 32)

wheels <- tuesdata$wheels

# Or read in the data manually

wheels <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-08-09/wheels.csv')

```
### Data Dictionary

# `wheels.csv`

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|name                  |character |Name    |
|height                |double    |Height in feet    |
|diameter              |double    |Diameter in feet    |
|opened                |double    |ISO Date opened    |
|closed                |double    |ISO date closed    |
|country               |character | Country    |
|location              |character | Location/city/region    |
|number_of_cabins      |integer   | Number of cabins    |
|passengers_per_cabin  |integer   | Passengers per cabin    |
|seating_capacity      |integer   | Seating capacity    |
|hourly_capacity       |integer   | Hourly capacity    |
|ride_duration_minutes |double    | Ride duration minutes    |
|climate_controlled    |character |climate_controlled     |
|construction_cost     |character |construction_cost      |
|status                |character |status                 |
|design_manufacturer   |character |design_manufacturer    |
|type                  |character |type                   |
|vip_area              |character |vip_area               |
|ticket_cost_to_ride   |character |ticket_cost_to_ride    |
|official_website      |character |official_website       |
|turns                 |double    |turns                  |

### Cleaning Script

