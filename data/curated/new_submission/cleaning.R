# Imports
library(tidyverse)
library(devtools)

#devtools::install_github("EmilHvitfeldt/sherlock")
library(sherlock)

# Load the dataset
holmes <- sherlock::holmes |>
  # Add line numbers to preserve narrative order
  mutate(line_num = row_number(), .by = "book") |>
  # Reorder columns
  select("book", "text", "line_num")
