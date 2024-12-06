################################################################################
### Cleaning data from the Himalayan Database ##################################
################################################################################

library(tidyverse)
library(foreign)
library(janitor)
library(httr)
library(glue)
library(zip)

###_____________________________________________________________________________
### Utilize httr and foreign to gain access to the file and import
###_____________________________________________________________________________

# Step 1: Set up the URL and file paths
url <- "https://www.himalayandatabase.com/downloads/Himalayan%20Database.zip"
zip_file <- tempfile(fileext = ".zip")
extracted_dir <- tempfile()

# Step 2: Download the ZIP file
httr::GET(url, httr::write_disk(zip_file, overwrite = TRUE))

# Step 3: Extract the ZIP file
zip::unzip(zip_file, exdir = extracted_dir)

# Test to confirm the extracted contents
list.files(extracted_dir, recursive = TRUE)

# Step 4: Locate the peaks.DBF file
dbf_file <- file.path(extracted_dir, "Himalayan Database", "HIMDATA", "peaks.DBF")
print(dbf_file) # Debugging: Verify the file path

# Step 5: Read the .DBF file using the `foreign` package
peaks_data <- foreign::read.dbf(dbf_file, as.is = F)

# Step 6: Convert the data to a tidy tibble
peaks_temp <- tibble::as_tibble(peaks_data)

# Preview the data
print(peaks_temp)

# Clean up temporary files (optional)
unlink(c(zip_file, extracted_dir), recursive = TRUE)

###_____________________________________________________________________________
### Add columns that recode some variables that are integers into character
### strings that describe their subject
###_____________________________________________________________________________

peaks_tidy <- peaks_temp |> 
  dplyr::mutate(HIMAL_FACTOR = case_when(
    HIMAL == 0  ~ "Unclassified",
    HIMAL == 1  ~ "Annapurna",
    HIMAL == 2  ~ "Api/Byas Risi/Guras",
    HIMAL == 3  ~ "Damodar",
    HIMAL == 4  ~ "Dhaulagiri",
    HIMAL == 5  ~ "Ganesh/Shringi",
    HIMAL == 6  ~ "Janak/Ohmi Kangri",
    HIMAL == 7  ~ "Jongsang",
    HIMAL == 8  ~ "Jugal",
    HIMAL == 9  ~ "Kangchenjunga/Simhalila",
    HIMAL == 10 ~ "Kanjiroba",
    HIMAL == 11 ~ "Kanti/Palchung",
    HIMAL == 12 ~ "Khumbu",
    HIMAL == 13 ~ "Langtang",
    HIMAL == 14 ~ "Makalu",
    HIMAL == 15 ~ "Manaslu/Mansiri",
    HIMAL == 16 ~ "Mukut/Mustang",
    HIMAL == 17 ~ "Nalakankar/Chandi/Changla",
    HIMAL == 18 ~ "Peri",
    HIMAL == 19 ~ "Rolwaling",
    HIMAL == 20 ~ "Saipal",
    TRUE ~ "Unknown" # Default case if a value doesn't match
  ),
  .after = HIMAL
  ) |> 
  mutate(REGION_FACTOR = case_when(
    REGION == 0 ~ "Unclassified",
    REGION == 1 ~ "Kangchenjunga-Janak",
    REGION == 2 ~ "Khumbu-Rolwaling-Makalu",
    REGION == 3 ~ "Langtang-Jugal",
    REGION == 4 ~ "Manaslu-Ganesh",
    REGION == 5 ~ "Annapurna-Damodar-Peri",
    REGION == 6 ~ "Dhaulagiri-Mukut",
    REGION == 7 ~ "Kanjiroba-Far West",
    TRUE        ~ "Unknown" # Default case if a value doesn't match
  ),
  .after = REGION
  ) |> 
  mutate(PHOST_FACTOR = case_when(
    PHOST == 0 ~ "Unclassified",
    PHOST == 1 ~ "Nepal only",
    PHOST == 2 ~ "China only",
    PHOST == 3 ~ "India only",
    PHOST == 4 ~ "Nepal & China",
    PHOST == 5 ~ "Nepal & India",
    PHOST == 6 ~ "Nepal, China & India",
    TRUE       ~ "Unknown" # Default case if a value doesn't match
  ),
  .after = PHOST
  ) |> 
  mutate(PSTATUS_FACTOR = case_when(
    PSTATUS == 0 ~ "Unknown",
    PSTATUS == 1 ~ "Unclimbed",
    PSTATUS == 2 ~ "Climbed",
    TRUE         ~ "Invalid" # Default case if a value doesn't match
  ),
  .after = PSTATUS
  ) |> 
  mutate(across(c(HIMAL_FACTOR, PHOST_FACTOR, PSTATUS_FACTOR), ~ factor(.)))

################################################################################
### End  #######################################################################
################################################################################
