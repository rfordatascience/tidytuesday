# Philadelphia Parking Violations

This week's data is from [Open Data Philly](https://www.opendataphilly.org/dataset/parking-violations) - there is over 1 GB of data, but I have filtered it down to <100 MB due to GitHub restrictions. I accomplished this mainly by filtering to data for only 2017 in Pennsylvania that had lat/long data. If you would like to use the entire dataset, please see the link above.

H/t to [Jess Streeter](https://twitter.com/phillynerd) for sharing this week's data!

Some visualizations from [Philly Open Data](https://data.phila.gov/visualizations/parking-violations) and a news article by [NBC Philadelphia](https://www.nbcphiladelphia.com/news/local/Nearly-6-Million-Philadelphia-Parking-Authority-Tickets-Are-on-the-Rise-Since-2016-565438131.html).

# Get the Data

```
tickets <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-03/tickets.csv")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!
# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load("2019-12-03")
tuesdata <- tidytuesdayR::tt_load(2019, week = 49)

tickets <- tuesdata$tickets
```


# Cleaning

```
# Load Libraries ----------------------------------------------------------

library(here)
library(tidyverse)


# Read in raw Data --------------------------------------------------------

df <- read_csv(here("2019", "2019-12-03", "parking_violations.csv"))

small_df <- df %>% 
  mutate(date = lubridate::date(issue_datetime),
         year = lubridate::year(date)) %>% 
  filter(year == 2017, state == "PA") %>% 
  
  # removing date/year as duplicative
  # removing state as all PA
  # gps as filtering only lat/long present
  # division is > 60% missing
  # location as a very large amount of metadata without as much use
  
  select(-date, -year, -gps, -location, -state, -division) %>% 
  filter(!is.na(lat))

pryr::object_size(small_df)

# Write to csv ------------------------------------------------------------

write_csv(small_df, here("2019", "2019-12-03", "tickets.csv"))

```