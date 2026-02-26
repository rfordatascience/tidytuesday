read_piece <- function(filename) {
  readLines(filename, warn = FALSE) |>
    paste(collapse = "\n") |>
    stringr::str_remove_all("<!--[\\s\\S]*?-->") |>
    stringr::str_trim() |>
    stringr::str_c("\n")
}

get_readme_datasets <- function(path = here::here("README.md")) {
  readme <- read_piece(path)
  return(readMDTable::extract_md_table(readme, show_col_types = FALSE))
}

glue_comma <- function(..., sep = ", ", env = rlang::caller_env()) {
  glue::glue_collapse(glue::glue(..., .envir = env), sep = ", ", last = ", ")
}
