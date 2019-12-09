devtools::install_github("rafalab/dslabs")

library(dslabs)
library(tidyverse)
library(here)

murders <- tibble(country = toupper(c("US", "Italy", "Canada", "UK", "Japan", "Germany", "France", "Russia")),
              count = c(3.2, 0.71, 0.5, 0.1, 0, 0.2, 0.1, 0),
              label = c(as.character(c(3.2, 0.71, 0.5, 0.1, 0, 0.2, 0.1)), "No Data"),
              code = c("us", "it", "ca", "gb", "jp", "de", "fr", "ru"))

gun_murders <- tibble(country = toupper(c("United States", "Canada", "Portugal", "Ireland", "Italy", "Belgium", "Finland", "France", "Netherlands", "Denmark", "Sweden", "Slovakia", "Austria", "New Zealand", "Australia", "Spain", "Czech Republic", "Hungry", "Germany", "United Kingdom", "Norway", "Japan", "Republic of Korea")),
              count = c(3.61, 0.5, 0.48, 0.35, 0.35, 0.33, 0.26, 0.20, 0.20, 0.20, 0.19, 0.19, 0.18, 0.16,
                        0.16, 0.15, 0.12, 0.10, 0.06, 0.04, 0.04, 0.01, 0.01))

diseases <- dslabs::us_contagious_diseases

nyc <- dslabs::nyc_regents_scores


murders %>% 
  write_csv(here("2019", "2019-12-10","international_murders.csv"))

gun_murders %>% 
  write_csv(here("2019", "2019-12-10","gun_murders.csv"))


diseases %>% 
  write_csv(here("2019", "2019-12-10","diseases.csv"))

nyc %>% 
  write_csv(here("2019", "2019-12-10","nyc_regents.csv"))
