# Clean data provided by Chris Dalla Riva Billboard Hot 100 Number Ones Database Google Sheet
# No cleaning was necessary.

library(googlesheets4)
library(janitor)

billboard <- read_sheet("https://docs.google.com/spreadsheets/d/1j1AUgtMnjpFTz54UdXgCKZ1i4bNxFjf01ImJ-BqBEt0/edit?gid=1974823090#gid=1974823090", sheet = 2) %>%
  clean_names()

topics <- read_sheet("https://docs.google.com/spreadsheets/d/1j1AUgtMnjpFTz54UdXgCKZ1i4bNxFjf01ImJ-BqBEt0/edit?gid=1974823090#gid=1974823090", sheet = 4) %>%
  clean_names()

