###_____________________________________________________________________________
### The Simpson's data!
### Script to clean the data sourced from Kaggle
###_____________________________________________________________________________

# packages
library(httr)
library(tidyverse)
library(jsonlite)
library(withr)

# Define the metadata URL and fetch it
metadata_url <- "www.kaggle.com/datasets/prashant111/the-simpsons-dataset/croissant/download"
response <- httr::GET(metadata_url)

# Ensure the request succeeded
if (httr::http_status(response)$category != "Success") {
  stop("Failed to fetch metadata.")
}

# Parse the metadata
metadata <- httr::content(response, as = "parsed", type = "application/json")

# Locate the ZIP file URL
distribution <- metadata$distribution
zip_url <- NULL

for (file in distribution) {
  if (file$encodingFormat == "application/zip") {
    zip_url <- file$contentUrl
    break
  }
}

if (is.null(zip_url)) {
  stop("No ZIP file URL found in the metadata.")
}

# Download the ZIP file. We'll use the withr package to make sure the downloaded
# files get cleaned up when we're done.
temp_file <- withr::local_tempfile(fileext = ".zip") 
utils::download.file(zip_url, temp_file, mode = "wb")

# Unzip and read the CSV
unzip_dir <- withr::local_tempdir()
utils::unzip(temp_file, exdir = unzip_dir)

# Locate the CSV file within the extracted contents
csv_file <- list.files(unzip_dir, pattern = "\\.csv$", full.names = TRUE)

if (length(csv_file) == 0) {
  stop("No CSV file found in the unzipped contents.")
}

# Read the CSV into a dataframe
simpsons_characters <- read_csv(csv_file[1])
simpsons_episodes <- read_csv(csv_file[2])
simpsons_locations <- read_csv(csv_file[3])
simpsons_script_lines <- read_csv(csv_file[4])

# Step 5: Explore the data
glimpse(simpsons_characters)
glimpse(simpsons_episodes)
glimpse(simpsons_locations)
glimpse(simpsons_script_lines)

###_____________________________________________________________________________
# Problems with the Data!

# The script lines are of great interest, but it is a larger file, too big
# for Tidy Tuesday.  We need to reduce the size of the file so we can use all
# the files together for a more robust analysis.
# Let's filter episodes down to the years 2010-2016, and then only select
# the script lines that correspond with those episodes.

###_____________________________________________________________________________

# filter episodes to include 2010+
simpsons_episodes <- simpsons_episodes |> 
  dplyr::filter(original_air_year >= 2010)

# filter script lines to only include lines for these episodes
simpsons_script_lines <- simpsons_script_lines |> 
  dplyr::semi_join(simpsons_episodes, by = c("episode_id" = "id"))
