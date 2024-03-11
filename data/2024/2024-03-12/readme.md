# Fiscal Sponsors

TidyTuesday is organized by the [R4DS Online Learning Community](https://r4ds.io).
We are currently (when this dataset was first posted in March, 2024) seeking a new fiscal sponsor.
See [our Donate page](https://r4ds.io/donate.html) for details about our current efforts.

To aid in our search, the dataset this week comes from the [Fiscal Sponsor Directory](https://fiscalsponsordirectory.org/?page_id=1330).
The data is fairly messy, but you may be able to extract more information from it.

The Fiscal Sponsor Directory [analyzed their directory in March 2023](https://fiscalsponsordirectory.org/?page_id=95).

- Has the data changed?
- Can you identify other trends, or represent them more clearly?
- Can you identify sponsors that might be particularly appealing to the R4DS Online Learning Community, a "diverse, friendly, and inclusive community of data science learners and practitioners" (a global community based in Austin, Texas, USA)?


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-03-12')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 11)

fiscal_sponsor_directory <- tuesdata$fiscal_sponsor_directory


# Option 2: Read directly from GitHub

fiscal_sponsor_directory <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-12/fiscal_sponsor_directory.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `fiscal_sponsor_directory.csv`

|variable                           |class     |description                        |
|:----------------------------------|:---------|:----------------------------------|
|details_url                        |character |The source of the information about this sponsor. |
|name                               |character |The name of this fiscal sponsor. |
|website                            |character |The URL for this sponsor's website. |
|year_501c3                         |integer   |The year in which this sponsor became a 501(c)(3) charitable organization. |
|year_fiscal_sponsor                |integer   |The year in which this organization first acted as a fiscal sponsor. |
|n_sponsored                        |integer   |The number of projects sponsored by this sponsor. |
|fiscal_sponsorship_fee_description |character |Free text describing the fees associated with fiscal sponsorship by this organization. |
|eligibility_criteria               |character |Free text describing requirements for an organization to be sponsored by this sponsor. This field contains multiple values, concatenated with "|" (see below).|
|project_types                      |character |Free text describing the types of projects that this organization sponsors. This field contains multiple values, concatenated with "|" (see below). |
|services                           |character |The services offered by this sponsor. This field contains multiple values, concatenated with "|" (see below). |
|fiscal_sponsorship_model           |character |The model(s) to which this sponsor belongs. The models are described in "Fiscal Sponsorship: 6 Ways to Do It Right", sold by fiscalsponsordirectory.org. This field contains multiple values, concatenated with "|" (see below). |
|description                        |character |A free text description of this organization. |


### Cleaning Script

Note: To separate the `eligibility_criteria`, `project_types`, `services`, and `fiscal_sponsorship_model` fields into list columns, you can use the following code:

``` r
fiscal_sponsor_directory |> 
  dplyr::mutate(
    dplyr::across(
      c(eligibility_criteria, project_types, services, fiscal_sponsorship_model),
      \(col) {
        stringr::str_split(col, "\\|")
      }
    )
  )
```

``` r
library(tidyverse)
library(rlang)
library(rvest)
library(here)
library(fs)

working_dir <- here::here("data", "2024", "2024-03-12")

fiscal_sponsors_list_url <- "https://fiscalsponsordirectory.org/?page_id=1330"

# Read the HTML once so we don't have to keep hitting it.
fiscal_sponsors_list_html <- rvest::read_html(fiscal_sponsors_list_url)

fiscal_sponsor_names <- fiscal_sponsors_list_html |> 
  rvest::html_elements("#main-content a") |>   
  rvest::html_text2() |> 
  stringr::str_trim()

fiscal_sponsor_urls <- fiscal_sponsors_list_html |> 
  rvest::html_elements("#main-content a") |> 
  rvest::html_attr("href") |> 
  # Some of them randomly have "&preview=true" appended, but it doesn't do
  # anything useful.
  stringr::str_remove("&preview=true$")

fiscal_sponsors <- tibble::tibble(
  name = fiscal_sponsor_names,
  details_url = fiscal_sponsor_urls
) |> 
  dplyr::distinct() |> 
  dplyr::summarize(
    name = paste(name, collapse = ""),
    .by = details_url
  )

text_after_heading <- function(these_texts,
                               heading_regex,
                               heading_regex_remove = heading_regex) {
  this_text <- these_texts |>
    stringr::str_subset(paste0(heading_regex, "\\S+")) |>
    # One had a weird repeat.
    stringr::str_remove(heading_regex_remove)
  
  if (!length(this_text)) {
    this_text_n <- these_texts |> 
      stringr::str_which(heading_regex)
    if (length(this_text_n)) {
      this_text <- these_texts[[this_text_n + 1]]
    } else {
      this_text <- NA_character_
    }
  }
  this_text <- unique(this_text)
  
  if (!all(is.na(this_text))) {
    this_text <- paste(this_text, collapse = "\n")
  }
  
  return(this_text)
}

fiscal_sponsor_details <- fiscal_sponsors$details_url |> 
  purrr::map(
    \(details) {
      this_page <- rlang::try_fetch(
        rvest::read_html(details),
        error = function(e) {
          NULL
        }
      )
      if (is.null(this_page)) {
        return(tibble::tibble(details_url = details))
      }
      
      # The pages all have a logical structure, but the data doesn't know about
      # the structure. We need to extract things back out.
      these_texts <- this_page |> 
        rvest::html_elements(".entry-content p, .entry-content div") |> 
        rvest::html_text2() |> 
        stringr::str_subset(".+") |> 
        unique()
      these_uls <- this_page |> 
        rvest::html_elements(".entry-content ul") |> 
        rvest::html_text2()
      
      website <- these_texts |> 
        stringr::str_subset(
          "Website:\\s*"
        ) |>
        stringr::str_extract(
          "Website:\\s*(\\S+)",
          1
        ) |> 
        stringr::str_remove("^https?://") |>
        unique()
      year_501c3 <- these_texts |> 
        stringr::str_subset(
          "Year organization became a 501\\(c\\)\\(3\\):\\s*"
        ) |>
        stringr::str_extract(
          "Year organization became a 501\\(c\\)\\(3\\):\\s*(\\d+)",
          1
        ) |> 
        as.integer() |> 
        unique()
      year_fiscal_sponsor <- these_texts |> 
        stringr::str_subset(
          "Year of first fiscal sponsorship:\\s*"
        ) |>
        stringr::str_extract(
          "Year of first fiscal sponsorship:\\s*(\\d+)",
          1
        ) |> 
        as.integer() |> 
        unique()
      n_sponsored <- these_texts |> 
        stringr::str_subset(
          "Number of sponsored projects:\\s*"
        ) |>
        stringr::str_extract(
          "Number of sponsored projects:\\s*(\\d+)",
          1
        ) |> 
        as.integer() |> 
        unique()
      fiscal_sponsorship_fee_description <- text_after_heading(
        these_texts,
        "^(Fiscal sponsorship fee)|(Fees)",
        "^(((Fiscal sponsorship fee)|(Fees))(:?)(\\s*))+"
      )
      organization_description <- text_after_heading(
        these_texts, 
        "^(Project )?Organization ([dD]escription:)?\\s*"
      )
      
      if (length(these_uls)) {
        eligibility_criteria <- NA_character_
        project_types <- NA_character_
        services <- NA_character_
        fiscal_sponsorship_model <- NA_character_
        n <- 1L
        if (
          any(stringr::str_detect(these_texts, "Eligibility criteria:")) &&
          length(these_uls) >= n
        ) {
          eligibility_criteria <- these_uls[[n]]
          n <- n + 1L
        }
        if (
          any(stringr::str_detect(these_texts, "Types of projects or services we sponsor:")) &&
          length(these_uls) >= n
        ) {
          project_types <- these_uls[[n]]
          n <- n + 1L
        }
        if (
          any(stringr::str_detect(these_texts, "Services we offer projects:")) &&
          length(these_uls) >= n
        ) {
          services <- these_uls[[n]]
          n <- n + 1L
        }
        if (
          any(stringr::str_detect(these_texts, "Based on Fiscal Sponsorship: 6 Ways to Do It Right")) &&
          length(these_uls) >= n
        ) {
          fiscal_sponsorship_model <- these_uls[[n]]
          n <- n + 1L
        }
      } else {
        eligibility_criteria <- text_after_heading(
          these_texts,
          "^Eligibility criteria:\\s*"
        )
        project_types <- text_after_heading(
          these_texts,
          "^Types of projects or services we sponsor:\\s*"
        )
        services <- text_after_heading(
          these_texts,
          "Services we offer projects:\\s*"
        )
        fiscal_sponsorship_model <- text_after_heading(
          these_texts,
          "Based on Fiscal Sponsorship: 6 Ways to Do It Right: Our model\\(s\\) of fiscal sponsorship are:\\s*"
        )
      }
      
      # Work on the assumption that all are the same until proven otherwise.
      tibble::tibble(
        details_url = details,
        website = website,
        year_501c3 = year_501c3,
        year_fiscal_sponsor = year_fiscal_sponsor,
        n_sponsored = n_sponsored,
        fiscal_sponsorship_fee_description = fiscal_sponsorship_fee_description,
        eligibility_criteria = eligibility_criteria,
        project_types = project_types,
        services = services,
        fiscal_sponsorship_model = fiscal_sponsorship_model,
        description = organization_description
      )
    }
  ) |> 
  purrr::list_rbind()

fiscal_sponsor_details <- fiscal_sponsor_details |> 
  dplyr::mutate(
    eligibility_criteria = stringr::str_split(eligibility_criteria, "\\n"),
    project_types = stringr::str_split(project_types, "\\n"),
    services = stringr::str_split(services, "\\n"),
    fiscal_sponsorship_model = stringr::str_split(fiscal_sponsorship_model, "\\n")
  )

fiscal_sponsor_directory <- fiscal_sponsors |> 
  dplyr::left_join(fiscal_sponsor_details) |> 
  # Recombine the list columns to save as CSV.
  dplyr::mutate(
    dplyr::across(
      c(eligibility_criteria, project_types, services, fiscal_sponsorship_model),
      \(col) {
        purrr::map_chr(
          col,
          \(x) {
            paste(x, collapse = "|")
          }
        )
      }
    )
  )

readr::write_csv(
  fiscal_sponsor_directory,
  fs::path(working_dir, "fiscal_sponsor_directory.csv")
)
```
