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
  in_block_scalar <- FALSE
  block_scalar_indent <- 0L
  result <- yaml_lines

  for (i in seq_along(yaml_lines)) {
    line <- yaml_lines[[i]]
    line_indent <- nchar(line) - nchar(trimws(line, "left"))
    is_empty <- !nzchar(trimws(line))

    # A non-empty line whose indentation is <= the key that opened the block
    # scalar signals that we have left the block scalar.
    if (in_block_scalar && !is_empty && line_indent <= block_scalar_indent) {
      in_block_scalar <- FALSE
    }

    if (in_block_scalar) {
      # Leave continuation lines untouched.
      next
    }

    # Detect the start of a block scalar: a key whose value is > or |
    # optionally followed by chomp/indent modifiers (e.g. >-, |+, >2) and
    # nothing else on the line.
    if (grepl("^(\\s*\\S[^:]*:\\s*)[>|][-+]?[0-9]*\\s*$", line)) {
      in_block_scalar <- TRUE
      block_scalar_indent <- line_indent
    }

    result[[i]] <- stringr::str_replace(
      line,
      "^([^:]*:\\s+)([^>|\"'].*)$",
      '\\1"\\2"'
    )
  }

  result
}
