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
errors <- c() # A vector to collect all identified errors.

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

# --- 3. Final Report ---
# After all checks, prepare the report for commenting.
cli::cli_inform("3. Preparing report...")
report_file <- "pr_comment.md"

if (length(errors) > 0) {
  header <- "### TidyTuesday Submission Check: Failed ❌\n\nFound the following issues with the submission:\n"
  error_list <- paste("- [ ]", errors, collapse = "\n")
  report_body <- paste0(header, error_list)
  check_status <- "failure"
} else {
  report_body <- "### TidyTuesday Submission Check: Passed ✅\n\nAll checks passed successfully!"
  check_status <- "success"
}

writeLines(report_body, report_file)
cli::cli_inform("Report written to {.path {report_file}}")

# Set outputs for subsequent steps
write(paste0("check_status=", check_status), file = Sys.getenv("GITHUB_OUTPUT"))
