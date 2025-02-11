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
