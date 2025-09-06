library(tidyverse)
library(here)

# download, unzip and read the file #
august_zipped <- here("fide/standard_aug25frl.zip")
september_zipped <- here("fide/standard_sep25frl.zip")

download.file("http://ratings.fide.com/download/standard_aug25frl.zip",
              destfile = august_zipped, mode = "wb")
download.file("http://ratings.fide.com/download/standard_sep25frl.zip",
              destfile = september_zipped, mode = "wb")

august_unzipped <- unzip(august_zipped, exdir = here("fide"))
september_unzipped <- unzip(september_zipped, exdir = here("fide"))

fide_ratings_august <- readr::read_fwf(file = august_unzipped,
                                       skip = 1,
                                       col_types=c("dcccccccdddcc"),
                                       fwf_widths(c(8, 68, 4, 4, 5, 5, 15, 4, 6, 4, 3, 6, 4),
                                                  c("id", "name", "fed", "sex", "title","wtitle",
                                                    "otitle", "foa", "rating", "games","k", "bday", "flag"))
) %>%
  # cleaning up player names
  mutate(name = str_remove(name, "^\\d+\\s+")) %>%
  # filter to only players who were active in the last 12 months
  filter(flag %in% c(NA, "w"),
         bday > 0) %>%
  select(-flag)

fide_ratings_september <- readr::read_fwf(file = september_unzipped,
                                          skip = 1,
                                          col_types=c("dcccccccdddcc"),
                                          fwf_widths(c(8, 68, 4, 4, 5, 5, 15, 4, 6, 4, 3, 6, 4),
                                                     c("id", "name", "fed", "sex", "title","wtitle",
                                                       "otitle", "foa", "rating", "games","k", "bday", "flag"))
) %>%
  # cleaning up player names
  mutate(name = str_remove(name, "^\\d+\\s+")) %>%
  # filter to only players who were active in the last 12 months
  filter(flag %in% c(NA, "w"),
         bday > 0) %>%
  select(-flag)

