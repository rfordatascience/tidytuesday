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

# Radio Stations

The data this week comes from [Wikipedia](https://en.wikipedia.org/wiki/Lists_of_radio_stations_in_the_United_States). 

The dataset included was mined from all 50 states, tidying column names, binding and aggregating. 

[Erin's](https://twitter.com/erindataviz) blogpost on [Visualizing the Geography of FM Radio](https://erdavis.com/2020/01/04/visualizing-the-geography-of-fm-radio/). Data sourced from [FCC](https://www.fcc.gov/media/radio/fm-service-contour-data-points).

Credit: [Frank Hull](twitter.com/frankiethull)

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-11-08')
tuesdata <- tidytuesdayR::tt_load(2022, week = 45)

state_stations <- tuesdata$state_stations

# Or read in the data manually

state_stations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-08/state_stations.csv')

```
### Data Dictionary

# `state_stations.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|call_sign |character | Call Sign   |
|frequency |character |frequency   |
|city      |character |city        |
|licensee  |character |licensee    |
|format    |character | format      |
|state     |character | state       |

# `fm_service_contour_current.zip`

A large Zip file (~200 Mb on disk when unzipped) - see cleaning script for use.

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|application_id     |character |application_id     |
|service            |character |service            |
|lms_application_id |character |lms_application_id |
|dts_site_number    |character |dts_site_number    |
|site_lat           |double    | Site of station latitude           |
|site_long          |double    | Site of station longitude          |
|angle              |integer   | angle (0 to 360)              |
|deg_lat            |double    | Latitude for angle            |
|deg_lng            |double    | Longitude for angle            |

# `station_info.csv`

Can be joined:

```r
state_stations |> dplyr::right_join(station_info, by = c("call_sign"))
```

|variable |class     |description |
|:--------|:---------|:-----------|
|Call     |character |Call        |
|Sign     |double    |Sign        |
|Facility |character |Facility    |
|Id       |character |Id          |
|Service  |character |Service     |
|Licensee |character |Licensee    |
|Status   |character |Status      |
|Details  |character |Details     |

### Cleaning Script

```r
library(purrr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(janitor)
library(rvest)


all_states <- datasets::state.name
all_states <- gsub(" ", "_", all_states)


get_stations <- function(state){

root <- paste0("https://en.wikipedia.org/wiki/List_of_radio_stations_in_", state) 
 tables <- read_html(root) %>% html_nodes("table")
  stations <- tables[1] %>% # ideally all pages will have same format
              html_table(header = TRUE) %>% 
              do.call(rbind, .) %>% 
              clean_names() %>% 
              mutate(frequency = as.character(frequency)) %>%                    # handling Ohio special case (frequency / band split)
              rename_if(startsWith(names(.), "city"), ~ ("city")) %>%            # handling naming issues, citation handler
              rename_at(vars(matches("format")), ~ "format") %>%                 # handling naming issues, Oklahoma handler
              rename_if(startsWith(names(.), "licensee"), ~ ("licensee")) %>%    # handling naming issues, citation handler
              rename_if(startsWith(names(.), "owner"), ~ ("licensee")) %>%       # South Dakota handler
              select(call_sign, frequency, city, licensee, format) %>% 
              mutate(
                state = state
              )
  
  return(stations)
}

state_stations <- map_dfr(all_states, get_stations)


```

For the Contour cleaning:

```r
library(tidyverse)

raw_contour <- read_delim(
  "2022/2022-11-08/FM_service_contour_current.txt",
  delim = "|"
)

conv_contour <- raw_contour |>
  select(-last_col()) |>
  set_names(nm = c(
    "application_id", "service", "lms_application_id", "dts_site_number", "transmitter_site",
    glue::glue("deg_{0:360}")
  ))

lng_contour <- conv_contour |>
  separate(
    transmitter_site, 
    into = c("site_lat", "site_long"), 
    sep = " ,") |>
  pivot_longer(
    names_to = "angle",
    values_to = "values",
    cols = deg_0:deg_360
  ) |>
  mutate(
    angle = str_remove(angle, "deg_"),
    angle = as.integer(angle)
  ) |>
  separate(
    values,
    into = c("deg_lat", "deg_lng"),
    sep = " ,"
  )
  
```