# TidyTuesday Datasets

This week we're exploring our own data!
The data this week comes from our [{ttmeta}](https://r4ds.github.io/ttmeta/) package, which automatically updates with information about the TidyTuesday datasets.
The data shared here was compiled on 2024-06-18. 
If you would like, you can use the package to retrieve updated information about the last few weeks.

What are the most common variable names?
Of those variables, which are used to mean the same thing, and which are used to mean different things?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-07-02')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 27)

tt_datasets <- tuesdata$tt_datasets
tt_summary <- tuesdata$tt_summary
tt_urls <- tuesdata$tt_urls
tt_variables <- tuesdata$tt_variables

# Option 2: Read directly from GitHub

tt_datasets <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_datasets.csv')
tt_summary <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_summary.csv')
tt_urls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_urls.csv')
tt_variables <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-02/tt_variables.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `tt_summary.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|year          |integer   |The year in which the dataset was released. |
|week          |integer   |The week number for this dataset within this year. |
|date          |Date      |The date of the Tuesday of this week. |
|title         |character |The overall title of this week's TidyTuesday. This is different from the individual dataset titles (although often similar). |
|source_title  |character |The title of this week's source. If there are multiple sources, there is still a single title merging them. |
|article_title |character |The title of this week's article. If there are multiple articles, there is still a single title merging them. |

# `tt_urls.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|year      |integer   |The year in which the dataset was released. |
|week      |integer   |The week number for this dataset within this year. |
|type      |factor    |Whether this url appeared as an "article" or as a data "source". |
|url       |character |The full url. |
|scheme    |factor    |Whether this url uses "http" or "https". |
|domain    |character |The main part of the url. For example, in www.google.com, "google" would be the domain for this column. |
|subdomain |character |The part of the url before the period (when present). For example, in www.google.com, "www" would be the subdomain for this column. |
|tld       |character |The top-level domain, the part of the url after the domain. For example, in www.google.com, "com" would be the tld for this column. |
|path      |character |The part of the url after the slash but before any "?" or "#" (when present). For example, in www.google.com/maps/place/Googleplex, "maps/place/Googleplex" would be the path for this column. |
|query     |character |The parts of the url after "?" (when present). For example, for example.com/source?a=1&b=2, this column would contain "a=1&b=2" |
|fragment  |character |The part of the url after "#" (when present). for example, for cascadiarconf.com/agenda/#craggy, this column would contain "craggy". |

# `tt_datasets.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|year         |integer   |The year in which the dataset was released. |
|week         |integer   |The week number for this dataset within this year. |
|dataset_name |character |The name of this dataset. Some weeks have multiple datasets. |
|variables    |integer   |The number of columns in this dataset. |
|observations |integer   |The number of rows in this dataset. |

# `tt_variables.csv`

|variable     |class     |description  |
|:------------|:---------|:------------|
|year         |integer   |The year in which the dataset was released. |
|week         |integer   |The week number for this dataset within this year. |
|dataset_name |character |The name of this dataset. Some weeks have multiple datasets. |
|variable     |character |The name of this variable. |
|class        |character |The class of this variable. |
|n_unique     |integer   |The number of unique values of this variable within this dataset. |
|min          |character |The "lowest" value of this variable (lowest number, first value alphabetically, etc). |
|max          |character |The "highest" value of this variable (highest number, last value alphabetically, etc). |
|description  |character |A short description of this variable. |

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
