# Country Music Lyrics

This week we're exploring **Country Music Lyrics**. The dataset comes from 
[Grady Smith](https://www.youtube.com/@GradySmith)'s investigation into some stereotypes associated with this music genre.  

Here's an excerpt from his video, ["Every country song has these lyrics. Right?"](https://www.youtube.com/watch?v=48ZxNFGJTo8), where he discusses his findings:  

> Today's video is a DEEP DIVE into the world of country music, and I'm determined to figure out if the stereotypes people have about modern country songwriting are actually true. Is it REALLY all about beer and trucks and girls and blue jeans? Are all the lyrics REALLY the same? To find out, I maintained a spreadsheet of every country song that has reached the Top 30 of Billboard's Country Airplay chart for the past six years (2014-2019) and then crunched a whole lot of data.

Dana Gibbon created [this notebook](https://danagibbon.github.io/country-music-lyrics-grady/gibbon_report.html#tables) that summarized and visualised some insights from the data.  

Some questions you can answer:

- Is country radio run by a small circle of hitmakers?  
- How has the country 'vocabulary' shifted over time?    

Thank you to [Jake Kaupp](https://github.com/jkaupp) for [suggesting this dataset](https://github.com/rfordatascience/tidytuesday/issues/261).

Thank you to [Ntobeko Sosibo](https://github.com/afrikaniz3d-za) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-08-25')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 34)

country_lyrics <- tuesdata$country_lyrics
top_all_writers <- tuesdata$top_all_writers
top_primary_writers <- tuesdata$top_primary_writers
top_producers <- tuesdata$top_producers

# Option 2: Read directly from GitHub

country_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/country_lyrics.csv')
top_all_writers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_all_writers.csv')
top_primary_writers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_primary_writers.csv')
top_producers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_producers.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-08-25')

# Option 2: Read directly from GitHub and assign to an object

country_lyrics = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/country_lyrics.csv')
top_all_writers = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_all_writers.csv')
top_primary_writers = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_primary_writers.csv')
top_producers = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_producers.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-08-25")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

country_lyrics = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/country_lyrics.csv")
top_all_writers = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_all_writers.csv")
top_primary_writers = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_primary_writers.csv")
top_producers = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_producers.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
country_lyrics = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/country_lyrics.csv", DataFrame)
top_all_writers = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_all_writers.csv", DataFrame)
top_primary_writers = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_primary_writers.csv", DataFrame)
top_producers = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-25/top_producers.csv", DataFrame)
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

### `country_lyrics.csv`

|variable                     |class     |description                           |
|:----------------------------|:---------|:-------------------------------------|
|song                         |character |The title of the track. |
|artist                       |character |The primary performing artist or band credited for the track. |
|featuring                    |character |Guest or featured artists on the track. NA if solo performance. |
|entered_top_30_in            |integer   |The date or month/year the track first entered the Top 30 Country Airplay chart. |
|lyrics                       |character |Full text lyrics for the track. |
|writers                      |character |Songwriters credited on the track (frequently multi-value / comma-separated). |
|producer                     |character |Record producer(s) credited for the track (may contain multiple names separated by slashes/commas). |
|rough_order                  |integer   |Original entry index or sequence number assigned during data collection. |
|rules_top_30_country_airplay |double    |Original metadata / eligibility notes detailing chart inclusion rules (March 2014 – March 2017). |

### `top_all_writers.csv`

|variable   |class     |description                           |
|:----------|:---------|:-------------------------------------|
|writer     |character |Name of the songwriter. |
|song_count |integer   |Total number of songs in the dataset where this individual appears in the writing credits (including co-writes). |

### `top_primary_writers.csv`

|variable   |class     |description                           |
|:----------|:---------|:-------------------------------------|
|writer     |character |Name of the songwriter listed as the primary credit. |
|song_count |integer   |Total number of songs in the dataset where this individual is credited as a primary writer. |

### `top_producers.csv`

|variable   |class     |description                           |
|:----------|:---------|:-------------------------------------|
|producer   |character |Name of the record producer. |
|song_count |integer   |Total number of songs in the dataset produced or co-produced by this individual. |

## Cleaning Script

```r
# Data provided by Grady Smith.

# Getting the data ----
library(tidyverse)
library(openxlsx)

# Extract the Spreadsheet ID from the Google Sheet URL
# The full link is: https://drive.google.com/file/d/1lz-xpqufGggdPh4gUeIdYvtB2s8ePewn/view
sheet_id <- "1lz-xpqufGggdPh4gUeIdYvtB2s8ePewn"

# Construct the direct export URL
export_url <- paste0(
  "https://docs.google.com/spreadsheets/d/",
  sheet_id,
  "/export?format=xlsx"
)

# Download to a temporary file
temp_xlsx <- tempfile(fileext = ".xlsx")
download.file(export_url, destfile = temp_xlsx, mode = "wb")

# Read using openxlsx
country_lyrics <- read.xlsx(temp_xlsx, sheet = 1) |>
  # Cleaning column names and drop empty column
  select(
    song = Song,
    artist = Artist,
    featuring = Featuring,
    entered_top_30_in = `Entered.Top.30.In:`,
    lyrics = Lyrics,
    writers = `Writers`,
    producer = `Producer`,
    rough_order = `Rough.Order`
  )
writers_producers <- read.xlsx(temp_xlsx, sheet = 2)

# Splitting the writers_producers table into the three categories ----

# Table 1: Primary Writers Summary
top_primary_writers <- writers_producers |>
  select(
    writer = Writer,
    song_count = `#.songs`
  ) |>
  drop_na()

# Table 2: All Co-Writers Summary
top_all_writers <- writers_producers |>
  select(
    writer = Writers,
    song_count = `#.Songs`
  ) |>
  drop_na()

# Table 3: Record Producers Summary
top_producers <- writers_producers |>
  select(producer = Producers, song_count = `#.Songsss`) |>
  drop_na()

```
