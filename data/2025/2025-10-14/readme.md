# World Food Day

This Thursday (2025-10-16) is [World Food Day](https://en.wikipedia.org/wiki/World_Food_Day), which celebrates the foundation of [The Food and Agriculture Organization of the United Nations (FAO)](https://en.wikipedia.org/wiki/Food_and_Agriculture_Organization), which turns 80 this week! To mark this occasion, this week we're looking at the FAO's [Suite of Food Security Indicators](https://www.fao.org/faostat/en/#data/FS).

> Following the recommendation of experts gathered in the Committee on World Food Security (CFS) Round Table on hunger measurement, hosted at FAO headquarters in September 2011, an initial set of indicators aiming to capture various aspects of food insecurity is presented here. The choice of the indicators has been informed by expert judgment and the availability of data with sufficient coverage to enable comparisons across regions and over time.

- Which indicators tend to vary together?
- Do any indicators appear to be leading indicators of others?
- Of the indicators with confidence intervals, how have the confidence intervals changed over time or by region?

Thanks to [Carl Börstell](https://github.com/borstell) for suggesting this dataset!

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-10-14')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 41)

food_security <- tuesdata$food_security

# Option 2: Read directly from GitHub

food_security <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-14/food_security.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-10-14')

# Option 2: Read directly from GitHub and assign to an object

food_security = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-14/food_security.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-10-14')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

food_security = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-14/food_security.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
food_security = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-10-14/food_security.csv", DataFrame)
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

### `food_security.csv`

|variable   |class     |description                           |
|:----------|:---------|:-------------------------------------|
|Year_Start |integer   |First year of this observation. |
|Year_End   |integer   |Final year of this observation. |
|Area       |character |Country or region in which the observation took place. |
|Item       |character |The specific indicator of food security. |
|Unit       |character |Unit of the measurement. One of "g/cap/d" (Grams per capita per day), "Int$/cap" (International Dollar per capita), "kcal/cap/d" (Kilocalories per capita per day), "km" (Kilometers), "million No" (million Number), "No" (Number), "%" (Percent), "1000 Int$/cap" (thousand International Dollar per capita), or "index". |
|Value      |double    |The numeric value of the measurement. Note: values of "0.09", "0.49", and "2.49" were "<0.1", "<0.5", and "<2.5" (respectively) in the original dataset. |
|CI_Lower   |double    |The lower bound of the confidence interval of the measurement. Note: values of "0.09" and "0.49" were "<0.1" and "<0.5" (respectively) in the original dataset. |
|CI_Upper   |double    |The upper bound of the confidence interval of the measurement. Note: values of "0.09" and "0.49" were "<0.1" and "<0.5" (respectively) in the original dataset. |
|Flag       |character |Additional information about the measurement. One of "Estimated value", "Figure from external organization", "Missing value", "Missing value; suppressed", or "Official figure" |
|Note       |character |Additional details about this measurement (mostly NA). |

## Cleaning Script

```r
library(tidyverse)
library(withr)

food_security_url <- "https://bulks-faostat.fao.org/production/Food_Security_Data_E_All_Data_(Normalized).zip"
csv_location <- withr::local_tempfile(fileext = ".zip")
download.file(food_security_url, destfile = csv_location)
food_security <- readr::read_csv(csv_location) |>
  # These fields are only useful if you're looking things up elsewhere
  dplyr::select(-tidyselect::contains("Code")) |>
  tidyr::pivot_wider(names_from = "Element", values_from = "Value") |>
  dplyr::rename(
    CI_Lower = "Confidence interval: Lower bound",
    CI_Upper = "Confidence interval: Upper bound"
  ) |>
  dplyr::mutate(
    Flag = dplyr::case_match(
      .data$Flag,
      "E" ~ "Estimated value",
      "X" ~ "Figure from external organization",
      "O" ~ "Missing value",
      "Q" ~ "Missing value; suppressed",
      "A" ~ "Official figure"
    ),
    # Remember to note this in dictionary!
    dplyr::across(
      c(tidyselect::starts_with("CI_"), "Value"),
      \(CI) {
        dplyr::case_match(
          .data$CI,
          "<0.1" ~ 0.09,
          "<0.5" ~ 0.49,
          "<2.5" ~ 2.49
        ) |>
          as.numeric()
      }
    ),
    Year_Start = as.integer(stringr::str_extract(.data$Year, "^(\\d{4})")),
    Year_End = as.integer(stringr::str_extract(.data$Year, "(\\d{4})$")),
    Unit = dplyr::case_when(
      is.na(.data$Unit) &
        .data$Item ==
          "Political stability and absence of violence/terrorism (index)" ~
        "index",
      .default = .data$Unit
    )
  ) |>
  dplyr::select(
    tidyselect::starts_with("Year_"),
    "Area",
    "Item",
    "Unit",
    "Value",
    tidyselect::starts_with("CI"),
    "Flag",
    "Note"
  )

# Filter so the resulting CSV will fit on GitHub.
food_security <- food_security |>
  dplyr::filter(.data$Year_Start >= 2005)

rm(csv_location, food_security_url)

```
