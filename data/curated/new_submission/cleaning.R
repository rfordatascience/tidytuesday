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
