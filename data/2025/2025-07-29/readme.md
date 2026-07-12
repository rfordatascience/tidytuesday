# What have we been watching on Netflix?

This week we are exploring TV show and movie viewing data from Netflix. Since 2023, Netflix has released regular 
[Engagement Reports](https://about.netflix.com/en/news/what-we-watched-the-first-half-of-2025) 
summarising the number of hours that users have spent watching each show and movie in the last 6 months. 

> This report, which captures ~99% of all viewing in the first half of 2025, shows that people watched a lot of Netflix — over 95B hours — 
spanning a wide range of genres and languages. It’s why we continue to invest in a variety of quality titles for various moods and tastes 
and work hard to make them great. 

The dataset this week combines viewing data from late 2023 through the first half of 2025. 

- What is the relation between time since release and current viewing performance? Do older shows have staying power or do newer releases dominate?
- How does the timing of a show's release (month/season) relate to engagement metrics?
- How does the performance of globally available content compare to regionally restricted titles? Do global releases consistently outperform regional ones?
- How do the top movie performers in each reporting period compare? Are the same kinds of movies consistently popular?
- How does viewing change across seasons for shows that appear in multiple Netflix engagement reports? Do later seasons of popular shows maintain, gain, or lose audience engagement compared to their earlier seasons?

Thank you to [Jen Richmond, RLadies-Sydney](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-07-29')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 30)

movies <- tuesdata$movies
shows <- tuesdata$shows

# Option 2: Read directly from GitHub

movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/movies.csv')
shows <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/shows.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-07-29')

# Option 2: Read directly from GitHub and assign to an object

movies = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/movies.csv')
shows = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/shows.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-07-29')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

movies = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/movies.csv")
shows = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/shows.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
movies = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/movies.csv", DataFrame)
shows = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-29/shows.csv", DataFrame)
```


## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


## Data Dictionary

### `movies.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|source             |character |Source file name |
|report             |character |Report period |
|title              |character |Movie title|
|available_globally |character |Whether the movie is available globally or not |
|release_date       |date      |Movie release date |
|hours_viewed       |double    |Hours spent viewing the movie |
|runtime            |Period    |Movie runtime |
|views              |double    |Hours viewed / runtime |

### `shows.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|source             |character |Source file name |
|report             |character |Report period |
|title              |character |Show title |
|available_globally |character |Whether the show is available globally or not |
|release_date       |date      |Show release date|
|hours_viewed       |double    |Hours spent viewing the show|
|runtime            |Period    |Show runtime|
|views              |double    |Hours viewed / runtime |

## Cleaning Script

```r
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

```
