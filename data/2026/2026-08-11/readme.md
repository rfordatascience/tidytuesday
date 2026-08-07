# the Palomar Spectroscopic Survey of Nearby Galaxies

This week we're exploring spectroscopic observations of 486 nearby galaxies from the Palomar Spectroscopic Survey. In the 1990s, astronomers used the 200-inch Hale Telescope at Palomar Observatory — once the world's largest — to split the light from the centers of nearly 500 nearby galaxies into a rainbow of wavelengths. By measuring the strength of specific emission lines in those spectra, they classified each galaxy's nucleus as powered by young stars, by an active galactic nucleus (AGN), or by some combination of both.

The dataset comes from a landmark series of papers by Ho, Filippenko & Sargent that quantified the demographics of nuclear activity in the local universe. Their key finding: roughly 43% of nearby galaxies show spectroscopic signatures of AGN activity, making "active" nuclei far more common than previously recognized. A more recent census of over 8,000 galaxies using similar techniques ([Harvard CfA, January 2025](https://www.cfa.harvard.edu/news/scientists-find-more-active-black-holes-dwarf-and-milky-way-sized-galaxies-cutting-through-glare)) continues to refine these detection rates, confirming that the spectral classification approach pioneered in the Palomar survey remains foundational to the field.

> We use the sample of emission-line nuclei derived from a recently completed
> optical spectroscopic survey of nearby galaxies to quantify the incidence of
> local (z = 0) nuclear activity. [...] Half of the objects can be classified as
> H II or star-forming nuclei and the other half as some form of AGN, of which
> we distinguish three classes — Seyfert nuclei, LINERs, and transition objects.

- What types of nuclear activity are most common, and how does that vary with galaxy morphology (spirals vs. ellipticals)?
- Can you recreate the classic [BPT diagnostic diagram](https://ned.ipac.caltech.edu/level5/Glossary/Essay_bpt.html) using the emission-line ratios? Where do the different activity types fall?
- Is there a relationship between a galaxy's velocity dispersion (a proxy for central mass) and the type of nuclear activity it hosts?
- Which galaxy morphological types are most likely to host Seyfert nuclei vs. LINERs?

Thank you to [Tony Galvan, Golden Dome Data Science](https://github.com/gdatascience) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-08-11')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 32)

palomar_emission_lines <- tuesdata$palomar_emission_lines
palomar_survey <- tuesdata$palomar_survey

# Option 2: Read directly from GitHub

palomar_emission_lines <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_emission_lines.csv')
palomar_survey <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_survey.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-08-11')

# Option 2: Read directly from GitHub and assign to an object

palomar_emission_lines = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_emission_lines.csv')
palomar_survey = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_survey.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-08-11")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

palomar_emission_lines = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_emission_lines.csv")
palomar_survey = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_survey.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
palomar_emission_lines = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_emission_lines.csv", DataFrame)
palomar_survey = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_survey.csv", DataFrame)
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

### `palomar_emission_lines.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|galaxy_name |character |Common name of the galaxy. Can be joined with the palomar_survey dataset. |
|h_gamma     |double    |H-gamma (4340 angstrom) line intensity relative to H-alpha (= 1.0). |
|h_beta      |double    |H-beta (4861 angstrom) line intensity relative to H-alpha (= 1.0). Fundamental reference line for emission-line diagnostics. |
|oiii_5007   |double    |[O III] 5007 angstrom forbidden line intensity relative to H-alpha. Strongest line from doubly-ionized oxygen. |
|oi_6300     |double    |[O I] 6300 angstrom forbidden line intensity relative to H-alpha. Enhanced in shocks and LINER nuclei. |
|nii_6583    |double    |[N II] 6583 angstrom forbidden line intensity relative to H-alpha. Key line in BPT classification diagrams. |
|sii_6716    |double    |[S II] 6716 angstrom forbidden line intensity relative to H-alpha. One member of the sulfur doublet used for density estimates. |
|sii_6731    |double    |[S II] 6731 angstrom forbidden line intensity relative to H-alpha. The 6716/6731 ratio is density-sensitive. |

### `palomar_survey.csv`

|variable                  |class     |description                           |
|:-------------------------|:---------|:-------------------------------------|
|galaxy_name               |character |Common name of the galaxy (e.g. "NGC 224", "IC 342"). |
|hubble_type               |character |Morphological type in the Hubble sequence (e.g. "Sb", "E2", "SBc"). Includes luminosity class when available. |
|b_magnitude               |double    |Apparent blue (B-band) magnitude, uncorrected for extinction. Brighter objects have lower values. |
|helio_velocity_km_s       |double    |Heliocentric radial velocity in km/s. Negative values indicate motion toward us. Dividing by ~70 gives approximate distance in Mpc. |
|ra_j2000                  |character |Right ascension in J2000 coordinates (hours, minutes, seconds). |
|dec_j2000                 |character |Declination in J2000 coordinates (degrees, arcminutes, arcseconds). |
|ha_hb_ratio               |double    |Observed H-alpha to H-beta intensity ratio. The theoretical value for pure hydrogen gas is 2.86; higher values indicate dust reddening. |
|internal_reddening_ebv    |double    |Internal color excess E(B-V) derived from the H-alpha/H-beta ratio. Measures dust inside the galaxy reddening the nuclear light. |
|sii_density_ratio         |double    |Ratio of [S II] 6716 to [S II] 6731 line intensities. Used to estimate electron density in the emitting gas. |
|electron_density_cm3      |double    |Electron density in particles per cubic centimeter, derived from the [S II] doublet ratio. |
|log_oiii_hb               |double    |Dereddened [O III] 5007 / H-beta intensity ratio. Higher values indicate higher ionization. Used on the y-axis of BPT diagrams. |
|log_oi_ha                 |double    |Dereddened [O I] 6300 / H-alpha intensity ratio. Sensitive to shock excitation and partial ionization zones common in LINERs. |
|log_nii_ha                |double    |Dereddened [N II] 6583 / H-alpha intensity ratio. The primary x-axis of the classic BPT diagnostic diagram. |
|log_sii_ha                |double    |Dereddened [S II] (6716+6731) / H-alpha intensity ratio. Used in alternative BPT diagrams to separate Seyferts from LINERs. |
|spectral_class            |character |Nuclear spectral classification code (e.g. "S1.9", "L2", "T2:", "H"). Letters encode type, numbers subtype, colons indicate uncertainty. |
|activity_type             |character |Simplified nuclear activity classification: "Seyfert", "LINER", "Transition", "H II", or "Absorption". |
|activity_subtype          |integer   |Numeric subtype (1 or 2). Type 1 shows broad emission lines; type 2 shows only narrow lines. |
|classification_confidence |character |Confidence level: "confident", "uncertain", or "very uncertain". |
|velocity_dispersion_km_s  |double    |Adopted central stellar velocity dispersion in km/s. Correlates with central mass via the M-sigma relation. |
|velocity_dispersion_error |double    |Measurement uncertainty on the velocity dispersion in km/s. |

## Cleaning Script

```r
# Palomar Spectroscopic Survey of Nearby Galaxies
# Data from Ho, Filippenko & Sargent (1995, 1997, 2009)
# Observed with the 200-inch Hale Telescope at Palomar Observatory
#
# Downloads three catalogs from VizieR and joins them into two datasets:
#   palomar_survey - Galaxy properties + spectral classification (486 rows)
#   palomar_emission_lines - Raw emission-line intensities (418 rows)

library(httr)
library(readr)
library(dplyr)
library(stringr)

# --- Helper: download a VizieR table as a data frame ---
get_vizier_table <- function(catalog, table_name) {
  url <- paste0(
    "https://vizier.cds.unistra.fr/viz-bin/asu-tsv?-source=",
    catalog, "/", table_name,
    "&-out.max=unlimited&-oc.form=dec"
  )
  resp <- GET(url, timeout(60))
  stopifnot(status_code(resp) == 200)
  txt <- content(resp, "text", encoding = "UTF-8")
  lines <- strsplit(txt, "\n")[[1]]

  non_comment <- which(!grepl("^#", lines) & nchar(trimws(lines)) > 0)
  header <- strsplit(lines[non_comment[1]], "\t")[[1]]
  data_lines <- lines[non_comment[-(1:2)]]
  data_lines <- data_lines[!grepl("^-", data_lines)]

  tsv_text <- paste(c(paste(header, collapse = "\t"), data_lines), collapse = "\n")
  read_tsv(I(tsv_text), show_col_types = FALSE, trim_ws = TRUE)
}

# Download raw tables from VizieR
observations   <- get_vizier_table("J/ApJS/98/477", "table2")
classification <- get_vizier_table("J/ApJS/112/315", "table4")
emission_lines <- get_vizier_table("J/ApJS/112/315", "table2")
dispersions    <- get_vizier_table("J/ApJS/183/1", "table1")

# Galaxy properties from the observation log
galaxies <- observations |>
  mutate(Name = trimws(Name)) |>
  distinct(Name, .keep_all = TRUE) |>
  transmute(
    galaxy_name = Name,
    hubble_type = trimws(Type),
    b_magnitude = BT,
    helio_velocity_km_s = HRV,
    ra_j2000 = `_RA.icrs`,
    dec_j2000 = `_DE.icrs`
  )

# Nuclear spectral classification and dereddened emission-line ratios
classes <- classification |>
  mutate(Name = trimws(Name)) |>
  transmute(
    galaxy_name = Name,
    ha_hb_ratio = `Ha/Hb`,
    internal_reddening_ebv = `E(B-V)int`,
    sii_density_ratio = `R([SII])`,
    electron_density_cm3 = Ne,
    log_oiii_hb = `[OIII]/Hb`,
    log_oi_ha = `[OI]/Ha`,
    log_nii_ha = `[NII]/Ha`,
    log_sii_ha = `[SII]/Ha`,
    spectral_class = trimws(Class),
    activity_type = case_when(
      grepl("^S", spectral_class) ~ "Seyfert",
      grepl("^L", spectral_class) ~ "LINER",
      grepl("^T", spectral_class) ~ "Transition",
      grepl("^H", spectral_class) ~ "H II",
      TRUE ~ "Absorption"
    ),
    activity_subtype = as.integer(str_extract(spectral_class, "[12]")),
    classification_confidence = case_when(
      grepl("::", spectral_class) ~ "very uncertain",
      grepl(":", spectral_class) ~ "uncertain",
      TRUE ~ "confident"
    )
  )

# Velocity dispersions
vel_disp <- dispersions |>
  mutate(Name = trimws(Name)) |>
  transmute(
    galaxy_name = Name,
    velocity_dispersion_km_s = sig,
    velocity_dispersion_error = e_sig
  )

# Join into main dataset
palomar_survey <- galaxies |>
  left_join(classes, by = "galaxy_name") |>
  left_join(vel_disp, by = "galaxy_name")

# Emission-line intensities (normalized to H-alpha = 1.0)
palomar_emission_lines <- emission_lines |>
  mutate(galaxy_name = trimws(Name)) |>
  transmute(
    galaxy_name,
    h_gamma = Hgamma,
    h_beta = Hbeta,
    oiii_5007 = `[OIII]`,
    oi_6300 = `[OI]`,
    nii_6583 = `[NII]`,
    sii_6716 = `[SII]a`,
    sii_6731 = `[SII]b`
  )

```
