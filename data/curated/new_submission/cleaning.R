library(tidyverse)
library(withr)
conflicted::conflicts_prefer(dplyr::filter)

# download, unzip and read the file #
august_zipped <- withr::local_tempfile(fileext = ".zip")
september_zipped <- withr::local_tempfile(fileext = ".zip")

download.file(
  "https://ratings.fide.com/download/standard_aug25frl.zip",
  destfile = august_zipped,
  mode = "wb"
)
download.file(
  "https://ratings.fide.com/download/standard_sep25frl.zip",
  destfile = september_zipped,
  mode = "wb"
)

august_unzipped <- unzip(august_zipped, exdir = tempdir())
september_unzipped <- unzip(september_zipped, exdir = tempdir())

fide_ratings_august <- readr::read_fwf(
  file = august_unzipped,
  skip = 1,
  col_types = c("dcccccccdddcc"),
  fwf_widths(
    c(8, 68, 4, 4, 5, 5, 15, 4, 6, 4, 3, 6, 4),
    c(
      "id",
      "name",
      "fed",
      "sex",
      "title",
      "wtitle",
      "otitle",
      "foa",
      "rating",
      "games",
      "k",
      "bday",
      "flag"
    )
  )
) %>%
  # cleaning up player names
  mutate(name = str_remove(name, "^\\d+\\s+")) %>%
  # filter to only players who were active in the last 12 months
  filter(flag %in% c(NA, "w"), bday > 0) %>%
  select(-flag)

fide_ratings_september <- readr::read_fwf(
  file = september_unzipped,
  skip = 1,
  col_types = c("dcccccccdddcc"),
  fwf_widths(
    c(8, 68, 4, 4, 5, 5, 15, 4, 6, 4, 3, 6, 4),
    c(
      "id",
      "name",
      "fed",
      "sex",
      "title",
      "wtitle",
      "otitle",
      "foa",
      "rating",
      "games",
      "k",
      "bday",
      "flag"
    )
  )
) %>%
  # cleaning up player names
  mutate(name = str_remove(name, "^\\d+\\s+")) %>%
  # filter to only players who were active in the last 12 months
  filter(flag %in% c(NA, "w"), bday > 0) %>%
  select(-flag)
