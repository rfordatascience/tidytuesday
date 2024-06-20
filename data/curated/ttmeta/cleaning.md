### Cleaning Script

```r
library(tidyverse)
library(here)
library(fs)
# install.packages("pak")
# pak::pak("r4ds/ttmeta")
library(ttmeta)

tt_summary <- ttmeta::tt_summary_tbl |> 
  dplyr::select(-dplyr::ends_with("urls"))

tt_urls <- ttmeta::tt_urls_tbl |> 
  dplyr::mutate(
    query = purrr::map_chr(
      query,
      \(x) {
        if (!length(x)) {
          return(NA_character_)
        }
        paste0(names(x), "=", x, collapse = "&")
      }
    )
  )

tt_datasets <- ttmeta::tt_datasets_metadata |> 
  dplyr::filter(!is.na(dataset_name)) |> 
  dplyr::select(-variable_details)

tt_variables <- ttmeta::tt_datasets_metadata |> 
  dplyr::filter(!is.na(dataset_name)) |> 
  dplyr::select(-variables, -observations) |> 
  tidyr::unnest(variable_details) |> 
  dplyr::mutate(
    min = purrr::map_chr(
      min,
      \(x) {
        if (!length(x)) {
          return(NA_character_)
        }
        as.character(x)
      }
    ),
    max = purrr::map_chr(
      max,
      \(x) {
        if (!length(x)) {
          return(NA_character_)
        }
        as.character(x)
      }
    )
  )
```