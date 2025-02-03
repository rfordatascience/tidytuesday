library(tidyverse)
library(rvest)
library(janitor)
library(httr2)

index <- rvest::read_html_live("https://archive.org/download/20250128-cdc-datasets")
meta_urls <- index |> 
  rvest::html_element(".download-directory-listing") |> 
  rvest::html_table() |> 
  janitor::clean_names() |> 
  dplyr::filter(stringr::str_ends(name, "-meta.csv")) |> 
  dplyr::mutate(
    url = paste0(
      "https://archive.org/download/20250128-cdc-datasets/",
      URLencode(name)
    )
  ) |> 
  dplyr::select(url)
rm(index)

# As of 2025-02-03, there are 1257 metadata CSVs available. We will load each
# one and widen it, then stitch them all together. This can take a very long
# time.
requests <- meta_urls$url |>
  purrr::map(\(url) {
    httr2::request(url) |> 
      httr2::req_retry(
        max_tries = 10,
        is_transient = \(resp) {
          httr2::resp_status(resp) %in% c(429, 500, 503)
        },
        # Always wait 10 seconds to retry. It seems to be a general throttle,
        # but they don't tell us how long they need us to back off.
        backoff = \(i) 10
      )
  })

resps <- httr2::req_perform_sequential(requests, on_error = "continue")

reqs_to_retry <- resps |> 
  httr2::resps_failures() |> 
  purrr::map("request")

resps2 <- httr2::req_perform_sequential(reqs_to_retry)

resps <- c(httr2::resps_successes(resps), httr2::resps_successes(resps2))

extract_cdc_dataset_row <- function(resp) {
  httr2::resp_body_string(resp) |> 
    stringr::str_trim()
}

cdc_datasets <- tibble::tibble(
  dataset_url = purrr::map_chr(resps, c("request", "url")),
  raw = httr2::resps_data(resps, extract_cdc_dataset_row)
) |>
  tidyr::separate_longer_delim(raw, delim = "\r\n") |> 
  dplyr::filter(stringr::str_detect(raw, ",")) |> 
  tidyr::separate_wider_delim(
    raw,
    delim = ",",
    names = c("field", "value"),
    too_many = "merge",
    too_few = "align_start"
  ) |> 
  # Remove opening/closing quotes and trailing commas.
  dplyr::mutate(
    value = stringr::str_trim(value),
    value = dplyr::if_else(
      stringr::str_starts(value, '"') & stringr::str_ends(value, '"') &
        !stringr::str_detect(stringr::str_sub(value, 2, -2), '"'),
      stringr::str_sub(value, 2, -2),
      value
    ) |> 
      stringr::str_remove(",\\s*$") |> 
      dplyr::na_if("") |> 
      dplyr::na_if("NA") |>  
      dplyr::na_if("n/a") |>  
      dplyr::na_if("N/A") 
  ) |> 
  dplyr::distinct() |> 
  dplyr::filter(!is.na(value)) |> 
  tidyr::pivot_wider(
    id_cols = c(dataset_url),
    names_from = field,
    values_from = value,
    # Paste the contents of multi-value fields together.
    values_fn = \(x) {
      paste(unique(x), collapse = "\n")
    }
  ) |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    tags = purrr::map2_chr(tags, theme, \(tags, theme) {
      if (!is.na(theme)) {
        paste(tags, theme, sep = ", ")
      } else {
        tags
      }
    }),
    language = dplyr::case_match(
      language,
      "English" ~ "en-US",
      .default = language
    )
  ) |> 
  dplyr::mutate(
    dplyr::across(
      c("public_access_level", "update_frequency"),
      tolower
    )
  ) |> 
  # Manually dropped identified meaningless columns.
  dplyr::select(
    -resource_name,
    -system_of_records,
    -theme,
    -is_quality_data
  )

omb_codes <- readr::read_csv("https://resources.data.gov/schemas/dcat-us/v1.1/omb_bureau_codes.csv") |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    cgac_code = dplyr::na_if(cgac_code, "n/a")
  )

fpi_codes <- readr::read_csv("https://resources.data.gov/schemas/dcat-us/v1.1/FederalProgramInventory_FY13_MachineReadable_091613.csv") |> 
  janitor::clean_names()
