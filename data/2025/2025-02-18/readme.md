# Agencies from the FBI Crime Data API

This week we're exploring data from the [FBI Crime Data API](https://cde.ucr.cjis.gov/LATEST/webapp/#/pages/docApi)! Specifically, we’re looking at agency-level data across all 50 states in the USA. This dataset provides details on law enforcement agencies that have submitted data to the FBI’s Uniform Crime Reporting (UCR) Program and are displayed on the Crime Data Explorer (CDE).

> Currently, the FBI produces four annual publications from data provided by more than 18,000 federal, state, county, city, university and college, and tribal law enforcement agencies voluntarily participating in the UCR program. 
>
> Crime data is dynamic. Offenses occur, arrests are made, and property is recovered every day. The FBI’s Crime Data Explorer, the digital front door for UCR data, is an attempt to reflect that fluidity in crime. The data presented there is updated regularly in a way that UCR publications previously could not be. Launched in 2017, the CDE’s content and features are updated and expanded continuously. CDE enables law enforcement agencies, researchers, journalists, and the public to more easily use and understand the massive amounts of UCR data using charts and graphs.

- How do agency types vary? How are agencies distributed geographically within each state?

- What percentage of agencies in each state participate in NIBRS reporting?  Are there any trends in NIBRS adoption?

Thank you to [Ford Johnson](https://github.com/bradfordjohnson) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-02-18')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 7)

agencies <- tuesdata$agencies

# Option 2: Read directly from GitHub

agencies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-18/agencies.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date("2025-02-18")

# Option 2: Read directly from GitHub and assign to an object

agencies = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-18/agencies.csv')
```
## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

## TidyTuesday Python Challenge: A collaboration with Posit  

- Exploring the TidyTuesday data in Python and looking for an extra challenge? Use Python to create a [Quarto dashboard](https://quarto.org/docs/dashboards/). Share it with the world using the hashtags #TidyTuesday and #PositPythonChallenge so that Posit has the chance to highlight your work, too!
- Deploy it however you want! If you'd like a super easy way to publish your dashboard, give [Connect Cloud](https://connect.posit.cloud/) a try.
- Check out [Posit's Python Challenge repo](https://github.com/posit-dev/python-tidytuesday-challenge) for more information and resources to get you started.

### Data Dictionary

# `agencies.csv`

|variable         |class     |description                           |
|:----------------|:---------|:-------------------------------------|
|ori              |character |Unique ID used to identify an agency. |
|county           |character |The county associated with the agency’s jurisdiction within a state. |
|latitude         |double    |The *approximate* latitude of the agency. |
|longitude        |double    |The *approximate* latitude of the agency. |
|state_abbr       |character |The abbreviated two letter state code for the agency's location. |
|state            |character |The full name of the state where the agency is located. |
|agency_name      |character |The official name of the agency. |
|agency_type      |character |The type or category of the agency, such as city or county. |
|is_nibrs         |logical   |Indicates whether the agency participates in the FBI’s National Incident-Based Reporting System (NIBRS). |
|nibrs_start_date |character |The date on which the agency began reporting data to NIBRS. |

### Cleaning Script

```r
# "The Crime Data Explorer (CDE) provides select datasets for download. Incident-based data by state,
# summary data estimates, and data about other specific topics may be downloaded in CSV files from
# the selections below. Data are also available via the Crime Data API, a read-only web service that
# returns JSON or CSV data, and provides experienced users access to large amounts of UCR data to use
# and share." - From https://cde.ucr.cjis.gov/LATEST/webapp/#/pages/downloads

# To re-create this dataset:
# 1. Get a FBI Crime Data API Key from the docs here: https://cde.ucr.cjis.gov/LATEST/webapp/#/pages/docApi
# 2. Set an environment variable via: `Sys.setenv(API_KEY = "{YOUR_API_KEY}")`
# 3. Run the script which will access your environment variable via: `Sys.getenv("API_KEY")`


library(httr2)
library(jsonlite)
library(dplyr)
library(purrr)

state_abbrs <- c(
  "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
  "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
  "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
  "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
  "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
)

api_key <- Sys.getenv("API_KEY")

parse_nibrs_date <- function(date_val) {
  if (is.null(date_val)) {
    NA_character_
  } else if (is.list(date_val)) {
    if (length(date_val) > 0) as.character(date_val[[1]]) else NA_character_
  } else {
    as.character(date_val)
  }
}

fetch_agency_data <- function(state_abbr, api_key) {
  url <- sprintf(
    "https://api.usa.gov/crime/fbi/cde/agency/byStateAbbr/%s?API_KEY=%s",
    state_abbr, api_key
  )

  response_text <- request(url) %>%
    req_perform() %>%
    resp_body_string()

  agency_data <- fromJSON(response_text, flatten = TRUE)

  agency_df <- if (is.data.frame(agency_data)) {
    agency_data
  } else if (is.list(agency_data)) {
    bind_rows(agency_data)
  } else {
    stop("Unexpected JSON structure: not a list or data frame.")
  }

  if ("nibrs_start_date" %in% names(agency_df)) {
    agency_df <- agency_df %>%
      mutate(nibrs_start_date = map_chr(nibrs_start_date, parse_nibrs_date))
  } else {
    agency_df$nibrs_start_date <- NA_character_
  }

  agency_df$state <- state_abbr

  agency_df
}

agency_data_list <- list()
qa_data_list <- list()

for (state in state_abbrs) {
  cat("Fetching data for state:", state, "\n")

  state_agency_df <- fetch_agency_data(state, api_key)

  agency_data_list[[state]] <- state_agency_df

  qa_data_list[[state]] <- tibble(
    state = state,
    response_length = nrow(state_agency_df)
  )
}

agencies <- bind_rows(agency_data_list) |>
  mutate(agency_type = agency_type_name, county = counties, state = state_name) |>
  select(ori, county, latitude, longitude, state_abbr, state, agency_name, agency_type, is_nibrs, nibrs_start_date)



# QA checks

response_qa <- bind_rows(qa_data_list)

agencies_qa <- agencies %>%
  group_by(state) %>%
  summarise(n_ori = n_distinct(ori), .groups = "drop")

qa_comparison <- inner_join(response_qa, agencies_qa, by = "state") %>%
  mutate(match = response_length == n_ori) %>%
  filter(match != TRUE)

print(qa_comparison)
```
