# Imports
library(tidyverse)

# Download raw data and filter to endangered status
endangered_status <- 
  readr::read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/refs/heads/master/cldf/values.csv") |> 
  dplyr::filter(Parameter_ID == "aes") |> 
  dplyr::select(Language_ID, Value, Code_ID) |> 
  dplyr::rename(id = Language_ID,
                status_code = Value,
                status_label = Code_ID) |> 
  dplyr::mutate(status_label = stringr::str_replace(stringr::str_remove(status_label, "^aes-"), "_", " "))

# Download language and family data
fam_lgs <- 
  readr::read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/refs/heads/master/cldf/languages.csv")

# Filter and clean language family data
families <- 
  fam_lgs |> 
  dplyr::filter(Level == "family") |> 
  dplyr::select(ID, Name) |> 
  dplyr::rename(Family = Name) |> 
  dplyr::rename_with(stringr::str_to_lower, dplyr::everything())

# Filter and clean language data
languages <- 
  fam_lgs |> 
  dplyr::filter(Level == "language") |> 
  dplyr::select(ID, Name, Macroarea, Latitude, Longitude, ISO639P3code, Countries, Is_Isolate, Family_ID) |> 
  dplyr::rename_with(stringr::str_to_lower, dplyr::everything())

