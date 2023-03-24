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

# Time Zones

The data this week comes from the [IANA tz database](https://data.iana.org/time-zones/tz-link.html) via the {[clock](https://clock.r-lib.org/)} and {[tzdb](https://tzdb.r-lib.org/)} packages. Special thanks to [Davis Vaughan for the assist in preparing this data](https://twitter.com/dvaughan32/status/1639281179433074692)!

Many websites operate using the data in the IANA tz database. ["What Is Daylight Saving Time"](https://www.timeanddate.com/time/dst/) from [timeanddate.com]("https://www.timeanddate.com/") is a good place to start to find interesting information about time zones, such as the strange case of [Lord Howe Island, Australia](https://www.timeanddate.com/time/time-zones-interesting.html#:~:text=Lord%20Howe%20Island%3A%20UTC%20%2B10%3A30%20/%20%2B11%3A00).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-03-28')
tuesdata <- tidytuesdayR::tt_load(2023, week = 13)

transitions <- tuesdata$transitions
timezones <- tuesdata$timezones
timezone_countries <- tuesdata$timezone_countries
countries <- tuesdata$countries

# Or read in the data manually

transitions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-28/transitions.csv')
timezones <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-28/timezones.csv')
timezone_countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-28/timezone_countries.csv')
countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-28/countries.csv')
```

### Data Dictionary

# `transitions.csv`

Changes in the conversion of a given time zone to UTC (for example for daylight savings or because the definition of the time zone changed).

|variable     |class     |description  |
|:------------|:---------|:------------|
|zone         |character |The name of the time zone.|
|begin        |character |When this definition went into effect, in UTC. Tip: convert to a datetime using lubridate::as_datetime().|
|end          |character |When this definition ended (and the next definition went into effect), in UTC. Tip: convert to a datetime using lubridate::as_datetime().|
|offset       |double    |The offset of this time zone from UTC, in seconds.|
|dst          |logical   |Whether daylight savings time is active within this definition.|
|abbreviation |character |The time zone abbreviation in use throughout this begin to end range.|

# `timezones.csv`

Descriptions of time zones from the [IANA time zone database](https://data.iana.org/time-zones/tz-link.html).

|variable  |class     |description |
|:---------|:---------|:-----------|
|zone      |character |The name of the time zone.|
|latitude  |double    |Latitude of the time zone's "principal location."|
|longitude |double    |Longitude of the time zone's "principal location."|
|comments  |character |Comments from the tzdb definition file.|

# `timezone_countries.csv`

Countries (or other place names) that overlap with each time zone.

|variable     |class     |description  |
|:------------|:---------|:------------|
|zone         |character |The name of the time zone.|
|country_code |character |The [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 2-character country code.|

# `countries.csv`

Names of countries and other places.

|variable     |class     |description  |
|:------------|:---------|:------------|
|country_code |character |The [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 2-character country code.|
|place_name   |character |The usual English name for the coded region, chosen so that alphabetic sorting of subsets produces helpful lists. This is not the same as the English name in the ISO 3166 tables.|

### Cleaning Script

```r
# All packages used in this script:
library(tidyverse)
library(clock)
library(vctrs)
library(tzdb)
library(fs)
library(here)

# Code for extracting transitions provided by David Vaughan at
# https://gist.github.com/DavisVaughan/95a3bdb6b11e8e8f00ac671384461c72
# Slightly adapted for use in TidyTuesday.

generate_transitions <- function(zone,
                                 from = date_build(1900, 1, 1),
                                 to = date_build(2030, 1, 1)) {
  days <- date_seq(
    from = from,
    to = to,
    by = 1
  )
  
  days <- as_sys_time(days)
  info <- sys_time_info(days, zone = zone)
  
  # Must choose a unified transition time zone to use for display
  info$begin <- as_date_time(info$begin, zone = "UTC")
  info$end <- as_date_time(info$end, zone = "UTC")
  info$offset <- as.double(info$offset)
  
  info <- vec_unique(info)
  
  info
}

zones <- tzdb_names()
zones <- vec_set_names(zones, zones)

transitions <- map(zones, generate_transitions)
transitions <- list_rbind(transitions, names_to = "zone")
transitions <- as_tibble(transitions)

# All transitions (as long as more than one didn't happen within the same day)
transitions


# Add some additional information from the tzdb package.

tzdata <- tzdb::tzdb_path("text")

# zone1970 lists time zones that have been agreed upon since at least 1970. Many
# lines don't have comments, so expect warnings.
zone1970 <- read_tsv(
  fs::path(tzdb::tzdb_path("text"), "zone1970.tab"),
  skip = 34,
  col_names = c(
    "country_code",
    "coordinates",
    "zone",
    "comments"
  ),
  col_types = "cccc"
) |>
  # There's a comment in the middle of the table.
  filter(!str_starts(country_code, "#")) |> 
  # Break coordinates into lat/long columns. They're in "ISO 6709
  # sign-degrees-minutes-seconds format, either ±DDMM±DDDMM or ±DDMMSS±DDDMMSS,
  # first latitude (+ is north), then longitude (+ is east)." This is a good
  # opportunity to practice the new tidyr::separate_wider_regex function!
  # There's probably a function in a spatial package somewhere to deal with
  # this, but I'll work it out by hand.
  separate_wider_regex(
    coordinates,
    patterns = c(
      latitude = "[+-]\\d+",
      longitude = "[+-]\\d+"
    )
  ) |> 
  separate_wider_regex(
    latitude,
    patterns = c(
      lat_sign = "[+-]",
      lat_deg = "\\d{2}",
      lat_min = "\\d{2}",
      lat_sec = "\\d*"
    ),
    cols_remove = FALSE
  ) |> 
  mutate(
    lat_sec = as.integer(lat_sec),
    lat_sec = replace_na(lat_sec, 0),
    latitude = as.integer(paste0(lat_sign, 1)) * (
      as.integer(lat_deg) + as.integer(lat_min)/60 + lat_sec/60
    )
  ) |> 
  separate_wider_regex(
    longitude,
    patterns = c(
      long_sign = "[+-]",
      long_deg = "\\d{3}",
      long_min = "\\d{2}",
      long_sec = "\\d*"
    ),
    cols_remove = FALSE
  ) |> 
  mutate(
    long_sec = as.integer(long_sec),
    long_sec = replace_na(long_sec, 0),
    longitude = as.integer(paste0(long_sign, 1)) * (
      as.integer(long_deg) + as.integer(long_min)/60 + long_sec/60
    )
  ) |> 
  select(
    -starts_with("lat_"),
    -starts_with("long_")
  )

# Let's normalize that dataset a little by splitting it.
timezones <- zone1970 |> 
  select(zone, latitude, longitude, comments) |> 
  arrange(zone)
timezone_countries <- zone1970 |> 
  select(zone, country_code) |> 
  tidyr::separate_longer_delim(country_code, ",") |> 
  arrange(zone)

countries <- read_tsv(
  fs::path(tzdb::tzdb_path("text"), "iso3166.tab"),
  skip = 34,
  col_names = c(
    "country_code",
    "place_name"
  ),
  col_types = "cc"
)

colnames(transitions)
colnames(timezones)
colnames(timezone_countries)
colnames(countries)

write_csv(
  transitions,
  here(
    "data",
    "2023",
    "2023-03-28",
    "transitions.csv"
  )
)
write_csv(
  timezones,
  here(
    "data",
    "2023",
    "2023-03-28",
    "timezones.csv"
  )
)
write_csv(
  timezone_countries,
  here(
    "data",
    "2023",
    "2023-03-28",
    "timezone_countries.csv"
  )
)
write_csv(
  countries,
  here(
    "data",
    "2023",
    "2023-03-28",
    "countries.csv"
  )
)
```
