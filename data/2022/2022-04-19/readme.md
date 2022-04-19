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

# Crossword Puzzles and Clues

Data this week comes from [Cryptic Crossword Clues](https://cryptics.georgeho.org/). A short [TDS article on Crosswords](https://towardsdatascience.com/the-wild-world-of-crossword-data-71d560e222f5)

> cryptics.georgeho.org is a dataset of cryptic crossword1 clues, indicators and charades, collected from various blogs and digital archives.

> This dataset is a significant work of crossword archivism and scholarship, as acquiring historical crosswords and structuring their contents require focused effort and tedious cleaning that few are willing to do for such trivial data - for example, according to this selection guide2, the Library of Congress explicitly does not collect crossword puzzles.

> This project indexes various blogs and digital archives for cryptic crosswords. Several fields - such as clues, answers, clue numbers, annotations or commentary, puzzle title and publication date - are parsed and extracted into a tabular dataset. The result is over half a million clues from cryptic crosswords over the past twelve years.

> Two other datasets are subsequently derived from the clues - wordplay indicators and charades (a.k.a. substitutions). All told, the derived datasets contain over twelve thousand wordplay indicators and over sixty thousand charades.

### Get the data here

https://www.sciencebase.gov/catalog/item/60ba5a00d34e86b9388d86bc

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-04-19')
tuesdata <- tidytuesdayR::tt_load(2022, week = 16)

big_dave <- tuesdata$big_dave

# Or read in the data manually

big_dave <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-19/big_dave.csv')
times <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-19/times.csv')

```
### Data Dictionary

# `big_dave.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|rowid       |double    | row ID |
|clue        |character | Clue      |
|answer      |character | Answer      |
|definition  |character | Definition         |
|clue_number |character | Clue Number  |
|puzzle_date |double    | Puzzle date|
|puzzle_name |character | Puzzle name |
|source_url  |character | Source URL |
|source      |character | Source |

### Cleaning Script

```
raw_df <- read_csv("https://cryptics.georgeho.org/data/clues.csv?_stream=on&source=bigdave44&_size=max")

raw_df %>% 
  write_csv("2022/2022-04-19/big_dave.csv")

times <- read_csv("https://cryptics.georgeho.org/data/clues.csv?_stream=on&source=times_xwd_times&_size=max")

times %>% 
  write_csv("2022/2022-04-19/times.csv")

```