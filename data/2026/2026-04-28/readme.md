# US Agricultural Tariffs

This week we're exploring US Agricultural Tariffs! The dataset comes from the [USITC Tariff Database](https://dataweb.usitc.gov/tariff/annual), which contains tariff rates for all products imported into the United States from 1997-2025. This week's data focuses on agricultural and food products (HTS Chapters 1-24), covering everything from live animals to beverages.

This is part of a potential series of US tariff datasets exploring different sectors of the Harmonized Tariff Schedule. The data includes Most Favored Nation (MFN) rates that apply to normal trade relations, as well as preferential rates under various trade agreements like NAFTA/USMCA, and individual bilateral agreements with countries like Chile, Australia, and Korea. Tariff rates can include both ad valorem (percentage-based) and specific (per-unit) components, and they can change multiple times within a year.

> Welcome to the U.S. International Trade Commission. We’re an independent, nonpartisan, quasi-judicial federal agency that fulfills a range of trade-related mandates. We provide high-quality, leading-edge analysis of international trade issues to the President and the Congress. The Commission is a highly regarded forum for the adjudication of intellectual property and trade disputes.

* How do tariff rates for agricultural products compare between different trade agreements?
* Which products have seen the largest changes in MFN rates over time?
* Do products with higher MFN rates tend to have more preferential trade agreements?
* How have NAFTA/USMCA rates evolved from the 1990s to today?

This submission was generated with the help of Claude Sonnet 4.5 via Posit Assistant (in private beta at the time of this submission, but now available to everyone). [Learn more about Posit Assistant and sign up](https://posit.co/products/ai/).

Code for the plot:

```r
library(conflicted)
conflicted::conflict_prefer_all("dplyr", quiet = TRUE)
library(tidyverse)
library(lubridate)
library(ggtext)

# Load the data
tariff_agricultural <- read_csv("tariff_agricultural.csv")
agreements <- read_csv("agreements.csv")

# Add year columns for joining
tariff_with_years <- tariff_agricultural |>
  mutate(
    begin_effective_year = year(begin_effective_date),
    end_effective_year = year(end_effective_date)
  )

# Create all combinations of hts8-agreement pairs with years 2000-2024
tariff_hts_agreement <- tariff_agricultural |>
  distinct(hts8, agreement)

tariff_agricultural_years <- tariff_hts_agreement |>
  crossing(year = 2000:2024)

# Join to get the rates that were in effect for each year
tariff_rates_by_year <- tariff_agricultural_years |>
  left_join(
    tariff_with_years,
    join_by(
      hts8,
      agreement,
      year >= begin_effective_year,
      year <= end_effective_year
    )
  ) |>
  filter(!is.na(ad_val_rate))

# Remove duplicates (rates that apply to same product-agreement-year)
tariff_rates_by_year_clean <- tariff_rates_by_year |>
  distinct(hts8, agreement, year, ad_val_rate, specific_rate)

# Extract HTS section from the first 2 digits of hts8
tariff_rates_with_section <- tariff_rates_by_year_clean |>
  mutate(
    hts_chapter = as.integer(substr(hts8, 1, 2)),
    section = case_when(
      hts_chapter <= 5 ~ "I. Live Animals & Animal Products",
      hts_chapter <= 14 ~ "II. Vegetable Products",
      hts_chapter <= 15 ~ "III. Animal/Vegetable Fats & Oils",
      hts_chapter <= 24 ~ "IV. Prepared Foodstuffs",
      TRUE ~ "Other"
    )
  )

section_colors <- c(
  "I. Live Animals & Animal Products" = "#D55E00",
  "II. Vegetable Products" = "#009E73",
  "III. Animal/Vegetable Fats & Oils" = "#CC79A7",
  "IV. Prepared Foodstuffs" = "#0072B2"
)

mfn_by_section <- tariff_rates_with_section |>
  # Filter for reasonable percentage rates
  filter(ad_val_rate > 0, ad_val_rate < 1) |> 
  left_join(agreements, by = "agreement") |>
  filter(agreement_full == "Most Favored Nation (MFN)") |>
  group_by(year, section) |>
  summarise(
    avg_rate = mean(ad_val_rate, na.rm = TRUE),
    n_products = n(),
    .groups = "drop"
  ) |>
  filter(n_products >= 10) |>
  mutate(
    section_label = case_when(
      section == "I. Live Animals & Animal Products" ~ 
        "<span style='color:#D55E00'>**I. Live Animals & Animal Products**</span>",
      section == "II. Vegetable Products" ~ 
        "<span style='color:#009E73'>**II. Vegetable Products**</span>",
      section == "III. Animal/Vegetable Fats & Oils" ~ 
        "<span style='color:#CC79A7'>**III. Animal/Vegetable Fats & Oils**</span>",
      section == "IV. Prepared Foodstuffs" ~ 
        "<span style='color:#0072B2'>**IV. Prepared Foodstuffs**</span>",
      TRUE ~ section
    ),
    section_label = factor(section_label, levels = c(
      "<span style='color:#D55E00'>**I. Live Animals & Animal Products**</span>",
      "<span style='color:#009E73'>**II. Vegetable Products**</span>",
      "<span style='color:#CC79A7'>**III. Animal/Vegetable Fats & Oils**</span>",
      "<span style='color:#0072B2'>**IV. Prepared Foodstuffs**</span>"
    ))
  )

mfn_background <- select(mfn_by_section, "year", "section", "avg_rate")

p <- ggplot() +
  # Background: all sections in grey
  geom_line(data = mfn_background, 
            aes(x = year, y = avg_rate * 100, group = section),
            color = "grey70", linewidth = 0.5, alpha = 0.6) +
  # Foreground: highlighted section with its color
  geom_line(data = mfn_by_section,
            aes(x = year, y = avg_rate * 100, color = section),
            linewidth = 1.2, show.legend = FALSE) +
  geom_point(data = mfn_by_section,
             aes(x = year, y = avg_rate * 100, color = section),
             size = 1.5, alpha = 0.7, show.legend = FALSE) +
  scale_color_manual(values = section_colors) +
  facet_wrap(~section_label, ncol = 2) +
  scale_x_continuous(breaks = seq(2000, 2024, by = 4)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "MFN tariff rates are highest for <span style='color:#D55E00'>**Live Animals & Animal Products**</span>",
    subtitle = "Most Favored Nation rates by HTS section (2000-2024), with all sections shown in grey for comparison",
    x = "Year",
    y = "Average Tariff Rate"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_markdown(size = 14),
    plot.subtitle = element_text(size = 10),
    strip.text = element_markdown(size = 9)
  )

p
```

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-04-28')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 17)

agreements <- tuesdata$agreements
quantity_codes <- tuesdata$quantity_codes
tariff_agricultural <- tuesdata$tariff_agricultural
tariff_codes <- tuesdata$tariff_codes

# Option 2: Read directly from GitHub

agreements <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/agreements.csv')
quantity_codes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/quantity_codes.csv')
tariff_agricultural <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_agricultural.csv')
tariff_codes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_codes.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-04-28')

# Option 2: Read directly from GitHub and assign to an object

agreements = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/agreements.csv')
quantity_codes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/quantity_codes.csv')
tariff_agricultural = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_agricultural.csv')
tariff_codes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_codes.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-04-28")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

agreements = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/agreements.csv")
quantity_codes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/quantity_codes.csv")
tariff_agricultural = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_agricultural.csv")
tariff_codes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_codes.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
agreements = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/agreements.csv", DataFrame)
quantity_codes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/quantity_codes.csv", DataFrame)
tariff_agricultural = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_agricultural.csv", DataFrame)
tariff_codes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-28/tariff_codes.csv", DataFrame)
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

### `agreements.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|agreement       |character |Trade agreement or rate type code as used in the tariff datasets (e.g., "mfn", "chile", "cbi*"). |
|agreement_full  |character |Full name of the trade agreement or rate type. |
|agreement_notes |character |Additional notes about eligibility, restrictions, or program status. Common values: duty-free status, country-specific variations (e.g., "Canada" vs "Mexico" for NAFTA), "Plus rate" for enhanced benefits, or "Program expired" for discontinued programs. |

### `quantity_codes.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|code        |character |Unit of quantity code used in tariff schedules (e.g., KG, NO, M2). |
|description |character |Full description of the unit of measurement for the code. |

### `tariff_agricultural.csv`

|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|hts8                 |character |8-digit Harmonized Tariff Schedule code (legal tariff line). Join with `tariff_codes` for product descriptions. |
|begin_effective_date |date      |Beginning effective date for tariff rate (rates can change mid-year). |
|end_effective_date   |date      |Ending effective date for tariff rate. Far-future dates (e.g., 2050-12-31, 2100-12-31) indicate no scheduled change. |
|agreement            |character |Trade agreement or rate type code. Join with `agreements` table for full names and notes. Asterisk (`*`) or plus (`+`) suffix indicates restrictions (e.g., `"cbi*"` = certain products/countries excluded). |
|rate_type_code       |character |Duty calculation method code. See https://www.usitc.gov/applications/dataweb/td-codes.pdf for details (0=free, 1-6=specific formulas, 7=ad valorem, 9=derived duty, K/X/T=see HTS). |
|ad_val_rate          |double    |Ad valorem (percentage) portion of the duty rate (0.05 = 5%). |
|specific_rate        |double    |Specific (per-unit) portion of the duty rate in dollars (0.05 = $0.05 per unit of quantity). |

### `tariff_codes.csv`

|variable                |class     |description                           |
|:-----------------------|:---------|:-------------------------------------|
|earliest_effective_date |date      |Earliest effective date this HTS code/description combination appeared in the data. |
|hts8                    |character |8-digit Harmonized Tariff Schedule code (legal tariff line). |
|description             |character |Abbreviated product description (max 150 characters, not legally binding). |
|quantity_1_code         |character |Primary unit of quantity code. See the `quantity_codes` dataset for descriptions. |
|quantity_2_code         |character |Secondary unit of quantity code if applicable. See the `quantity_codes` dataset for descriptions. |
|wto_binding_code        |character |WTO tariff binding status (B=bound, U=unbound; C/P/V are undocumented, possibly typos). |

## Cleaning Script

```r
library(tidyverse)
library(withr)
library(curl)
library(glue)
library(cli)
library(fs)

# Setup ----

# Create a handle with user agent to avoid 403 errors
handle <- curl::new_handle()
curl::handle_setheaders(
  handle,
  "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
)

# Function to download one year of data
download_tariff_year <- function(year, handle, cache_dir) {
  url <- glue::glue(
    "https://www.usitc.gov/tariff_affairs/documents/tariff_data/tariff_data_{year}.zip"
  )

  zip_file <- fs::path(cache_dir, glue::glue("tariff_data_{year}.zip"))

  # Only download if not already cached
  if (!fs::file_exists(zip_file)) {
    cli::cli_inform("Downloading year {year}...")
    curl::curl_download(url, zip_file, handle = handle)
  }

  return(zip_file)
}

# Function to read one year of data from downloaded file
read_tariff_year <- function(year, cache_dir) {
  zip_file <- fs::path(cache_dir, glue::glue("tariff_data_{year}.zip"))
  extract_dir <- fs::path(cache_dir, glue::glue("extracted_{year}"))

  if (!dir.exists(extract_dir)) {
    cli::cli_inform("Extracting year {year}...")
    fs::dir_create(extract_dir, recurse = TRUE)
    utils::unzip(zip_file, exdir = extract_dir)
  }

  txt_file <- fs::dir_ls(extract_dir, glob = "*.txt")
  if (length(txt_file) != 1) {
    cli::cli_abort("Year {year} has something wrong with its files.")
  }
  cli::cli_inform("Fixing year {year}...")

  # Detect delimiter (some years use pipe, others use comma)
  first_line <- readLines(txt_file, n = 1)
  delim <- ifelse(stringr::str_detect(first_line, "\\|"), "|", ",")
  expected_cols <- stringr::str_count(first_line, stringr::fixed(delim)) + 1

  # Some files (e.g., 2011) have embedded newlines in text fields
  # Read all lines and fix malformed rows before parsing
  all_lines <- readLines(txt_file, encoding = "latin1")
  header <- all_lines[[1]]
  data_lines <- all_lines[-1]

  # Fix rows that don't have the expected number of delimiters
  # by joining them with the next row(s) until we have the right count
  fixed_lines <- character()
  i <- 1
  while (i <= length(data_lines)) {
    current_line <- data_lines[i]
    delim_count <- stringr::str_count(current_line, stringr::fixed(delim))

    # If line has too few delimiters, append next lines until we have enough
    while (delim_count < (expected_cols - 1) && (i + 1) <= length(data_lines)) {
      i <- i + 1
      current_line <- paste(current_line, data_lines[i])
      delim_count <- stringr::str_count(current_line, stringr::fixed(delim))
    }

    fixed_lines <- c(fixed_lines, current_line)
    i <- i + 1
  }

  # Save it as a locally-temporary tempfile because we want to re-process if we
  # change this function.
  fixed_file <- withr::local_tempfile(fileext = ".txt")
  writeLines(c(header, fixed_lines), fixed_file)

  cli::cli_inform("Reading year {year}...")
  data <- readr::read_delim(
    fixed_file,
    delim = delim,
    col_types = readr::cols(.default = "c"),
    show_col_types = FALSE
  )
  return(data)
}

# Setup cache directory. Hard-code the subdir path so we use the same dir if we rerun in the same session.
cache_dir <- fs::path(tempdir(), "tariff_cache")
on.exit(unlink(cache_dir), add = TRUE)
fs::dir_create(cache_dir, recurse = TRUE)

years <- 1997:2025

# We assign this to zip_files for debugging, but don't actually use that object in the code.
zip_files <- purrr::map(
  years,
  download_tariff_year,
  handle = handle,
  cache_dir = cache_dir
)

tariff_raw <- purrr::map_dfr(
  years,
  read_tariff_year,
  cache_dir = cache_dir
)

# Convert date columns after combining all years
# Handle both "MM/DD/YYYY HH:MM:SS" and "MM/DD/YYYY" formats

tariff_raw <- tariff_raw |>
  dplyr::rename(
    begin_effective_date = "begin_effect_date"
  ) |>
  dplyr::mutate(
    dplyr::across(
      tidyselect::ends_with("_effective_date"),
      \(date_col) {
        stringr::str_extract(date_col, "^\\S+") |>
          lubridate::mdy()
      }
    )
  ) |>
  dplyr::distinct()

# Clean and create tidy datasets

# Dataset 1: HTS Code lookup table ----

# Contains product descriptions and units for each HTS code
tariff_codes <- tariff_raw |>
  dplyr::select(
    "begin_effective_date",
    "hts8",
    description = "brief_description",
    "quantity_1_code",
    "quantity_2_code",
    "wto_binding_code"
  ) |>
  dplyr::arrange(.data$hts8, .data$begin_effective_date) |>
  dplyr::distinct(
    .data$hts8,
    .data$description,
    .data$quantity_1_code,
    .data$quantity_2_code,
    .data$wto_binding_code,
    .keep_all = TRUE
  ) |>
  dplyr::rename(earliest_effective_date = "begin_effective_date")

# Dataset 2: Quantity codes lookup table ----
# Extracted from USITC Tariff Database Code Key
td_codes_file <- withr::local_tempfile(fileext = ".pdf")
curl::curl_download(
  "https://www.usitc.gov/applications/dataweb/td-codes.pdf",
  td_codes_file,
  handle = handle
)

# Extract quantity codes table from PDF
pdf_text <- pdftools::pdf_text(td_codes_file)

# Quantity codes span pages 3-5
quantity_code_text <- paste(pdf_text[3:5], collapse = "\n")
lines <- strsplit(quantity_code_text, "\n")[[1]]

# Find table start (after header and column names)
start_idx <- which(stringr::str_detect(
  lines,
  "Description of quantity codes"
)) +
  2

# Extract and clean table lines
table_lines <- lines[start_idx:length(lines)] |>
  stringr::str_trim()
table_lines <- table_lines[nzchar(table_lines)]

# Most lines have format: CODE  description (with 2+ spaces)
# One entry (NA) has its description split across 3 lines
# Identify lines without the standard 2-space separator (these are extra pieces)
line_numbers_to_merge <- stringr::str_which(table_lines, "  ", negate = TRUE)
extra_pieces <- table_lines[line_numbers_to_merge]

# Extract codes and descriptions from normal lines
normal_pieces <- stringr::str_subset(table_lines, "  ")
codes <- stringr::str_extract(normal_pieces, "^\\S+")
descriptions <- stringr::str_extract(normal_pieces, "\\s{2}(\\S.+$)", 1)

# Merge the multi-line description for NA code
na_line_number <- line_numbers_to_merge[[1]]
descriptions[[na_line_number]] <- paste(
  extra_pieces[[1]],
  descriptions[[na_line_number]],
  extra_pieces[[2]]
)

quantity_codes <- tibble::tibble(
  code = codes,
  description = descriptions
)

# Dataset 3: Agreements lookup table ----

# Manually constructed from
# https://www.usitc.gov/applications/dataweb/td-fields.pdf
agreements <- tibble::tribble(
  ~agreement                                                           ,
  ~agreement_full                                                      ,
  ~agreement_notes                                                     ,
  "agoa"                                                               ,
  "African Growth and Opportunity Act (AGOA)"                          ,
  NA_character_                                                        ,
  "apta"                                                               ,
  "Automotive Products Trade Act (APTA)"                               ,
  "Duty-free"                                                          ,
  "atpa"                                                               ,
  "Andean Trade Preference Act (ATPA)"                                 ,
  "Program expired"                                                    ,
  "atpa*"                                                              ,
  "Andean Trade Preference Act (ATPA)"                                 ,
  "Certain products excluded; program expired"                         ,
  "atpdea"                                                             ,
  "Andean Trade Promotion and Drug Eradication Act (ATPDEA)"           ,
  "Program expired"                                                    ,
  "australia"                                                          ,
  "Australia-United States Free Trade Agreement"                       ,
  NA_character_                                                        ,
  "bahrain"                                                            ,
  "Bahrain-United States Free Trade Agreement"                         ,
  NA_character_                                                        ,
  "canada"                                                             ,
  "North American Free Trade Agreement (NAFTA)"                        ,
  "Canada"                                                             ,
  "cbi"                                                                ,
  "Caribbean Basin Initiative (CBI)"                                   ,
  NA_character_                                                        ,
  "cbi*"                                                               ,
  "Caribbean Basin Initiative (CBI)"                                   ,
  "Certain products or countries excluded"                             ,
  "cbtpa"                                                              ,
  "Caribbean Basin Trade Partnership Act (CBTPA)"                      ,
  NA_character_                                                        ,
  "chile"                                                              ,
  "Chile-United States Free Trade Agreement"                           ,
  NA_character_                                                        ,
  "civil_air"                                                          ,
  "Agreement on Trade in Civil Aircraft"                               ,
  "Duty-free"                                                          ,
  "col2"                                                               ,
  "Column 2 Rates"                                                     ,
  "Non-market economy countries"                                       ,
  "colombia"                                                           ,
  "Colombia-United States Trade Promotion Agreement"                   ,
  NA_character_                                                        ,
  "dr_cafta"                                                           ,
  "Dominican Republic-Central America Free Trade Agreement (DR-CAFTA)" ,
  NA_character_                                                        ,
  "dr_cafta_plus"                                                      ,
  "Dominican Republic-Central America Free Trade Agreement (DR-CAFTA)" ,
  "Plus rate"                                                          ,
  "dyes"                                                               ,
  "Uruguay Round Concessions on Intermediate Chemicals for Dyes"       ,
  "Duty-free"                                                          ,
  "gsp"                                                                ,
  "Generalized System of Preferences (GSP)"                            ,
  "Duty-free for eligible beneficiary countries"                       ,
  "israel_fta"                                                         ,
  "Israel-United States Free Trade Agreement"                          ,
  "Duty-free"                                                          ,
  "japan"                                                              ,
  "United States-Japan Trade Agreement"                                ,
  NA_character_                                                        ,
  "jordan"                                                             ,
  "Jordan-United States Free Trade Agreement"                          ,
  NA_character_                                                        ,
  "korea"                                                              ,
  "Korea-United States Free Trade Agreement (KORUS)"                   ,
  NA_character_                                                        ,
  "mexico"                                                             ,
  "North American Free Trade Agreement (NAFTA)"                        ,
  "Mexico"                                                             ,
  "mfn"                                                                ,
  "Most Favored Nation (MFN)"                                          ,
  "Standard rates for WTO members"                                     ,
  "morocco"                                                            ,
  "Morocco-United States Free Trade Agreement"                         ,
  NA_character_                                                        ,
  "nepal"                                                              ,
  "Nepal Trade Preference Program"                                     ,
  NA_character_                                                        ,
  "oman"                                                               ,
  "Oman-United States Free Trade Agreement"                            ,
  NA_character_                                                        ,
  "panama"                                                             ,
  "Panama-United States Trade Promotion Agreement"                     ,
  NA_character_                                                        ,
  "peru"                                                               ,
  "Peru-United States Trade Promotion Agreement"                       ,
  NA_character_                                                        ,
  "pharmaceutical"                                                     ,
  "Agreement on Trade in Pharmaceutical Products"                      ,
  "Duty-free"                                                          ,
  "singapore"                                                          ,
  "Singapore-United States Free Trade Agreement"                       ,
  NA_character_                                                        ,
  "usmca"                                                              ,
  "United States-Mexico-Canada Agreement (USMCA)"                      ,
  NA_character_                                                        ,
  "usmca+"                                                             ,
  "United States-Mexico-Canada Agreement (USMCA)"                      ,
  "Plus rate"
)

# Dataset 4: Tariff rates in long format ----

# Each row represents one agreement's rate for an HTS code during a time period
# This includes MFN (Most Favored Nation) and COL2 (Column 2) as agreement types

# Step 1: Pivot all rate data to long format
tariff_rates_long <- tariff_raw |>
  dplyr::select(
    "hts8",
    "begin_effective_date",
    "end_effective_date",
    tidyselect::ends_with("_rate_type_code"),
    tidyselect::ends_with("_ad_val_rate"),
    tidyselect::ends_with("_specific_rate"),
    tidyselect::ends_with("_indicator")
  ) |>
  tidyr::pivot_longer(
    cols = c(
      tidyselect::ends_with("_rate_type_code"),
      tidyselect::ends_with("_ad_val_rate"),
      tidyselect::ends_with("_specific_rate"),
      tidyselect::ends_with("_indicator")
    ),
    names_to = c("agreement", ".value"),
    names_pattern = "^(.+)_(rate_type_code|ad_val_rate|specific_rate|indicator)$"
  ) |>
  dplyr::filter(
    !is.na(.data$ad_val_rate) |
      !is.na(.data$specific_rate) |
      !is.na(.data$rate_type_code)
  ) |>
  dplyr::mutate(
    dplyr::across(
      c("ad_val_rate", "specific_rate"),
      as.numeric
    )
  ) |>
  # Merge "agreement" and "indicator"
  dplyr::mutate(
    agreement = dplyr::case_when(
      .data$agreement == "atpa" & .data$indicator == "J*" ~ "atpa*",
      .data$agreement == "cbi" & .data$indicator == "E*" ~ "cbi*",
      .data$agreement == "usmca" & .data$indicator == "S+" ~ "usmca+",
      TRUE ~ .data$agreement
    )
  ) |>
  dplyr::select(-"indicator") |>
  dplyr::mutate(
    chapter = as.integer(substr(.data$hts8, 1, 2))
  ) |>
  dplyr::distinct()

# Step 2: Split by HTS chapter groups to stay under size limits
tariff_agricultural <- tariff_rates_long |>
  dplyr::filter(.data$chapter < 25) |>
  dplyr::select(-"chapter")

```
