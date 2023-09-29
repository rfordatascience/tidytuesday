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
|funding_opportunity_number             |character |Funding opportunity ID number |
|funding_opportunity_title              |character |Title of the opportunity |
|opportunity_category                   |character |"Continuation", "Discretionary", "Earmark", "Mandatory", or "Other" |
|opportunity_category_explanation       |character |More details about why the opportunity is in that category (mostly details about Other) |
|expected_number_of_awards              |integer   |Expected count of awards |
|cost_sharing_or_matching_requirement   |logical   |Whether the opportunity requires a cost-sharing or cost-matching agreement |
|version                                |integer   |Integer version number of the opportunity |
|posted_date                            |date      |When the opportunity was posted |
|last_updated_date                      |date      |When the opportunity was updated |
|original_closing_date_for_applications |date      |When the opportunity was originally scheduled to close |
|current_closing_date_for_applications  |date      |When the opportunity is currently scheduled to close |
|archive_date                           |date      |When the opportunity will be archived |
|estimated_total_program_funding        |double    |Estimated funding amount in dollars |
|award_ceiling                          |double    |Maximum individual award amount in dollars |
|award_floor                            |double    |Minimum individual award amount in dollars |
|agency_name                            |character |Full name of the granting agency |
|description                            |character |Free text description of the opportunity. Sometimes includes tables or potentially other figures, which did not necessarily scrape accurately |
|link_to_additional_information         |character |The text of any links to additional information (unlikely to be useful in this format) |
|grantor_contact_information            |character |Information about who to contact about the grant; may have contained links, which are not included in the scraped data |
|eligibility_individuals                |logical   |Are individuals eligible? |
|eligibility_state_governments          |logical   |Are state governments eligible? |
|eligibility_county_governments         |logical   |Are county governments eligible? |
|eligibility_independent_school_districts    |logical   |Are independent school districts eligible? |
|eligibility_city_or_township_governments    |logical   |Are city or township governments eligible? |
|eligibility_special_district_governments    |logical   |Are special district governments eligible? |
|eligibility_native_american_tribal_governments_federally_recognized |logical   |Are Native American tribal governments (Federally recognized) eligible? |
|eligibility_native_american_tribal_organizations_other  |logical   |Are Native American tribal organizations (other than Federally recognized tribal governments) eligible? |
|eligibility_nonprofits_501c3  |logical   |Are nonprofits having a 501(c)(3) status with the IRS, other than institutions of higher education eligible? |
|eligibility_nonprofits_non_501c3    |logical   |Are nonprofits that do not have a 501(c)(3) status with the IRS, other than institutions of higher education eligible? |
|eligibility_for_profit  |logical   |Are for profit organizations other than small businesses eligible? |
|eligibility_small_businesses  |logical   |Are small businesses eligible? |
|eligibility_private_institutions_of_higher_education  |logical   |Are private institutions of higher education eligible? |
|eligibility_public_institutions_of_higher_education   |logical   |Are public and State controlled institutions of higher education eligible? |
|eligibility_public_indian_housing_authorities   |logical   |Are public housing authorities and Indian housing authorities eligible? |
|eligibility_others  |logical   |Are other groups eligible? |
|eligibility_unrestricted    |logical   |Is eligibility unrestricted? |
|additional_information_on_eligibility   |character |Additional details about eligibility |
|funding_cooperative_agreement   |logical   |Is the opportunity funded via a cooperative agreement? |
|funding_grant   |logical   |Is the opportunity funded via a grant? |
|funding_procurement_contract  |logical   |Is the opportunity funded via a procurement contract? |
|funding_other   |logical   |Is the opportunity funded via some other instrument? |
|cfda_numbers  |character |Catalog of Federal Domestic Assistance number(s) (see https://sam.gov/content/assistance-listings) |
|category_agriculture  |logical   |Category: Agriculture |
|category_arts   |logical   |Category: Arts (see "Cultural Affairs" in CFDA) |
|category_business   |logical   |Category: Business and Commerce |
|category_community_development  |logical   |Category: Community Development |
|category_consumer_protection  |logical   |Category: Consumer Protection |
|category_disaster   |logical   |Category: Disaster Prevention and Relief |
|category_education  |logical   |Category: Education |
|category_employment   |logical   |Category: Employment, Labor and Training |
|category_energy     |logical   |Category: Energy |
|category_environment  |logical   |Category: Environment|
|category_food   |logical   |Category: Food and Nutrition |
|category_health     |logical   |Category: Health |
|category_housing    |logical   |Category: Housing |
|category_humanities   |logical   |Category: Humanities (see "Cultural Affairs" in CFDA) |
|category_iija   |logical   |Category: Infrastructure Investment and Jobs Act (IIJA) |
|category_income_security    |logical   |Category: Income Security and Social Services |
|category_info   |logical   |Category: Information and Statistics |
|category_law  |logical   |Category: Law, Justice and Legal Services |
|category_natural_resources  |logical   |Category: Natural Resources |
|category_opportunity_zone   |logical   |Category: Opportunity Zone Benefits |
|category_regional_development   |logical   |Category: Regional Development |
|category_science    |logical   |Category: Science and Technology and other Research and Development |
|category_transportation     |logical   |Category: Transportation |
|category_other  |logical   |Category: Other (see category_explanation for clarification) |
|category_explanation  |character |More details about the funding category or categories |

### Cleaning Script


``` r
library(tidyverse)
library(janitor)
library(here)
library(fs)

# Requires dev rvest from this draft pull request:
# https://github.com/tidyverse/rvest/pull/362
#
# pak::pak("tidyverse/rvest#362")
library(rvest)
library(chromote)

working_dir <- here::here("data", "2023", "2023-10-03")

# I wanted to be able to download this CSV periodically, so I found a way to do
# it with {chromote}.

url <- "https://www.grants.gov/web/grants/search-grants.html"
# This probably SHOULD be done in chromote directly, but I'm using this
# rvest::read_html_live() function later and became familiar-enough with it.
live_page <- rvest::read_html_live(url)
# I used sleep()s to make sure the page was ready to continue.
Sys.sleep(10)

js_export_dataset <- readLines(
  fs::path(working_dir, "export_dataset.js")
) |> 
  paste(collapse = "\n")

live_page$session$Browser$setDownloadBehavior(behavior = "allow", downloadPath = tempdir())

live_page$session$Runtime$evaluate(
  js_export_dataset,
  wait_ = TRUE,
  awaitPromise = TRUE
)

# I can't figure out how to await promises with JS just yet, but I can make sure
# the file is there and isn't continuing to save.
grants_path <- fs::dir_info(tempdir(), glob = "*/grants-gov*.csv") |> 
  dplyr::arrange(desc(modification_time)) |> 
  head(1) |> 
  dplyr::pull(path)
while (!length(grants_path)) {
  Sys.sleep(1)
  grants_path <- fs::dir_info(tempdir(), glob = "*/grants-gov*.csv") |> 
    dplyr::arrange(desc(modification_time)) |> 
    head(1) |> 
    dplyr::pull(path)
}
grants_size <- fs::file_size(grants_path)
grants_ready <- FALSE
while (!grants_ready) {
  Sys.sleep(1)
  grants_ready <- grants_size == fs::file_size(grants_path)
}

live_page$session$close()

if (grants_size < 20000000) {
  cli::cli_abort("Grants csv did not download properly.")
}

# Many rows have extra commas at the end, which cause confusion but otherwise
# don't damage the data. You can probably safely ignore the warnings.
grants <- 
  grants_path |> 
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
  ) |> 
  dplyr::mutate(opportunity_id = as.integer(opportunity_id))

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

known_details <- tibble::tibble(opportunity_id = integer(), version = integer())
to_parse <- 
  grants |> 
  dplyr::filter(opportunity_status == "Posted") |> 
  dplyr::pull(opportunity_id)

if (fs::file_exists(fs::path(working_dir, "grant_opportunity_details.csv"))) {
  known_details <- 
    readr::read_csv(
      fs::path(working_dir, "grant_opportunity_details.csv"),
      show_col_types = FALSE
    ) |> 
    dplyr::mutate(
      opportunity_id = as.integer(opportunity_id)
    )
  to_parse <- 
    grants |> 
    dplyr::filter(opportunity_status == "Posted") |> 
    dplyr::mutate(
      version = stringr::str_remove(version, "Synopsis ") |> 
        readr::parse_number()
    ) |> 
    dplyr::anti_join(known_details, by = c("opportunity_id", "version")) |> 
    dplyr::pull(opportunity_id)
}

grant_opportunity_details <- 
  to_parse |>
  purrr::map(get_grant_details) |> 
  purrr::list_rbind()

if (nrow(grant_opportunity_details)) {
  grant_opportunity_details <- 
    grant_opportunity_details |> 
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
    ) |> 
    # Extract information about the various eligibility groups for easier filtering.
    dplyr::mutate(
      eligibility_individuals = stringr::str_detect(eligible_applicants, "Individuals"),
      eligibility_state_governments = stringr::str_detect(eligible_applicants, "State governments"),
      eligibility_county_governments = stringr::str_detect(eligible_applicants, "County governments"),
      eligibility_independent_school_districts = stringr::str_detect(eligible_applicants, "County governments"),
      eligibility_city_or_township_governments = stringr::str_detect(eligible_applicants, "City or township governments"),
      eligibility_special_district_governments = stringr::str_detect(eligible_applicants, "Special district governments"),
      eligibility_native_american_tribal_governments_federally_recognized = stringr::str_detect(eligible_applicants, stringr::fixed("Native American tribal governments (Federally recognized)")),
      eligibility_native_american_tribal_organizations_other = stringr::str_detect(eligible_applicants, stringr::fixed("Native American tribal organizations (other than Federally recognized tribal governments)")),
      eligibility_nonprofits_501c3 = stringr::str_detect(eligible_applicants, stringr::fixed("Nonprofits having a 501(c)(3) status with the IRS, other than institutions of higher education")),
      eligibility_nonprofits_non_501c3 = stringr::str_detect(eligible_applicants, stringr::fixed("Nonprofits that do not have a 501(c)(3) status with the IRS, other than institutions of higher education")),
      eligibility_for_profit = stringr::str_detect(eligible_applicants, "For profit organizations other than small businesses"),
      eligibility_small_businesses = stringr::str_detect(eligible_applicants, "Small businesses"),
      eligibility_private_institutions_of_higher_education = stringr::str_detect(eligible_applicants, "Private institutions of higher education"),
      eligibility_public_institutions_of_higher_education = stringr::str_detect(eligible_applicants, "Public and State controlled institutions of higher education"),
      eligibility_public_indian_housing_authorities = stringr::str_detect(eligible_applicants, stringr::fixed("Public housing authorities/Indian housing authorities")),
      eligibility_others = stringr::str_detect(eligible_applicants, stringr::fixed("Others (see text field entitled \"Additional Information on Eligibility\" for clarification)")),
      eligibility_unrestricted = stringr::str_detect(eligible_applicants, stringr::fixed("Unrestricted (i.e., open to any type of entity above), subject to any clarification in text field entitled \"Additional Information on Eligibility\""))
    ) |> 
    dplyr::relocate(additional_information_on_eligibility, .after = eligibility_unrestricted) |>
    dplyr::select(-eligible_applicants) |> 
    # Extract information about the various funding_instrument_types for easier filtering.
    dplyr::mutate(
      funding_cooperative_agreement = stringr::str_detect(funding_instrument_type, "Cooperative Agreement"),
      funding_grant = stringr::str_detect(funding_instrument_type, "Grant"),
      funding_procurement_contract = stringr::str_detect(funding_instrument_type, "Procurement Contract"),
      funding_other = stringr::str_detect(funding_instrument_type, "Other")
    ) |> 
    dplyr::select(-funding_instrument_type) |> 
    # Clean up the CFDA numbers, at least somewhat.
    dplyr::mutate(
      cfda_numbers = stringr::str_extract_all(cfda_number_s, "\\d{2}\\.\\d{3} -- \\D+") |> 
        purrr::map_chr(paste, collapse = " | ")
    ) |> 
    dplyr::select(-cfda_number_s) |>
    # Clean up the category_of_funding_activity, at least somewhat.
    dplyr::mutate(
      category_agriculture = stringr::str_detect(category_of_funding_activity, "Agriculture"),
      category_arts = stringr::str_detect(category_of_funding_activity, stringr::fixed("Arts (see \"Cultural Affairs\" in CFDA)")),
      category_business = stringr::str_detect(category_of_funding_activity, "Business and Commerce"),
      category_community_development = stringr::str_detect(category_of_funding_activity, "Community Development"),
      category_consumer_protection = stringr::str_detect(category_of_funding_activity, "Consumer Protection"),
      category_disaster = stringr::str_detect(category_of_funding_activity, "Disaster Prevention and Relief"),
      category_education = stringr::str_detect(category_of_funding_activity, "Education"),
      category_employment = stringr::str_detect(category_of_funding_activity, "Employment, Labor and Training"),
      category_energy = stringr::str_detect(category_of_funding_activity, "Energy"),
      category_environment = stringr::str_detect(category_of_funding_activity, "Environment"),
      category_food = stringr::str_detect(category_of_funding_activity, "Food and Nutrition"),
      category_health = stringr::str_detect(category_of_funding_activity, "Health"),
      category_housing = stringr::str_detect(category_of_funding_activity, "Housing"),
      category_humanities = stringr::str_detect(category_of_funding_activity, stringr::fixed("Humanities (see \"Cultural Affairs\" in CFDA)")),
      category_iija = stringr::str_detect(category_of_funding_activity, stringr::fixed("Infrastructure Investment and Jobs Act (IIJA)")),
      category_income_security = stringr::str_detect(category_of_funding_activity, "Income Security and Social Services"),
      category_info = stringr::str_detect(category_of_funding_activity, "Information and Statistics"),
      category_law = stringr::str_detect(category_of_funding_activity, "Law, Justice and Legal Services"),
      category_natural_resources = stringr::str_detect(category_of_funding_activity, "Natural Resources"),
      category_opportunity_zone = stringr::str_detect(category_of_funding_activity, "Opportunity Zone Benefits"),
      category_regional_development = stringr::str_detect(category_of_funding_activity, "Regional Development"),
      category_science = stringr::str_detect(category_of_funding_activity, "Science and Technology and other Research and Development"),
      category_transportation = stringr::str_detect(category_of_funding_activity, "Transportation"),
      category_other = stringr::str_detect(category_of_funding_activity, stringr::fixed("Other (see text field entitled \"Explanation of Other Category of Funding Activity\" for clarification)"))
    ) |> 
    dplyr::relocate(category_explanation, .after = category_other) |> 
    dplyr::select(-category_of_funding_activity) |> 
    dplyr::select(-document_type)
}

if (nrow(known_details)) {
  grant_opportunity_details <- 
    known_details |> 
    dplyr::bind_rows(grant_opportunity_details) |> 
    dplyr::arrange(opportunity_id, desc(version)) |> 
    dplyr::distinct(opportunity_id, .keep_all = TRUE)
}

readr::write_csv(
  grants,
  fs::path(working_dir, "grants.csv")
)
readr::write_csv(
  grant_opportunity_details,
  fs::path(working_dir, "grant_opportunity_details.csv")
)
```
