library(tidyverse)
library(withr)

food_security_url <- "https://bulks-faostat.fao.org/production/Food_Security_Data_E_All_Data_(Normalized).zip"
csv_location <- withr::local_tempfile(fileext = ".zip")
download.file(food_security_url, destfile = csv_location)
food_security <- readr::read_csv(csv_location) |>
  # These fields are only useful if you're looking things up elsewhere
  dplyr::select(-tidyselect::contains("Code")) |>
  tidyr::pivot_wider(names_from = "Element", values_from = "Value") |>
  dplyr::rename(
    CI_Lower = "Confidence interval: Lower bound",
    CI_Upper = "Confidence interval: Upper bound"
  ) |>
  dplyr::mutate(
    Flag = dplyr::case_match(
      .data$Flag,
      "E" ~ "Estimated value",
      "X" ~ "Figure from external organization",
      "O" ~ "Missing value",
      "Q" ~ "Missing value; suppressed",
      "A" ~ "Official figure"
    ),
    # Remember to note this in dictionary!
    dplyr::across(
      c(tidyselect::starts_with("CI_"), "Value"),
      \(CI) {
        dplyr::case_match(
          .data$CI,
          "<0.1" ~ 0.09,
          "<0.5" ~ 0.49,
          "<2.5" ~ 2.49
        ) |>
          as.numeric()
      }
    ),
    Year_Start = as.integer(stringr::str_extract(.data$Year, "^(\\d{4})")),
    Year_End = as.integer(stringr::str_extract(.data$Year, "(\\d{4})$")),
    Unit = dplyr::case_when(
      is.na(.data$Unit) &
        .data$Item ==
          "Political stability and absence of violence/terrorism (index)" ~
        "index",
      .default = .data$Unit
    )
  ) |>
  dplyr::select(
    tidyselect::starts_with("Year_"),
    "Area",
    "Item",
    "Unit",
    "Value",
    tidyselect::starts_with("CI"),
    "Flag",
    "Note"
  )

rm(csv_location, food_security_url)
