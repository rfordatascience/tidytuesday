### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type
> It's helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you're including this visual. What does it show that's meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don't include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Page Metrics

The data this week comes from [httparchive.org](https://httparchive.org/reports/loading-speed?start=earliest&end=latest&view=list) by way of [Data is Plural](https://www.data-is-plural.com/archive/2022-11-02-edition/). As seen in: "[Why web pages can have a size problem](https://blog.datawrapper.de/why-web-pages-can-have-a-size-problem/)" (Datawrapper).

Full detail available via BigQuery, but aggregate data used for this week.

Full data available via instructions at: <https://github.com/HTTPArchive/httparchive.org/blob/main/docs/gettingstarted_bigquery.md>

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-11-15')
tuesdata <- tidytuesdayR::tt_load(2022, week = 46)

image_alt <- tuesdata$image_alt

# Or read in the data manually

image_alt <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-15/image_alt.csv')
color_contrast <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-15/color_contrast.csv')
ally_scores <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-15/ally_scores.csv')
bytes_total <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-15/bytes_total.csv')
speed_index <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-15/speed_index.csv')

```
### Data Dictionary

# `ally_scores.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|measure   |character |measure     |
|client    |character |client      |
|date      |character |date        |
|p10       |character |p10         |
|p25       |character |p25         |
|p50       |character |p50         |
|p75       |character |p75         |
|p90       |character |p90         |
|timestamp |character |timestamp   |

# `image_alt.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|measure   |character |measure     |
|client    |character |client      |
|date      |character |date        |
|p10       |character |p10         |
|p25       |character |p25         |
|p50       |character |p50         |
|p75       |character |p75         |
|p90       |character |p90         |
|timestamp |character |timestamp   |

# `color_contrast.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|measure   |character |measure     |
|client    |character |client      |
|date      |character |date        |
|p10       |character |p10         |
|p25       |character |p25         |
|p50       |character |p50         |
|p75       |character |p75         |
|p90       |character |p90         |
|timestamp |character |timestamp   |


# `bytes_total.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|measure   |character |measure     |
|client    |character |client      |
|date      |character |date        |
|p10       |character |p10         |
|p25       |character |p25         |
|p50       |character |p50         |
|p75       |character |p75         |
|p90       |character |p90         |
|timestamp |character |timestamp   |

# `speed_index.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|measure   |character |measure     |
|client    |character |client      |
|date      |character |date        |
|p10       |character |p10         |
|p25       |character |p25         |
|p50       |character |p50         |
|p75       |character |p75         |
|p90       |character |p90         |
|timestamp |character |timestamp   |

### Cleaning Script

```r
library(tidyverse)
library(jsonlite)



# ally-scores -------------------------------------------------------------

get_df <- function(url){
  raw_list <- fromJSON(url, simplifyVector = FALSE)
  
  tibble(data = raw_list) |> 
    unnest_wider(data) |> 
    mutate(
      measure = fs::path_file(url) |> tools::file_path_sans_ext(),
      .before = 1)
}



ally_scores_url <- "https://cdn.httparchive.org/reports/a11yScores.json"
color_contrast_url <- "https://cdn.httparchive.org/reports/a11yColorContrast.json"
image_alt_url <- "https://cdn.httparchive.org/reports/a11yImageAlt.json"


ally_scores <- get_df(ally_scores_url)
color_contrast <- get_df(color_contrast_url)
image_alt <- get_df(image_alt_url)

ally_scores |> write_csv("2022/2022-11-15/ally_scores.csv")
color_contrast |> write_csv("2022/2022-11-15/color_contrast.csv")
image_alt |> write_csv("2022/2022-11-15/image_alt.csv")

# speed-size --------------------------------------------------------------

bytes_total_url <- "https://cdn.httparchive.org/reports/bytesTotal.json"
speed_index_url <- "https://cdn.httparchive.org/reports/speedIndex.json"

bytes_total <- get_df(bytes_total_url)
speed_index <- get_df(speed_index_url)

bytes_total |> write_csv("2022/2022-11-15/bytes_total.csv")
speed_index |> write_csv("2022/2022-11-15/speed_index.csv")
```
