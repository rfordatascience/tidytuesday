# Tests for metadata.R (yaml_quote, yaml_preprocess, read_metadata)
#
# Run with:
#   testthat::test_file(".github/scripts/test-assign_week.R")

library(testthat)

# Resolve paths relative to this file so tests work from any working directory.
.script_dir <- getSrcDirectory(function() {})
source(file.path(.script_dir, "metadata.R"))

fixtures <- file.path(.script_dir, "fixtures")

# yaml_quote() ---------------------------------------------------

test_that("yaml_quote() quotes unquoted scalar values", {
  expect_equal(yaml_quote("title: Test Dataset"), 'title: "Test Dataset"')
})

test_that("yaml_quote() does not double-quote already-quoted values", {
  expect_equal(yaml_quote('title: "Test Dataset"'), 'title: "Test Dataset"')
})

test_that("yaml_quote() leaves bare key lines alone", {
  expect_equal(yaml_quote("images:"), "images:")
})

test_that("yaml_quote() does not quote a block scalar indicator", {
  expect_equal(yaml_quote("  alt: >"), "  alt: >")
  expect_equal(yaml_quote("  alt: |"), "  alt: |")
})

test_that("yaml_quote() preserves block scalar continuation lines containing colons", {
  lines <- c(
    "images:",
    "- file: image.png",
    "  alt: >",
    "    Overall success rate: 62% across 136,000 repairs."
  )
  result <- yaml_quote(lines)
  expect_equal(result[[4]], "    Overall success rate: 62% across 136,000 repairs.")
})

test_that("yaml_quote() resumes quoting after a block scalar ends", {
  lines <- c(
    "  alt: >",
    "    Some text: with colon",
    "title: Next Section"
  )
  result <- yaml_quote(lines)
  # Continuation line must not be quoted
  expect_equal(result[[2]], "    Some text: with colon")
  # Line after block scalar must be quoted
  expect_equal(result[[3]], 'title: "Next Section"')
})

test_that("yaml_quote() does not quote empty lines inside a block scalar", {
  lines <- c(
    "  alt: >",
    "",
    "    Continuation after blank line: value",
    "title: After"
  )
  result <- yaml_quote(lines)
  expect_equal(result[[2]], "")
  expect_equal(result[[3]], "    Continuation after blank line: value")
  expect_equal(result[[4]], 'title: "After"')
})

# read_metadata() ------------------------------------------------

test_that("read_metadata() parses the standard valid fixture without error", {
  dir <- withr::local_tempdir()
  fs::file_copy(
    file.path(fixtures, "valid", "meta.yaml"),
    file.path(dir, "meta.yaml")
  )
  result <- read_metadata(file.path(dir, "meta.yaml"))
  expect_type(result, "list")
  expect_equal(result$title, "Test Dataset")
})

test_that("read_metadata() parses a meta.yaml whose block-scalar alt contains colons", {
  dir <- withr::local_tempdir()
  fs::file_copy(
    file.path(fixtures, "alt-with-colon", "meta.yaml"),
    file.path(dir, "meta.yaml")
  )
  result <- read_metadata(file.path(dir, "meta.yaml"))
  expect_type(result, "list")
  # The alt text must not contain stray quote characters injected by yaml_quote()
  expect_false(grepl('"', result$images[[1]]$alt, fixed = TRUE))
  # The key content from the bug report must survive intact
  expect_true(grepl("62%", result$images[[1]]$alt, fixed = TRUE))
})
