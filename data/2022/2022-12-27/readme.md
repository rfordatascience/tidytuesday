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

# Star Trek Timelines

The data this week comes from the [{rtrek} package](https://leonawicz.github.io/rtrek/). Thank you [Georgios Karamanis](https://github.com/gkaramanis) for suggesting the dataset!

> The rtrek package provides datasets related to the Star Trek fictional universe and functions for working with those datasets. It interfaces with the Star Trek API (STAPI), Memory Alpha and Memory Beta to retrieve data, metadata and other information relating to Star Trek.

We directly included two of the datasets from the {rtrek} package, but we encourage you to install the package and explore the trekverse of Star-Trek-related R packages!

**Warnings:**

- We filtered the tlFootnotes dataset and renamed columns, so you won't see exactly the same dataset if you load directly from the package.
- Some of the years do not fit into R integers, and will be coerced to NA if you attempt to convert the years to integer.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-12-27')
tuesdata <- tidytuesdayR::tt_load(2022, week = 52)

tlBooks <- tuesdata$tlBooks
tlFootnotes <- tuesdata$tlFootnotes

# Or read in the data manually

tlBooks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-27/tlBooks.csv')
tlFootnotes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-27/tlFootnotes.csv')

# Or load this data and more directly from the rtrek package! 
# Install it from CRAN via: install.packages("rtrek")
# See the cleaning script for more details.
```

### Data Dictionary

# `tlBooks.csv`

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|year               |double    |year (CE)          |
|title              |character |book (or story or episode) title         |
|series             |character |associated series abbreviation|
|anthology          |character |anthology          |
|format             |character |book, story, or episode |
|number             |integer   |number of this book, story, or episode within its collection|
|novelization       |logical   |TRUE if this thing did not begin as a book |
|setting            |character |universe in which the book takes place |
|stardate_start     |double    |first stardate mentioned or implied|
|stardate_end       |double    |last stardate mentioned or implied|
|detailed_date      |character |other information about the date|
|section            |character |section of the book, story, or episode in which the event takes place|
|primary_entry_year |integer   |year of the main events of the book, story, or episode|
|footnote           |integer   |footnote number|

# `tlFootnotes.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|footnote |integer   |footnote number|
|text     |character |text        |

### Cleaning Script

```r
# Slight cleaning of footnotes.

library(rtrek)

tlBooks |> 
  readr::write_csv("tlBooks.csv")

tlFootnotes |> 
  purrr::set_names(
    c("association", "footnote", "text")
  ) |> 
  dplyr::filter(association == "book") |> 
  dplyr::select(-association) |> 
  readr::write_csv("tlFootnotes.csv")
```
