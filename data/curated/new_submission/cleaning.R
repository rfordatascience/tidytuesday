# install.packages("pak")
# pak::pak("benyamindsmith/fightr")

library(fightr)
# fightr::update_all_ufc_data()
library(dplyr)
library(lubridate)

ufc_athletes <- fightr::get_ufc_data("ufc_athletes")

# Removing Events that do not have results
ufc_fights <- fightr::get_ufc_data("ufc_fights") |>
  dplyr::filter(!is.na(f1_result))

ufcstats_data <- fightr::get_ufc_data("ufcstats_data")
ultimate_ufc_dataset<- fightr::get_ufc_data("ultimate_ufc_dataset")
ufc_rankings_dataset <- fightr::get_ufc_data("ufc_rankings_dataset")
