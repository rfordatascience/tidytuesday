
# Data downloaded from Netflix News https://about.netflix.com/en/news/what-we-watched-the-first-half-of-2025
# Cleaning script read in reports from 2023-2025, separated excel sheets into separate data files and fixed variable names

library(tidyverse)
library(readxl)
library(here)

# Define the folder path where your Excel files are located
folder_path <- here("tt_submission", "data")

# Get list of Excel files
excel_files <- list.files(folder_path, pattern = "\\.xlsx$", full.names = TRUE)

# Function to read and combine data for a specific sheet type (TV or Film)

read_and_combine_sheets <- function(files, sheet_name) {
  files %>%
    set_names(tools::file_path_sans_ext(basename(.))) %>%
    map_dfr(~ {
      # Read the specific sheet from each file
      read_excel(.x, sheet = sheet_name)
    }, .id = "file_id")
}

# Read and combine TV data

shows <- read_and_combine_sheets(excel_files, "TV") %>%
  row_to_names(4) %>%
  clean_names() %>%
  rename(source = x1_what_we_watched_a_netflix_engagement_report_2025jan_jun) %>%
  mutate(report = str_sub(source, -11)) %>%
  relocate(report, .before = title) %>%
  mutate(release_date = ymd(release_date), 
         hours_viewed = as.numeric(hours_viewed),
         runtime = hm(runtime),
         views = as.numeric(views)) 


# Read and combine Movies data  

movies <- read_and_combine_sheets(excel_files, "Film") %>%
  row_to_names(4) %>%
  clean_names() %>%
  rename(source = x1_what_we_watched_a_netflix_engagement_report_2025jan_jun) %>%
  mutate(report = str_sub(source, -11)) %>%
  relocate(report, .before = title) %>%
  mutate(release_date = ymd(release_date), 
         hours_viewed = as.numeric(hours_viewed),
         runtime = hm(runtime),
         views = as.numeric(views)) 

