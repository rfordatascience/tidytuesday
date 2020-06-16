
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
