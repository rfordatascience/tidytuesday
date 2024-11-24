
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
