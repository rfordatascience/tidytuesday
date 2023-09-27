# US Government Grant Opportunities

The R4DS Online Learning Community is a community of learners at all skill levels working together to improve our data-science-related skills.
We offer free data-related education through [book clubs](https://r4ds.io/youtube) and free live question-answering on our [Slack](https://r4ds.io/join), and by curating a dataset every week here at TidyTuesday.

We are now a fiscally sponsored project of Open Collective Foundation (https://opencollective.foundation), a 501(c)(3) public charity. 
That means [donations to the R4DS Online Learning Community](https://r4ds.io/donate) are now tax-deductible in the US!
It also means that we are now eligible for a number of grants, including some of the grants listed on [Grants.gov](https://www.grants.gov/web/grants/search-grants.html).

We have exported all grants past and present from that site, and we are making them available here for you to explore and visualize.
We also scraped details for all posted grants.
Please let us know if you find anything interesting!

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-10-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 40)

grants <- tuesdata$grants
grant_opportunity_details <- tuesdata$grant_opportunity_details

# Option 2: Read directly from GitHub

grants <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-03/grants.csv')
grant_opportunity_details <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-03/grant_opportunity_details.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

Source Created by Deepsha Menghani by watching the show and counting the number of F-cks used in sentences and as gestures.

# `grants.csv`

|variable                       |class     |description                    |
|:------------------------------|:---------|:------------------------------|
|opportunity_id                 |integer   |Integer ID for this opportunity, which can be used to find details at https://www.grants.gov/web/grants/view-opportunity.html?oppId={opportunity_id} |
|opportunity_number             |character |Funding opportunity ID number |
|opportunity_title              |character |Title of the opportunity |
|agency_code                    |character |Abbreviated name for the funding agency |
|agency_name                    |character |Full name of the funding agency |
|estimated_funding              |double    |Estimated funding amount in dollars |
|expected_number_of_awards      |integer   |Expected count of awards |
|grantor_contact                |character |Information about how to contact the grantor. Often includes email address |
|agency_contact_phone           |character |Phone number for the agency when available |
|agency_contact_email           |character |Contact email address for the agency (almost always available) |
|estimated_post_date            |date      |When the opportunity is/was expected to be posted |
|estimated_application_due_date |date      |Date by which applications are/were expected to be received |
|posted_date                    |date      |When the opportunity was posted |
|close_date                     |date      |When the opportunity was closed or will close |
|last_updated_date_time         |datetime  |Date and time when the opportunity was updated |
|version                        |character |Integer version number of the opportunity |
|opportunity_status             |character |Whether the opportunity is Archived, Closed, Forecasted, or Posted |

# `grant_opportunity_details.csv`

|variable                               |class     |description                            |
|:--------------------------------------|:---------|:--------------------------------------|
|opportunity_id                         |integer   |Integer ID for this opportunity, which can be used to find these details at https://www.grants.gov/web/grants/view-opportunity.html?oppId={opportunity_id} |
|document_type                          |character |Always "Grants Notice" |
|funding_opportunity_number             |character |Funding opportunity ID number |
|funding_opportunity_title              |character |Title of the opportunity |
|opportunity_category                   |character |"Continuation", "Discretionary", "Earmark", "Mandatory", or "Other" |
|opportunity_category_explanation       |character |More details about why the opportunity is in that category (40 unique values for 5 categories; Discretionary has two explanations, Other has 39) |
|funding_instrument_type                |character |"Cooperative Agreement", "Grant", "Procurement Contract", or "Other" (this field needs cleaning) |
|category_of_funding_activity           |character |General category or categories of the funding (this field also needs cleaning) |
|category_explanation                   |character |More details about the funding category or categories |
|expected_number_of_awards              |integer   |Expected count of awards |
|cfda_number_s                          |character |Catalog of Federal Domestic Assistance number(s) (see https://sam.gov/content/assistance-listings) (this field needs cleaning to extract XX.XXX numbers) |
|cost_sharing_or_matching_requirement   |logical   |Whether the opportunity requires a cost-sharing or cost-matching agreement |
|version                                |integer   |Integer version number of the opportunity |
|posted_date                            |date      |When the opportunity was posted |
|last_updated_date                      |date      |When the opportunity was updated |
|original_closing_date_for_applications |date      |When the opportunity was originally scheduled to close |
|current_closing_date_for_applications  |date      |When the opportunity is current scheduled to close |
|archive_date                           |date      |When the opportunity will be archived |
|estimated_total_program_funding        |double    |Estimated funding amount in dollars |
|award_ceiling                          |double    |Maximum individual award amount in dollars |
|award_floor                            |double    |Minimum individual award amount in dollars |
|eligible_applicants                    |character |Details about eligibility |
|additional_information_on_eligibility  |character |Additional details about eligibility |
|agency_name                            |character |Full name of the granting agency |
|description                            |character |Free text description of the opportunity. Sometimes includes tables or potentially other figures, which did not necessarily scrape accurately |
|link_to_additional_information         |character |The text of any links to additional information (unlikely to be useful in this format) |
|grantor_contact_information            |character |Information about who to contact about the grant; may have contained links, which are not included in the scraped data |

### Cleaning Script


``` r
library(tidyverse)
library(janitor)
library(here)

# Requires dev rvest from this draft pull request:
# https://github.com/tidyverse/rvest/pull/362
#
# pak::pak("tidyverse/rvest#362")
library(rvest)
library(chromote)

working_dir <- here::here("data", "2023", "2023-10-03")

# Grants csv manually downloaded from
# https://www.grants.gov/web/grants/search-grants.html. Many rows have extra
# commas at the end, which cause confusion but otherwise don't damage the data.
grants <- 
  here::here(working_dir, "grants-gov-opp-search--20230927122308.csv") |> 
  readr::read_csv(
    col_types = cols(
      `OPPORTUNITY NUMBER` = col_character(),
      `OPPORTUNITY TITLE` = col_character(),
      `AGENCY CODE` = col_character(),
      `AGENCY NAME` = col_character(),
      `ESTIMATED FUNDING` = col_character(),
      `EXPECTED NUMBER OF AWARDS` = col_character(),
      `GRANTOR CONTACT` = col_character(),
      `AGENCY CONTACT PHONE` = col_character(),
      `AGENCY CONTACT EMAIL` = col_character(),
      `ESTIMATED POST DATE` = col_character(),
      `ESTIMATED APPLICATION DUE DATE` = col_character(),
      `POSTED DATE` = col_character(),
      `CLOSE DATE` = col_character(),
      `LAST UPDATED DATE/TIME` = col_character(),
      VERSION = col_character(),
      `OPPORTUNITY STATUS` = col_character()
    )
  ) |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    estimated_funding = case_match(
      estimated_funding,
      "Not available" ~ NA, 
      .default = estimated_funding
    ) |> 
      stringr::str_remove_all(",") |> 
      as.double(),
    last_updated_date_time = lubridate::mdy_hms(last_updated_date_time),
    opportunity_status = stringr::str_remove_all(opportunity_status, ",")
  ) |> 
  dplyr::mutate(
    dplyr::across(
      dplyr::ends_with("_date"),
      lubridate::mdy
    )
  ) |> 
  tidyr::separate_wider_regex(
    opportunity_number,
    c(
      ".+oppId=",
      opportunity_id = "\\d+",
      "\",\"",
      opportunity_number = "[^\"]+",
      "\"\\)"
    )
  )

# Create a couple helper functions to get the grant details.
extract_synopsis_table <- function(html_document, div_id) {
  headings <- 
    html_document |> 
    rvest::html_elements(glue::glue("#{div_id} > table > tbody > tr > th")) |> 
    rvest::html_text2()
  bodies <- 
    html_document |> 
    rvest::html_elements(glue::glue("#{div_id} > table > tbody > tr > td")) |> 
    rvest::html_text2()
  bodies  <- as.list(bodies)
  names(bodies) <- headings
  tibble::as_tibble(bodies)
}

get_grant_details <- function(opportunity_id, sleep = 0.5) {
  # Let's put an escape hatch in, in case something just won't load.
  if (sleep > 10) {
    return(
      tibble::tibble(
        opportunity_id = opportunity_id,
        synopsis_failed = TRUE
      )
    )
  }
  
  url <- glue::glue(
    "https://www.grants.gov/web/grants/view-opportunity.html?oppId={opportunity_id}"
  )
  
  live_page <- rvest::read_html_live(url)
  
  # If anybody can help me figure out how to make this wait for promise
  # evaluation more correctly, please let me know!
  Sys.sleep(sleep)
  
  iframe_html <- 
    live_page$session$Runtime$evaluate(
      "document.querySelector('iframe').contentDocument.documentElement.innerHTML",
      wait_ = TRUE,
      awaitPromise = TRUE,
      returnByValue = TRUE
    )
  
  html_document <- 
    iframe_html$result$value |> 
    rvest::read_html()
  
  general_info_left <- 
    html_document |> 
    extract_synopsis_table("synopsisDetailsGeneralInfoTableLeft")
  
  general_info_right <-
    html_document |>
    extract_synopsis_table("synopsisDetailsGeneralInfoTableRight")

  eligibility <-
    html_document |>
    extract_synopsis_table("synopsisDetailsEligibilityTable")

  additional_info <-
    html_document |>
    extract_synopsis_table("synopsisDetailsAdditionalInfoTable")

  synopsis <-
    dplyr::bind_cols(
      general_info_left,
      general_info_right,
      eligibility,
      additional_info
    ) |>
    janitor::clean_names()
  
  live_page$session$close()
  
  if(nrow(synopsis)) {
    synopsis <- dplyr::bind_cols(
      tibble::tibble(opportunity_id = opportunity_id),
      synopsis
    )
    return(synopsis)
  }
  
  return(
    get_grant_details(opportunity_id, sleep = sleep + 0.5)
  )
}

grant_opportunity_details <- 
  grants |> 
  dplyr::filter(opportunity_status == "Posted") |> 
  dplyr::pull(opportunity_id) |>
  purrr::map(get_grant_details) |> 
  purrr::list_rbind() |> 
  dplyr::mutate(
    category_explanation = stringr::str_squish(category_explanation),
    expected_number_of_awards = readr::parse_integer(expected_number_of_awards),
    cost_sharing_or_matching_requirement = cost_sharing_or_matching_requirement == "Yes",
    version = stringr::str_remove(version, "Synopsis ") |> 
      readr::parse_integer(),
    dplyr::across(
      dplyr::contains("date"),
      \(x) {
        x |> 
          stringr::str_extract("\\w+ \\d+, \\d+") |>
          stringr::str_squish() |> 
          lubridate::mdy()
      }
    ),
    dplyr::across(
      c(
        "estimated_total_program_funding",
        "award_ceiling",
        "award_floor"
      ),
      readr::parse_number
    )
  )

readr::write_csv(
  grants,
  here::here(working_dir, "grants.csv")
)
readr::write_csv(
  grant_opportunity_details,
  here::here(working_dir, "grant_opportunity_details.csv")
)
```
