# Data saved for TidyTuesday using the new curation functions in the dev branch
# of the {tidytuesdayR} package. See
# https://dslc-io.github.io/tidytuesdayR/articles/curating.html for details.

# install.packages("pak")
# pak::pak("dslc-io/tidytuesdayR")
# library(tidytuesdayR)
# tidytuesdayR::tt_clean()

# Clean data provided by the {pixarfilms} package by Eric Leung. Additional
# datasets are available in the package or via the package's GitHub repository
# at https://erictleung.com/pixarfilms/

# install.packages("pixarfilms")
library(pixarfilms)

pixar_films <- pixarfilms::pixar_films |>
  dplyr::mutate(
    dplyr::across(
      c("number", "run_time"),
      as.integer
    )
  )
public_response <- pixarfilms::public_response |>
  dplyr::mutate(
    dplyr::across(
      c("rotten_tomatoes", "metacritic", "critics_choice"),
      as.integer
    )
  )

# tidytuesdayR::tt_save_dataset(pixar_films)
# tidytuesdayR::tt_save_dataset(public_response)
