# IELTS exam results

This week we're exploring **International English Language Testing System (IELTS) Tests statistics**.
The dataset comes from the [IELTS research website](https://ielts.org/researchers/our-research/test-statistics) and contains mean scores in various aggregations. 

> IELTS is proud to offer transparent statistics on our testing system. 
> The following data has been compiled from the scores achieved by various groups of test takers. 
> It helps researchers and teachers understand the performance of the test and how test takers perform in particular countries or regions.

The IELTS exam consists of 4 parts: Listening, Speaking, Reading and Writing. 
Each part is scored using a "band" system from 1 to 9, and then the four parts are averaged for an overall score. 
You can find more information on what each band means [in the IELTS website](https://ielts.org/take-a-test/your-results/ielts-scoring-in-detail).
There are two versions of the exam: Academic and General Training. 
The dataset provides values for the years 2022, 2023 and 2024. 

Some questions you can answer:  

- Do English speakers consistently get top marks on the English language test?
- Which parts of the test do test takers find the most difficult? Is it the same for all test takers?
- Does the reason for taking the test affect the score?
- Has there been a change in tests scores in the three years for which we have information?

Thank you to [Elio Campitelli](https://github.com/eliocamp) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-08-18')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 33)

demo_by_first_language <- tuesdata$demo_by_first_language
demo_by_nationality <- tuesdata$demo_by_nationality
demo_by_reasons <- tuesdata$demo_by_reasons
performance_by_first_language <- tuesdata$performance_by_first_language
performance_by_nationality <- tuesdata$performance_by_nationality

# Option 2: Read directly from GitHub

demo_by_first_language <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_first_language.csv')
demo_by_nationality <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_nationality.csv')
demo_by_reasons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_reasons.csv')
performance_by_first_language <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_first_language.csv')
performance_by_nationality <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_nationality.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-08-18')

# Option 2: Read directly from GitHub and assign to an object

demo_by_first_language = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_first_language.csv')
demo_by_nationality = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_nationality.csv')
demo_by_reasons = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_reasons.csv')
performance_by_first_language = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_first_language.csv')
performance_by_nationality = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_nationality.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-08-18")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

demo_by_first_language = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_first_language.csv")
demo_by_nationality = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_nationality.csv")
demo_by_reasons = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_reasons.csv")
performance_by_first_language = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_first_language.csv")
performance_by_nationality = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_nationality.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
demo_by_first_language = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_first_language.csv", DataFrame)
demo_by_nationality = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_nationality.csv", DataFrame)
demo_by_reasons = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_reasons.csv", DataFrame)
performance_by_first_language = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_first_language.csv", DataFrame)
performance_by_nationality = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_nationality.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `demo_by_first_language.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|type     |character |Type of IELTS exam (Academic or General Training). |
|language |character |Native language of the test taker. |
|band     |character |Band Score.|
|percent  |double    |Proportion of test taker of this native language that got this band score. |
|year     |character |Year cohort. |

### `demo_by_nationality.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|type     |character |Type of IELTS exam (Academic or General Training). |
|nationality |character |Nationality of the test taker. |
|band     |character |Band Score.|
|percent  |double    |Proportion of test taker of this nationality that got this band score. |
|year     |character |Year cohort. |

### `demo_by_reasons.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|type     |character |Type of IELTS exam (Academic or General Training). |
|reason   |character |Stated reason to take the exam. |
|band     |character |Band Score.|
|percent  |double    |Proportion of test taker of this reason that got this band score. |
|year     |character |Year cohort. |

### `performance_by_first_language.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|type     |character |Type of IELTS exam (Academic or General Training). |
|language |character |Native language of the test taker. |
|part     |character |Part of the test (listening, reading, writing, speaking and overall score) |
|score    |double    |Mean score.|
|year     |character |Year cohort. |

### `performance_by_nationality.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|type     |character |Type of IELTS exam (Academic or General Training). |
|nationality |character |Nationality of the test taker. |
|part     |character |Part of the test (listening, reading, writing, speaking and overall score) |
|score    |double    |Mean score.|
|year     |character |Year cohort. |

## Cleaning Script

```r
# URL from https://ielts.org/researchers/our-research/test-statistics
# and internet archive
sources <- list(
  demographic = list(
    "2024-2025" = "https://ielts.org/cdn/ielts-research-data/ielts-demographic-data-2024-2025.xlsx",
    "2023-2024" = "https://ielts.org/cdn/ielts-research-data/ielts-demographic-data-2023-2024.xlsx",
    "2022-2023" = "https://web.archive.org/web/20240105131824/https://s3.eu-west-2.amazonaws.com/ielts-web-static/production/Research/ielts-demographic-data-2022.xlsx"
  ),
  performance = list(
    "2024-2025" = "https://ielts.org/cdn/ielts-research-data/ielts-test-taker-performance-data-2024-2025.xlsx",
    "2023-2024" = "https://ielts.org/cdn/ielts-research-data/ielts-test-taker-performance-data-2023-2024.xlsx",
    "2022-2023" = "https://web.archive.org/web/20231001091407/https://s3.eu-west-2.amazonaws.com/ielts-web-static/production/Research/ielts-test-taker-performance-data-2022.xlsx"
  )
)

root_dir <- "data/curated/ielts"

download <- function(type, year) {
  dir <- file.path(root_dir, "data/raw")
  url <- sources[[type]][[year]]
  destfile <- file.path(dir, glue::glue("{year}_{type}.xlsx"))
  if (file.exists(destfile)) {
    return(destfile)
  }
  dir.create(dirname(destfile), recursive = TRUE, showWarnings = FALSE)
  download.file(url, destfile, mode = "wb")
  return(destfile)
}

read_page_demographics <- function(file, page) {
  bands <- c(
    "<4",
    "4",
    "4.5",
    "5",
    "5.5",
    "6",
    "6.5",
    "7",
    "7.5",
    "8",
    "8.5",
    "9"
  )

  data <- readxl::read_excel(file, sheet = page, skip = 3) |>
    na.omit() # last row sometimes is blank

  colnames(data)[colnames(data) == "Below 4"] <- "<4"
  colnames(data) <- tolower(colnames(data))
  data[["statistic"]] <- NULL
  id <- colnames(data)[1]

  data |>
    tidyr::pivot_longer(cols = -1, names_to = "band", values_to = "percent")
}

read_page_performance <- function(file, page) {
  cols <- c("listening", "reading", "writing", "speaking", "overall")

  data <- readxl::read_excel(file, sheet = page, skip = 2) |>
    na.omit() |> # last row sometimes is blank
    dplyr::select(-2) # remove the "Statistic" column

  colnames(data)[2:6] <- cols
  colnames(data) <- tolower(colnames(data))
  id <- colnames(data)[1]

  data |>
    tidyr::pivot_longer(cols = -1, names_to = "part", values_to = "score")
}

prepare <- function(name, pages_groups, read_page) {
  dir <- file.path(root_dir, "data/cleaned")
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  out <- list()
  for (group in names(pages_groups)) {
    out[[group]] <- lapply(names(sources[[name]]), \(year) {
      file <- download(name, year)
      lapply(pages_groups[[group]], \(page) read_page(file, page)) |>
        setNames(c("Academic", "General_Training")) |>
        dplyr::bind_rows(.id = "type") |>
        dplyr::mutate(year = year)
    }) |>
      dplyr::bind_rows() 
  }
  return(out)
}

demo <- prepare(
  "demographic",
  list(
    reasons = 1:2,
    first_language = 3:4,
    nationality = 5:6
  ),
  read_page_demographics
)
demo_by_reasons <- demo$reasons
demo_by_first_language <- demo$first_language
demo_by_nationality <- demo$nationality

performance <- prepare(
  "performance",
  list(
    nationality = 1:2,
    first_language = 3:4
  ),
  read_page_performance
)

performance_by_nationality <- performance$nationality
performance_by_first_language <- performance$first_language

```
