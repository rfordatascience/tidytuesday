# The History of Himalayan Mountaineering Expeditions

This week, we are exploring mountaineering data from the [Himalayan Dataset](https://www.himalayandatabase.com/index.html)!

The Himalayan Database is a comprehensive archive documenting mountaineering expeditions in the Nepal Himalaya. It continues the pioneering work of [Elizabeth Hawley](https://www.himalayandatabase.com/history.html), a journalist who dedicated much of her life to cataloging climbing history in the region. Her meticulous records were initially compiled from a wide range of sources, including books, alpine journals, and direct correspondence with Himalayan climbers.

Originally published in 2004 by the American Alpine Club as a CD-ROM booklet, the Himalayan Database became a critical resource for the climbing community. In 2017, a non-profit organization named The Himalayan Database was formed to continue Hawley's legacy. This marked the release of Version 2 of the database, now freely available for download via the [internet](https://www.himalayandatabase.com/downloads.html).

These data are rich in historical value, detailing the peaks, expeditions, climbing statuses, and geographic information of numerous Himalayan summits. We will explore these data in two tidy tibbles, making it easier to analyze trends in mountaineering expeditions, including seasonality, success rates, and national participation over time.  Participants this week will be able to use the peaks and expeditions datasets.  To manage file size, the expeditions file was filtered down to 2020-2024.


* What is the distribution of climbing status (PSTATUS) across different mountain ranges (HIMAL_FACTOR)?
* Which mountain range (HIMAL_FACTOR) has the highest average peak height (HEIGHTM)?
* What is the distribution of peak heights (HEIGHTM) for peaks that are open (OPEN) versus those that are not?
* Which climbing routes (ROUTE1, ROUTE2, ROUTE3, ROUTE4) have the highest success rates (SUCCESS1, SUCCESS2, SUCCESS3, SUCCESS4) across all expeditions?
* How does the use of supplemental oxygen (O2USED, O2NONE) affect summit success rates?
* How often does bad weather (TERMREASON = 4) play a role in termination compared to technical difficulty (TERMREASON = 10)?
* Are expeditions with no hired personnel (NOHIRED) associated with higher or lower death rates?

Thank you to [Nicolas Foss, Ed.D., MS](https://www.linkedin.com/in/nicolas-foss) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-01-21')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 3)

exped_tidy <- tuesdata$exped_tidy
peaks_tidy <- tuesdata$peaks_tidy

# Option 2: Read directly from GitHub

exped_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/exped_tidy.csv')
peaks_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/peaks_tidy.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `exped_tidy.csv`

|variable          |class         |description                           |
|:-----------------|:-------------|:-------------------------------------|
|EXPID             |factor |Expedition ID. |
|PEAKID            |factor |Peak ID |
|YEAR              |factor |Year of the expedition. |
|SEASON            |integer       |Season of the expedition as an integer. |
|SEASON_FACTOR     |character     | Season of the expedition converted to a the descriptive name. |
|HOST              |integer       |Host county of the expedition as an integer. |
|HOST_FACTOR       |character     |Host country of the expedition converted to a descriptive name. |
|ROUTE1            |factor |Climbing route 1. |
|ROUTE2            |factor |Climbing route 2. |
|ROUTE3            |factor |Climbing route 3. |
|ROUTE4            |factor |Climbing route 4. |
|NATION            |factor |Principle nationality. |
|LEADERS           |factor |Leadership of the expedition. |
|SPONSOR           |factor |Expedition sponsor / name. |
|SUCCESS1          |logical       |Success on route 1? |
|SUCCESS2          |logical       |Success on route 2? |
|SUCCESS3          |logical       |Success on route 3? |
|SUCCESS4          |logical       |Success on route 4? |
|ASCENT1           |factor |Ascent numbers for route 1. |
|ASCENT2           |factor |Ascent numbers for route 2. |
|ASCENT3           |factor |Ascent numbers for route 3. |
|ASCENT4           |factor |Ascent numbers for route 4. |
|CLAIMED           |logical       |Success claimed? |
|DISPUTED          |logical       |Success disputed? |
|COUNTRIES         |factor |Other countries. |
|APPROACH          |factor |Approach march. |
|BCDATE            |date          |Date arrived at base camp. |
|SMTDATE           |date          |Date reached summit. |
|SMTTIME           |factor |Time reached summit. |
|SMTDAYS           |integer       |Number of days to summit / high-point. |
|TOTDAYS           |integer       |Total number of days. |
|TERMDATE          |date          |Date the expedition was terminated. |
|TERMREASON        |integer       |Reason the expedition was terminated as an integer. |
|TERMREASON_FACTOR |character     |Reason the expedition was terminated converted to a descriptive name. |
|TERMNOTE          |factor |Termination details. |
|HIGHPOINT         |integer       |Expedition high-point. |
|TRAVERSE          |logical       |Did the expedition traverse. |
|SKI               |logical       |Ski / snowboard descent? |
|PARAPENTE         |logical       |Parapente descent? |
|CAMPS             |integer       |Number of high camps above base camp. |
|ROPE              |integer       |Amount of fixed rope. |
|TOTMEMBERS        |integer       |Number of members. |
|SMTMEMBERS        |integer       |Number of members on summit. |
|MDEATHS           |integer       |Number of member deaths. |
|TOTHIRED          |integer       |Number of hired personnel (above base camp). |
|SMTHIRED          |integer       |Number of hired personnel on summit. |
|HDEATHS           |integer       |Number of hired personnel deaths. |
|NOHIRED           |logical       |No hired personnel used above base camp. |
|O2USED            |logical       |Oxygen used? |
|O2NONE            |logical       |Oxygen not used? |
|O2CLIMB           |logical       |Oxygen climbing? |
|O2DESCENT         |logical       |Oxygen descending? |
|O2SLEEP           |logical       |Oxygen sleeping? |
|O2MEDICAL         |logical       |Oxygen used medically? |
|O2TAKEN           |logical       |Oxygen taken, not used? |
|O2UNKWN           |logical       |Oxygen use unknown? |
|OTHERSMTS         |factor |Other summits. |
|CAMPSITES         |factor |Campsite details. |
|ROUTEMEMO         |factor |Route details. |
|ACCIDENTS         |factor |Accidents on the expedition. |
|ACHIEVMENT        |factor |Achievements. |
|AGENCY            |factor |Trekking agency. |
|COMRTE            |logical       |Commercial route? |
|STDRTE            |logical       |8000m standard route? |
|PRIMRTE           |logical       |Route info with primary expedition? |
|PRIMMEM           |logical       |Member info with primary expedition? |
|PRIMREF           |logical       |Literature info with primary expedition? |
|PRIMID            |factor |Primary expedition ID (if any). |
|CHKSUM            |integer       |Internal consistency check. |

# `peaks_tidy.csv`

|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|PEAKID     |integer |Peak ID, the key field (unique identifier) for each record. |
|PKNAME     |integer |Peak name. |
|PKNAME2    |integer |Peak name 2. |
|LOCATION   |integer |Location of the peak. |
|HEIGHTM    |integer |Peak height in meters. |
|HEIGHTF    |integer |Peak height in feet. |
|HIMAL      |integer |Mountain range identifier.  See HIMAL_FACTOR for names.  |
|HIMAL_FACTOR   |integer   |Mountain range name. |
|REGION   |integer   |Region identifier. |
|REGION_FACTOR  |character |Region name. |
|OPEN     |logical   |Indicates  whether the peak is open for expeditions. |
|UNLISTED       |logical   |Indicates whether the peak is unlisted in official records. |
|TREKKING       |logical   |Indicates whether the peak is a trekking peak. |
|TREKYEAR        |integer   |Year the peak was designated as a trekking peak. |
|RESTRICT        |logical   |Indicates whether the peak is restricted for climbing or access. |
|PHOST           |integer   |Primary host country identifier for the peak. See PHOST_FACTOR for names. |
|PHOST_FACTOR    |character |Primary host country name corresponding to the PHOST identifier. |
|PSTATUS         |integer   |Climbing status identifier for the peak. See PSTATUS_FACTOR for names. |
|PSTATUS_FACTOR  |character |Climbing status description corresponding to the PSTATUS identifier. |
|PEAKMEMO        |character |Additional notes or remarks about the peak. |
|PYEAR           |integer   |Year of the first recorded climbing attempt on the peak. |
|PSEASON         |character |Climbing season associated with the first recorded ascent or expedition. |
|PEXPID          |integer   |Expedition ID associated with the first recorded climb. |
|PSMTDATE        |character |Date of the first successful summit. |
|PCOUNTRY        |character |Country of origin for the expedition or climbers. |
|PSUMMITERS      |integer   |Number of climbers who first reached the summit. |
|PSMTNOTE        |character |Notes or remarks related to the first successful summit. |
|REFERMEMO       |character |Peak chronology references. |
|PHOTOMEMO       |character |Peak photo references. |

### Cleaning Script

```r
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
```
