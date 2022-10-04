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

# Product Hunt

The data this week comes from [components.one](https://components.one/posts/gamer-and-nihilist-product-hunt) by way of [Data is Plural](https://www.data-is-plural.com/archive/2022-09-28-edition/#:~:text=t%20Factle%5D-,Tech%20products%20promoted.,-For%20%E2%80%9CThe).

> For “The Gamer and the Nihilist,” an essay in Components, Andrew Thompson and collaborators created a dataset of 76,000+ tech products on Product Hunt, a popular social network for launching and promoting such things. The dataset includes the name, description, launch date, upvote count, and other details for every product from 2014 to 2021 in the platform’s sitemap. (“Based on experience, not every product that appears on Product Hunt seems to appear on the sitemap,” the authors caution.)

A [report](https://components.one/posts/gamer-and-nihilist-product-hunt) on the result of anaylsis from 2014 to 2021.

Get the full dataset (280 mB) at <https://components.one/datasets/product-hunt-products>

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-10-04')
tuesdata <- tidytuesdayR::tt_load(2022, week = 40)

product_hunt <- tuesdata$product_hunt

# Or read in the data manually

product_hunt <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-04/product_hunt.csv')

```
### Data Dictionary

# `product_hunt.csv`

|variable                |class     |description |
|:-----------------------|:---------|:-----------|
|id                      |character | ID    |
|name                    |character | Name of product    |
|product_description     |character | Product description     |
|release_date            |double    | Release date    |
|product_of_the_day_date |double    | Product of the day date    |
|product_ranking         |double    | Product ranking     |
|main_image              |character | Main image    |
|upvotes                 |double    | Upvotes    |
|category_tags           |character | Category tags - multiple tags per line    |
|hunter                  |character | Hunters, who sponsor a product by promoting it to their follower    |
|makers                  |character | Makers, who build and release products on the site    |
|last_updated            |double    | Last updated    |

### Cleaning Script

```r
library(tidyverse)

raw_df <- read_csv("2022/2022-10-04/product-hunt-prouducts-1-1-2014-to-12-31-2021.csv")

full_df <- raw_df |> 
  rename(id = 1) |> 
  mutate(id = str_remove(id, "https://www.producthunt.com/posts/"))

raw_df |> 
  select(-comments, -websites, -images) |> 
  lobstr::obj_size() |> 
  unclass() |> 
  prettyunits::compute_bytes()

full_df |> 
  select(id:main_image, upvotes, category_tags, hunter:last_updated) |> 
  write_csv("2022/2022-10-04/product_hunt.csv")
```

