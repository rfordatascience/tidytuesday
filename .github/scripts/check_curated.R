# Check a TidyTuesday submission for expected content.
source(".github/scripts/check_functions.R")

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

# Checks ----

## 1. Required files ----
cli::cli_inform("1. Checking for required files...")
errors <- c(errors, check_required_files(submission_dir))

## 2. CSV files and data dictionaries ----
cli::cli_inform("2. Checking CSV files and data dictionaries...")
csv_result <- check_csv_files(submission_dir)
errors <- c(errors, csv_result$errors)
other_info <- c(other_info, csv_result$info)

## 3. meta.yaml content and linked files ----
cli::cli_inform("3. Checking meta.yaml content...")
meta_result <- check_meta_yaml(submission_dir)
errors <- c(errors, meta_result$errors)
other_info <- c(other_info, meta_result$info)

# Final Report ----
cli::cli_inform("4. Preparing report...")
write_report(errors, other_info)
