# CDC Datasets

This week we're exploring datasets that the Trump administration has purged. 

The [Trump administration has ordered agencies to purge their websites of any references to topics such as LGBTQ+ rights](https://www.npr.org/sections/shots-health-news/2025/01/31/nx-s1-5282274/trump-administration-purges-health-websites). 


An effort is underway to back up this publicly funded data before it is lost. 
This week's dataset contains metadata about [CDC datasets backed up on archive.org](https://archive.org/download/20250128-cdc-datasets).

> "The removal of HIV- and LGBTQ-related resources from the websites of the Centers for Disease Control and Prevention and other health agencies is deeply concerning and creates a dangerous gap in scientific information and data to monitor and respond to disease outbreaks," the Infectious Disease Society of America said in a statement. "Access to this information is crucial for infectious diseases and HIV health care professionals who care for people with HIV and members of the LGBTQ community and is critical to efforts to end the HIV epidemic."

- Which Bureaus and Programs have the most datasets archived in this collection?
- Explore some of the datasets. What keywords do the datasets have in common?


Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-02-11')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 6)

cdc_datasets <- tuesdata$cdc_datasets
fpi_codes <- tuesdata$fpi_codes
omb_codes <- tuesdata$omb_codes

# Option 2: Read directly from GitHub

cdc_datasets <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-11/cdc_datasets.csv')
fpi_codes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-11/fpi_codes.csv')
omb_codes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-02-11/omb_codes.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `cdc_datasets.csv`

|variable                     |class     |description                           |
|:----------------------------|:---------|:-------------------------------------|
|dataset_url                  |character |The location to download the metadata about the archived dataset. The dataset itself is at this location with `-meta` removed (replace "-meta.csv" with ".csv"). |
|contact_name                 |character |A name to contact about the dataset. Sometimes this field contains the name of the dataset. |
|contact_email                |character |A government email to contact about the dataset. Many of these email addresses likely no longer work under the Trump administration. |
|bureau_code                  |character |Federal agencies, combined agency and bureau code from OMB Circular A-11, Appendix C (see omb_codes dataset). |
|program_code                 |character |The primary program related to this data asset, from the Federal Program Inventory (see fpi_codes dataset). |
|category                     |character |Main thematic category of the dataset. |
|tags                         |character |Tags (or keywords) to help users discover the dataset. Intended to include terms that would be used by technical and non-technical users. |
|publisher                    |character |The publishing entity and optionally their parent organization(s). |
|public_access_level          |character |The degree to which this dataset could be made publicly-available, regardless of whether it has been made available. Choices: public (Data asset is or could be made publicly available to all without restrictions), restricted public (Data asset is available under certain use restrictions), or non-public (Data asset is not available to members of the public). |
|footnotes                    |character |Additional notes about this dataset. |
|license                      |character |The license or non-license (i.e. Public Domain) status with which the dataset or API has been published. |
|source_link                  |character |The location where the dataset was stored. |
|issued                       |character |Date of formal issuance. |
|geographic_coverage          |character |The range of spatial applicability of a dataset. Could include a spatial region like a bounding box or a named place. |
|temporal_applicability       |character |The range of temporal applicability of a dataset (i.e., a start and end date of applicability for the data). |
|update_frequency             |character |The frequency with which dataset is published. |
|described_by                 |character |URL to the data dictionary for the dataset. |
|homepage                     |character |Intended for use if a dataset has a human-friendly hub or landing page that users can be directed to for all resources tied to the dataset. |
|geographic_unit_of_analysis  |character |Likely very similar to geographic_coverage. |
|suggested_citation           |character |How to cite this dataset. |
|geospatial_resolution        |character |The sizes of geospatial units included in the dataset. |
|references                   |character |Related documents such as technical information about a dataset, developer documentation, etc. |
|glossary_methodology         |character |A URL or reference to how things were named. |
|access_level_comment         |character |This may include information regarding access or restrictions based on privacy, security, or other policies. |
|analytical_methods_reference |character |Usually a URL describing the methodology. URL may not be available under the Trump administration. |
|language                     |character |The language of the dataset. |
|collection                   |character |The collection of which the dataset is a subset. |

# `fpi_codes.csv`

|variable                        |class     |description                           |
|:-------------------------------|:---------|:-------------------------------------|
|agency_name                     |character |The name of the federal agency. |
|program_name                    |character |The name of this program. |
|additional_information_optional |character |Other notes. |
|agency_code                     |character |The three-digit code for the agency housing this program. |
|program_code                    |character |The Federal Program Inventory code for this program. |
|program_code_pod_format         |character |The Federal Program Inventory code for this program in "project open data" format. |

# `omb_codes.csv`

|variable      |class     |description                           |
|:-------------|:---------|:-------------------------------------|
|agency_name   |character |The name of the federal agency. |
|bureau_name   |character |The name of the entity within the agency. |
|agency_code   |double    |The OMB code for this agency. |
|bureau_code   |double    |The OMB code for this bureau within this agency. |
|treasury_code |character |The Treasury Department code for this agency. |
|cgac_code     |character |Common Government-wide Accounting Classification. |

### Cleaning Script

```r
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
```
