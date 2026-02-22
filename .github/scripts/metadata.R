read_metadata <- function(path) {
  yaml_preprocess(path)
  yaml::read_yaml(path)
}

yaml_preprocess <- function(path) {
  readLines(path, warn = FALSE) |>
    stringr::str_trim("right") |>
    yaml_quote() |>
    writeLines(path)
}

yaml_quote <- function(yaml_lines) {
  stringr::str_replace(
    yaml_lines,
    "^([^:]*:\\s+)([^>|\"'].*)$",
    '\\1"\\2"'
  )
}
