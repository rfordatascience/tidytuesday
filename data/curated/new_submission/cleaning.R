# Mostly clean data provided by the {gutenbergr} package.
# install.packages("gutenbergr")
library(gutenbergr)
library(dplyr)
gutenberg_metadata <- gutenbergr::gutenberg_metadata
gutenberg_authors <- gutenbergr::gutenberg_authors
gutenberg_languages <- gutenbergr::gutenberg_languages |>
  # Fix a typo in the current CRAN version of the package.
  dplyr::mutate(language = as.factor(language))
gutenberg_languages$lanuage <- NULL
gutenberg_subjects <- gutenbergr::gutenberg_subjects
