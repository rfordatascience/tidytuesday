
# Data manually downloaded from Netflix News to a `tt_submission` folder, from:

# last half 2023: https://assets.ctfassets.net/4cd45et68cgf/inuAnzotdsAEgbInGLzH5/1be323ba419b2af3a96bffa29acc31a3/What_We_Watched_A_Netflix_Engagement_Report_2023Jul-Dec.xlsx
# first half 2024: https://assets.ctfassets.net/4cd45et68cgf/2PoZlfdc46dH2gQvI8eUzI/9db5840720c47acfcf7b89ffe2402860/What_We_Watched_A_Netflix_Engagement_Report_2024Jan-Jun.xlsx
# last half 2024: https://assets.ctfassets.net/4cd45et68cgf/6XSmoEjBjVMPRtYybT9d1E/8c0b0b2645b8712d5597b0bdbe0d64e2/What_We_Watched_A_Netflix_Engagement_Report_2024Jul-Dec.xlsx
# first half 2025: https://assets.ctfassets.net/4cd45et68cgf/mplcXj5ulHDfbCPCr0f0I/5dbb6ec09f03df89706476e380e9b8bd/What_We_Watched_A_Netflix_Engagement_Report_2025Jan-Jun.xlsx

# This script reads in the downloaded reports, separates excel sheets into separate data files, and fixes variable names

library(tidyverse)
library(readxl)
library(here)
library(janitor)

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
  mutate(report = str_sub(source, -11), .before = title) %>%
  mutate(release_date = ymd(release_date), 
         hours_viewed = as.numeric(hours_viewed),
         runtime = hm(runtime),
         views = as.numeric(views)) 


# Read and combine Movies data  

movies <- read_and_combine_sheets(excel_files, "Film") %>%
  row_to_names(4) %>%
  clean_names() %>%
  rename(source = x1_what_we_watched_a_netflix_engagement_report_2025jan_jun) %>%
  mutate(report = str_sub(source, -11), .before = title) %>%
  mutate(release_date = ymd(release_date), 
         hours_viewed = as.numeric(hours_viewed),
         runtime = hm(runtime),
         views = as.numeric(views)) 

