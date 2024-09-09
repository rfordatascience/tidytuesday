# Mostly clean data provided by https://opportunityinsights.org.
library(tidyverse)

data_url <- "https://opportunityinsights.org/wp-content/uploads/2023/07/CollegeAdmissions_Data.csv"
college_admissions <- readr::read_csv(data_url) |> 
  # Drop redundant variables.
  dplyr::select(
    -"tier_name"
  ) |> 
  # Recode variables.
  dplyr::mutate(
    public = public == "Public",
    flagship = as.logical(flagship)
  )
