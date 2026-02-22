# Functions for checking TidyTuesday submissions.
# Sourced by check_curated.R.

#' Check whether a URL is reachable
#'
#' Validates the URL scheme and hostname before sending a HEAD request. Returns
#' an error string if the URL uses a non-HTTP/HTTPS scheme, targets a private or
#' reserved address (SSRF risk), the server responds with a 4xx/5xx status, or
#' the request fails entirely (e.g. timeout, DNS failure). Returns `NULL` if the
#' URL is accessible or if no URL was provided.
#'
#' @param url `character(1)` The URL to check. Treated as absent if `NULL`,
#'   non-character, or zero-length.
#' @param source_name `character(1)` A human-readable label for the URL used in
#'   the error message (e.g. `"article"` or `"data_source"`).
#'
#' @returns `NULL` if the URL is reachable or absent; a `character(1)` error
#'   string otherwise.
check_url <- function(url, source_name) {
  if (is.null(url) || !is.character(url) || !nchar(url)) {
    return(NULL) # No URL to check
  }
  # Only allow safe HTTP/HTTPS schemes to prevent SSRF via other protocols
  # (e.g. file://, ftp://).
  if (!grepl("^https?://", url, ignore.case = TRUE)) {
    return(glue::glue(
      "URL for '{source_name}' must use http:// or https:// scheme: {url}"
    ))
  }
  # Block private/internal addresses to prevent SSRF from CI environments
  # (e.g. probing cloud metadata endpoints or internal services).
  if (.is_ssrf_risk(url)) {
    return(glue::glue(
      "URL for '{source_name}' targets a private or reserved address: {url}"
    ))
  }
  # nocov start
  error_message <- glue::glue(
    "Could not reach URL for '{source_name}'.",
    "Please check manually: {url}",
    .sep = " "
  )
  tryCatch(
    {
      # Use a HEAD request for efficiency. Set a 10-second timeout.
      # A browser-like user agent reduces false positives from servers that
      # block or reject requests from unrecognized agents (e.g. Wiley, Elsevier).
      response <- .httr_head(
        url,
        httr::timeout(10),
        httr::user_agent("Mozilla/5.0 (compatible; TidyTuesdayBot/1.0)")
      )
      # Check for client (4xx) or server (5xx) errors.
      if (httr::http_error(response)) {
        error_message
      }
    },
    error = function(e) {
      # This catches lower-level errors like timeouts, DNS resolution failures,
      # etc.
      error_message
    }
  )
  # nocov end
}

#' Check whether a URL targets a private or reserved host (SSRF risk)
#'
#' Parses the hostname from the URL and tests it against known private/reserved
#' address patterns, including loopback, link-local (e.g. AWS/Azure metadata),
#' RFC 1918 private ranges, and IPv6 private addresses.
#'
#' @param url `character(1)` A URL that has already been confirmed to start with
#'   `http://` or `https://`.
#' @returns `TRUE` if the hostname looks like a private/internal address,
#'   `FALSE` otherwise.
#' @keywords internal
.is_ssrf_risk <- function(url) {
  parsed <- tryCatch(httr::parse_url(url), error = function(e) NULL)
  if (is.null(parsed)) {
    return(TRUE) # Unparseable URL — treat as unsafe
  }
  host <- parsed$hostname
  if (is.null(host) || !nchar(host)) {
    return(TRUE) # Missing host — treat as unsafe
  }
  # Patterns covering loopback, link-local (169.254.x.x covers AWS/GCP/Azure
  # metadata endpoints), RFC 1918 private ranges, and IPv6 private addresses
  # (fc00::/7 covers both fc and fd ULA ranges).
  private_patterns <- c(
    "^localhost$",
    "^127\\.",
    "^10\\.",
    "^172\\.(1[6-9]|2[0-9]|3[01])\\.",
    "^192\\.168\\.",
    "^169\\.254\\.",
    "^::1$",
    "^\\[::1\\]$",
    "^f[cd][0-9a-f]{2}:"
  )
  any(vapply(
    private_patterns,
    function(p) grepl(p, host, ignore.case = TRUE, perl = TRUE),
    logical(1)
  ))
}

#' Wrapper around httr::HEAD
#'
#' @param url `character(1)` The URL to request.
#' @param ... Additional arguments passed to `httr::HEAD()`.
#' @returns An `httr` response object.
#' @keywords internal
.httr_head <- function(url, ...) {
  httr::HEAD(url, ...)
}

#' Check that all required files are present in a submission directory
#'
#' Verifies that `meta.yaml`, `cleaning.R`, and `intro.md` all exist, and that
#' at least one `*.png` image is present.
#'
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A `character` vector of error strings, zero-length if no errors are
#'   found.
check_required_files <- function(submission_dir) {
  c(
    .check_main_files(submission_dir),
    .check_png_exists(submission_dir)
  )
}

#' Check that the named required files exist in a submission directory
#'
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A `character` vector of error strings, zero-length if all present.
#' @keywords internal
.check_main_files <- function(submission_dir) {
  required_files <- c("meta.yaml", "cleaning.R", "intro.md")
  missing <- required_files[
    !fs::file_exists(fs::path(submission_dir, required_files))
  ]
  glue::glue("Missing required file: {missing}")
}

#' Check that at least one PNG image exists in a submission directory
#'
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A `character` vector of error strings, zero-length if a PNG is
#'   present.
#' @keywords internal
.check_png_exists <- function(submission_dir) {
  if (length(fs::dir_ls(submission_dir, glob = "*.png"))) {
    return(character())
  }
  "Missing required file: At least one *.png image is required."
}

#' Check CSV data files in a submission directory
#'
#' For each `*.csv` found, verifies that:
#' \itemize{
#'   \item A matching data dictionary (`*.md`) exists alongside it.
#'   \item All lines in the file are valid UTF-8. If not, reports the offending
#'     line numbers, raw non-ASCII bytes, and a Latin-1 interpretation as a
#'     diagnostic hint.
#' }
#' Also reads each CSV and appends a Markdown summary table of its columns
#' (name, class, percent missing, number of unique values) to the info output.
#'
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A named `list` with two elements:
#'   \describe{
#'     \item{`errors`}{`character` vector of error strings, zero-length if no
#'       errors are found.}
#'     \item{`info`}{`character` vector of Markdown-formatted column summary
#'       strings, one per CSV.}
#'   }
check_csv_files <- function(submission_dir) {
  csv_files <- fs::dir_ls(submission_dir, glob = "*.csv")
  if (!length(csv_files)) {
    return(list(
      errors = "Missing required file: At least one *.csv data file is required.",
      info = character()
    ))
  }
  results <- purrr::map(csv_files, .check_dataset)
  list(
    errors = purrr::list_c(purrr::map(results, "errors")),
    info = purrr::list_c(purrr::map(results, "info"))
  )
}

#' Check a single CSV file and its associated dictionary
#'
#' @param csv_file `character(1)` Path to the CSV file.
#' @returns A named `list` with two elements:
#'   \describe{
#'     \item{`errors`}{`character` vector of error strings, zero-length if no
#'       errors are found.}
#'     \item{`info`}{`character` vector of Markdown summary strings, zero-length
#'       if the data dictionary is missing.}
#'   }
#' @keywords internal
.check_dataset <- function(csv_file) {
  md_file <- fs::path_ext_set(csv_file, ".md")
  if (!fs::file_exists(md_file)) {
    return(list(
      errors = glue::glue(
        "Missing data dictionary for {fs::path_file(csv_file)}.",
        "Expected {fs::path_file(md_file)}.",
        .sep = " "
      ),
      info = character()
    ))
  }
  list(
    errors = .check_utf8(csv_file),
    info = .summarize_csv(csv_file)
  )
}

#' Check that a CSV file is valid UTF-8
#'
#' @param csv_file `character(1)` Path to the CSV file to check.
#' @returns A `character` vector of error strings, zero-length if the file is
#'   clean.
#' @keywords internal
.check_utf8 <- function(csv_file) {
  raw_lines <- readLines(csv_file, encoding = "UTF-8", warn = FALSE)
  bad_lines <- which(!validUTF8(raw_lines))
  if (!length(bad_lines)) {
    return(character())
  }
  .build_utf8_error(csv_file, bad_lines)
}

#' Build a UTF-8 encoding error message for a CSV file
#'
#' @param csv_file `character(1)` Path to the CSV file.
#' @param bad_lines `integer` vector of 1-based line numbers that failed
#'   `validUTF8()`.
#'
#' @returns A `character(1)` error string describing the offending lines and
#'   bytes.
#'
#' @keywords internal
.build_utf8_error <- function(csv_file, bad_lines) {
  all_bytes <- readBin(csv_file, what = "raw", n = .Machine$integer.max)
  newline_pos <- which(all_bytes == as.raw(0x0a))
  bad_details <- purrr::map_chr(utils::head(bad_lines, 5), function(i) {
    .describe_bad_line(i, all_bytes, newline_pos)
  })
  glue::glue(
    "{fs::path_file(csv_file)} contains {length(bad_lines)} line(s) with",
    "non-UTF-8 bytes (first 5 shown). The file may be Latin-1 or another",
    "encoding; re-save as UTF-8 in cleaning.R using",
    "`readr::locale(encoding = \"latin1\")` (or the correct encoding).",
    "Offending bytes per line:\n{paste(bad_details, collapse = '\n')}",
    .sep = " "
  )
}

#' Describe the non-ASCII bytes on a single bad line
#'
#' @param i `integer(1)` 1-based line number.
#' @param all_bytes `raw` vector of all bytes in the file.
#' @param newline_pos `integer` vector of byte positions of `\\n` characters.
#' @returns A `character(1)` formatted description of the offending bytes.
#' @keywords internal
.describe_bad_line <- function(i, all_bytes, newline_pos) {
  line_start <- if (i == 1L) 1L else newline_pos[i - 1L] + 1L
  line_end <- if (i <= length(newline_pos)) {
    newline_pos[i]
  } else {
    length(all_bytes)
  }
  non_ascii <- all_bytes[line_start:line_end]
  non_ascii <- non_ascii[non_ascii > as.raw(0x7f)]
  hex_str <- .to_hex_str(non_ascii)
  latin1_chars <- .to_latin1_str(non_ascii)
  glue::glue("  line {i}: bytes [{hex_str}] (as latin1: \"{latin1_chars}\")")
}

#' Format a raw vector as a space-separated hex string
#'
#' @param raw_bytes `raw` vector of bytes.
#' @returns A `character(1)` of space-separated hex byte values.
#' @keywords internal
.to_hex_str <- function(raw_bytes) {
  paste(as.character(raw_bytes), collapse = " ")
}

#' Attempt to decode a raw vector from Latin-1 to UTF-8
#'
#' @param raw_bytes `raw` vector of bytes.
#' @returns A `character(1)` of decoded characters, or `"(could not decode)"`.
#' @keywords internal
.to_latin1_str <- function(raw_bytes) {
  tryCatch(
    paste(
      iconv(
        rawToChar(raw_bytes, multiple = TRUE),
        from = "latin1",
        to = "UTF-8"
      ),
      collapse = ""
    ),
    error = function(e) "(could not decode)"
  )
}

#' Build a Markdown column-summary table for a CSV file
#'
#' @param csv_file `character(1)` Path to the CSV file.
#' @returns A `character(1)` Markdown string, including the filename as a
#'   header.
#' @keywords internal
.summarize_csv <- function(csv_file) {
  this_data <- readr::read_csv(csv_file, show_col_types = FALSE)
  paste(
    glue::glue("{fs::path_file(csv_file)}:"),
    "",
    .build_column_table(this_data),
    sep = "\n"
  )
}

#' Build a Markdown column-summary table for a data frame
#'
#' @param data A `data.frame`.
#' @returns A `character(1)` Markdown pipe table of column summaries.
#' @keywords internal
.build_column_table <- function(data) {
  purrr::map(names(data), function(var) .summarize_column(var, data)) |>
    purrr::list_rbind() |>
    knitr::kable(format = "pipe") |>
    paste(collapse = "\n")
}

#' Summarize a single column of a data frame
#'
#' @param var `character(1)` Column name.
#' @param data A `data.frame` containing `var`.
#' @returns A one-row `data.frame` with columns `variable`, `class`,
#'   `p_missing`, and `n_unique`.
#' @keywords internal
.summarize_column <- function(var, data) {
  data.frame(
    variable = var,
    class = class(data[[var]])[1],
    p_missing = round(sum(is.na(data[[var]])) / nrow(data) * 100, 1),
    n_unique = length(unique(data[[var]]))
  )
}

#' Check the content of meta.yaml and its linked assets
#'
#' Reads `meta.yaml` from the submission directory and performs the following
#' checks:
#' \itemize{
#'   \item Generates a Google search link for a manual controversy check (added
#'     to info output).
#'   \item Verifies that the `article` and `data_source` URLs are reachable via
#'     [check_url()].
#'   \item For each image listed under `images`: confirms the file exists, is
#'     within the Bluesky file-size limit (976.56 KB), and is within the
#'     Mastodon megapixel limit (8.3 MP).
#' }
#' Returns silently with empty results if `meta.yaml` does not exist (that
#' absence is caught separately by [check_required_files()]).
#'
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A named `list` with two elements:
#'   \describe{
#'     \item{`errors`}{`character` vector of error strings, zero-length if no
#'       errors are found.}
#'     \item{`info`}{`character` vector of informational strings (currently the
#'       manual controversy check link).}
#'   }
check_meta_yaml <- function(submission_dir) {
  meta_path <- fs::path(submission_dir, "meta.yaml")
  if (!fs::file_exists(meta_path)) {
    return(list(errors = character(), info = character()))
  }

  metadata <- yaml::read_yaml(meta_path)

  list(
    errors = c(
      .check_meta_urls(metadata),
      .check_images(metadata$images, submission_dir)
    ),
    info = .build_controversy_link(metadata$title)
  )
}

#' Check article and data source URLs from parsed meta.yaml metadata
#'
#' @param metadata A named `list` as returned by `yaml::read_yaml()`.
#' @returns A `character` vector of error strings, zero-length if all pass.
#' @keywords internal
.check_meta_urls <- function(metadata) {
  c(
    check_url(metadata$article$url, "article"),
    check_url(metadata$data_source$url, "data_source")
  )
}

#' Check all images listed in meta.yaml
#'
#' @param images The `images` element from parsed meta.yaml metadata, or `NULL`.
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A `character` vector of error strings, zero-length if all pass.
#' @keywords internal
.check_images <- function(images, submission_dir) {
  if (is.null(images) || !is.list(images)) {
    return("'images' section is missing or malformed in meta.yaml.")
  }
  purrr::list_c(purrr::map(images, .check_image, submission_dir))
}

#' Build a manual controversy check link for the report
#'
#' @param title `character(1)` (or `NULL`) The dataset title from `meta.yaml`.
#' @returns A `character(1)` Markdown string, or `character(0)` if no title.
#' @keywords internal
.build_controversy_link <- function(title) {
  if (!length(title) || !nchar(title)) {
    return(character())
  }
  search_query <- URLencode(title)
  controversy_link <- glue::glue(
    "https://www.google.com/search?q={search_query}+controversy"
  )
  glue::glue("- [ ] [Manual controversy check]({controversy_link})")
}

#' Check a single image listed in meta.yaml
#'
#' @param img_item A named `list` with at least a `file` element, as parsed
#'   from the `images` section of `meta.yaml`.
#' @param submission_dir `character(1)` Path to the submission directory.
#' @returns A `character` vector of error strings, zero-length if all checks pass.
#' @keywords internal
.check_image <- function(img_item, submission_dir) {
  img_path <- fs::path(submission_dir, img_item$file)
  if (!fs::file_exists(img_path)) {
    return(glue::glue(
      "Image file '{img_item$file}' listed in meta.yaml does not exist."
    ))
  }
  info_img <- magick::image_info(magick::image_read(img_path))
  c(
    .check_image_filesize(img_item$file, info_img),
    .check_image_megapixels(img_item$file, info_img)
  )
}

#' Check an image's file size against the Bluesky limit
#'
#' @param filename `character(1)` The image filename, used in error messages.
#' @param info_img A one-row `data.frame` as returned by `magick::image_info()`.
#' @returns A `character` vector of error strings, zero-length if the check passes.
#' @keywords internal
.check_image_filesize <- function(filename, info_img) {
  max_bsky_size_kb <- 976.56
  max_bsky_size <- fs::fs_bytes(paste0(max_bsky_size_kb, "KB"))
  if (info_img$filesize <= max_bsky_size) {
    return(character())
  }
  filesize_kb <- info_img$filesize / 1024
  glue::glue(
    "Image '{filename}' is too large.",
    "Size is {round(filesize_kb, 2)} KB, max is {max_bsky_size_kb} KB.",
    .sep = " "
  )
}

#' Check an image's megapixels against the Mastodon limit
#'
#' @param filename `character(1)` The image filename, used in error messages.
#' @param info_img A one-row `data.frame` as returned by `magick::image_info()`.
#' @returns A `character` vector of error strings, zero-length if the check passes.
#' @keywords internal
.check_image_megapixels <- function(filename, info_img) {
  max_mastodon_megapix <- 8.3
  megapix <- info_img$width * info_img$height / 1e6
  if (megapix <= max_mastodon_megapix) {
    return(character())
  }
  glue::glue(
    "Image '{filename}' has too many megapixels.",
    "It is {round(megapix, 2)} MP, max is {max_mastodon_megapix} MP.",
    .sep = " "
  )
}

#' Write the final PR check report
#'
#' Assembles a Markdown-formatted PR comment from the collected errors and
#' supplementary info strings, writes it to `pr_comment.md` in the working
#' directory, and appends `check_status=success` or `check_status=failure` to
#' the file at `$GITHUB_OUTPUT` for use in subsequent workflow steps.
#'
#' @param errors `character` vector of error strings collected during checks.
#'   Zero-length signals a passing run.
#' @param other_info `character` vector of supplementary informational strings
#'   to append to the report body regardless of pass/fail status.
#' @param report_file `character(1)` Path to write the Markdown PR comment.
#'   Defaults to `"pr_comment.md"` in the working directory.
#' @param status_file `character(1)` Path to the GitHub Actions output file
#'   where `check_status` is appended. Defaults to `$GITHUB_OUTPUT`.
#'
#' @returns Called for its side effects. Returns `NULL` invisibly.
write_report <- function(
  errors,
  other_info,
  report_file = "pr_comment.md",
  status_file = Sys.getenv("GITHUB_OUTPUT")
) {
  result <- .build_report_body(errors, other_info)
  writeLines(result$body, report_file)
  cli::cli_inform("Report written to {.path {report_file}}")
  write(paste0("check_status=", result$status), file = status_file)
}

#' Build the PR comment body and determine check status
#'
#' @param errors `character` vector of error strings, zero-length for a passing run.
#' @param other_info `character` vector of supplementary strings to append below
#'   the error list.
#' @returns A named `list` with `body` (`character(1)` Markdown) and `status`
#'   (`"success"` or `"failure"`).
#' @keywords internal
.build_report_body <- function(errors, other_info) {
  header <- "### TidyTuesday Submission Check:"

  if (length(other_info)) {
    other_info <- paste(other_info, collapse = "\n\n")
  }

  if (length(errors)) {
    header <- paste(header, "Failed ❌")
    errors <- paste("- [ ]", errors, collapse = "\n")
    status <- "failure"
  } else {
    header <- paste(header, "Passed ✅")
    status <- "success"
  }

  list(
    body = paste(header, errors, other_info, sep = "\n\n"),
    status = status
  )
}
