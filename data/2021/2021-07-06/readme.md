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

![Independence Day celebrations in the Dominican Republic. Image is of a Dominican Republic citizen celebrating independence day in a half mask, smiling, waving a Dominican Republic flag and wearing a Dominican Republic flag t shirt. Editorial credit: Tina Andros / Shutterstock.com](https://www.worldatlas.com/r/w960-q80/upload/a3/ab/28/shutterstock-385133644.jpg)

# Independence Days

The data this week comes from [Wikipedia](https://en.wikipedia.org/wiki/List_of_national_independence_days) and thank you to [Isabella Velasquez](https://github.com/rfordatascience/tidytuesday/issues/352) for prepping this week's dataset.

> An independence day is an annual event commemorating the anniversary of a nation's independence or statehood, usually after ceasing to be a group or part of another nation or state, or more rarely after the end of a military occupation. Many countries commemorate their independence from a colonial empire. American political commentator Walter Russell Mead notes that, "World-wide, British Leaving Day is never out of season.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-07-06')
tuesdata <- tidytuesdayR::tt_load(2021, week = 28)

holidays <- tuesdata$holidays

# Or read in the data manually

holidays <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-06/holidays.csv')

```
### Data Dictionary

# `holidays.csv`

|variable                     |class     |description |
|:----------------------------|:---------|:-----------|
|country                      |character | Country Name |
|date_parsed                  |double    | Date parsed |
|weekday                      |character | weekday |
|day                          |integer   | Day of month |
|month                        |integer   | Month number |
|name_of_holiday              |character | Name of holiday |
|date_of_holiday              |character | Date of holiday |
|year_of_event                |integer   | Year of event |
|independence_from            |character | Independence from what country |
|event_commemorated_and_notes |character | Event commemorated and other notes |
|year                         |integer   | Year |
|date_mdy                     |character | Date as month day year |

### Cleaning Script

Code credit goes to Isabella Velasquez.

```{r}
# Independence Days Around the World --------------------------------------

# Libraries ---------------------------------------------------------------

library(tidyverse)
library(rvest)
library(httr)
library(polite)
library(lubridate)
library(janitor)

# Scrape data -------------------------------------------------------------

url <- "https://en.wikipedia.org/wiki/List_of_national_independence_days"
url_bow <- polite::bow(url)

ind_html <-
  polite::scrape(url_bow) %>%
  rvest::html_nodes("table.wikitable") %>%
  rvest::html_table(fill = TRUE)

ind_tab <-
  ind_html[[1]][1:6] %>%
  as_tibble() %>%
  clean_names()

raw_html <- polite::scrape(url_bow) 

raw_html %>%
  # rvest::html_nodes("table.wikitable") %>%
  rvest::html_nodes("span.flagicon") %>% 
  length()
  rvest::html_table(fill = TRUE)

# Clean data --------------------------------------------------------------

ind_clean <-
  ind_tab %>%
  # Cleaning up some dates
  mutate(
    date_of_holiday = case_when(
      country == "Croatia" ~ "May 30",
      country == "Mexico" ~ "September 16",
      country == "Mongolia" ~ "December 29",
      country == "Paraguay" ~ "May 14",
      country == "Israel" ~ "May 14", # Independence Day exists within a range, but this was the original date.
      country == "Slovenia" ~ "June 25", # Slovenia has two dates; this one is "Statehood Day".
      TRUE ~ date_of_holiday
    ),
    year = str_sub(year_of_event, start = 1, end = 4),
    date_mdy = case_when(
      date_of_holiday != "" ~ paste0(date_of_holiday, ", ", year),
      TRUE ~ ""
    ),
    date_parsed = mdy(date_mdy),
    weekday = weekdays(date_parsed),
    day = day(date_parsed),
    month = month(date_parsed, label = TRUE),
    year_of_event = as.integer(year_of_event),
    year = as.integer(year)
  ) %>%
  relocate(date_parsed:month, .after = country)

ind_clean %>% 
  glimpse()

ind_clean %>% 
  write_csv("2021/2021-07-06/holidays.csv")

```
