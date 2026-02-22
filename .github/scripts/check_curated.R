# Check a TidyTuesday submission for expected content.

# Submission dir ----
submission_dir <- fs::dir_ls("data/curated", type = "directory") |>
  setdiff("data/curated/template")

if (length(submission_dir) != 1) {
  cli::cli_abort(
    "PR must contain files in exactly one new directory under {.path data/curated/}."
  )
}
cli::cli_inform(
  "Running checks on submission directory: {.path {submission_dir}}"
)

# Setup ----
errors <- character() # A vector to collect all identified errors.
other_info <- character() # A vector to collect other non-error info.

# Helper function to check URL accessibility
check_url <- function(url, source_name) {
  if (is.null(url) || !is.character(url) || !nchar(url)) {
    return(NULL) # No URL to check
  }
  error_message <- glue::glue(
    "Could not reach URL for '{source_name}'.",
    "Please check manually: {url}",
    .sep = " "
  )
  tryCatch(
    {
      # Use a HEAD request for efficiency. Set a 10-second timeout.
      response <- httr::HEAD(url, httr::timeout(10))
      # Check for client (4xx) or server (5xx) errors.
      if (httr::http_error(response)) {
        error_message
      }
    },
    error = function(e) {
      # This catches lower-level errors like timeouts, DNS resolution failures, etc.
      error_message
    }
  )
}

# Checks ----

## 1. Required files ----
cli::cli_inform("1. Checking for required files...")
required_files <- c("meta.yaml", "cleaning.R", "intro.md")
for (f in required_files) {
  file_path <- fs::path(submission_dir, f)
  if (!fs::file_exists(file_path)) {
    errors <- c(errors, glue::glue("Missing required file: {f}"))
  }
}

# Check for at least one PNG file.
png_files <- fs::dir_ls(submission_dir, glob = "*.png")
if (!length(png_files)) {
  errors <- c(
    errors,
    "Missing required file: At least one *.png image is required."
  )
}

# Check for data dictionaries (*.md) for each data file (*.csv).
csv_files <- fs::dir_ls(submission_dir, glob = "*.csv")
if (length(csv_files) > 0) {
  for (csv_file in csv_files) {
    md_file <- fs::path_ext_set(csv_file, ".md")
    if (!fs::file_exists(md_file)) {
      errors <- c(
        errors,
        glue::glue(
          "Missing data dictionary for {fs::path_file(csv_file)}. Expected {fs::path_file(md_file)}."
        )
      )
    } else {
      # Check that all lines are valid UTF-8.
      raw_lines <- readLines(csv_file, encoding = "UTF-8", warn = FALSE)
      bad_lines <- which(!validUTF8(raw_lines))
      if (length(bad_lines) > 0) {
        # For each bad line, find the specific non-UTF-8 bytes to help diagnosis.
        # Read the whole file as raw bytes once, then index into it per bad line.
        all_bytes   <- readBin(csv_file, what = "raw", n = .Machine$integer.max)
        newline_pos <- which(all_bytes == as.raw(0x0a))
        bad_details <- purrr::map_chr(utils::head(bad_lines, 5), function(i) {
          line_start <- if (i == 1L) 1L else newline_pos[i - 1L] + 1L
          line_end   <- if (i <= length(newline_pos)) newline_pos[i] else length(all_bytes)
          this_line  <- all_bytes[line_start:line_end]
          # Any byte > 0x7F is non-ASCII; in a file that failed validUTF8()
          # these are the characters causing the problem.
          non_ascii  <- this_line[this_line > as.raw(0x7f)]
          hex_str    <- paste(as.character(non_ascii), collapse = " ")
          # Attempt Latin-1 decode to give a human-readable hint.
          latin1_chars <- tryCatch(
            paste(
              iconv(rawToChar(non_ascii, multiple = TRUE), from = "latin1", to = "UTF-8"),
              collapse = ""
            ),
            error = function(e) "(could not decode)"
          )
          glue::glue("  line {i}: bytes [{hex_str}] (as latin1: \"{latin1_chars}\")")
        })
        errors <- c(
          errors,
          glue::glue(
            "{fs::path_file(csv_file)} contains {length(bad_lines)} line(s) with",
            "non-UTF-8 bytes (first 5 shown). The file may be Latin-1 or another",
            "encoding; re-save as UTF-8 in cleaning.R using",
            "`readr::locale(encoding = \"latin1\")` (or the correct encoding).",
            "Offending bytes per line:\n{paste(bad_details, collapse = '\n')}",
            .sep = " "
          )
        )
      }
      this_data <- readr::read_csv(csv_file)
      this_report <- c(
        glue::glue("{fs::path_file(csv_file)}:"),
        "",
        {
          purrr::map(
            names(this_data),
            function(var) {
              var_type <- class(this_data[[var]])[1]
              var_pmiss <- round(
                sum(is.na(this_data[[var]])) / nrow(this_data) * 100,
                1
              )
              var_nunique <- length(unique(this_data[[var]]))
              data.frame(
                variable = var,
                class = var_type,
                p_missing = var_pmiss,
                n_unique = var_nunique
              )
            }
          ) |>
            purrr::list_rbind() |>
            knitr::kable(format = "pipe") |>
            paste(collapse = "\n")
        }
      ) |>
        paste(collapse = "\n")
      other_info <- c(other_info, this_report)
    }
  }
} else {
  errors <- c(
    errors,
    "Missing required file: At least one *.csv data file is required."
  )
}


## 2. Check meta.yaml content and linked files ----
cli::cli_inform("2. Checking meta.yaml content...")
meta_path <- fs::path(submission_dir, "meta.yaml")

if (fs::file_exists(meta_path)) {
  metadata <- yaml::read_yaml(meta_path)

  # Generate a link to manually check for controversy
  if (length(metadata$title) && nchar(metadata$title)) {
    search_query <- URLencode(metadata$title)
    controversy_link <- glue::glue(
      "https://www.google.com/search?q={search_query}+controversy"
    )
    other_info <- c(
      other_info,
      glue::glue(
        "- [ ] [Manual controversy check]({controversy_link})"
      )
    )
  }

  # Check URLs from meta.yaml
  errors <- c(
    errors,
    check_url(metadata$article$url, "article"),
    check_url(metadata$data_source$url, "data_source")
  )

  # Check image specifications from meta.yaml
  if (!is.null(metadata$images) && is.list(metadata$images)) {
    # Define constraints.
    max_bsky_size_kb <- 976.56
    max_bsky_size <- fs::fs_bytes(paste0(max_bsky_size_kb, "KB"))
    max_mastodon_megapix <- 8.3

    image_info_list <- metadata$images
    for (img_item in image_info_list) {
      img_path <- fs::path(submission_dir, img_item$file)
      if (!fs::file_exists(img_path)) {
        errors <- c(
          errors,
          glue::glue(
            "Image file '{img_item$file}' listed in meta.yaml does not exist."
          )
        )
        next # Skip to next image if this one is missing.
      }

      # Read image and get its properties.
      img <- magick::image_read(img_path)
      info <- magick::image_info(img)

      # Check 1: Filesize for Bluesky compatibility.
      filesize_kb <- info$filesize / 1024
      if (info$filesize > max_bsky_size) {
        errors <- c(
          errors,
          glue::glue(
            "Image '{img_item$file}' is too large. Size is {round(filesize_kb, 2)} KB, max is {max_bsky_size_kb} KB."
          )
        )
      }

      # Check 2: Megapixels for Mastodon compatibility.
      megapix <- info$width * info$height / 1e6
      if (megapix > max_mastodon_megapix) {
        errors <- c(
          errors,
          glue::glue(
            "Image '{img_item$file}' has too many megapixels. It is {round(megapix, 2)} MP, max is {max_mastodon_megapix} MP."
          )
        )
      }
    }
  } else {
    errors <- c(
      errors,
      "'images' section is missing or malformed in meta.yaml."
    )
  }
}

# Final Report ----

# After all checks, prepare the report for commenting.
cli::cli_inform("3. Preparing report...")
report_file <- "pr_comment.md"
header <- "### TidyTuesday Submission Check:"

if (length(other_info)) {
  other_info <- paste(other_info, collapse = "\n\n")
}

if (length(errors)) {
  header <- paste(header, "Failed ❌")
  errors <- paste("- [ ]", errors, collapse = "\n")
  check_status <- "failure"
} else {
  header <- paste(header, "Passed ✅")
  check_status <- "success"
}

report_body <- paste(header, errors, other_info, sep = "\n\n")

writeLines(report_body, report_file)
cli::cli_inform("Report written to {.path {report_file}}")

# Set outputs for subsequent steps
write(paste0("check_status=", check_status), file = Sys.getenv("GITHUB_OUTPUT"))
