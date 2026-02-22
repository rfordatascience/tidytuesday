# Tests for check_functions.R
#
# Run with:
#   testthat::test_file(".github/scripts/test-check_functions.R")

library(testthat)

# Resolve paths relative to this file so tests work from any working directory.
.script_dir <- getSrcDirectory(function() {})
source(file.path(.script_dir, "check_functions.R"))

fixtures <- file.path(.script_dir, "fixtures")

# check_url() ----------------------------------------------------

# NOTE: Tests that require mocking .httr_head() (reachable URL, 4xx response,
# request error) are omitted here. local_mocked_bindings() / with_mocked_bindings()
# require the functions to live in a proper package namespace (loaded via
# pkgload). These tests should be added once check_functions.R is part of a
# package.

test_that("check_url() returns NULL for absent/empty URLs", {
  expect_null(check_url(NULL, "source"))
  expect_null(check_url("", "source"))
  expect_null(check_url(42L, "source"))
})

test_that("check_url() rejects non-HTTP/HTTPS schemes", {
  expect_match(check_url("file:///etc/passwd", "source"), "must use http")
  expect_match(check_url("ftp://example.com/file", "source"), "must use http")
  expect_match(check_url("javascript:alert(1)", "source"), "must use http")
})

test_that("check_url() rejects private/internal addresses", {
  expect_match(check_url("http://localhost/api", "source"), "private or reserved")
  expect_match(check_url("http://127.0.0.1/secret", "source"), "private or reserved")
  expect_match(check_url("http://169.254.169.254/metadata", "source"), "private or reserved")
  expect_match(check_url("http://10.0.0.1/internal", "source"), "private or reserved")
  expect_match(check_url("http://192.168.1.1/router", "source"), "private or reserved")
  expect_match(check_url("http://172.16.0.1/priv", "source"), "private or reserved")
})

test_that(".is_ssrf_risk() returns FALSE for public hostnames", {
  expect_false(.is_ssrf_risk("http://example.com"))
  expect_false(.is_ssrf_risk("https://github.com/repo"))
  expect_false(.is_ssrf_risk("https://www.google.com/search"))
})

test_that(".is_ssrf_risk() returns TRUE for private/reserved hosts", {
  expect_true(.is_ssrf_risk("http://localhost"))
  expect_true(.is_ssrf_risk("http://127.0.0.1"))
  expect_true(.is_ssrf_risk("http://169.254.169.254"))
  expect_true(.is_ssrf_risk("http://10.1.2.3"))
  expect_true(.is_ssrf_risk("http://192.168.0.1"))
  expect_true(.is_ssrf_risk("http://172.20.0.5"))
})

# check_required_files() -----------------------------------------

test_that("check_required_files() passes for a valid fixture", {
  errors <- check_required_files(fs::path(fixtures, "valid"))
  expect_length(errors, 0)
})

test_that("check_required_files() flags each missing named file", {
  for (f in c("meta.yaml", "cleaning.R", "intro.md")) {
    dir <- withr::local_tempdir()
    fs::dir_copy(fs::path(fixtures, "valid"), dir, overwrite = TRUE)
    fs::file_delete(fs::path(dir, f))
    errors <- check_required_files(dir)
    expect_true(
      any(grepl(f, errors, fixed = TRUE)),
      label = paste("missing", f)
    )
  }
})

test_that("check_required_files() flags missing PNG", {
  dir <- withr::local_tempdir()
  fs::dir_copy(fs::path(fixtures, "valid"), dir, overwrite = TRUE)
  fs::file_delete(fs::path(dir, "image.png"))
  errors <- check_required_files(dir)
  expect_true(any(grepl("png", errors, ignore.case = TRUE)))
})

# check_csv_files() ----------------------------------------------

test_that("check_csv_files() passes for a valid fixture", {
  result <- check_csv_files(fs::path(fixtures, "valid"))
  expect_length(result$errors, 0)
  expect_true(nchar(paste(result$info, collapse = "")) > 0)
})

test_that("check_csv_files() info contains the CSV filename", {
  result <- check_csv_files(fs::path(fixtures, "valid"))
  expect_true(any(grepl("data.csv", result$info, fixed = TRUE)))
})

test_that("check_csv_files() errors when no CSVs are present", {
  dir <- withr::local_tempdir()
  result <- check_csv_files(dir)
  expect_true(any(grepl("At least one *.csv", result$errors, fixed = TRUE)))
})

test_that("check_csv_files() errors when data dictionary is missing", {
  dir <- withr::local_tempdir()
  fs::file_copy(
    fs::path(fixtures, "valid", "data.csv"),
    fs::path(dir, "data.csv")
  )
  result <- check_csv_files(dir)
  expect_true(any(grepl("Missing data dictionary", result$errors)))
})

test_that("check_csv_files() errors on non-UTF-8 CSV", {
  result <- check_csv_files(fs::path(fixtures, "latin1"))
  expect_true(any(grepl("non-UTF-8", result$errors)))
})

test_that("check_csv_files() UTF-8 error includes hex bytes and latin1 hint", {
  result <- check_csv_files(fs::path(fixtures, "latin1"))
  utf8_error <- result$errors[grepl("non-UTF-8", result$errors)]
  expect_match(utf8_error, "e9") # hex byte for latin1 'é'
  expect_match(utf8_error, "as latin1")
})

test_that("check_csv_files() handles non-UTF-8 on the last line with no trailing newline", {
  # Exercises the else-branch in line-end detection (bad line past the last newline).
  result <- check_csv_files(fs::path(fixtures, "latin1_no_newline"))
  expect_true(any(grepl("non-UTF-8", result$errors)))
})

# check_meta_yaml() ----------------------------------------------
# NOTE: Tests that exercise the URL-checking logic within check_meta_yaml()
# (controversy link, URL pass/fail) are omitted for the same reason as above:
# they require mocking .httr_head(), which needs a package namespace.

test_that("check_meta_yaml() returns empty results when meta.yaml is absent", {
  dir <- withr::local_tempdir()
  result <- check_meta_yaml(dir)
  expect_length(result$errors, 0)
  expect_length(result$info, 0)
})

test_that("check_meta_yaml() returns no controversy link when title is absent", {
  dir <- withr::local_tempdir()
  writeLines(
    "data_source:\n  url: 'https://example.com'\n",
    fs::path(dir, "meta.yaml")
  )
  result <- check_meta_yaml(dir)
  expect_false(any(grepl("controversy", result$info, ignore.case = TRUE)))
})

test_that("check_meta_yaml() errors when images section is missing", {
  dir <- withr::local_tempdir()
  writeLines(
    "title: 'Test'\ndata_source:\n  url: 'https://example.com'\n",
    fs::path(dir, "meta.yaml")
  )
  result <- check_meta_yaml(dir)
  expect_true(any(grepl("images", result$errors, ignore.case = TRUE)))
})

test_that("check_meta_yaml() errors when a listed image file does not exist", {
  dir <- withr::local_tempdir()
  fs::dir_copy(fs::path(fixtures, "valid"), dir, overwrite = TRUE)
  fs::file_delete(fs::path(dir, "image.png"))
  result <- check_meta_yaml(dir)
  expect_true(any(grepl("does not exist", result$errors)))
})

test_that("check_meta_yaml() errors when image exceeds Bluesky size limit", {
  dir <- withr::local_tempdir()
  fs::dir_copy(fs::path(fixtures, "valid"), dir, overwrite = TRUE)
  # Replace the small fixture image with a pre-built oversized PNG (> 976.56 KB).
  fs::file_copy(
    fs::path(fixtures, "oversized.png"),
    fs::path(dir, "image.png"),
    overwrite = TRUE
  )
  result <- check_meta_yaml(dir)
  expect_true(any(grepl("too large", result$errors)))
})

test_that("check_meta_yaml() errors when image exceeds Mastodon megapixel limit", {
  dir <- withr::local_tempdir()
  fs::dir_copy(fs::path(fixtures, "valid"), dir, overwrite = TRUE)
  big_img <- magick::image_blank(3500, 3500, color = "white")
  magick::image_write(big_img, fs::path(dir, "image.png"), format = "png")
  result <- check_meta_yaml(dir)
  expect_true(any(grepl("megapixels", result$errors)))
})

# write_report() -------------------------------------------------

test_that("write_report() writes a passing report when there are no errors", {
  report_file <- withr::local_tempfile(fileext = ".md")
  status_file <- withr::local_tempfile()
  write_report(
    character(),
    character(),
    report_file = report_file,
    status_file = status_file
  )
  report <- paste(readLines(report_file), collapse = "\n")
  expect_match(report, "Passed")
  expect_match(readLines(status_file), "check_status=success")
})

test_that("write_report() writes a failing report when there are errors", {
  report_file <- withr::local_tempfile(fileext = ".md")
  status_file <- withr::local_tempfile()
  write_report(
    c("Something is wrong."),
    character(),
    report_file = report_file,
    status_file = status_file
  )
  report <- paste(readLines(report_file), collapse = "\n")
  expect_match(report, "Failed")
  expect_match(report, "Something is wrong.")
  expect_match(readLines(status_file), "check_status=failure")
})

test_that("write_report() includes other_info in the report body", {
  report_file <- withr::local_tempfile(fileext = ".md")
  status_file <- withr::local_tempfile()
  write_report(
    character(),
    c("Some extra info."),
    report_file = report_file,
    status_file = status_file
  )
  report <- paste(readLines(report_file), collapse = "\n")
  expect_match(report, "Some extra info.")
})
