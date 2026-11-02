# Data from Cited Feats (https://citedfeats.com/data/), licensed CC BY 4.0.
# The site regenerates these files every time it updates. The copies saved
# here are the version as of 2026-10-10, archived at
# https://doi.org/10.5281/zenodo.23278403.
#
# Cleaning: rows for the SCP Foundation ranking (franchise_slug == "scp") are
# dropped, because the site licenses them CC BY-SA 3.0 rather than CC BY 4.0.
# Nothing else is changed. readr parses `eligible` and `undone` as logical, and
# empty fields as NA.

library(dplyr)

read_citedfeats <- function(file) {
  readr::read_csv(
    paste0("https://citedfeats.com/data/", file),
    show_col_types = FALSE
  )
}

# One row per ranked character or entity.
fiction_rankings <- read_citedfeats("rankings.csv") |>
  filter(franchise_slug != "scp")

# One row per citation behind a ranking, each graded shown, stated or scaled.
fiction_citations <- read_citedfeats("citations.csv") |>
  filter(franchise_slug != "scp")

# One row per recorded death, and whether it was later undone.
fiction_deaths <- read_citedfeats("kills.csv") |>
  filter(franchise_slug != "scp")
