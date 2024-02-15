# R Consortium ISC Grants

The R Consortium Infrastructure Steering Committee (ISC) Grant Program will accept proposals again between March 1 and April 1, 2024 (and then again in the fall).

> This initiative is a cornerstone of our commitment to bolstering and enhancing the R Ecosystem. We fund projects contributing to the R community’s technical and social infrastructures.

Learn more in [their blog post announcing this round of grants](https://www.r-consortium.org/blog/2024/02/08/r-consortium-infrastructure-steering-committee-isc-grant-program-accepting-proposals-starting-march-1st).

The R Consortium ISC has been awarding grants since 2016.
This week's data is an exploration of past grant recipients.

Are there any keywords that stand out in the titles or summaries of awarded grants?
Have the funded amounts changed over time?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-02-20')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 8)

isc_grants <- tuesdata$isc_grants

# Option 2: Read directly from GitHub

isc_grants <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-20/isc_grants.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `isc_grants.csv`

|variable    |class     |description         |
|:-----------|:---------|:-------------------|
|year        |integer   |The year in which the grant was awarded. |
|group       |integer   |Whether the grant was awarded in the spring cycle (1) or the fall cycle (2). |
|title       |character |The title of the project. |
|funded      |integer   |The dollar amount funded for the project. |
|proposed_by |character |The name of the person who requested the grant. |
|summary     |character |A description of the project. |
|website     |character |The website associated with the project, if available. |

### Cleaning Script

``` r
library(tidyverse)
library(janitor)
library(rlang)
library(rvest)
library(here)

working_dir <- here::here("data", "2024", "2024-02-20")

all_grants_url <- "https://www.r-consortium.org/all-projects/awarded-projects"
urls <-
  all_grants_url |> 
  rvest::read_html() |> 
  rvest::html_node(".main-content") |> 
  rvest::html_nodes("a") |> 
  rvest::html_attr("href") |> 
  stringr::str_subset(stringr::fixed("/projects/awarded-projects/")) |> 
  stringr::str_remove("#.+$") |> 
  unique() |> 
  rvest::url_absolute(all_grants_url)

get_grant_data <- function(url) {
  year <- as.integer(stringr::str_extract(url, "\\d{4}"))
  group <- as.integer(stringr::str_extract(url, "\\d$"))
  project_description_html <- 
    rvest::read_html(url) |> 
    rvest::html_nodes(".project-description") 
  titles <- 
    project_description_html |> 
    rvest::html_nodes("h3") |> 
    rvest::html_text2()
  other_data <- 
    project_description_html |> 
    purrr::map(parse_project_description) |> 
    purrr::list_rbind()
  
  tibble::tibble(
    year = year,
    group = group,
    title = titles,
    other_data
  )
}

parse_project_description <- function(project_description_html) {
  pieces <- project_description_html |> 
    rvest::html_nodes("p") |> 
    rvest::html_text2() |> 
    stringr::str_split(":\n")
  
  pieces <- purrr::reduce(
    pieces,
    \(x, y) {
      if (!rlang::is_named(x) && length(x) == 2) {
        x <- rlang::set_names(x[[2]], x[[1]])
      }
      if (length(y) == 2) {
        y <- rlang::set_names(y[[2]], y[[1]])
      } else {
        x[[length(x)]] <- paste(x[[length(x)]], y, sep = "\n")
        y <- NULL
      }
      return(c(x, y))
    }
  )
  
  pieces |> 
    tibble::enframe() |> 
    tidyr::pivot_wider(names_from = name, values_from = value)
}

isc_grants <- 
  urls |> 
  purrr::map(get_grant_data) |> 
  purrr::list_rbind() |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    funded = stringr::str_remove(funded, "\\$") |> 
      stringr::str_remove(",") |> 
      as.integer(),
    website = dplyr::na_if(website, "")
  )

readr::write_csv(
  isc_grants,
  fs::path(working_dir, "isc_grants.csv")
)
```
