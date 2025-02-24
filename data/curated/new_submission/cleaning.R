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
