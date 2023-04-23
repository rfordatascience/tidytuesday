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

# London Marathon

The data this week comes from Nicola Rennie's [LondonMarathon R package](https://github.com/nrennie/LondonMarathon). This is an R package containing two data sets scraped from Wikipedia (1 November 2022) on London Marathon winners, and some general data. How the dataset was created, and some analysis, is described in Nicola's post ["Scraping London Marathon data with {rvest}"](https://nrennie.rbind.io/blog/web-scraping-rvest-london-marathon/). Thank you for putting this dataset together @nrennie! 


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-04-25')
tuesdata <- tidytuesdayR::tt_load(2023, week = 17)

winners <- tuesdata$winners
london_marathon <- tuesdata$london_marathon


# Or read in the data manually

winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/winners.csv')
london_marathon <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-25/london_marathon.csv')


```

### Data Dictionary

# `winners.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|Category    |character |Category of race           |
|Year        |double    |Year                       |
|Athlete     |character |Name of the winner         |
|Nationality |character |Nationality of the winner  |
|Time        |double    |Winning time               |


# `london_marathon.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|Date             |double    |Date of the race                        |
|Year             |double    |Year                                    |
|Applicants       |double    |Number of people who applied            |
|Accepted         |double    |Number of people accepted               |
|Starters         |double    |Number of people who started            |
|Finishers        |double    |Number of people who finished           |
|Raised           |double    |Amount raised for charity (£ millions)  |
|Official charity |character |Official charity                        |



### Cleaning Script

No data cleaning