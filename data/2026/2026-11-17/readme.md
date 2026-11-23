# Cholesterol and Mortality in US Adults

This week we're looking at cholesterol and death in US adults, built from the National Health and Nutrition Examination Survey (NHANES) linked to the NCHS public-use mortality records.

A 2019 study of 12.8 million Korean adults found a U-shaped link between total cholesterol and death: people at the low and high ends died at higher rates than people in the middle. It's a striking result, but the authors said plainly that they only had total cholesterol. They could not see LDL, HDL, or triglycerides, so they could not say which part of the cholesterol picture was doing the work.

That gap is the reason for this dataset. NHANES measures the full lipid panel and the US government links those participants to the National Death Index, so we can ask the question the Korean study could not. I pooled ten NHANES cycles from 1999 to 2018, kept the adults who gave a blood sample and were eligible for mortality follow-up, and joined each person to their mortality outcome. The result is 52,678 adults, 7,643 of whom had died by the end of 2019.

Researchers have already used this same NHANES data to dig into the fractions. A 2025 study of the 1999 to 2018 cycles found a U-shaped link between HDL and death, where both low and high HDL carried higher risk. That is the kind of question you can ask here that the total-cholesterol-only studies could not.

Each row is one person. You get total cholesterol, HDL, LDL, and triglycerides, plus the two ratios doctors actually read off a lab report (total-to-HDL and LDL-to-HDL). You also get age, sex, race, the survey design columns, and the mortality outcome: whether the person died, how many months of follow-up they had, and the cause of death.

Two things to keep in mind. LDL and triglycerides come from the fasting morning exam, so they are missing for about half the sample. And NHANES is a complex survey with weights, so population estimates need the `survey_weight`, `psu`, and `strata` columns fed into a package like `survey` or `srvyr`.

> The NHANES combines interviews and physical examinations to assess the health and nutritional status of adults and children in the United States. The survey is unique in that it combines interviews and physical examinations, and it has been a major program of the National Center for Health Statistics since the early 1960s.

- Does the total-cholesterol U-curve from the Korean study show up in US adults, and does it survive adjusting for age?
- Which single lipid measure best separates who dies from who survives: total cholesterol, LDL, HDL, or one of the ratios?
- Is low LDL linked to higher death because of reverse causality, where sick people already have low cholesterol?
- Does the cause of death differ along the cholesterol range? For example, is low cholesterol tied more to cancer deaths and high cholesterol tied more to heart disease?
- How much do the answers change once you apply the NHANES survey weights?

Thank you to [Tony Galvan, Golden Dome Data Science](https://github.com/gdatascience) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-11-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 46)

cholesterol_mortality <- tuesdata$cholesterol_mortality

# Option 2: Read directly from GitHub

cholesterol_mortality <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-17/cholesterol_mortality.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-11-17')

# Option 2: Read directly from GitHub and assign to an object

cholesterol_mortality = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-17/cholesterol_mortality.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-11-17")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

cholesterol_mortality = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-17/cholesterol_mortality.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
cholesterol_mortality = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-11-17/cholesterol_mortality.csv", DataFrame)
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

### `cholesterol_mortality.csv`

|variable        |class         |description                           |
|:---------------|:-------------|:-------------------------------------|
|seqn            |integer       |NHANES respondent sequence number, the unique participant ID that links the survey and mortality records. |
|cycle           |character     |The two-year NHANES survey cycle the participant was enrolled in, from 1999-2000 through 2017-2018. |
|age             |double        |Age in years at the time of the exam. Ages 80 and older are top-coded at 80 in 1999-2006 and at 85 from 2007 on, per NHANES disclosure rules. |
|sex             |factor        |Sex recorded at the exam: Male or Female. |
|race            |factor        |Race and Hispanic origin: Mexican American, Other Hispanic, Non-Hispanic White, Non-Hispanic Black, or Other/Multi. |
|total_chol      |double        |Total cholesterol in mg/dL. Measured for all participants who gave a blood sample. |
|hdl             |double        |HDL (high-density lipoprotein, the "good" cholesterol) in mg/dL. |
|ldl             |double        |LDL (low-density lipoprotein, the "bad" cholesterol) in mg/dL, calculated by the Friedewald equation. Only measured on the fasting morning subsample, so it is missing for about half of participants. |
|triglycerides   |double        |Triglycerides in mg/dL. Like LDL, only measured on the fasting morning subsample. |
|non_hdl         |double        |Non-HDL cholesterol in mg/dL, total cholesterol minus HDL. |
|tc_hdl_ratio    |double        |Ratio of total cholesterol to HDL. A common clinical risk measure where lower is generally considered better. |
|ldl_hdl_ratio   |double        |Ratio of LDL to HDL. Available only when LDL is present (the fasting subsample). |
|died            |integer       |All-cause mortality status at the end of follow-up: 1 if the participant had died, 0 if assumed alive. |
|followup_months |integer       |Months from the exam date to death or to the censoring date of December 31, 2019, whichever came first. |
|cause_of_death  |factor        |Underlying cause of death for those who died, using the ten NCHS leading-cause categories: Heart disease, Cancer, Chronic respiratory disease, Accidents, Cerebrovascular (stroke), Alzheimer's disease, Diabetes, Influenza and pneumonia, Kidney disease, and All other causes. Missing for participants who were still alive. |
|survey_weight   |double        |NHANES two-year MEC exam sampling weight. Divide by the number of pooled cycles when combining cycles. Use with psu and strata for survey-weighted estimates. |
|psu             |double        |Masked variance pseudo-PSU (primary sampling unit) for the complex survey design. |
|strata          |double        |Masked variance pseudo-stratum for the complex survey design. |

## Cleaning Script

```r
# =============================================================================
# Cholesterol fractions and mortality in US adults (NHANES 1999-2018)
#
# This script is fully self-contained: it runs from a fresh R session and
# downloads everything it needs from public CDC / NCHS sources.
#
# It builds one data frame:
#   cholesterol_mortality : one row per mortality-eligible adult, with the four
#                           lipid measures, derived ratios, demographics, survey
#                           design columns, and the linked mortality outcome.
# A small internal `cod_lookup` table maps the NCHS cause-of-death codes to the
# readable labels used in the `cause_of_death` column; it is not a shipped file.
#
# Data sources (both US public domain):
#   - NHANES survey tables (demographics + lipid labs), via the nhanesA package.
#   - NCHS Public-Use Linked Mortality Files (LMF), parsed from the published
#     fixed-width .dat layout so the mortality step is fully transparent.
# =============================================================================

library(nhanesA)
library(readr)
library(dplyr)
library(purrr)
library(tidyr)

# ---- Cycle -> table-name map ------------------------------------------------
# NHANES renames its lab files across cycles. These are the correct table names
# per cycle for total cholesterol, HDL, and the fasting triglyceride/LDL file.
# Total cholesterol and HDL share one file for 1999-2004, then split from 2005.
cycle_map <- tribble(
  ~cycle,        ~demo,     ~tc_tbl,   ~hdl_tbl,  ~hdl_var, ~trig_tbl,
  "1999-2000",   "DEMO",    "Lab13",   "Lab13",   "LBDHDL", "Lab13AM",
  "2001-2002",   "DEMO_B",  "l13_b",   "l13_b",   "LBDHDL", "l13am_b",
  "2003-2004",   "DEMO_C",  "l13_c",   "l13_c",   "LBXHDD", "l13am_c",
  "2005-2006",   "DEMO_D",  "TCHOL_D", "HDL_D",   "LBDHDD", "TRIGLY_D",
  "2007-2008",   "DEMO_E",  "TCHOL_E", "HDL_E",   "LBDHDD", "TRIGLY_E",
  "2009-2010",   "DEMO_F",  "TCHOL_F", "HDL_F",   "LBDHDD", "TRIGLY_F",
  "2011-2012",   "DEMO_G",  "TCHOL_G", "HDL_G",   "LBDHDD", "TRIGLY_G",
  "2013-2014",   "DEMO_H",  "TCHOL_H", "HDL_H",   "LBDHDD", "TRIGLY_H",
  "2015-2016",   "DEMO_I",  "TCHOL_I", "HDL_I",   "LBDHDD", "TRIGLY_I",
  "2017-2018",   "DEMO_J",  "TCHOL_J", "HDL_J",   "LBDHDD", "TRIGLY_J"
)

get_tbl <- function(tbl) nhanes(tbl, translated = FALSE)

# ---- Pull and assemble one cycle of survey data ----------------------------
build_cycle <- function(cycle, demo, tc_tbl, hdl_tbl, hdl_var, trig_tbl) {
  demo_d <- get_tbl(demo) |>
    transmute(
      SEQN,
      cycle      = cycle,
      age        = RIDAGEYR,
      sex        = RIAGENDR,              # 1 = male, 2 = female
      race       = RIDRETH1,
      weight_mec = WTMEC2YR,
      psu        = SDMVPSU,
      strata     = SDMVSTRA
    )

  tc_d  <- get_tbl(tc_tbl)   |> select(SEQN, TC_mgdl = LBXTC)
  hdl_d <- get_tbl(hdl_tbl)  |> select(SEQN, HDL_mgdl = all_of(hdl_var))
  tg_d  <- get_tbl(trig_tbl) |> select(SEQN, TG_mgdl = LBXTR, LDL_mgdl = LBDLDL)

  demo_d |>
    left_join(tc_d,  by = "SEQN") |>
    left_join(hdl_d, by = "SEQN") |>
    left_join(tg_d,  by = "SEQN")
}

message("Downloading NHANES survey tables with nhanesA ...")
survey_all <- pmap(cycle_map, build_cycle) |> bind_rows()

# ---- Mortality: parse the NCHS public-use Linked Mortality Files ------------
# Published fixed-width column layout (from the CDC-provided R/SAS read code):
#   SEQN         cols  1-6
#   eligstat     col  15      1 = eligible, 2 = under 18, 3 = ineligible
#   mortstat     col  16      0 = assumed alive, 1 = assumed deceased
#   ucod_leading cols 17-19   underlying cause recode (001 = heart disease, ...)
#   diabetes     col  20      diabetes among multiple causes of death (0/1)
#   hyperten     col  21      hypertension among multiple causes of death (0/1)
#   permth_int   cols 43-45   person-months of follow-up from interview date
#   permth_exm   cols 46-48   person-months of follow-up from MEC exam date
lmf_base <- "https://ftp.cdc.gov/pub/Health_Statistics/NCHS/datalinkage/linked_mortality/"

read_lmf <- function(cycle) {
  yrs <- strsplit(cycle, "-")[[1]]
  fn  <- sprintf("NHANES_%s_%s_MORT_2019_PUBLIC.dat", yrs[1], yrs[2])
  tmp <- tempfile(fileext = ".dat")
  utils::download.file(paste0(lmf_base, fn), tmp, mode = "wb", quiet = TRUE)
  read_fwf(
    tmp,
    fwf_cols(SEQN = c(1, 6), eligstat = c(15, 15), mortstat = c(16, 16),
             ucod_leading = c(17, 19), diabetes = c(20, 20), hyperten = c(21, 21),
             permth_int = c(43, 45), permth_exm = c(46, 48)),
    col_types = "iiiiiiii", na = c("", ".")
  ) |>
    mutate(cycle = cycle)
}

message("Downloading and parsing NCHS Linked Mortality Files ...")
mort_all <- map(cycle_map$cycle, read_lmf) |> bind_rows()

# ---- Cause-of-death recode lookup (internal; builds cause_of_death) ---------
cod_lookup <- tribble(
  ~ucod_leading, ~cod,
  1L,  "Heart disease",
  2L,  "Cancer",
  3L,  "Chronic respiratory disease",
  4L,  "Accidents",
  5L,  "Cerebrovascular (stroke)",
  6L,  "Alzheimer's disease",
  7L,  "Diabetes",
  8L,  "Influenza and pneumonia",
  9L,  "Kidney disease",
  10L, "All other causes"
)

# ---- Merge, filter to eligible adults, derive outcome + ratios --------------
cholesterol_mortality <- survey_all |>
  mutate(SEQN = as.integer(SEQN)) |>
  left_join(mort_all, by = c("SEQN", "cycle")) |>
  filter(eligstat == 1, age >= 18) |>          # mortality-eligible adults only
  filter(!is.na(TC_mgdl) | !is.na(HDL_mgdl) |  # must have at least one lipid
         !is.na(LDL_mgdl) | !is.na(TG_mgdl)) |>
  left_join(cod_lookup, by = "ucod_leading") |>
  mutate(
    sex  = factor(sex, levels = c(1, 2), labels = c("Male", "Female")),
    race = factor(race, levels = 1:5,
                  labels = c("Mexican American", "Other Hispanic",
                             "Non-Hispanic White", "Non-Hispanic Black",
                             "Other/Multi")),
    died        = mortstat,                      # 1 = died, 0 = alive at censor
    followup_months = permth_exm,                # months from MEC exam
    cod   = factor(cod, levels = cod_lookup$cod),
    non_hdl = TC_mgdl - HDL_mgdl,                # non-HDL cholesterol
    tc_hdl  = round(TC_mgdl / HDL_mgdl, 2),      # total-to-HDL ratio
    ldl_hdl = round(LDL_mgdl / HDL_mgdl, 2)      # LDL-to-HDL ratio
  ) |>
  select(seqn = SEQN, cycle, age, sex, race,
         total_chol = TC_mgdl, hdl = HDL_mgdl, ldl = LDL_mgdl,
         triglycerides = TG_mgdl, non_hdl, tc_hdl_ratio = tc_hdl,
         ldl_hdl_ratio = ldl_hdl,
         died, followup_months, cause_of_death = cod,
         survey_weight = weight_mec, psu, strata)

```
