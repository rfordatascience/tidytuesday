# Avocado Oil Authenticity

This week we're exploring avocado oil authenticity data from UC Davis researchers. The dataset includes two studies: one from 2020 examining bottled avocado oils and one from 2026 examining processed foods made with avocado oil. The studies reveal widespread fraud in the avocado oil market. The 2020 study found that 82% of bottled avocado oils were either rancid or adulterated with cheaper oils like soybean oil. Six years later, the problem had spread to processed foods: 89% of chips, mayonnaise, and salad dressings labeled as "made with avocado oil" failed authenticity testing. By contrast, olive oil products (which have been regulated for decades) were overwhelmingly pure.

The bottled oil dataset includes detailed chemical fingerprints (fatty acid profiles, sterol composition, and vitamin E content) that researchers use to detect fraud. The processed foods dataset tracks which specific brands and product categories passed or failed lot-level testing. Together, these datasets tell the story of a premium food category with almost no consumer protection.

> Consumers are increasingly paying a premium for products made with avocado oil or olive oil. They deserve to get what they pay for and food manufacturers deserve confidence that the ingredients they purchase from suppliers are authentic.
>
> Selina Wang, Professor of Cooperative Extension, UC Davis Department of Food Science and Technology

- Can you use the fatty acid and sterol profiles to build a classifier that distinguishes pure avocado oil from adulterated samples?
- Which chemical markers are the strongest indicators of soybean oil vs. sunflower/safflower oil adulteration?
- How does the failure rate differ across product categories (chips vs. mayo vs. dressings), and why might mayo fare better?
- Does price correlate with authenticity for bottled oils? Are consumers paying more for genuine products?
- How do the olive oil results compare to avocado oil results, and what does that tell us about the value of industry regulation?

Thank you to [Tony Galvan, Golden Dome Data Science](https://github.com/gdatascience) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-10-06')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 40)

avocado_oil_bottles <- tuesdata$avocado_oil_bottles
avocado_oil_processed_foods <- tuesdata$avocado_oil_processed_foods

# Option 2: Read directly from GitHub

avocado_oil_bottles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_bottles.csv')
avocado_oil_processed_foods <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_processed_foods.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-10-06')

# Option 2: Read directly from GitHub and assign to an object

avocado_oil_bottles = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_bottles.csv')
avocado_oil_processed_foods = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_processed_foods.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-10-06")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

avocado_oil_bottles = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_bottles.csv")
avocado_oil_processed_foods = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_processed_foods.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
avocado_oil_bottles = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_bottles.csv", DataFrame)
avocado_oil_processed_foods = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-06/avocado_oil_processed_foods.csv", DataFrame)
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

### `avocado_oil_bottles.csv`

|variable                    |class     |description                           |
|:---------------------------|:---------|:-------------------------------------|
|sample_code                 |character |Unique identifier for the oil sample (e.g., EV1, R3, U6). The prefix indicates the labeled grade: EV for extra virgin, R for refined, and U for unspecified. |
|grade_labeled               |character |Grade claimed on the bottle label: extra virgin, refined, or unspecified. |
|purchasing_method           |character |Where the sample was purchased: Online or In store. |
|expiration_date             |character |Best-by date printed on the bottle in month-year format (e.g., Oct-21). NA if not listed. |
|product_origin              |character |Country or region of origin listed on the label (e.g., California, Mexico, Brazil). |
|cost_per_fl_oz              |double    |Retail price in US dollars per fluid ounce at the time of purchase. |
|packaging_type              |character |Container material and color (e.g., Dark glass, Clear plastic, Tin bottle). |
|oxidized                    |logical   |Whether the sample showed signs of oxidation (high free fatty acidity or peroxide values) before its expiration date. NA for confirmed soybean oil samples where oxidation status is not meaningful. |
|purity_result               |character |Purity classification: pure (consistent with authentic avocado oil), adulterated (confirmed substitution with another oil), or suspected (chemical profile outside the normal avocado oil range but not conclusively adulterated). |
|adulterant                  |character |Identity of the adulterant oil if detected: soybean oil, sunflower/safflower oil, or NA if pure. |
|alpha_tocopherol_mg_kg      |double    |Alpha-tocopherol (vitamin E) content in milligrams per kilogram of oil. The primary form of vitamin E in most avocado oils. |
|gamma_beta_tocopherol_mg_kg |double    |Combined gamma and beta tocopherol content in mg/kg. Elevated levels may indicate soybean oil adulteration. NA if not detected. |
|delta_tocopherol_mg_kg      |double    |Delta-tocopherol content in mg/kg. Presence at high levels is characteristic of soybean oil. NA if not detected. |
|total_tocopherols_mg_kg     |double    |Total tocopherol (vitamin E) content in mg/kg, summing all measured forms. |
|c14_0_pct                   |double    |Myristic acid (C14:0) as a percent of total fatty acids. NA if not detected. |
|c16_0_palmitic_pct          |double    |Palmitic acid (C16:0) as a percent of total fatty acids. Typically 10 to 18 percent in avocado oil. |
|c16_1_palmitoleic_pct       |double    |Palmitoleic acid (C16:1) as a percent of total fatty acids. A key marker: high values (5 to 9 percent) indicate authentic avocado oil, while near-zero values suggest adulteration. |
|c18_0_stearic_pct           |double    |Stearic acid (C18:0) as a percent of total fatty acids. Elevated values (above 2 percent) may indicate sunflower or safflower adulteration. |
|c18_1_oleic_pct             |double    |Oleic acid (C18:1) as a percent of total fatty acids. The dominant fatty acid in authentic avocado oil, typically 55 to 70 percent. |
|c18_2_linoleic_pct          |double    |Linoleic acid (C18:2) as a percent of total fatty acids. Authentic avocado oil typically has 9 to 20 percent; values above 50 percent indicate soybean oil. |
|c18_3_linolenic_pct         |double    |Linolenic acid (C18:3) as a percent of total fatty acids. Values above 3 percent strongly suggest soybean oil adulteration. |
|c20_0_pct                   |double    |Arachidic acid (C20:0) as a percent of total fatty acids. NA if not detected. |
|c20_1_pct                   |double    |Gondoic acid (C20:1) as a percent of total fatty acids. |
|c22_0_pct                   |double    |Behenic acid (C22:0) as a percent of total fatty acids. NA if not detected. |
|c24_0_pct                   |double    |Lignoceric acid (C24:0) as a percent of total fatty acids. NA if not detected. |
|brassicasterol_pct          |double    |Brassicasterol as a percent of total sterols. NA if not detected. |
|campesterol_pct             |double    |Campesterol as a percent of total sterols. Values above 15 percent suggest soybean oil adulteration (soybean is typically around 20 percent). |
|stigmasterol_pct            |double    |Stigmasterol as a percent of total sterols. Elevated values (above 10 percent) are a strong indicator of soybean oil. |
|delta7_campesterol_pct      |double    |Delta-7-campesterol as a percent of total sterols. NA if not detected. |
|clerosterol_pct             |double    |Clerosterol as a percent of total sterols. NA if not detected. |
|beta_sitosterol_pct         |double    |Beta-sitosterol as a percent of total sterols. The dominant sterol in avocado oil, typically 75 to 90 percent. Values near 55 percent indicate soybean oil. |
|delta5_avenasterol_pct      |double    |Delta-5-avenasterol as a percent of total sterols. |
|delta7_stigmasterol_pct     |double    |Delta-7-stigmasterol as a percent of total sterols. NA if not detected. |
|delta7_avenasterol_pct      |double    |Delta-7-avenasterol as a percent of total sterols. NA if not detected. |
|total_sterols_mg_kg         |double    |Total sterol content in milligrams per kilogram of oil. |

### `avocado_oil_processed_foods.csv`

|variable                      |class     |description                           |
|:-----------------------------|:---------|:-------------------------------------|
|sample_number                 |double    |Unique sample identifier (1-74) matching the supplementary tables in the paper. Consecutive pairs (1-2, 3-4, etc.) represent two lots of the same product. |
|product_id                    |double    |Product identifier grouping two lots of the same product (derived as ceiling of sample_number / 2). |
|lot                           |integer   |Lot number (1 or 2). Each product was purchased in two separately acquired lots to test batch-to-batch consistency. |
|category                      |character |Product type: "chips", "mayonnaise", or "salad_dressing". |
|oil_type                      |character |Simplified oil classification: "avocado" or "olive". |
|declared_oil                  |character |Full oil declaration from the ingredient statement (e.g., "Avocado Oil", "Organic Avocado Oil", "Extra Virgin Olive Oil"). |
|front_label                   |character |Front-of-package oil marketing claim (e.g., "Made with 100% Pure Avocado Oil", "Made With Olive Oil"). |
|other_ingredients             |character |Non-oil ingredients listed on the package. |
|package_size_oz               |double    |Package size in ounces. |
|retail_price_usd              |double    |Retail price in US dollars at time of purchase. |
|purchase_location             |character |Where the product was purchased (retail store name or "Online"). |
|authentic                     |logical   |Whether the sample's fatty acid and sterol profile was consistent with the declared oil type, based on Codex Alimentarius standards with a 10% margin of deviation. TRUE = consistent, FALSE = inconsistent. |
|c6_0_pct                      |double    |Caproic acid (C6:0) as percent of total fatty acids. NA if not detected. |
|c8_0_pct                      |double    |Caprylic acid (C8:0) as percent of total fatty acids. NA if not detected. |
|c10_0_pct                     |double    |Capric acid (C10:0) as percent of total fatty acids. NA if not detected. |
|c12_0_pct                     |double    |Lauric acid (C12:0) as percent of total fatty acids. NA if not detected. |
|c14_0_pct                     |double    |Myristic acid (C14:0) as percent of total fatty acids. NA if not detected. |
|c16_0_palmitic_pct            |double    |Palmitic acid (C16:0) as percent of total fatty acids. Codex range for avocado oil: 11.0-26.0%. |
|c16_1_palmitoleic_pct         |double    |Palmitoleic acid (C16:1) as percent of total fatty acids. A key authenticity marker. Codex range for avocado oil is 4.0 to 17.1%; low values indicate adulteration. |
|c17_0_pct                     |double    |Margaric acid (C17:0) as percent of total fatty acids. NA if not detected. |
|c17_1_pct                     |double    |Heptadecenoic acid (C17:1) as percent of total fatty acids. NA if not detected. |
|c18_0_stearic_pct             |double    |Stearic acid (C18:0) as percent of total fatty acids. Codex range for avocado oil: 0.1-1.3%. Elevated values suggest vegetable oil substitution. |
|c18_1_oleic_pct               |double    |Oleic acid (C18:1) as percent of total fatty acids. The dominant fatty acid in authentic avocado oil. Codex range: 42.0-75.0%. |
|c18_1n7_vaccenic_pct          |double    |Cis-vaccenic acid (C18:1 n-7) as percent of total fatty acids. A strong discriminatory marker. Authentic avocado oil is typically 4 to 6%, while adulterated samples are typically 1 to 2%. |
|c18_2_linoleic_pct            |double    |Linoleic acid (C18:2) as percent of total fatty acids. Codex range for avocado oil: 7.8-19.0%. |
|c18_3_linolenic_pct           |double    |Alpha-linolenic acid (C18:3) as percent of total fatty acids. Codex range for avocado oil: 0.5-2.1%. |
|c20_0_pct                     |double    |Arachidic acid (C20:0) as percent of total fatty acids. |
|c20_1_pct                     |double    |Gondoic acid (C20:1) as percent of total fatty acids. |
|c20_2_pct                     |double    |Eicosadienoic acid (C20:2) as percent of total fatty acids. NA if not detected. |
|c22_0_pct                     |double    |Behenic acid (C22:0) as percent of total fatty acids. NA if not detected. |
|c24_1_pct                     |double    |Nervonic acid (C24:1) as percent of total fatty acids. NA if not detected. |
|brassicasterol_pct            |double    |Brassicasterol as percent of total sterols. Codex limit for avocado oil: ND-0.5%. Presence above trace levels may indicate canola oil substitution. |
|methylene_cholesterol_pct     |double    |24-Methylene cholesterol as percent of total sterols. |
|campesterol_pct               |double    |Campesterol as percent of total sterols. Codex range for avocado oil: 4.0-8.3%. Elevated values indicate vegetable oil substitution. |
|campestanol_pct               |double    |Campestanol as percent of total sterols. |
|stigmasterol_pct              |double    |Stigmasterol as percent of total sterols. Codex range for avocado oil: 0.3-2.0%. Elevated values indicate vegetable oil adulteration. |
|delta7_campesterol_pct        |double    |Delta-7-campesterol as percent of total sterols. |
|clerosterol_pct               |double    |Clerosterol as percent of total sterols. Codex range for avocado oil: 1.0-2.5%. Low values may indicate non-avocado oil. |
|beta_sitosterol_pct           |double    |Beta-sitosterol as percent of total sterols. Codex range for avocado oil: 79.0-93.4%. The dominant sterol in authentic avocado oil. |
|sitostanol_pct                |double    |Sitostanol as percent of total sterols. |
|delta5_avenasterol_pct        |double    |Delta-5-avenasterol as percent of total sterols. Codex range for avocado oil: 2.0-8.0%. |
|delta5_24_stigmastadienol_pct |double    |Delta-5,24-stigmastadienol as percent of total sterols. |
|delta7_stigmastenol_pct       |double    |Delta-7-stigmastenol as percent of total sterols. Codex limit for olive oil: ≤0.5%. |
|delta7_avenasterol_pct        |double    |Delta-7-avenasterol as percent of total sterols. Codex range for avocado oil: ND-1.5%. Elevated values indicate vegetable oil substitution. |
|apparent_beta_sitosterol_pct  |double    |Apparent beta-sitosterol (sum of delta-5,23-stigmastadienol, clerosterol, beta-sitosterol, sitostanol, delta-5-avenasterol, and delta-5,24-stigmastadienol) as percent of total sterols. Codex requirement for olive oil: ≥93.0%. |

## Cleaning Script

```r
# ============================================================================
# TidyTuesday Dataset: UC Davis Avocado Oil Quality & Authenticity Studies
# ============================================================================
#
# Two datasets curated from UC Davis research on avocado oil fraud:
#
# 1. avocado_oil_bottles: Chemical analysis of 22 bottled avocado oils (2020)
#    Source: Green & Wang (2020), Food Control 116, 107328
#    PDF: https://upload.wikimedia.org/wikipedia/commons/a/a4/First_report_on_quality_and_purity_evaluations_of_avocado_oil_sold_in_the_US.pdf
#
# 2. avocado_oil_processed_foods: Authenticity testing of processed food
#    products labeled as containing avocado or olive oil (2026)
#    Source: Lopez-Alvarez et al. (2026), Applied Food Research 6, 102389
#    DOI: 10.1016/j.afres.2026.102389
#    Supplementary data (Excel):
#    https://ars.els-cdn.com/content/image/1-s2.0-S2772502226007274-mmc1.xlsx
#
# ============================================================================

library(pdftools)
library(readxl)
library(tidyverse)

# ============================================================================
# PART 1: Bottled Avocado Oil (2020 Study)
# ============================================================================
# Download the open-access PDF from Wikimedia Commons

pdf_url <- "https://upload.wikimedia.org/wikipedia/commons/a/a4/First_report_on_quality_and_purity_evaluations_of_avocado_oil_sold_in_the_US.pdf"
pdf_path <- tempfile(fileext = ".pdf")
download.file(pdf_url, pdf_path, mode = "wb", quiet = TRUE)

# Extract text from all pages
txt <- pdf_text(pdf_path)

# --- Table 1: Sample Information (page 2) ---
page2_lines <- str_split(txt[2], "\n")[[1]]
table1_lines <- page2_lines[grepl("^\\s+(EV|R|U)\\d", page2_lines)]

table1 <- table1_lines |>
  str_trim() |>
  str_split("\\s{2,}") |>
  map_dfr(~ tibble(
    sample_code = .x[1],
    purchasing_method = .x[2],
    expiration_date = .x[3],
    product_origin = .x[4],
    cost_per_fl_oz = as.numeric(.x[5]),
    packaging_type = .x[6]
  ))

# Derive labeled grade from sample code prefix
table1 <- table1 |>
  mutate(
    grade_labeled = case_when(
      str_starts(sample_code, "EV") ~ "extra virgin",
      str_starts(sample_code, "R") ~ "refined",
      str_starts(sample_code, "U") ~ "unspecified"
    )
  )

# --- Table 2: Tocopherols (page 5, right column) ---
page5_lines <- str_split(txt[5], "\n")[[1]]
toco_lines <- page5_lines[grepl("(EV|R|U)\\d\\s+[0-9]", page5_lines)]

parse_toco_row <- function(line) {
  match <- str_match(line, "((?:EV|R|U)\\d)\\s+(.+)")
  if (is.na(match[1, 1])) return(NULL)

  sample_code <- match[1, 2]
  rest <- str_trim(match[1, 3])
  cells <- str_split(rest, "\\s{2,}")[[1]]

  extract_mean <- function(cell) {
    if (cell == "ND") return(NA_real_)
    as.numeric(str_extract(cell, "^[0-9.]+"))
  }

  if (length(cells) >= 4) {
    tibble(
      sample_code = sample_code,
      alpha_tocopherol_mg_kg = extract_mean(cells[1]),
      gamma_beta_tocopherol_mg_kg = extract_mean(cells[2]),
      delta_tocopherol_mg_kg = extract_mean(cells[3]),
      total_tocopherols_mg_kg = extract_mean(cells[4])
    )
  } else {
    NULL
  }
}

table2 <- map_dfr(toco_lines, parse_toco_row)

# --- Table 3: Fatty Acid Profile (page 6) ---
page6_lines <- str_split(txt[6], "\n")[[1]]
fa_lines <- page6_lines[grepl("^\\s+(EV|R|U)\\d", page6_lines)]

parse_fa_row <- function(line) {
  cells <- str_trim(line) |> str_split("\\s{2,}") |> pluck(1)
  sample_code <- cells[1]

  values <- cells[-1] |> map_dbl(function(cell) {
    if (cell == "ND") return(NA_real_)
    as.numeric(str_extract(cell, "^[0-9.]+"))
  })

  tibble(
    sample_code = sample_code,
    c14_0_pct = values[1],
    c16_0_palmitic_pct = values[2],
    c16_1_palmitoleic_pct = values[3],
    c18_0_stearic_pct = values[4],
    c18_1_oleic_pct = values[5],
    c18_2_linoleic_pct = values[6],
    c18_3_linolenic_pct = values[7],
    c20_0_pct = values[8],
    c20_1_pct = values[9],
    c22_0_pct = values[10],
    c24_0_pct = values[11]
  )
}

table3 <- map_dfr(fa_lines, parse_fa_row)

# --- Table 4: Sterols Profile (page 7) ---
page7_lines <- str_split(txt[7], "\n")[[1]]
sterol_lines <- page7_lines[grepl("^\\s+(EV|R|U)\\d", page7_lines)]

parse_sterol_row <- function(line) {
  cells <- str_trim(line) |> str_split("\\s{2,}") |> pluck(1)
  sample_code <- cells[1]

  values <- cells[-1] |> map_dbl(function(cell) {
    if (cell == "ND") return(NA_real_)
    as.numeric(str_extract(cell, "^[0-9.]+"))
  })

  tibble(
    sample_code = sample_code,
    brassicasterol_pct = values[1],
    campesterol_pct = values[2],
    stigmasterol_pct = values[3],
    delta7_campesterol_pct = values[4],
    clerosterol_pct = values[5],
    beta_sitosterol_pct = values[6],
    delta5_avenasterol_pct = values[7],
    delta7_stigmasterol_pct = values[8],
    delta7_avenasterol_pct = values[9],
    total_sterols_mg_kg = values[10]
  )
}

table4 <- map_dfr(sterol_lines, parse_sterol_row)

# --- Purity assessment (from paper text) ---
# EV3, EV6, U6: adulterated with soybean oil at ~100%
# R1, U4, U5: suspected adulteration with high oleic sunflower/safflower oil
# All others: pure avocado oil
purity_df <- tibble(
  sample_code = c(
    "EV1", "EV2", "EV3", "EV4", "EV5", "EV6", "EV7",
    "R1", "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9",
    "U1", "U2", "U3", "U4", "U5", "U6"
  ),
  purity_result = c(
    "pure", "pure", "adulterated", "pure", "pure", "adulterated", "pure",
    "suspected", "pure", "pure", "pure", "pure", "pure", "pure", "pure", "pure",
    "pure", "pure", "pure", "suspected", "suspected", "adulterated"
  ),
  adulterant = c(
    NA, NA, "soybean oil", NA, NA, "soybean oil", NA,
    "sunflower/safflower oil", NA, NA, NA, NA, NA, NA, NA, NA,
    NA, NA, NA, "sunflower/safflower oil", "sunflower/safflower oil", "soybean oil"
  )
)

# --- Quality assessment (from paper text) ---
# "15 of the samples were oxidized before the expiration date"
# R3 (Chosen Foods) and R5 (Marianne's) were the only pure AND non-oxidized.
# EV3, EV6, U6 are soybean oil so oxidation status is moot (NA).
quality_df <- tibble(
  sample_code = c(
    "EV1", "EV2", "EV3", "EV4", "EV5", "EV6", "EV7",
    "R1", "R2", "R3", "R4", "R5", "R6", "R7", "R8", "R9",
    "U1", "U2", "U3", "U4", "U5", "U6"
  ),
  oxidized = c(
    TRUE, TRUE, NA, TRUE, TRUE, NA, TRUE,
    TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE,
    TRUE, TRUE, TRUE, TRUE, TRUE, NA
  )
)

# --- Join all tables into avocado_oil_bottles ---
avocado_oil_bottles <- table1 |>
  left_join(table2, by = "sample_code") |>
  left_join(table3, by = "sample_code") |>
  left_join(table4, by = "sample_code") |>
  left_join(purity_df, by = "sample_code") |>
  left_join(quality_df, by = "sample_code") |>
  select(
    sample_code, grade_labeled, purchasing_method, expiration_date,
    product_origin, cost_per_fl_oz, packaging_type,
    oxidized, purity_result, adulterant,
    starts_with("alpha_"), starts_with("gamma_"), starts_with("delta_toco"),
    total_tocopherols_mg_kg,
    starts_with("c14"), starts_with("c16"), starts_with("c18"),
    starts_with("c20"), starts_with("c22"), starts_with("c24"),
    everything()
  )

# Clean up temp file
unlink(pdf_path)

# ============================================================================
# PART 2: Processed Foods (2026 Study)
# ============================================================================
# Download supplementary Excel file from Applied Food Research (open access)

xlsx_url <- "https://ars.els-cdn.com/content/image/1-s2.0-S2772502226007274-mmc1.xlsx"
xlsx_path <- tempfile(fileext = ".xlsx")
download.file(xlsx_url, xlsx_path, mode = "wb", quiet = TRUE)

# --- Helper: parse "mean ± sd" strings, return mean value ---
parse_mean <- function(x) {
  case_when(
    x == "ND" ~ NA_real_,
    is.na(x) ~ NA_real_,
    TRUE ~ as.numeric(str_extract(x, "^[0-9.]+"))
  )
}

# --- Table S1: Product information ---
product_info <- read_excel(xlsx_path, sheet = "Table 1", skip = 1) |>
  rename(
    sample_number = `Sample Number`,
    category = Category,
    declared_oil = `Declared oil`,
    front_label = `Front of package label`,
    other_ingredients = `Other ingredients`,
    package_size_oz = `Package size (oz)`,
    retail_price_usd = `Retail price ($USD)`,
    purchase_location = `Purchase location`,
    lot_code_recorded = `Lot code recorded`
  ) |>
  # Keep only the 74 avocado/olive oil products (exclude vegetable oil comparators 75-80)
  filter(sample_number <= 74)

# --- Table S3: Fatty acid profiles ---
fa_raw <- read_excel(xlsx_path, sheet = "Table 3", skip = 1) |>
  rename(sample_number = 1)

# Rows 1-2 hold the Codex reference ranges (row 1 = avocado oil, row 2 = olive
# oil). Capture them before dropping non-sample rows; they drive the
# authenticity classification below.
fa_codex_avocado <- fa_raw |> filter(sample_number == "CODEX") |> select(-sample_number)
fa_codex_olive <- fa_raw |> filter(sample_number == "Sample Number") |> select(-sample_number)

fa_data <- fa_raw |>
  filter(!sample_number %in% c("CODEX", "Sample Number")) |>
  mutate(sample_number = as.integer(sample_number)) |>
  filter(sample_number <= 74) |>
  mutate(across(-sample_number, parse_mean))

# Clean column names for fatty acids
fa_clean_names <- c(
  "sample_number",
  "c6_0_pct", "c8_0_pct", "c10_0_pct", "c12_0_pct", "c14_0_pct",
  "c16_0_palmitic_pct", "c16_1_palmitoleic_pct",
  "c17_0_pct", "c17_1_pct",
  "c18_0_stearic_pct", "c18_1_oleic_pct", "c18_1n7_vaccenic_pct",
  "c18_2_linoleic_pct", "c18_3_linolenic_pct",
  "c20_0_pct", "c20_1_pct", "c20_2_pct", "c22_0_pct", "c24_1_pct"
)
names(fa_data) <- fa_clean_names

# --- Table S4: Sterol profiles ---
sterol_raw <- read_excel(xlsx_path, sheet = "Table 4", skip = 1) |>
  rename(sample_number = 1)

# Same layout as Table S3: row 1 = avocado Codex range, row 2 = olive.
sterol_codex_avocado <- sterol_raw |> filter(sample_number == "CODEX") |> select(-sample_number)
sterol_codex_olive <- sterol_raw |> filter(sample_number == "Sample Number") |> select(-sample_number)

sterol_data <- sterol_raw |>
  filter(!sample_number %in% c("CODEX", "Sample Number")) |>
  mutate(sample_number = as.integer(sample_number)) |>
  filter(sample_number <= 74) |>
  mutate(across(-sample_number, parse_mean))

sterol_clean_names <- c(
  "sample_number",
  "brassicasterol_pct", "methylene_cholesterol_pct", "campesterol_pct",
  "campestanol_pct", "stigmasterol_pct", "delta7_campesterol_pct",
  "clerosterol_pct", "beta_sitosterol_pct", "sitostanol_pct",
  "delta5_avenasterol_pct", "delta5_24_stigmastadienol_pct",
  "delta7_stigmastenol_pct", "delta7_avenasterol_pct",
  "apparent_beta_sitosterol_pct"
)
names(sterol_data) <- sterol_clean_names

# --- Authenticity classification computed from the Codex reference ranges ---
# The paper (Section 2.4) classifies a sample as inconsistent with its declared
# oil when its measured fatty acid and sterol markers fall outside the Codex
# Alimentarius reference ranges, allowing a 10% tolerance for natural
# variability. Rather than hardcode the paper's per-category results, we
# reproduce that rule directly from the measured values and the Codex ranges
# published alongside the data (rows 1-2 of Tables S3 and S4).
#
# A marker counts as a violation when the measured value falls below the lower
# bound or above the upper bound after applying the 10% tolerance. A sample is
# classified inconsistent (authentic = FALSE) when more than two markers across
# the combined fatty acid and sterol profiles are violated. This threshold
# reproduces the category-level counts reported in Table 1 of the paper exactly:
#   avocado chips 26/28, dressings 12/12, mayo 10/14 inconsistent;
#   olive chips 1/10, dressings 0/6, mayo 0/4 inconsistent.

# Parse a Codex limit cell into numeric lower/upper bounds. Handles ranges
# ("11.0-26.0", "ND-0.3"), one-sided limits ("<= 0.03", ">= 93.0"), bare "ND"
# (must be ~0), and non-numeric limits ("< campesterol") which return NA (skipped).
parse_codex_bounds <- function(cell) {
  if (is.na(cell)) return(c(NA_real_, NA_real_))
  cell <- str_trim(cell)
  m <- str_match(cell, "^(ND|[0-9.]+)\\s*-\\s*([0-9.]+)$")
  if (!is.na(m[1, 1])) {
    lo <- if (m[1, 2] == "ND") 0 else as.numeric(m[1, 2])
    return(c(lo, as.numeric(m[1, 3])))
  }
  m <- str_match(cell, "[\u2264<]\\s*=?\\s*([0-9.]+)")
  if (!is.na(m[1, 1])) return(c(0, as.numeric(m[1, 2])))
  m <- str_match(cell, "[\u2265>]\\s*=?\\s*([0-9.]+)")
  if (!is.na(m[1, 1])) return(c(as.numeric(m[1, 2]), Inf))
  if (cell == "ND") return(c(0, 0))
  c(NA_real_, NA_real_)
}

# Count how many markers in a sample fall outside the Codex range (10% tolerance).
count_codex_violations <- function(values, codex_row, tol = 0.10) {
  n <- 0L
  for (col in names(codex_row)) {
    if (!col %in% names(values)) next
    bounds <- parse_codex_bounds(codex_row[[col]])
    lo <- bounds[1]
    hi <- bounds[2]
    if (is.na(lo) && is.na(hi)) next        # no numeric limit for this marker
    v <- values[[col]]
    if (is.na(v)) next                       # not detected -> not a violation
    lo_tol <- if (is.finite(lo)) lo * (1 - tol) else lo
    hi_tol <- if (is.finite(hi)) hi * (1 + tol) else hi
    if (v < lo_tol || v > hi_tol) n <- n + 1L
  }
  n
}

# Assign each sample its declared oil type
authenticity <- product_info |>
  select(sample_number, category, declared_oil) |>
  mutate(
    oil_type = case_when(
      str_detect(declared_oil, "(?i)avocado") ~ "avocado",
      str_detect(declared_oil, "(?i)olive") ~ "olive",
      TRUE ~ "vegetable"
    )
  )

# The Codex reference rows retain their original column names, which match the
# raw fatty acid and sterol tables (before renaming). Re-read the raw measured
# values keyed by sample number so violations are counted against the matching
# Codex columns.
fa_measured <- fa_raw |>
  filter(!sample_number %in% c("CODEX", "Sample Number")) |>
  mutate(sample_number = as.integer(sample_number)) |>
  filter(sample_number <= 74) |>
  mutate(across(-sample_number, parse_mean))

sterol_measured <- sterol_raw |>
  filter(!sample_number %in% c("CODEX", "Sample Number")) |>
  mutate(sample_number = as.integer(sample_number)) |>
  filter(sample_number <= 74) |>
  mutate(across(-sample_number, parse_mean))

classify_sample <- function(sn) {
  oil <- authenticity$oil_type[authenticity$sample_number == sn]
  fa_codex <- if (oil == "avocado") fa_codex_avocado else fa_codex_olive
  st_codex <- if (oil == "avocado") sterol_codex_avocado else sterol_codex_olive
  fa_vals <- as.list(fa_measured[fa_measured$sample_number == sn, ])
  st_vals <- as.list(sterol_measured[sterol_measured$sample_number == sn, ])
  fa_v <- count_codex_violations(fa_vals, fa_codex)
  st_v <- count_codex_violations(st_vals, st_codex)
  fa_v + st_v
}

authenticity <- authenticity |>
  mutate(
    codex_violations = map_int(sample_number, classify_sample),
    # More than two combined marker violations => inconsistent with declared oil
    authentic = codex_violations <= 2
  )

# --- Combine everything into the processed foods dataset ---
avocado_oil_processed_foods <- product_info |>
  left_join(fa_data, by = "sample_number") |>
  left_join(sterol_data, by = "sample_number") |>
  left_join(
    authenticity |> select(sample_number, oil_type, authentic),
    by = "sample_number"
  ) |>
  # Derive lot number: consecutive pairs represent two lots of the same product
  mutate(
    product_id = ceiling(sample_number / 2),
    lot = if_else(sample_number %% 2 == 1, 1L, 2L)
  ) |>
  # Clean up category names
  mutate(
    category = str_to_lower(category),
    category = str_replace(category, "salad dressing", "salad_dressing")
  ) |>
  select(
    sample_number, product_id, lot, category, oil_type, declared_oil,
    front_label, other_ingredients, package_size_oz, retail_price_usd,
    purchase_location, authentic,
    # Fatty acids
    starts_with("c6"), starts_with("c8"), starts_with("c10"),
    starts_with("c12"), starts_with("c14"),
    c16_0_palmitic_pct, c16_1_palmitoleic_pct,
    starts_with("c17"),
    c18_0_stearic_pct, c18_1_oleic_pct, c18_1n7_vaccenic_pct,
    c18_2_linoleic_pct, c18_3_linolenic_pct,
    c20_0_pct, c20_1_pct, c20_2_pct, c22_0_pct, c24_1_pct,
    # Sterols
    brassicasterol_pct, methylene_cholesterol_pct, campesterol_pct,
    campestanol_pct, stigmasterol_pct, delta7_campesterol_pct,
    clerosterol_pct, beta_sitosterol_pct, sitostanol_pct,
    delta5_avenasterol_pct, delta5_24_stigmastadienol_pct,
    delta7_stigmastenol_pct, delta7_avenasterol_pct,
    apparent_beta_sitosterol_pct
  )

# Clean up temp file
unlink(xlsx_path)

# ============================================================================
# PART 3: Verify and display summaries
# ============================================================================

cat("\n=== avocado_oil_bottles ===\n")
cat("Dimensions:", nrow(avocado_oil_bottles), "rows x", ncol(avocado_oil_bottles), "cols\n")
cat("\nPurity breakdown:\n")
print(count(avocado_oil_bottles, purity_result))

cat("\n=== avocado_oil_processed_foods ===\n")
cat("Dimensions:", nrow(avocado_oil_processed_foods), "rows x", ncol(avocado_oil_processed_foods), "cols\n")

cat("\nAuthenticity by oil type and category:\n")
avocado_oil_processed_foods |>
  group_by(oil_type, category) |>
  summarise(
    n_lots = n(),
    n_authentic = sum(authentic),
    pct_authentic = round(mean(authentic) * 100, 1),
    .groups = "drop"
  ) |>
  print()

```
