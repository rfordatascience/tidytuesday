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

# Step 4: Locate the peaks.DBF and exped.DBP files
dbf_file_peaks <- file.path(extracted_dir, "Himalayan Database", "HIMDATA", "peaks.DBF")
dbf_file_exped <- file.path(extracted_dir, "Himalayan Database", "HIMDATA", "exped.DBF")
print(dbf_file_peaks) # Debugging: Verify the file path
print(dbf_file_exped) # Debugging: Verify the file path

# Step 5: Read the .DBF files using the `foreign` package
peaks_data <- foreign::read.dbf(dbf_file_peaks, as.is = F)
exped_data <- foreign::read.dbf(dbf_file_exped, as.is = F)

# Step 6: Convert the data to a tidy tibble
peaks_temp <- tibble::as_tibble(peaks_data)
exped_temp <- tibble::as_tibble(exped_data)

# Preview the data
glimpse(peaks_temp)
glimpse(exped_temp)

# Clean up temporary files (optional)
unlink(c(zip_file, extracted_dir), recursive = TRUE)

###_____________________________________________________________________________
### Add columns that recode some variables that are integers into character
### strings that describe their subject in the peaks dataset
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

###_____________________________________________________________________________
### Add columns that recode some variables that are integers into character
### strings that describe their subject in the expeditions dataset
###_____________________________________________________________________________

exped_tidy <- exped_temp |> 
  dplyr::mutate(SEASON_FACTOR = case_when(SEASON == 0 ~ "Unknown",
                                          SEASON == 1 ~ "Spring",
                                          SEASON == 2 ~ "Summer",
                                          SEASON == 3 ~ "Autumn",
                                          SEASON == 4 ~ "Winter",
                                          TRUE ~ NA_character_
                                          ),
                .after = SEASON
                ) |> 
  dplyr::mutate(HOST_FACTOR = case_when(HOST == 0 ~ "Unknown",
                                        HOST == 1 ~ "Nepal",
                                        HOST == 2 ~ "China",
                                        HOST == 3 ~ "India",
                                        TRUE ~ NA_character_
                                        ),
                .after = HOST
                ) |> 
  dplyr::mutate(TERMREASON_FACTOR = case_when(TERMREASON == 0 ~ "Unknown",
                                       TERMREASON == 1 ~ "Success (main peak)",
                                       TERMREASON == 2 ~ "Success (subpeak, foresummit)",
                                       TERMREASON == 3 ~ "Success (claimed)",
                                       TERMREASON == 4 ~ "Bad weather (storms, high winds)",
                                       TERMREASON == 5 ~ "Bad conditions (deep snow, avalanching, falling ice, or rock)",
                                       TERMREASON == 6 ~ "Accident (death or serious injury)",
                                       TERMREASON == 7 ~ "Illness, AMS, exhaustion, or frostbite",
                                       TERMREASON == 8 ~ "Lack (or loss) of supplies, support or equipment",
                                       TERMREASON == 9 ~ "Lack of time",
                                       TERMREASON == 10 ~ "Route technically too difficult, lack of experience, strength, or motivation",
                                       TERMREASON == 11 ~ "Did not reach base camp",
                                       TERMREASON == 12 ~ "Did not attempt climb",
                                       TERMREASON == 13 ~ "Attempt rumored",
                                       TERMREASON == 14 ~ "Other"
                                       ),
                .after = TERMREASON
                ) |> 
  filter(grepl(pattern = "202[01234]", x = YEAR))

################################################################################
### End  #######################################################################
################################################################################
