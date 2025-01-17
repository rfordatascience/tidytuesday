# posit::conf talks

This week we're exploring posit::conf talks! 
On the day when this dataset is first being shared, the [call for speakers for posit::conf(2025)](https://posit.co/blog/speak-at-posit-conf-2025/) is open. 
To help inspire you to submit a talk, we've collected data about posit::conf talks from 2023 and 2024. 
Thank you to [Rachael Dempsey](https://www.linkedin.com/in/rachaeldempsey/) for the Google sheets!

> posit::conf is our annual conference that focuses on the R and Python programming languages and their applications in data science. The conference features a variety of workshops, talks, and networking opportunities for attendees, with a particular emphasis on fostering a sense of community among data science professionals. In addition to providing opportunities for learning and professional development, posit::conf also aims to create a fun and engaging atmosphere that encourages attendees to connect with one another and explore the latest trends and technologies in the field.

- Which speakers gave talks in both 2023 and 2024?
- Are there keywords that appear in track titles in both 2023 and 2024?
- What is the average sentiment of the descriptions in each track?

Be careful to de-duplicate talk data when necessary! 
Talks with multiple speakers might appear more than once.

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-01-14')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 2)

conf2023 <- tuesdata$conf2023
conf2024 <- tuesdata$conf2024

# Option 2: Read directly from GitHub

conf2023 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-14/conf2023.csv')
conf2024 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-14/conf2024.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `conf2023.csv`

|variable            |class     |description                           |
|:-------------------|:-------------------------|:-------------------------------------|
|speaker_name        |character |The name of the speaker. The data is indexed by this field, so other fields may contain duplicate data. |
|speaker_affiliation |character |The company or organization with which the speaker is affiliated. |
|session_type        |character |Whether the session is a "keynote" a "regular" talk, or a "lightning" talk. |
|session_title       |character |The title of the talk. |
|block_track_title   |character |The title of the block in which the talk was presented. A block is a set of talks on a related area. |
|session_date        |date      |The date on which this talk was given (either 2023-09-19 or 2023-09-20). |
|session_start       |datetime  |The start time of the talk in the America/Chicago (US CDT) timezone. |
|session_length      |integer   |The duration of the talk in minutes. |
|session_abstract    |character |A brief description of the talk. |

# `conf2024.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|talk_title   |character |The title of the talk. |
|speaker_name |character |The name of the speaker. The data is indexed by this field, so other fields may contain duplicate data. |
|track        |character |The title of the block in which the talk was presented. A block is a set of talks on a related area. |
|description  |character |A brief description of the talk. |
|yt_url       |character |The URL of the YouTube video of the talk. |

### Cleaning Script

```r
library(tidyverse)
library(googlesheets4)

# Mostly clean data provided by Posit.
conf2023_raw <- googlesheets4::read_sheet("<REDACTED>")
conf2023 <- conf2023_raw |> 
  dplyr::mutate(
    session_date = lubridate::ymd(session_date),
    session_start = lubridate::ymd_hm(
      paste(session_date, session_start),
      tz = "America/Chicago"
    ),
    session_length = as.integer(session_length)
  )

conf2024 <- googlesheets4::read_sheet("<REDACTED>") |> 
  janitor::clean_names()
```
