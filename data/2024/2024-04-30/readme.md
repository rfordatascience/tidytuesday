# Worldwide Bureaucracy Indicators 

This week we're looking at the Worldwide Bureaucracy Indicators (WWBI) dataset from the World Bank.

> The Worldwide Bureaucracy Indicators (WWBI) database is a unique cross-national dataset on public sector employment and wages that aims to fill an information gap, thereby helping researchers, development practitioners, and policymakers gain a better understanding of the personnel dimensions of state capability, the footprint of the public sector within the overall labor market, and the fiscal implications of the public sector wage bill. The dataset is derived from administrative data and household surveys, thereby complementing existing, expert perception-based approaches.

The World Bank introduced the dataset with a series of four blogs:

- [blog1](https://blogs.worldbank.org/developmenttalk/introducing-worldwide-bureaucracy-indicators)
- [blog2](https://blogs.worldbank.org/governance/five-facts-about-gender-equality-public-sector)
- [blog3](https://blogs.worldbank.org/governance/five-facts-gender-equity-public-sector)
- [blog4](https://www.cgdev.org/blog/three-lessons-world-banks-new-worldwide-bureaucracy-indicators-database)

Can you replicate the figures in the blogs? Can you display any of the data more clearly than in the blogs?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-04-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 18)

wwbi_data <- tuesdata$wwbi_data
wwbi_series <- tuesdata$wwbi_series
wwbi_country <- tuesdata$wwbi_country


# Option 2: Read directly from GitHub

wwbi_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_data.csv')
wwbi_series <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_series.csv')
wwbi_country <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-30/wwbi_country.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `wwbi_data.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|country_code   |character |3-letter ISO_3166-1 code |
|indicator_code |character |code identifying the indicator of bureaucracy |
|year           |numeric   |year of the data |
|value          |numeric   |numeric value of the data |

# `wwbi_series.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|indicator_code |character |code identifying the indicator of bureaucracy |
|indicator_name |character |name of the indicator |

# `wwbi_country.csv`

|variable         |class     |description                                      |
|:----------------|:---------|:------------------------------------------------|
|country_code     |character |3-letter ISO_3166-1 code |
|short_name       |character |short or common name for the country |
|table_name       |character |more alphabetically sortable name of the country |
|long_name        |character |full name of the country |
|x2_alpha_code    |character |2-letter ISO_3166-1 code |
|currency_unit    |character |currency unit |
|special_notes    |character |special notes |
|region           |character |region |
|income_group     |character |low, lower middle, upper middle, or high income |
|wb_2_code        |character |alternate 2-letter code |
|national_accounts_base_year |integer |national accounts base year |
|national_accounts_reference_year |integer |national accounts reference year |
|sna_price_valuation |character |UN system of national accounts price valuation |
|lending_category |character |International Development Association (IDA), Interanational Bank of Reconstruction and Development (IBRD), a blend or neither |
|other_groups     |character |Heavily Indebted Poor Countries initiative (HIPC), or countries classified as the "Euro area" |
|system_of_national_accounts |integer |which System of National Accounts methodology the country uses (1968, 1993, or 2008 version) |
|balance_of_payments_manual_in_use |character |the version of the Balance of Payments Manual used by the country |
|external_debt_reporting_status |character |estimate, preliminary, or actual |
|system_of_trade  |character |Under the general system imports include goods imported for domestic consumption and imports into bonded warehouses and free trade zones. Under the special system imports comprise goods imported for domestic consumption (including transformation and repair) and withdrawals for domestic consumption from bonded warehouses and free trade zones. Goods transported through a country en route to another are excluded. |
|government_accounting_concept |character |government accounting concept |
|imf_data_dissemination_standard |character |International Monetary Fund data-dissemination standard: Special Data Dissemination Standard (SDDS, 1996, created for countries
that have or seek to have access to international markets), SDDS Plus (2012, the highest tier of data standards, intended for systemically important economies), enhanced GDDS (e-GDDS, 2015, encouraging participants to emphasize data publication) |
|latest_household_survey |character |which household survey was most recently administered |
|source_of_most_recent_income_and_expenditure_data |character |which survey serves as the basis for income and expenditure data |
|vital_registration_complete |logical |whether the vital registration is complete |
|latest_agricultural_census |integer |year of latest agricultural census |
|latest_industrial_data |integer |year of latest industrial data |
|latest_trade_data |integer |year of latest trade data |
|latest_population_census_year |integer |year of latest population census |
|latest_population_census_notes |character |notes about latest population census |


### Cleaning Script

```{r}
library(tidyverse)
library(janitor)
library(here)
library(fs)
library(withr)

working_dir <- here::here("data", "2024", "2024-04-30")

url <- "https://databank.worldbank.org/data/download/WWBI_CSV.zip"

file_path <- withr::local_tempfile(fileext = ".zip")
download.file(url, file_path)

extract_dir <- withr::local_tempdir("csvs")
unzip(file_path, exdir = extract_dir)

wwbi_country <- readr::read_csv(
  fs::path(extract_dir, "WWBICountry.csv")
) |> 
  janitor::clean_names() |> 
  janitor::remove_empty("cols") |> 
  dplyr::mutate(
    # Several columns are years, make them integers
    national_accounts_reference_year = as.integer(national_accounts_reference_year),
    latest_industrial_data = as.integer(latest_industrial_data),
    latest_trade_data = as.integer(latest_trade_data),
    latest_population_census_year = as.integer(stringr::str_extract(
      latest_population_census,
      "^\\d{4}"
    )),
    latest_agricultural_census = as.integer(stringr::str_extract(
      latest_agricultural_census,
      "^\\d{4}"
    )),
    national_accounts_base_year = as.integer(stringr::str_extract(
      national_accounts_base_year,
      "^\\d{4}"
    )),
    system_of_national_accounts = as.integer(stringr::str_extract(
      system_of_national_accounts,
      "\\d{4}"
    )),
    latest_population_census_notes = stringr::str_remove(
      latest_population_census,
      "^\\d{4}\\.?\\s*"
    ),
    latest_population_census_notes = dplyr::na_if(
      latest_population_census_notes,
      ""
    ),
    # vital_registration_complete is either "yes" or "NA"
    vital_registration_complete = !is.na(vital_registration_complete) 
  ) |> 
  dplyr::select(-"latest_population_census")

wwbi_series <- readr::read_csv(
  fs::path(extract_dir, "WWBISeries.csv"),
  col_types = paste(rep("c", 21), collapse = "")
) |> 
  janitor::clean_names() |> 
  janitor::remove_empty("cols") |> 
  dplyr::rename(indicator_code = "series_code")

wwbi_data <- readr::read_csv(
  fs::path(extract_dir, "WWBIData.csv"),
  col_types = paste(c(rep("c", 4), rep("d", 21), "c"), collapse = "")
) |> 
  janitor::clean_names() |> 
  # indicator_name and country_name are redundant.
  dplyr::select(-"indicator_name", -"country_name") |> 
  janitor::remove_empty("cols") |> 
  tidyr::pivot_longer(
    cols = -c(country_code, indicator_code),
    names_to = "year",
    names_transform = ~ as.integer(stringr::str_remove(.x, "x")),
    values_to = "value"
  ) |> 
  dplyr::filter(!is.na(value))

readr::write_csv(
  wwbi_data,
  fs::path(working_dir, "wwbi_data.csv")
)
readr::write_csv(
  wwbi_series,
  fs::path(working_dir, "wwbi_series.csv")
)
readr::write_csv(
  wwbi_country,
  fs::path(working_dir, "wwbi_country.csv")
)
```
