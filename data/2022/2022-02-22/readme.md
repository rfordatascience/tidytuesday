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

# Freedom in the World

The data this week comes from [Freedom House](https://freedomhouse.org/reports/publication-archives) and the [United Nations](https://unstats.un.org/unsd/methodology/m49/overview/) by way of [Arthur Cheib](https://github.com/ArthurCheib/analytical-politics-project/blob/main/data/tidy-data-fh-un.csv).

> Freedom in the World, Freedom House's flagship publication, is the standard-setting comparative assessment of global political rights and civil liberties. Published annually since 1972, the survey ratings and narrative reports on 195 countries and 15 related and disputed territories are used by policymakers, the media, international corporations, civic activists, and human rights defenders. 

Freedom House has written about their index - notably an article in 2018 on ["Democracy in Crisis"](https://freedomhouse.org/report/freedom-world/2018/democracy-crisis) and ["10 years of Decline in Global Freedom""](https://freedomhouse.org/article/q-10-years-decline-global-freedom).

[`pic1.png`. A line chart of the trajectory of USA's freedom in the world aggregate score on the y-axis and year on the x-axis. The title of the chart is 'Trajectory of the United States, The past year brought further faster erosion of America's own democratic standards, damaging its credibility as a champion of good governance and human rights.' The x-axis in years goes from 2008 to 2017. The y-axis or the Freedom in the World index for the USA started at 94 in 2008 until 2010 and then dropped gradually from 94 to 92 in 2014. The Freedom index was 90 in 2015, 89 in 2016 and 86 in 2017.](pic1.png)

[`pic2.png`. The chart is titled ' A decade of decline, Countries with net declines in aggregate score have outnumbered those with gains for the past 10 years.' The area chart displays year on the x-axis from 2006 to 2015 and the number of countries improving or declining in their Freedom aggregate score from 30 to 80 on the y-axis. Declined countries were 59, 59, 60, 67, 49, 54, 61, 54, 58, 72 from 2006 to 2015. Improved countries were 56, 43, 38, 34, 34, 37, 42, 40, 32, 43 from 2006 to 2015. The chart represents a greater number of countries with declining freedom in every year versus improving freedom.](pic2.png)

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-02-22')
tuesdata <- tidytuesdayR::tt_load(2022, week = 8)

freedom <- tuesdata$freedom

# Or read in the data manually

freedom <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-22/freedom.csv')

```
### Data Dictionary

# `freedom.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|country     |character | Country Name |
|year        |double    | Year |
|CL          |double    | Civil Liberties |
|PR          |double    | Political rights |
|Status      |character | Status (Free `F`, Not Free `NF`, Partially Free `PF`) |
|Region_Code |double    | UN Region code |
|Region_Name |character | UN Region Name |
|is_ldc      |double    | Is a least developed country (binary 0/1) |

### Cleaning Script

