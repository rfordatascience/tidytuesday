
# Imports
library(tidyverse)
library(devtools)

#devtools::install_github("EmilHvitfeldt/sherlock")
library(sherlock)

# Load the dataset
holmes <- sherlock::holmes

# Add line numbers to preserve narrative order
holmes <- holmes %>%
  mutate(line_num = row_number())

# Reorder columns
holmes <- holmes %>%
  select(book, text, line_num)

