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

# US Populated Places

While we embark on a road trip for summer vacation, the data this week comes from the [National Map Staged Products Directory](https://prd-tnm.s3.amazonaws.com/index.html?prefix=StagedProducts/GeographicNames/) from the [US Board of Geographic Names](https://www.usgs.gov/us-board-on-geographic-names/download-gnis-data).

Note: Quite a lot of more data is available from the GNIS. See the cleaning script for clues for downloading the additional data.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-06-27')
tuesdata <- tidytuesdayR::tt_load(2023, week = 26)

us_place_names <- tuesdata$`us_place_names`
us_place_history <- tuesdata$`us_place_history`

# Or read in the data manually

us_place_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-27/us_place_names.csv')
us_place_history <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-27/us_place_history.csv')
```

### Data Dictionary

# `us_place_names.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|feature_id     |double    |Permanent, unique feature record identifier. |
|feature_name   |character |Official feature name. |
|state_name     |character |The name of the state containing the primary coordinates. |
|county_name    |character |The name of the county containing the primary coordinates. |
|county_numeric |double    |The 3-digit code for the county containing the primary coordinates. |
|date_created   |date |The date the record was initially entered into the
Geographic Names Information System. |
|date_edited    |date |The date any attribute of an existing record was
edited. |
|prim_lat_dec   |double    |The latitude of the official feature location. Note that some values are unknown. |
|prim_long_dec  |double    |The longitude of the official feature location. Note that some values are unknown. |

# `us_place_history.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|feature_id  |double    |Permanent, unique feature record identifier. |
|description |character |Characteristics or information about a feature or the feature data |
|history     |character |Refers to the name origin, and/or cultural history of a feature. |

### Cleaning Script

See Jon Harmon's [cleaning](https://github.com/jonthegeek/apis/blob/main/01_ufo-data.qmd) and [enriching](https://github.com/jonthegeek/apis/blob/main/01_ufo-enrich.qmd) scripts for most of the (extensive) cleaning.

```
library(tidyverse)
library(withr)
library(fs)
library(here)

url <- "https://prd-tnm.s3.amazonaws.com/StagedProducts/GeographicNames/DomesticNames/DomesticNames_National_Text.zip"

path_zip <- local_tempfile(fileext = ".zip")
download.file(url, path_zip)

us_place_names <- read_delim(path_zip, "|") |> 
  mutate(county_numeric = as.integer(county_numeric)) |> 
  # We'll just use populated places, you might want to keep more!
  filter(feature_class == "Populated Place") |> 
  select(-feature_class, -starts_with("source_")) |> 
  # We also don't keep some redundant or less useful features.
  select(
    -state_numeric,
    -map_name, 
    -starts_with("bgn"), 
    -ends_with("_dms")) |> 
  mutate(
    across(
      ends_with("_dec"),
      ~ na_if(.x, 0)
    ),
    across(
      starts_with("date_"),
      lubridate::mdy
    )
  ) |> 
  distinct()

glimpse(us_place_names)

url_history <- "https://prd-tnm.s3.amazonaws.com/StagedProducts/GeographicNames/Topical/FeatureDescriptionHistory_National_Text.zip"

path_history <- local_tempfile(fileext = ".zip")
download.file(url_history, path_history)

us_place_history <- read_delim(path_history, "|") |> 
  semi_join(us_place_names)

# Data dictionary: 
# https://prd-tnm.s3.amazonaws.com/StagedProducts/GeographicNames/GNIS_file_format.pdf

write_csv(
  us_place_names,
  here::here(
    "data",
    "2023",
    "2023-06-27",
    "us_place_names.csv"
  )
)
write_csv(
  us_place_history,
  here::here(
    "data",
    "2023",
    "2023-06-27",
    "us_place_history.csv"
  )
)
```