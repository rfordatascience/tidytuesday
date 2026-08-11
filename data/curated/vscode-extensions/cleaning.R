# The dataset is published as a tidy CSV already, archived on Zenodo under CC BY 4.0.
# `extensions.csv` is one row per distinct extension. Two columns are dropped here:
#   * publisher_display — two publishers had pasted a publish token into that field and the
#     source replaces those values with a redaction marker; a redaction artefact does not
#     belong in this repository.
#   * updates — the Marketplace's update-install counter, easily mistaken for a release
#     count. `installs` is the demand signal.
# 26 rows are also dropped: their `publisher` is a bare UUID rather than a namespace, which
# is the shape of an Open VSX access token. They are 0.04% of the crawl, they move no
# headline figure and two per-category medians by one install, and a public dataset should
# not reprint a string that might be somebody's live credential.
# vsx_publishers is derived here rather than shipped separately, so the derivation is visible.

library(tidyverse)

raw <- read_csv(
  "https://raw.githubusercontent.com/sujeito-operator/vscode-marketplace-data/main/data/extensions.csv",
  col_types = cols(
    released = col_date(), updated = col_date(),
    installs = col_integer(), updates = col_integer(), downloads = col_integer(),
    ratings = col_integer(), rating = col_double(), trending_weekly = col_double(),
    .default = col_character()
  )
)

vsx_extensions <- raw |>
  filter(!str_detect(
    publisher,
    "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  )) |>
  select(id, publisher, name, display, category, installs, downloads,
         rating, ratings, trending_weekly, released, updated, version)

vsx_publishers <- vsx_extensions |>
  summarise(
    n_extensions   = n(),
    total_installs = sum(installs),
    median_installs = as.integer(median(installs)),
    max_installs   = max(installs),
    first_release  = min(released),
    last_update    = max(updated),
    .by = publisher
  ) |>
  arrange(desc(total_installs))
