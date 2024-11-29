# The Scent of Data - Exploring the Parfumo Fragrance Dataset

This week we're diving into the fascinating world of fragrances with a dataset sourced from [Parfumo](https://www.parfumo.com/), a vibrant community of perfume enthusiasts.  [Olga G.](https://www.kaggle.com/olgagmiufana1) webscraped these data from the various fragrance sections on the Parfumo website. Here is a description from the author:

> This dataset contains detailed information about perfumes sourced from Parfumo, obtained through web scraping. It includes data on perfume ratings, olfactory notes (top, middle, and base notes), perfumers, year of release and other relevant characteristics of the perfumes listed on the Parfumo website.

> The data provides a comprehensive look at how various perfumes are rated, which families of scents they belong to, and detailed breakdowns of the key olfactory components that define their overall profile

We’ll explore how perfumes are rated, uncover the scent families they belong to, and delve into the minds of the perfumers behind them. From the year of release to the delicate composition of each scent, this dataset offers a rich olfactory experience for anyone curious about the magic behind their favorite perfumes.

Join us as we decode the stories within these perfumes, from the top notes that hit you first to the lasting base notes that linger in the air. Whether you're a fragrance aficionado or just curious about the data behind the scents, this exploration will open your eyes (and nose) to the artistry of perfume crafting. Ready to sniff out some data?

* What factors most influence the rating of a perfume?
* Are there distinct scent families that dominate the market, and how are they perceived by users?
* Has the popularity of certain fragrance notes evolved over time?

Thank you to [Nicolas Foss, Ed.D., MS | Bureau of Emergency Medical and Trauma Services > Iowa HHS](https://github.com/nicolasfoss) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-12-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 50)

parfumo_data_clean <- tuesdata$parfumo_data_clean

# Option 2: Read directly from GitHub

parfumo_data_clean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-10/parfumo_data_clean.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `parfumo_data_clean.csv`

|variable      |class       |description                                                                      |
|:-------------|:-----------|:--------------------------------------------------------------------------------|
|Number        |character   |A unique identifier or number assigned to each perfume.                          |
|Name          |character   |The name of the perfume or fragrance.                                            |
|Brand         |character   |The brand or manufacturer of the fragrance.                                      |
|Release_Year  |double      |The year the fragrance was released.                                             |
|Concentration |character   |The concentration of the fragrance (e.g., Eau de Parfum, Eau de Toilette).       |
|Rating_Value  |double      |The overall rating score given by users.                                         |
|Rating_Count  |double      |The number of user ratings for the fragrance.                                    |
|Main_Accords  |character   |The primary scent characteristics or accords of the fragrance.                   |
|Top_Notes     |character   |The initial scent notes perceived after application.                             |
|Middle_Notes  |character   |The heart or middle notes of the fragrance that emerge after the top notes fade. |
|Base_Notes    |character   |The lasting, final scent notes that linger after the fragrance has dried down.   |
|Perfumers     |character   |The creators or perfumers responsible for the fragrance composition.             |
|URL           |character   |The link to the product page on Parfumo.com.                                     |

### Cleaning Script

```r
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
```
