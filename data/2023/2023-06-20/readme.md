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

# UFO Sightings Redux

The data this week comes from the [National UFO Reporting Center](https://nuforc.org/webreports/ndxshape.html), [cleaned](https://github.com/jonthegeek/apis/blob/main/01_ufo-data.qmd) and [enriched](https://github.com/jonthegeek/apis/blob/main/01_ufo-enrich.qmd) with data from [sunrise-sunset.org](https://sunrise-sunset.org/) by [Jon Harmon](https://github.com/jonthegeek/apis/).

If this dataset looks familiar, that's because we [used a version of it back in 2019](https://tidytues.day/2019/2019-06-25). The new version adds the last several years of data, adds information about time-of-day, and cleans up some errors in the original dataset. We'd love to see visualizations describing the differences between the 2019 dataset and this new dataset!

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-06-20')
tuesdata <- tidytuesdayR::tt_load(2023, week = 25)

ufo_sightings <- tuesdata$`ufo_sightings`
places <- tuesdata$`places`
day_parts_map <- tuesdata$`day_parts_map`

# Or read in the data manually

ufo_sightings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/ufo_sightings.csv')
places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/places.csv')
day_parts_map <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/day_parts_map.csv')
```

### Data Dictionary

# `ufo_sightings.csv`

|variable               |class     |description            |
|:----------------------|:---------|:----------------------|
|reported_date_time     |datetime  |The time and date of the sighting, as it appears in the original NUFORC data. |
|reported_date_time_utc |datetime  |The time and date of the sighting, normalized to UTC. |
|posted_date            |datetime  |The date when the sighting was posted to NUFORC. |
|city                   |character |The city of the sighting. Some of these have been cleaned from the original data. |
|state                  |character |The state, province, or similar division of the sighting. |
|country_code           |character |The 2-letter country code of the sighting, normalized from the original data. |
|shape                  |character |The reported shape of the craft. |
|reported_duration      |character |The reported duration of the event, in the reporter's words. |
|duration_seconds       |double    |The duration normalized to seconds using regex. |
|summary                |character |The reported summary of the event. |
|has_images             |logical   |Whether the sighting has images available on NUFORC. |
|day_part               |character |The approximate part of the day in which the sighting took place, based on the reported date and time, the place, and data from sunrise-sunset.org. Latitude and longitude were rounded to the 10s digit, and the date was rounded to the week, to match against time points such as "nautical twilight", "sunrise", and "sunset." |

# `places.csv`

|variable             |class     |description          |
|:--------------------|:---------|:--------------------|
|city                 |character |Unique cities in which sightings took place. |
|alternate_city_names |character |Comma-separated other names for the city. |
|state                |character |The state, province, or similar division of the sighting. |
|country              |character |The name of the country. |
|country_code         |character |The 2-letter country code of the sighting. |
|latitude             |double    |The latitude for this city, from geonames.org. |
|longitude            |double    |The longitude for this city, from geonames.org. |
|timezone             |character |The timezone for this city, from geonames.org. |
|population           |double    |The population for this city, from geonames.org. |
|elevation_m          |double    |The elevation in meters for this city, from geonames.org. |

# `day_parts_map.csv`

|variable                    |class  |description                 |
|:---------------------------|:------|:---------------------------|
|rounded_lat                 |double |Latitudes rounded to the tens digit. |
|rounded_long                |double |Longitudes rounded to the tens digit. |
|rounded_date                |double |Dates rounded to the nearest week. |
|astronomical_twilight_begin |double |The UTC time of day when astronomical twilight began on this date in this location. Astronomical twilight begins when the sun is 18 degrees below the horizon before sunrise. |
|nautical_twilight_begin     |double |The UTC time of day when nautical twilight began on this date (or the next date) in this location. Nautical twilight begins when the sun is 12 degrees below the horizon before sunrise. |
|civil_twilight_begin        |double |The UTC time of day when civil twilight began on this date (or the next date) in this location. Civil twilight begins when the sun is 6 degrees below the horizon before sunrise. |
|sunrise                     |double |The UTC time of day when the sun rose on this date (or the next date) in this location. |
|solar_noon                  |double |The UTC time of day when the sun was at its zenith on this date (or the next date) in this location. |
|sunset                      |double |The UTC time of day when the sun set on this date (or the next date) in this location. |
|civil_twilight_end          |double |The UTC time of day when civil twilight ended on this date (or the next date) in this location. Civil twilight ends when the sun is 6 degrees below the horizon after sunset. |
|nautical_twilight_end       |double |The UTC time of day when nautical twilight ended on this date (or the next date) in this location. Nautical twilight ends when the sun is 12 degrees below the horizon after sunset. |
|astronomical_twilight_end   |double |The UTC time of day when astronomical twilight ended on this date (or the next date) in this location. Astronomical twilight ends when the sun is 18 degrees below the horizon after sunset. |

### Cleaning Script

See Jon Harmon's [cleaning](https://github.com/jonthegeek/apis/blob/main/01_ufo-data.qmd) and [enriching](https://github.com/jonthegeek/apis/blob/main/01_ufo-enrich.qmd) scripts for most of the (extensive) cleaning.

```
# All packages used in this script:
library(tidyverse)
library(here)
library(withr)

url <- "https://github.com/jonthegeek/apis/raw/main/data/data_ufo_reports_with_day_part.rds"
ufo_path <- withr::local_tempfile(fileext = ".rds")
download.file(url, ufo_path)

ufo_data_original <- readRDS(ufo_path)

# We need to make the csv small enough that github won't choke. We'll pull out
# some of the joined data back into separate tables.

ufo_sightings <- ufo_data_original |> 
  dplyr::select(
    reported_date_time:city,
    state, 
    country_code,
    shape:has_images,
    day_part
  ) |> 
  # This got normalized after the data was saved, re-normalize.
  dplyr::mutate(
    shape = tolower(shape)
  )

places <- ufo_data_original |>
  dplyr::select(
    city:country_code, 
    latitude:elevation_m
  ) |> 
  dplyr::distinct()

# We'll also provide the map of "day parts" in case anybody wants to do
# something with that.
url2 <- "https://github.com/jonthegeek/apis/raw/main/data/data_day_parts_map.rds"
day_parts_path <- withr::local_tempfile(fileext = ".rds")
download.file(url2, day_parts_path)

day_parts_map <- readRDS(day_parts_path)

readr::write_csv(
  ufo_sightings,
  here::here(
    "data",
    "2023",
    "2023-06-20",
    "ufo_sightings.csv"
  )
)

readr::write_csv(
  places,
  here::here(
    "data",
    "2023",
    "2023-06-20",
    "places.csv"
  )
)

readr::write_csv(
  day_parts_map,
  here::here(
    "data",
    "2023",
    "2023-06-20",
    "day_parts_map.csv"
  )
)
```