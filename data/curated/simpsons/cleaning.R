###_____________________________________________________________________________
### The Simpson's data!
### Script to clean the data sourced from Kaggle
###_____________________________________________________________________________

# packages
library(httr)
library(tidyverse)
library(jsonlite)
library(glue)
library(janitor)
library(naniar)

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

# Download the ZIP file
temp_file <- base::tempfile(fileext = ".zip")
utils::download.file(zip_url, temp_file, mode = "wb")

# Unzip and read the CSV
unzip_dir <- base::tempdir()
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
glimpse(parfumo_data)

# Clean up temporary files (optional)
unlink(c(temp_file, unzip_dir), recursive = TRUE)

###_____________________________________________________________________________
# Problems with the Data!

# The script lines are of great interest, but it is a larger file, too big
# for Tidy Tuesday.  We need to reduce the size of the file so we can use all
# the files together for a more robust analysis.
# Let's filter episodes down to the years 2010-2016, and then only select
# the script lines that correspond with with those episodes.

###_____________________________________________________________________________

# filter
simpsons_episodes_filter <- simpsons_episodes |> 
  filter(original_air_year >= 2010)

# get episode ids of interest
new_episode_id <- simpsons_episodes_filter$id

# filter script lines to only include lines for these episodes

simpsons_script_lines_filter <- simpsons_script_lines |> 
  filter(episode_id %in% new_episode_id)

# visualize viewership throughout the life of the Simpson's


# export



################################################################################
### End ########################################################################
################################################################################