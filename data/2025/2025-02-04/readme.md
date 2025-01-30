# Donuts, Data, and D'oh - A Deep Dive into The Simpsons

This week, we are going to explore a [Simpsons Dataset from Kaggle](https://www.kaggle.com/datasets/prashant111/the-simpsons-dataset).  Many thanks to [Prashant Banerjee](https://www.kaggle.com/prashant111) for making this dataset available to the public.  The Simpsons Dataset is composed of four files that contain the characters, locations, episode details, and script lines for approximately 600 Simpsons episodes.  Please note that episodes and script lines have been filtered to only include episodes from 2010 to 2016 in the episodes data to keep file size within GitHub limits!

Here is some history on the Simpsons Dataset from the author:

> Originally, this dataset was scraped by [Todd W. Schneider] for his post [The Simpsons by the Data](https://toddwschneider.com/posts/the-simpsons-by-the-data/), for which he made the scraper available on GitHub. Kaggle user William Cukierski used the scraper to upload the data set, which has been rehosted here.

* Which character has the most spoken lines across all episodes, and how has their dialogue volume changed over the seasons?
* What are the most frequently used locations in the series, and do specific locations correspond to higher IMDb ratings for episodes?
* Is there a relationship between the number of U.S. viewers (in millions) and the IMDb ratings or votes for episodes?
* What are the most commonly used words or phrases in the dialogue across the series, and do they differ by character or location?

Thank you to [Nicolas Foss, Ed.D., MS with Iowa HHS](https://github.com/nicolasfoss) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-02-04')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 5)

simpsons_characters <- tuesdata$simpsons_characters
simpsons_episodes <- tuesdata$simpsons_episodes
simpsons_locations <- tuesdata$simpsons_locations
simpsons_script_lines <- tuesdata$simpsons_script_lines

# Option 2: Read directly from GitHub

simpsons_characters <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_characters.csv')
simpsons_episodes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_episodes.csv')
simpsons_locations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_locations.csv')
simpsons_script_lines <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-04/simpsons_script_lines.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `simpsons_characters.csv`

| variable        | class     | description                                 |
|:----------------|:----------|:-------------------------------------------|
| id              | double    | Unique identifier for each character record.          |
| name            | character | Full name associated with the character record.       |
| normalized_name | character | Lowercase version of the character name.           |
| gender          | character | Gender associated with the character record.          |

# `simpsons_episodes.csv`

| variable               | class     | description                                         |
|:-----------------------|:----------|:---------------------------------------------------|
| id                     | double    | Unique identifier for each episode record.                 |
| image_url              | character | URL linking to the image associated with the episode record. |
| imdb_rating            | double    | IMDb rating for the episode. |
| imdb_votes             | double    | Number of votes received on IMDb for the episode. |
| number_in_season       | double    | Episode number within the season. |
| number_in_series       | double    | Episode number within the series. |
| original_air_date      | date      | Date the episode originally aired. |
| original_air_year      | double    | Year the episode originally aired. |
| production_code        | character | Code used in production to identify the episode. |
| season                 | double    | Season number of the episode. |
| title                  | character | Title of the episode. |
| us_viewers_in_millions | double    | Number of viewers in the U.S. in millions. |
| video_url              | character | URL linking to the video associated with the record. |
| views                  | double    | Total number of views recorded for the episode video URL. |

# `simpsons_locations.csv`

| variable        | class     | description                                 |
|:----------------|:----------|:-------------------------------------------|
| id              | double    | Unique identifier for each location.        |
| name            | character | Name of the location.                       |
| normalized_name | character | Lowercase version of the location name.  |

# `simpsons_script_lines.csv`

| variable           | class     | description                                              |
|:-------------------|:----------|:--------------------------------------------------------|
| id                 | double    | Unique identifier for each script line. |
| episode_id         | double    | Identifier for the episode in which the line appears. |
| number             | double    | Sequential number of the line within the episode. |
| raw_text           | character | The original text of the script line. |
| timestamp_in_ms    | double    | Timestamp of the line in milliseconds. |
| speaking_line      | logical   | Indicates whether the line is spoken by a character. |
| character_id       | double    | Identifier for the character speaking the line. |
| location_id        | double    | Identifier for the location where the line is spoken. |
| raw_character_text | character | Original text of the character's name. |
| raw_location_text  | character | Original text of the location name. |
| spoken_words       | character | Words spoken by the character in the line. |
| normalized_text    | character | Lowercase version of the script line. |
| word_count         | double    | Number of words in the line. |

### Cleaning Script

```r
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
```
