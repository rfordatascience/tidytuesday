# Fatal Car Crashes on 4/20

Today we're exploring the (lack of) connection between fatal car crashes in the United States and the ["4/20 holiday" (4:20pm to 11:59pm on April 20th)](https://en.wikipedia.org/wiki/420_(cannabis_culture)).
Thank you to @Rmadillo for [submitting this dataset *6 years ago!*](https://github.com/rfordatascience/tidytuesday/issues/58), including [a bonus script to generate sample plots!](https://github.com/Rmadillo/Harper_and_Palayew/blob/master/Load_Data_and_Clean.R)

> [In January 2019], Harper and Palayew[1] published a study looking at whether 
> a signal could be detected in fatal car crashes in the United States based on 
> the "4/20" holiday, based on a previous study by Staples and Redelmeier[2] 
> that suggested a strong link. Using more robust methods and a more 
> comprehensive time window, Harper and Palayew could not find a signal for 
> 4/20, but could for other holidays, such as July 4.

> This is a great example of how charts can mislead based on choices in analysis
> and plotting.

[1]. Harper S, Palayew A "The annual cannabis holiday and fatal traffic 
crashes." *BMJ Injury Prevention.* Published Online First: 29 January 2019. 
doi: 10.1136/injuryprev-2018-043068. Manuscript and original data/code at 
https://osf.io/qnrg6/

[2]. Staples JA, Redelmeier DA. "The April 20 cannabis celebration and fatal 
traffic crashes in the United States." *JAMA Intern Med.* 2018 Feb;
178(4):569–72.

Questions:

- Can you detect any correlations between fatal car crashes and particular days of the year?
- What are the most dangerous days of the year for fatal car crashes in the United States?
- What other factors might help analyze the data in more detail? You can use the cleaning script to download the full dataset.


Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-04-22')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 16)

daily_accidents <- tuesdata$daily_accidents
daily_accidents_420 <- tuesdata$daily_accidents_420

# Option 2: Read directly from GitHub

daily_accidents <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents.csv')
daily_accidents_420 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents_420.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-04-22')

# Option 2: Read directly from GitHub and assign to an object

daily_accidents = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents.csv')
daily_accidents_420 = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-22/daily_accidents_420.csv')
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

### `daily_accidents.csv`

|variable         |class   |description                           |
|:----------------|:-------|:-------------------------------------|
|date             |date    |Date of the accident. |
|fatalities_count |integer |Total count of fatalities. |

### `daily_accidents_420.csv`

|variable         |class   |description                           |
|:----------------|:-------|:-------------------------------------|
|date             |date    |Date of the accident. |
|e420             |logical |Did the accident occur on the 4/20 "holiday" (between 4:20pm and 11:59pm on April 20th)? |
|fatalities_count |integer |Total count of fatalities. |

### `daily_accidents_420_time.csv`

|variable         |class   |description                           |
|:----------------|:-------|:-------------------------------------|
|date             |date    |Date of the accident. |
|d420             |logical |Did the accident occur between 4:20pm and 11:59pm on *any* day of the year)? |
|fatalities_count |integer |Total count of fatalities. |

## Cleaning Script

```r
# Draft cleaning script provided by @Rmadillo at
# https://github.com/Rmadillo/Harper_and_Palayew/blob/1aaf1333e8fb6a8f3aa7f169a12943c17b3487da/Load_Data_and_Clean.R
# Script cleaned and modernized by @jonthegeek (the script was submitted as a
# TidyTuesday issue in 2019!).

#### Load packages -------------------------------------------------------------

library(haven)
library(tidyverse)
library(fs)

#### Acquire raw data ----------------------------------------------------------

# Crash data (from Harper and Palayew)
dl_path <- withr::local_tempfile(fileext = ".zip")
download.file("https://osf.io/kj7ub/download", dl_path, mode = "wb")
unzip_path <- withr::local_tempdir()
unzip(dl_path, exdir = unzip_path)

dta_files <- fs::dir_ls(unzip_path, glob = "*.dta")

fars <- purrr::map(dta_files, haven::read_dta) |> 
  purrr::list_rbind(names_to = "id") |> 
  dplyr::mutate(id = basename(id))

# Geographic lookup
geog <- readr::read_csv(
  "https://www2.census.gov/geo/docs/reference/codes/files/national_county.txt",
  col_names = c(
    "state_name",
    "state_code",
    "county_code",
    "county_name",
    "FIPS_class_code"
  )
) |> 
  dplyr::mutate(
    state = as.numeric(state_code),
    count = as.numeric(county_code),
    FIPS = paste0(state_code, county_code)
  )

#### Data wrangling ------------------------------------------------------------
# Used https://osf.io/drbge/ Stata code as a guide for cleaning

# All data
# This might take a while... go get a coffee
all_accidents <- fars |> 
  # What are state and county codes/look ups?
  dplyr::select(
    "id", "state", "county", 
    "month", "day", "hour", "minute", 
    "st_case", "per_no", "veh_no", "per_typ", 
    "age", "sex", 
    "death_da", "death_mo", "death_yr", "death_hr", "death_mn", "death_tm",
    "inj_sev", "mod_year", "lag_hrs", "lag_mins"
  ) |> 
  dplyr::mutate(
    dplyr::across(
      c("month", "day", "hour", "minute"),
      ~ na_if(.x, 99)
    ),
    year = readr::parse_number(id)
  ) |> 
  dplyr::filter(
    .data$per_typ == 1,
    !is.na(.data$year),
    !is.na(.data$month),
    !is.na(.data$day)
  ) |> 
  dplyr::mutate(
    crashtime = .data$hour * 100 + .data$minute,
    date = as.Date(paste(.data$year, .data$month, .data$day, sep = "-")),
    time = paste(.data$hour, .data$minute, sep = ":"),
    timestamp = as.POSIXct(
      paste(.data$date, .data$time),
      format = "%Y-%m-%d %H:%M"
    ),
    e420 = .data$month == 4 & .data$day == 20 & 
      .data$crashtime >= 1620 & .data$crashtime <= 2359,
    e420_control = .data$month == 4 & (.data$day == 20 | .data$day == 27) & 
      .data$crashtime >= 1620 & .data$crashtime < 2359,
    d420 = .data$crashtime >= 1620 & .data$crashtime <= 2359,
    sex = factor(
      dplyr::case_when(
        .data$sex == 2 ~ "F",
        .data$sex == 1 ~ "M",
        .default = NA_character_
      )
    ),
    period = factor(
      dplyr::case_when(
        .data$year < 2004  ~ "Remote (1992-2003)",
        .data$year >= 2004 ~ "Recent (2004-2016)",
        .default = NA_character_
      )
    ),
    age_group = factor(
      dplyr::case_when(
        .data$age <= 20 ~ "<20y",
        .data$age <= 30 ~ "21-30y",
        .data$age <= 40 ~ "31-40y",
        .data$age <= 50 ~ "41-50y",
        .data$age <= 97 ~ "51-97y",
        .default = NA_character_
      )
    )
  )

# Daily final working data
# Only use data starting in 1992
daily_accidents <- all_accidents |> 
  dplyr::filter(.data$year > 1991) |> 
  summarize(fatalities_count = dplyr::n(), .by = "date")

# Daily+Time Group final working data
daily_accidents_420 <- all_accidents |> 
  dplyr::filter(.data$year > 1991) |> 
  dplyr::summarize(fatalities_count = dplyr::n(), .by = c("date", "e420"))
  
# Daily working data for daily 420 period
daily_accidents_420_time <- all_accidents |> 
  dplyr::filter(.data$year > 1991) |> 
  dplyr::summarize(fatalities_count = dplyr::n(), .by = c("date", "d420"))

```
