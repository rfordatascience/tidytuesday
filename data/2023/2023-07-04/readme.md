### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> \### Chart type It's helpful for people with partial sight to know
> what chart type it is and gives context for understanding the rest of
> the visual. Example: Line graph \### Type of data What data is
> included in the chart? The x and y axis labels may help you figure
> this out. Example: number of bananas sold per day in the last year
> \### Reason for including the chart Think about why you're including
> this visual. What does it show that's meaningful. There should be a
> point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales \### Link to data or
> source Don't include this in your alt text, but it should be included
> somewhere in the surrounding text. People should be able to click on a
> link to view the source data or dig further into the visual. This
> provides transparency about your source and lets people explore the
> data. Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

# Historical Markers

The data this week comes from the [Historical Marker Database USA Index](https://www.hmdb.org/geolists.asp?c=United%20States%20of%20America). Learn more about the markers on the [HMDb.org site](https://www.hmdb.org/), which includes a number of articles, including [Database Counts and Statistics](https://www.hmdb.org/stats.asp).

We included a dataset of places that do *not* have entries in the Historical Markers Database.
You might try to combine that with information from [geonames.org](http://www.geonames.org/) (code: HSTS) to find markers that need to be submitted. Thanks to [Jesus M. Castagnetto](https://github.com/rfordatascience/tidytuesday/issues/574#issuecomment-1601050053) for the geonames tip!

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-07-04')
tuesdata <- tidytuesdayR::tt_load(2023, week = 27)

historical_markers <- tuesdata$`historical_markers`
no_markers <- tuesdata$`no_markers`

# Or read in the data manually

historical_markers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-07-04/historical_markers.csv')
no_markers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-07-04/no_markers.csv')
```

### Data Dictionary

# `historical_markers.csv`

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|marker_id          |double    |Unique ID for this marker in the HMdb. |
|marker_no          |character |Number of this marker in the state numbering scheme. |
|title              |character |Main title of the marker. |
|subtitle           |character |Subtitle of the marker, if any. |
|addl_subtitle      |character |Additional subtitle text. |
|year_erected       |integer   |The year in which the marker was erected. |
|erected_by         |character |The organization which erected the marker. |
|latitude_minus_s   |double    |The latitude of the marker. |
|longitude_minus_w  |double    |The longitude of the marker. |
|street_address     |character |The street address of the marker, if available. |
|city_or_town       |character |The city, town, etc in which the marker is located. |
|section_or_quarter |character |The section of the city, town, etc, when available. |
|county_or_parish   |character |The county, parish, or similar designation in which the marker appears. |
|state_or_prov      |character |The state, province, territory, etc in which the marker appears. |
|location           |character |A description of the marker's location. |
|missing            |character |Whether the marker is "Reported missing" or "Confirmed missing". NA values indicate that the marker has neither been reported missing nor confirmed as missing. |
|link               |character |The HMDb link to the marker. Links include additional details, such as photos and topic lists to which this marker belongs. |

# `no_markers.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|county   |character |County or equivalent. |
|state    |character |State or territory. |

### Cleaning Script

```
library(tidyverse)
library(here)
library(fs)
library(janitor)
library(remotes)

# I used the dev version of rvest from
# https://github.com/tidyverse/rvest/pull/362 as of 2023-06-21 to scrape some
# data this week.
install_github("tidyverse/rvest#362")
library(rvest)

# Begin by visiting
# https://www.hmdb.org/geolists.asp?c=United%20States%20of%20America, opening
# each state in a new tab, and then clicking the "Download" button at the
# top-right. I saved them all locally in a state_exports folder in this week's
# data folder, but I won't upload those unprocessed CSVs to github.

export_path <- here::here("data", "2023", "2023-07-04", "state_exports")

historical_markers_raw <- fs::dir_map(
  export_path,
  read_csv
)

# I know there's one problem with each read, which we'll deal with. Check for
# additional problems.
probs <- historical_markers_raw |> 
  purrr::map(
    \(hm) {
      problems(hm) |> 
        filter(!(expected == "17 columns" & actual == "4 columns")) |> 
        mutate(file = str_remove(file, fixed(export_path)))
    }
  )

has_probs <- vctrs::list_sizes(probs) > 0

probs[has_probs]
historical_markers_raw[[which(has_probs)]] |> 
  slice(1168:1170) |> 
  glimpse()

# It looks like the "Section or Quarter" column is auto-guessed as logical (NA),
# but should actually be character. We'll use this information to re-parse.

hmdb_cols <- spec(historical_markers_raw[[1]]) |> 
  cols_condense()
hmdb_cols

# That spec will take care of the problem.

historical_markers_raw <- fs::dir_map(
  export_path,
  \(path) {
    read_csv(path, col_types = hmdb_cols)
  }
)

# The remaining problems are all the expected one.

historical_markers <- historical_markers_raw |> 
  purrr::list_rbind() |> 
  filter(`Marker No.` != "Source: Hmdb.org") |> 
  clean_names()

# HMDb.org also has an interesting dataset about missing data. We'll scrape that
# as well. 

stats_page <- rvest::read_html_live("https://www.hmdb.org/stats.asp")

stats_page$click("#NoCArrow")

no_markers <- stats_page |> 
  rvest::html_element("#NoCDiv") |> 
  rvest::html_table() |> 
  select(X2) |> 
  filter(!X2 == "") |> 
  tidyr::separate_wider_delim(X2, ",  ", names = c("county", "state"))

write_csv(
  historical_markers,
  here::here(
    "data",
    "2023",
    "2023-07-04",
    "historical_markers.csv"
  )
)
write_csv(
  no_markers,
  here::here(
    "data",
    "2023",
    "2023-07-04",
    "no_markers.csv"
  )
)
```
