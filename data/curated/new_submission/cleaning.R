# =============================================================================
# TidyTuesday dataset: College majors, AI disruption risk, and starting salaries
# =============================================================================
#
# This script is fully self-contained. It downloads three public data sources,
# joins them at the level of the college major (4-digit CIP code), and produces
# two tidy data frames:
#
#   1. ai_salary_majors   - one row per major: starting salary + AI exposure
#   2. major_occupations  - the major -> occupation crosswalk with per-occupation
#                           AI exposure scores (the detail behind each major's
#                           exposure)
#
# SOURCES
# -------
# A. AI Occupational Exposure (AIOE), Felten, Raj & Seamans (2021), Strategic
#    Management Journal 42(12):2195-2217. Occupation-level (SOC) exposure to AI,
#    plus generative-AI variants for language modeling and image generation.
#    https://github.com/AIOE-Data/AIOE
#
# B. U.S. Department of Education, College Scorecard, Field of Study data files
#    (updated 2026-06-10). Median earnings one year after graduation, by
#    institution x 4-digit CIP code x credential level.
#    https://collegescorecard.ed.gov/data/
#
# C. NCES / BLS CIP (2020) -> SOC (2018) Crosswalk. Maps fields of study to the
#    occupations their graduates enter.
#    https://nces.ed.gov/ipeds/cipcode/resources.aspx
#
# D. NCES Classification of Instructional Programs (CIP) 2020 code file. Supplies
#    the official title for each 2-digit CIP family, used for the broad_field
#    grouping.
#    https://nces.ed.gov/ipeds/cipcode/resources.aspx
# =============================================================================

library(readr)
library(readxl)
library(dplyr)
library(stringr)
library(tidyr)

# -----------------------------------------------------------------------------
# 0. Download raw files to a temporary directory
# -----------------------------------------------------------------------------
tmp <- tempdir()

aioe_url <- "https://github.com/AIOE-Data/AIOE/raw/main/AIOE_DataAppendix.xlsx"
lm_url   <- "https://github.com/AIOE-Data/AIOE/raw/main/Language%20Modeling%20AIOE%20and%20AIIE.xlsx"
ig_url   <- "https://github.com/AIOE-Data/AIOE/raw/main/Image%20Generation%20AIOE%20and%20AIIE.xlsx"
xw_url   <- "https://nces.ed.gov/ipeds/cipcode/Files/CIP2020_SOC2018_Crosswalk.xlsx"
cip_url  <- "https://nces.ed.gov/ipeds/cipcode/Files/CIPCode2020.csv"
sc_url   <- paste0("https://ed-public-download.scorecard.network/downloads/",
                   "Most-Recent-Cohorts-Field-of-Study_06102026.zip")

aioe_file <- file.path(tmp, "AIOE_DataAppendix.xlsx")
lm_file   <- file.path(tmp, "LanguageModeling_AIOE.xlsx")
ig_file   <- file.path(tmp, "ImageGeneration_AIOE.xlsx")
xw_file   <- file.path(tmp, "CIP2020_SOC2018_Crosswalk.xlsx")
cip_file  <- file.path(tmp, "CIPCode2020.csv")
sc_zip    <- file.path(tmp, "fos.zip")

download.file(aioe_url, aioe_file, mode = "wb", quiet = TRUE)
download.file(lm_url,   lm_file,   mode = "wb", quiet = TRUE)
download.file(ig_url,   ig_file,   mode = "wb", quiet = TRUE)
download.file(xw_url,   xw_file,   mode = "wb", quiet = TRUE)
download.file(cip_url,  cip_file,  mode = "wb", quiet = TRUE)
download.file(sc_url,   sc_zip,    mode = "wb", quiet = TRUE)

sc_csv <- unzip(sc_zip, exdir = file.path(tmp, "fos"))
sc_csv <- sc_csv[grepl("Field-of-Study\\.csv$", sc_csv)][1]

# -----------------------------------------------------------------------------
# 1. AI exposure by occupation (SOC)
#    AIOE scores are standardized (mean 0, SD 1). Higher = more exposed to AI.
# -----------------------------------------------------------------------------
aioe <- read_excel(aioe_file, sheet = "Appendix A") |>
  rename(soc = `SOC Code`, occupation = `Occupation Title`, aioe = AIOE) |>
  select(soc, occupation, aioe)

lm <- read_excel(lm_file, sheet = "LM AIOE") |>
  rename(soc = `SOC Code`, aioe_language = `Language Modeling AIOE`) |>
  select(soc, aioe_language)

ig <- read_excel(ig_file, sheet = "IG AIOE") |>
  rename(soc = `SOC Code`, aioe_image = `Image Generation AIOE`) |>
  select(soc, aioe_image)

exposure <- aioe |>
  left_join(lm, by = "soc") |>
  left_join(ig, by = "soc")

# -----------------------------------------------------------------------------
# 2. CIP (2020) -> SOC (2018) crosswalk
#    A major maps to one or more occupations. Drop the "NO MATCH" sentinel.
#    Normalize the dotted 6-digit CIP (e.g. "11.0701") to the 4-digit key
#    ("1107") used by the College Scorecard field-of-study file.
# -----------------------------------------------------------------------------
crosswalk <- read_excel(xw_file, sheet = "CIP-SOC") |>
  rename(cip6 = CIP2020Code, cip_title = CIP2020Title,
         soc  = SOC2018Code, soc_title = SOC2018Title) |>
  filter(soc != "99-9999") |>
  mutate(cip4 = str_sub(str_remove(cip6, fixed(".")), 1, 4)) |>
  distinct(cip4, soc, .keep_all = TRUE)

# -----------------------------------------------------------------------------
# 2b. CIP family (2-digit) labels, from the official NCES CIP 2020 code file
#     The CSV wraps every value as an Excel text guard (e.g. ="01"), so strip
#     that first. The family-header row is the one whose CIPCode equals its
#     CIPFamily. broad_field is the official NCES title (title-cased, trailing
#     period removed). broad_field_short is a chart-friendly label I maintain by
#     hand, keyed to the family code; it is a convenience, not an NCES label.
# -----------------------------------------------------------------------------
unguard <- function(x) str_replace_all(x, '^="?|"$', "")

cip_families <- read_csv(cip_file, col_types = cols(.default = col_character())) |>
  transmute(fam = unguard(CIPFamily), code = unguard(CIPCode), title = CIPTitle) |>
  filter(code == fam) |>
  distinct(fam, title) |>
  mutate(broad_field = title |>
           str_remove("\\.$") |>
           str_to_title() |>
           str_replace_all("\\bAnd\\b", "and") |>
           str_replace_all("\\bOf\\b", "of")) |>
  select(fam, broad_field)

broad_field_short <- tribble(
  ~fam, ~broad_field_short,
  "01", "Agriculture",              "03", "Natural Resources",
  "04", "Architecture",             "05", "Area & Ethnic Studies",
  "09", "Communication",            "10", "Communications Tech",
  "11", "Computer Science",         "12", "Culinary & Personal Svc",
  "13", "Education",                "14", "Engineering",
  "15", "Engineering Tech",         "16", "Foreign Languages",
  "19", "Family & Consumer Sci",    "22", "Legal",
  "23", "English",                  "24", "Liberal Arts",
  "25", "Library Science",          "26", "Biological Sciences",
  "27", "Mathematics & Statistics", "28", "Military Science",
  "29", "Military Tech",            "30", "Interdisciplinary",
  "31", "Parks & Recreation",       "38", "Philosophy & Religion",
  "39", "Theology & Religion",      "40", "Physical Sciences",
  "41", "Science Tech",             "42", "Psychology",
  "43", "Homeland Security",        "44", "Public Administration",
  "45", "Social Sciences",          "46", "Construction Trades",
  "47", "Mechanic & Repair Tech",   "48", "Precision Production",
  "49", "Transportation",           "50", "Visual & Performing Arts",
  "51", "Health Professions",       "52", "Business",
  "54", "History"
)

cip_families <- cip_families |> left_join(broad_field_short, by = "fam")

# -----------------------------------------------------------------------------
# 3. Starting salary by major (College Scorecard, bachelor's degrees)
#    CREDLEV == 3 is Bachelor's Degree. EARN_MDN_1YR is median earnings one year
#    after completion. Aggregate institution-level values to a national median
#    per 4-digit CIP. "PrivacySuppressed" cells are treated as missing.
# -----------------------------------------------------------------------------
scorecard <- read_csv(
  sc_csv,
  col_types = cols(.default = col_character()),
  na = c("", "NA", "NULL", "PrivacySuppressed")
) |>
  filter(CREDLEV == "3") |>
  transmute(
    cip4        = str_pad(CIPCODE, 4, "left", "0"),
    cip_desc    = str_squish(str_remove(CIPDESC, "\\.$")),
    earn_1yr    = suppressWarnings(as.numeric(EARN_MDN_1YR)),
    earn_4yr    = suppressWarnings(as.numeric(EARN_MDN_4YR)),
    grad_count  = suppressWarnings(as.numeric(EARN_COUNT_WNE_1YR))
  )

salary <- scorecard |>
  filter(!is.na(earn_1yr)) |>
  group_by(cip4) |>
  summarise(
    field_of_study         = first(cip_desc),
    median_starting_salary = round(median(earn_1yr, na.rm = TRUE)),
    median_salary_4yr      = round(median(earn_4yr, na.rm = TRUE)),
    n_institutions         = n(),
    n_graduates            = sum(grad_count, na.rm = TRUE),
    .groups = "drop"
  )

# -----------------------------------------------------------------------------
# 4. Major-level AI exposure
#    Average the occupation-level AIOE scores across every occupation a major
#    maps to. Attach the standardized scores to the salary table.
# -----------------------------------------------------------------------------
major_exposure <- crosswalk |>
  inner_join(exposure, by = "soc") |>
  group_by(cip4) |>
  summarise(
    n_occupations    = n_distinct(soc),
    ai_exposure       = mean(aioe, na.rm = TRUE),
    ai_exposure_language = mean(aioe_language, na.rm = TRUE),
    ai_exposure_image    = mean(aioe_image, na.rm = TRUE),
    .groups = "drop"
  )

# -----------------------------------------------------------------------------
# 5. Final major-level dataset
#    Keep majors that have BOTH a starting salary and an AI-exposure score.
#    Add a 0-100 percentile rank for AI exposure so a non-specialist can read
#    "how exposed is this major relative to all others" without needing to know
#    that the raw score is a z-score.
# -----------------------------------------------------------------------------
ai_salary_majors <- salary |>
  inner_join(major_exposure, by = "cip4") |>
  mutate(fam = str_sub(cip4, 1, 2)) |>
  left_join(cip_families, by = "fam") |>
  mutate(
    ai_exposure_percentile = round(100 * (rank(ai_exposure) - 1) / (n() - 1), 1)
  ) |>
  select(
    cip4, field_of_study, broad_field, broad_field_short,
    median_starting_salary, median_salary_4yr,
    ai_exposure, ai_exposure_percentile,
    ai_exposure_language, ai_exposure_image,
    n_occupations, n_institutions, n_graduates
  ) |>
  arrange(ai_exposure)

# Fail loudly if any major did not match an NCES CIP family label, rather than
# silently emitting NA or an "Other" bucket. This guards future data refreshes.
if (anyNA(ai_salary_majors$broad_field) ||
    anyNA(ai_salary_majors$broad_field_short)) {
  missing <- ai_salary_majors |>
    filter(is.na(broad_field) | is.na(broad_field_short)) |>
    distinct(fam = str_sub(cip4, 1, 2))
  stop("Unmapped CIP family codes (add them to the lookups): ",
       paste(missing$fam, collapse = ", "))
}

# -----------------------------------------------------------------------------
# 6. Supporting dataset: which occupations drive each major's exposure
# -----------------------------------------------------------------------------
major_occupations <- crosswalk |>
  inner_join(exposure, by = "soc") |>
  semi_join(ai_salary_majors, by = "cip4") |>
  transmute(
    cip4,
    field_of_study      = str_squish(str_remove(cip_title, "\\.$")),
    soc,
    occupation,
    ai_exposure          = round(aioe, 3),
    ai_exposure_language = round(aioe_language, 3),
    ai_exposure_image    = round(aioe_image, 3)
  ) |>
  arrange(cip4, desc(ai_exposure))

# round the standardized scores in the main table for readability
ai_salary_majors <- ai_salary_majors |>
  mutate(across(c(ai_exposure, ai_exposure_language, ai_exposure_image),
                \(x) round(x, 3)))
