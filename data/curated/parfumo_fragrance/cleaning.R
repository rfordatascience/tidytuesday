###_____________________________________________________________________________
### Parfumo Fragrance
### Script to clean the data sourced from Kaggle
### Thanks to Olga G. Miufana!
###_____________________________________________________________________________

# packages
library(httr)
library(tidyverse)
library(jsonlite)
library(glue)
library(janitor)
library(naniar)

# Define the metadata URL and fetch it
metadata_url <- "https://www.kaggle.com/datasets/olgagmiufana1/parfumo-fragrance-dataset/croissant/download"
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
parfumo_data <- read_csv(csv_file)

# Step 5: Explore the data
glimpse(parfumo_data)

###_____________________________________________________________________________
# Problems with the Data!

# Some of the columns utilize "N/A" instead of a missing value
# deal with these values efficiently using {tidyselect} and {dplyr}
# additionally, the perfume names include the brand and sometimes the year
# along with a perfume number
# clean the perfume names so we have only the names as there are separate
# variables for the brand and release year
# use the perfume number as an additional column
# there are some numeric columns that are encoded as character due to the "N/A"
# values, we will deal with those
# variables that could be numeric are encoded as strings due to the use of "N/A"
# versus a true missing
# fix!

###_____________________________________________________________________________

# we will create a few different objects while we clean 
# to inspect and avoid errors

parfumo_data_prep <- parfumo_data |> 
  dplyr::mutate(
    
    # replace the "N/A" values with true missings
    dplyr::across(
      
      tidyselect::everything(), ~ dplyr::if_else(
        
        grepl(pattern = "\\bN/A\\b", x = .), NA_character_, .
        
        )
      
      )) |> 
  dplyr::mutate(
    
    # new perfume # variable
    Number = stringr::str_extract(Name, pattern = "^#?\\s?\\d*\\.?\\d*?"),
    
    # remove the preceding optional pound sign and space
    Number = stringr::str_remove(Number, pattern = "^#?\\s?"),
    .before = Name
    
    ) |> 
  
  # replace Number blanks with NA, as some have no # value
  naniar::replace_with_na(replace = list(Number = "")) |> 
  dplyr::mutate(
    
    # create a temporary pattern variable to pick up the year
    # and brand names that appear in the Name string to build
    # dynamic regex for each row
    # leverage the {glue} package, here
    
    dynamic_pattern = glue::glue("(?:\\s{Brand})*(?:\\s{`Release Year`})?$"),
    
    # clean the perfume name
    Clean_Name = stringr::str_remove_all(Name, pattern = "^#?\\s?\\d*\\.?\\d*\\s?-?\\s?"),
    
    # again for the Brand and Release Year removal
    
    Clean_Name = stringr::str_remove_all(Clean_Name, pattern = dynamic_pattern),
    Clean_Name = str_squish(Clean_Name),
    .before = Name
    
  ) |> 
  
  dplyr::select(-dynamic_pattern, -Name)

# inspect the object after initial cleaning

glimpse(parfumo_data_prep)

# a new dplyr chain to continue cleaning,
# break it up to mutate and inspect to avoid errors

parfumo_data_clean <- parfumo_data_prep |> 
  
  dplyr::rename(Name = Clean_Name) |> 
  
  # the rating value column as the word "Ratings" in it, preventing the column from being
  # numeric, fix
  # release year, rating value, and rating count are still character strings instead of numeric values
  # fix!
  
  dplyr::mutate(
    `Rating Count` = stringr::str_remove_all(`Rating Count`, pattern = "\\sRatings$"),
    across(c(`Release Year`, `Rating Value`, `Rating Count`), ~ as.numeric(.))
  ) |> 
  
  # clean the names so that they are easier to use in the future
  
  clean_names(case = "title", sep_out = "_") |> 
  rename(URL = Url)

# inspect the final object

glimpse(parfumo_data_clean)
  
###_____________________________________________________________________________
### End
###_____________________________________________________________________________
