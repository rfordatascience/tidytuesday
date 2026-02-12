
# Data read from https://figure.nz/table/TSQ8lkuKnyzfERF3/download
# Cleaning to fix column names and remove empty variables

library(tidyverse)
library(janitor)

dataset <- readr::read_csv("https://figure.nz/table/TSQ8lkuKnyzfERF3/download") %>%
  janitor::clean_names() %>%
  dplyr::select(-value_unit, -null_reason, -metadata_1)


