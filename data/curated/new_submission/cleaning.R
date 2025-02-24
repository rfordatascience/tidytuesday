# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

# Clean data provided by {animalshelter} R package (https://emilhvitfeldt.github.io/animalshelter/). No cleaning was necessary.
# install.packages("devtools")
# devtools::install_github("EmilHvitfeldt/animalshelter")
library(dplyr)
library(animalshelter)

longbeach <- animalshelter::longbeach |> 
  dplyr::mutate(
    dplyr::across(
      c("was_outcome_alive"),
      as.factor
      )
    )
