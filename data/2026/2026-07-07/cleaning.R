# install.packages("pak")
pak::pak("benyamindsmith/fightr")

library(fightr)
library(dplyr)
library(janitor)

fightr::update_all_ufc_data()

ufc_athletes <- fightr::get_ufc_data("ufc_athletes") |> 
  janitor::clean_names()

# Removing Events that do not have results
ufc_fights <- fightr::get_ufc_data("ufc_fights")|>
  dplyr::filter(!is.na(f1_result)) |> 
    janitor::clean_names()

ufcstats_data <- fightr::get_ufc_data("ufcstats_data") |> 
  janitor::clean_names()
ultimate_ufc_dataset<- fightr::get_ufc_data("ultimate_ufc_dataset") |> 
  janitor::clean_names()
ufc_rankings_dataset <- fightr::get_ufc_data("ufc_rankings_dataset") |> 
  janitor::clean_names()

