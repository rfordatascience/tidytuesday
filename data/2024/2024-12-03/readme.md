# National Highways Traffic Flow

This week we're exploring National Highways Traffic Flow data! National Highways operates and maintains motorways and major A roads in England. They directly monitor the speed and flow of roads using on road sensors, and the data can be accessed via the [National Highways API](https://webtris.nationalhighways.co.uk/api/swagger/ui/index).

This week's data has vehicle size and speed information for May 2021 from four different road sensors on the A64 road. 

* Do vehicles travel faster on certain days or at certain times?
* What time of day do large vehicles use this road?
* Do smaller vehicles travel faster?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-12-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 49)

A64_traffic <- tuesdata$A64_traffic

# Option 2: Read directly from GitHub

A64_traffic <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-12-03/A64_traffic.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `A64_traffic.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|SiteId             |character |Road sensor ID number. |
|Site Name          |character |Name of road sensor, also often a number. |
|Report Date        |character |Date that the data was recorded. |
|Time Period Ending |character |Time of day in hh:mm:ss that time period ends. |
|Time Interval      |double    |Number of the time interval during the day. |
|0 - 520 cm         |double    |Number of vehicles between 0 and 520cm. |
|521 - 660 cm       |double    |Number of vehicles between 521 and 660cm. |
|661 - 1160 cm      |double    |Number of vehicles between 661 and 1160cm. |
|1160+ cm           |double    |Number of vehicles over 1160cm. |
|0 - 10 mph         |double    |Number of vehicles travelling between 0 and 10mph. |
|11 - 15 mph        |double    |Number of vehicles travelling between 11 and 10mph. |
|16 - 20 mph        |double    |Number of vehicles travelling between 16 and 20mph. |
|21 - 25 mph        |double    |Number of vehicles travelling between 21 and 25mph. |
|26 - 30 mph        |double    |Number of vehicles travelling between 26 and 30mph. |
|31 - 35 mph        |double    |Number of vehicles travelling between 31 and 35mph. |
|36 - 40 mph        |double    |Number of vehicles travelling between 36 and 40mph. |
|41 - 45 mph        |double    |Number of vehicles travelling between 41 and 45mph. |
|46 - 50 mph        |double    |Number of vehicles travelling between 46 and 50mph. |
|51 - 55 mph        |double    |Number of vehicles travelling between 51 and 55mph. |
|56 - 60 mph        |double    |Number of vehicles travelling between 56 and 60mph. |
|61 - 70 mph        |double    |Number of vehicles travelling between 61 and 70mph. |
|71 - 80 mph        |double    |Number of vehicles travelling between 71 and 80mph. |
|80+ mph            |double    |Number of vehicles travelling over 80mph. |
|Avg mph            |double    |Average speed of all vehicles in miles per hour. |
|Total Volume       |double    |Total number of vehicles. |
|Name               |character |Name of sensor site describing location. |
|Longitude          |double    |Longitude of road sensor. |
|Latitude           |double    |Latitude of road sensor. |
|Status             |character |Whether the road sensor is active or inactive. |

### Cleaning Script

```r

# Functions ---------------------------------------------------------------

# Function to get site data from API
get_sites <- function() {
  url <- "http://webtris.nationalhighways.co.uk/api/v1.0"
  api_call_sites <- glue::glue("{url}/sites")
  sites_df <- jsonlite::fromJSON(api_call_sites) 
  sites <- sites_df["sites"][[1]] 
  return(sites)
}

#' Function to get data from API
#' @param site site id.
#' @param start_date character string for start date in ddmmyyyy format.
#' @param end_date character string for end date in ddmmyyyy format.
#' @param page page.
#' @param page_size. page size. Default 50.
get_daily_reports <- function(
    site,
    start_date,
    end_date,
    page = 1,
    page_size = 1000) {
  url <- "http://webtris.nationalhighways.co.uk/api/v1.0"
  api_call <- glue::glue("{url}/reports/daily?sites={site}&start_date={start_date}&end_date={end_date}&page={page}&page_size={page_size}")
  api_df <- jsonlite::fromJSON(api_call)
  output <- api_df$Rows |>
    tibble::as_tibble() |>
    dplyr::mutate(SiteId = as.character(site), .before = 1) |> 
    dplyr::mutate(dplyr::across(`Time Interval`:`Total Volume`, as.numeric))
  return(output)
}


# Sites data --------------------------------------------------------------

# Pull sites data
sites <- get_sites()

# Choose sites using https://webtris.nationalhighways.co.uk/
# A64 Eastbound from York to Scarborough
# Get Id
sites_chosen <- c("30361466", "30361338", "30361451", "30361486")
sites_id <- sites |> 
  tibble::as_tibble() |> 
  dplyr::filter(Description %in% sites_chosen) |> 
  dplyr::pull(Id)


# Traffic data ------------------------------------------------------------

# Map over chosen sites
sites_data <- purrr::map(
  .x = sites_id,
  .f = ~get_daily_reports(
    site = .x,
    start_date = "01052021",
    end_date = "31052021",
    page_size = 3000 # exceeds 31 days * 4 intervals/hr * 24 hrs
  )
)

# Join to sites data
A64_traffic <- dplyr::bind_rows(
  sites_data
) |> 
  dplyr::left_join(
    sites, by = c("SiteId" = "Id")
  ) |> 
  # Description duplicate of Site Name
  dplyr::select(
    -c(Description)
  ) |> 
  # Replace characters which cause problems saving to CSV
  dplyr::mutate(
    Name = stringr::str_replace_all(Name, ";", "-")
  )
```
