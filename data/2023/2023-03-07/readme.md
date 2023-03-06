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

# Numbats in Australia

The data this week comes from the [Atlas of Living Australia](https://www.ala.org.au). Thanks to Di Cook for [preparing this week's dataset](https://github.com/numbats/numbats-tidytuesday)! 

This [Numbat page at the Atlas of Living Australia](https://bie.ala.org.au/species/https://biodiversity.org.au/afd/taxa/6c72d199-f0f1-44d3-8197-224a2f7cff5f) talks about these endangered species in greater detail.

A [csv](data/numbats.csv) file of numbat sightings is provided. The code to refresh the data is below. 

Questions that would be interesting to answer are:

- Where do you find numbats in Australia?
- Was the distribution more widespread historically? (You may need to exclude zoo reported observations.)
- What time of day do numbat sightings occur?
- Are they more frequent in the summer or winter?
- Are numbats seen more on sunny and warm days than cloudy, wet, cold days?
- Do sightings happen more on week days than weekends?


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-03-07')
tuesdata <- tidytuesdayR::tt_load(2023, week = 10)

numbats <- tuesdata$numbats

# Or read in the data manually

numbats <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-07/numbats.csv')
```

### Data Dictionary

# `numbats.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|decimalLatitude  |double    |decimalLatitude  |
|decimalLongitude |double    |decimalLongitude |
|eventDate        |datetime  |eventDate        |
|scientificName   |factor    |Either "Myrmecobius fasciatus" or "Myrmecobius fasciatus rufus" |
|taxonConceptID   |factor    |The URL for this (sub)species |
|recordID         |character |recordID         |
|dataResourceName |factor    |dataResourceName |
|year             |integer   |The 4-digit year of the event (when available) |
|month            |factor    |The 3-letter month abbreviation of the event (when available) |
|wday             |factor    |The 3-letter weekday abbreviation of the event (when available) |
|hour             |integer   |The hour of the event (when available) |
|day              |date      |The date of the event (when available) |
|dryandra         |logical   |whether the observation was in Dryandra Woodland |
|prcp             |double    |Precipitation on that day in Dryandra Woodland (when relevant), in millimeters |
|tmax             |double    |Maximum temperature on that day in Dryandra Woodland (when relevant), in degrees Celsius |
|tmin             |double    |Minimum temperature on that day in Dryandra Woodland (when relevant), in degrees Celsius |


### Cleaning Script

```r
# Cleaning script provided at
# https://github.com/numbats/numbats-tidytuesday/blob/main/code/data.R Slightly
# updated here.

library(galah) # API to ALA
library(lubridate)
library(tidyverse)
library(rnoaa)
library(here)

# Downloading data is free but you need to 
# create an account https://www.ala.org.au then
# use this email address to pull data.
# galah_config(email = YOUR_EMAIL_ADDRESS)
id <- galah_identify("numbat")

numbats <- atlas_occurrences(identify = id)
numbats <- numbats %>%
  mutate(
    year = year(eventDate),
    month = month(eventDate, label=TRUE, abbr=TRUE),
    wday = wday(eventDate, label=TRUE, abbr=TRUE, week_start = 1),
    hour = hour(eventDate),
    day = ymd(as.Date(eventDate))
  )

narrogin <- meteo_pull_monitors(
  monitors = "ASN00010614",
  var = c("PRCP", "TMAX", "TMIN"),
  date_min = "2005-01-01",
  date_max = "2023-02-23")

narrogin %>%
  pivot_longer(cols = prcp:tmin, names_to = "var", values_to = "value") %>%
  mutate(day = lubridate::yday(date), year = lubridate::year(date)) %>%
  ggplot(aes(x = day, y= year, fill = is.na(value))) +
  geom_tile() +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  facet_wrap(vars(var), ncol = 1) +
  scale_fill_brewer(palette = "Dark2", name = "missing") +
  xlab("Day of the year")

narrogin_latlon <- tibble(lon = 117.1782, lat = -32.9310)

within_rad <- function(x, y, lon, lat, km) {
  deg <- km/111
  inside <- sqrt((lon-x)^2 + (lat-y)^2) < deg
  return(inside)
}

# Only sites within 50km radius of Narrogin weather station
# which is Dryandra Woodlands
numbats <- numbats %>%
  mutate(
    dryandra = within_rad(
      decimalLongitude, decimalLatitude, 
      narrogin_latlon$lon, narrogin_latlon$lat,
      50
    )
  )
  
numbats <- numbats %>% 
  left_join(narrogin, by = join_by(day == date)) %>%
  mutate(
    prcp = if_else(dryandra, prcp, NA, missing = NA),
    tmax = if_else(dryandra, tmax, NA, missing = NA),
    tmin = if_else(dryandra, tmin, NA, missing = NA)
  ) %>%
  select(-id)

# Things are only in this dataset if they were PRESENT.
numbats <- numbats |> 
  select(-occurrenceStatus)

# Those last three values are in values to coerce them to integers, and might be
# confusing. Translate them to doubles.
numbats <- numbats |> 
  mutate(
    prcp = prcp/10,
    tmax = tmax/10,
    tmin = tmin/10
  )

write_csv(
  numbats, 
  file = here::here(
    "data",
    "2023",
    "2023-03-07",
    "numbats.csv"
  )
)
```
