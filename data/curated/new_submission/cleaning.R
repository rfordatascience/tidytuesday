library(gutenbergr)
library(tidyverse)

# I do this as a separate step so I can be sure the option has resolved before I
# do anything in bulk.
gutenbergr::gutenberg_get_mirror()

christmas_novels_raw <- gutenbergr::gutenberg_works(
  dplyr::if_all(dplyr::everything(), ~ !is.na(.)),
  stringr::str_detect(.data$gutenberg_bookshelf, "Novels"),
  stringr::str_detect(.data$title, "Christmas"),
  stringr::str_detect(.data$gutenberg_bookshelf, "Christmas")
)

christmas_novels <- christmas_novels_raw |>
  dplyr::distinct(
    .data$gutenberg_id,
    .data$title
  )

christmas_novel_authors <- christmas_novels_raw |>
  dplyr::distinct(
    .data$gutenberg_id,
    .data$author,
    .data$gutenberg_author_id
  )

christmas_novel_text <- gutenbergr::gutenberg_download(christmas_novels)
