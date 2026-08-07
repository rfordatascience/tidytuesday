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

