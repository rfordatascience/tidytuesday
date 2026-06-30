# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

# Clean data provided by <source of data>. No cleaning was necessary.

library(fightr)
library(dplyr)
ufc_athletes <- fightr::get_ufc_data("ufc_athletes")

# Removing Events that do not have results
ufc_fights <- fightr::get_ufc_data("ufc_fights")|>
  dplyr::filter(!is.na(f1_result))

ufcstats_data <- fightr::get_ufc_data("ufcstats_data")
ultimate_ufc_dataset<- fightr::get_ufc_data("ultimate_ufc_dataset")
ufc_rankings_dataset <- fightr::get_ufc_data("ufc_rankings_dataset")
