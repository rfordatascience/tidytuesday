# This script was used to clean data saved as 13 csv files 
# from the Italian Istituto Nazionale di Geofisica e Vulcanologia found
# here https://terremoti.ov.ingv.it/gossip/vesuvio/index.html

# Load packages
library(tidyverse)
library(janitor)

# List all vesuvius CSV files in the data_raw folder
file_list <- list.files(path = "data/data_raw", pattern = "^vesuvius_\\d{4}\\.csv$", full.names = TRUE)

# Read and row-bind all CSVs
vesuvius_data <- 
  file_list |> 
  map_dfr(read_csv)

# Clean column names and create year variable from time variable
vesuvius <- 
  vesuvius_data |> 
  clean_names() |> 
  mutate(
    year = year(time)
  )


# Add unit and context to column names
vesuvius <- 
  vesuvius |> 
  rename(duration_magnitude_md = md, 
         depth_km = depth,
         event_id = number_event_id,
         review_level = level)

# Translate some values from Italian to English
# Rivisto is revised (reviewed by humans)
# Bollettino is "bulletin" or the original preliminary source of the data,
# the Italian Seismic Bulletin (Il Bollettino Sismico Italiano)
vesuvius <-
  vesuvius |> 
  mutate(review_level = case_when(
    review_level == "Rivisto" ~ "revised",
    review_level == "Bollettino" ~ "preliminary",
    .default = NA_character_
  ))

# Let's change vesuvio to Mount Vesuvius! (Same value for all rows, but still)
vesuvius <-
  vesuvius |> 
  mutate(area = case_when(
    area == "vesuvio" ~ "Mount Vesuvius",
    .default = NA_character_
  ))

# Make year and event_id into integers, but everything else is a decimal/dbl
vesuvius <-
  vesuvius |> 
  mutate(
    dplyr::across(
      c("event_id", "year"),
      as.integer
    )
  )
