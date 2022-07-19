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

# Technology Adoption

The data this week comes from [data.nber.org](https://data.nber.org/data-appendix/w15319/).

This data is released under CCBY 4.0, please reference the CHAT dataset via: 10.3386/w15319.


Per the [working paper](https://www.cgdev.org/sites/default/files/technology-and-development-exploration-data.pdf):

> We present data on the global diffusion of technologies over time, updating and
adding to Comin and Mestieri’s ‘CHAT’ database. We analyze usage primarily based
on per capita measures and divide technologies into the two broad categories of
production and consumption. We conclude that there has been strong convergence in
use of consumption technologies with somewhat slower and more partial convergence
in production technologies. This reflects considerably stronger global convergence
in quality of life than in income, but we note that universal convergence in use of
production technologies is not required for income convergence (only that countries
are approaching the technology frontier in the goods and services that they produce).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-07-19')
tuesdata <- tidytuesdayR::tt_load(2022, week = 29)

technology <- tuesdata$technology

# Or read in the data manually

technology <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-07-19/technology.csv')

```
### Data Dictionary

# `technology.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|variable |character |Variable name    |
|label    |character | Label for variable    |
|iso3c    |character | Country code    |
|year     |double    | Year    |
|group    |character | Group (consumption/production)    |
|category |character | Category    |
|value    |double    | Value (related to label)   |

### Cleaning Script

