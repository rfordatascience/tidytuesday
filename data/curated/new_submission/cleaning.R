# Clean data provided by {palmtrees} R package. No cleaning was necessary.
# install.packages("devtools")

devtools::install_github("EmilHvitfeldt/palmtrees")
library(palmtrees)
library(dplyr)

palmtrees <- palmtrees::palmtrees |>
  dplyr::mutate(
    dplyr::across(
      "max_leaf_number",
      as.integer
    )
  )

