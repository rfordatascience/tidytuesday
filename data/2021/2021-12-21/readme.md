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

<img align='right' height='200' src="https://user-images.githubusercontent.com/55933131/146823691-4c19c28c-d2ef-46b5-82bc-76923f5c3256.png" alt = "Starbucks logo, it is a white mermaid on a green background">

# Starbucks

Official Starbucks Nutritional dataset from the pdf *Starbucks Coffee Company* Beverage Nutrition Information. The pdf version is 22 pages and only steamed milk data is omitted for this dataset.

Hat-tip to [PythonCoderUnicorn](https://github.com/PythonCoderUnicorn/starbucks/blob/main/README.md) for their contribution!

There's some infographics from [Behance.net](https://www.behance.net/gallery/58743971/Starbucks-Menu-Infographic-Design)

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-12-21')
tuesdata <- tidytuesdayR::tt_load(2021, week = 52)

starbucks <- tuesdata$starbucks

# Or read in the data manually

starbucks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-12-21/starbucks.csv')

```
### Data Dictionary

# `starbucks.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|Product_Name    |character | Product Name |
|Size            |character | Size of drink (short, tall, grande, venti) |
|Milk            |double    | Milk Type type of milk used
|                |          |  - `0` none
|                |          |  - `1` nonfat
|                |          |  - `2` 2%
|                |          |  - `3` soy
|                |          |  - `4` coconut
|                |          |  - `5` whole |
|Whip            |double    | Whip added or not (binary 0/1) |
|Serv_Size_mL    |double    | Serving size in ml |
|Calories        |double    | KCal|
|Total_Fat_g     |double    | Total fat grams |
|Saturated_Fat_g |double    | Saturated fat grams |
|Trans_Fat_g     |character | Trans fat grams |
|Cholesterol_mg  |double    | Cholesterol mg |
|Sodium_mg       |double    | Sodium milligrams |
|Total_Carbs_g   |double    | Total Carbs grams |
|Fiber_g         |character | Fiber grams |
|Sugar_g         |double    | Sugar grams  |
|Caffeine_mg     |double    | Caffeine in milligrams |

### Cleaning Script

