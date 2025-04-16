ttsave <- function(data, dir, name = NULL) {
  if (is.null(name)) {
    name <- deparse(substitute(data))
  }
  
  path <- file.path("data", "curated", dir)
  
  # Write CSV
  readr::write_csv(data, file = file.path(path, paste0(name, ".csv")))
  
  # Build data dictionary
  dictionary <- purrr::map_chr(data, ~ class(.x)[1])
  dictionary <- tibble::tibble(
    variable = names(data),
    type = dictionary,
    description = ""  # You'll fill this in manually
  )
  
  # Write markdown dictionary
  dict_file <- file.path(path, paste0(name, ".md"))
  readr::write_lines(
    paste0("| variable | type | description |\n|----------|------|-------------|"),
    dict_file
  )
  
  readr::write_lines(
    paste0("| ", dictionary$variable, " | ", dictionary$type, " | ", dictionary$description, " |"),
    dict_file,
    append = TRUE
  )
}
