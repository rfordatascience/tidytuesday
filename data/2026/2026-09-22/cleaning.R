# Packages 
library(readxl)
library(janitor)
library(dplyr)
library(tidyr)
library(withr)

# Download the dataset from the UN-Habitat website and save it as a local file.
xlsx_url <- "https://guo-un-habitat.maps.arcgis.com/sharing/rest/content/items/4350427c2e3341f69de14cb00c8d3ef3/data"
xlsx_file <- withr::local_tempfile(fileext = ".xlsx")
download.file(xlsx_url, xlsx_file, mode = "wb")

# Clean dataset 
# Ignore the first sheet because it has metadata and info 
# Then we will fix the columns that are in wide format and leave 
# the entire dataset in long format 
urban <- readxl::read_excel(xlsx_file, 
                            sheet = 2, 
                            na = '-') |> 
  janitor::clean_names(case = "small_camel") |> 
  tidyr::pivot_longer(
    cols = matches("^(averageShareOfGreenAreaInCityUrbanArea|greenAreaPerCapita)\\d{4}"),
    names_to = c(".value", "year"),
    names_pattern = "^(averageShareOfGreenAreaInCityUrbanArea|greenAreaPerCapita)(\\d{4})"
  ) |>
  rename(
    averageShareOfGreenAreaInCityUrbanAreaPct = averageShareOfGreenAreaInCityUrbanArea,
    greenAreaPerCapitaM2 = greenAreaPerCapita
  ) |>
  mutate(year = as.integer(year))

