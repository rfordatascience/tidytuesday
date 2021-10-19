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

# Giant Pumpkins

The data this week comes from [BigPumpkins.com](http://www.bigpumpkins.com/ViewArticle.asp?id=132).

> The Great Pumpkin Commonwealth's (GPC) mission cultivates the hobby of growing giant pumpkins throughout the world by establishing standards and regulations that ensure quality of fruit, fairness of competition, recognition of achievement, fellowship and education for all participating growers and weigh-off sites.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-10-19')
tuesdata <- tidytuesdayR::tt_load(2021, week = 43)

pumpkins <- tuesdata$pumpkins

# Or read in the data manually

pumpkins <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-10-19/pumpkins.csv')

```
### Data Dictionary

# `pumpkins.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|id                |character |Year-type|
|place             |character |Place/ranking |
|weight_lbs        |character |Weight in pounds |
|grower_name       |character |Name of grower |
|city              |character |City|
|state_prov        |character |State/Province|
|country           |character |Country|
|gpc_site          |character |GPC site (great pumpkin commonwealth) |
|seed_mother       |character |Seed mother|
|pollinator_father |character |Father |
|ott               |character |Over the top inches, can be used to estimate weight |
|est_weight        |character |Estimated weight in lbs |
|pct_chart         |character |Percent on chart |
|variety           |character |Variety of pumpkin |

Types: F = "Field Pumpkin", P = "Giant Pumpkin", S = "Giant Squash", W = "Giant Watermelon", L = "Long Gourd" (length in inches, not weight in pounds), T = Tomato

[Great Pumpkin Commonwealth rule book](https://gpc1.org/wp-content/uploads/2021/03/GPC-Rules-and-Handbook-2021.pdf)

### Cleaning Script

