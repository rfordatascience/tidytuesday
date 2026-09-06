# URL from https://ielts.org/researchers/our-research/test-statistics
# and internet archive
sources <- list(
  demographic = list(
    "2024-2025" = "https://ielts.org/cdn/ielts-research-data/ielts-demographic-data-2024-2025.xlsx",
    "2023-2024" = "https://ielts.org/cdn/ielts-research-data/ielts-demographic-data-2023-2024.xlsx",
    "2022-2023" = "https://web.archive.org/web/20240105131824/https://s3.eu-west-2.amazonaws.com/ielts-web-static/production/Research/ielts-demographic-data-2022.xlsx"
  ),
  performance = list(
    "2024-2025" = "https://ielts.org/cdn/ielts-research-data/ielts-test-taker-performance-data-2024-2025.xlsx",
    "2023-2024" = "https://ielts.org/cdn/ielts-research-data/ielts-test-taker-performance-data-2023-2024.xlsx",
    "2022-2023" = "https://web.archive.org/web/20231001091407/https://s3.eu-west-2.amazonaws.com/ielts-web-static/production/Research/ielts-test-taker-performance-data-2022.xlsx"
  )
)

root_dir <- "data/curated/ielts"

download <- function(type, year) {
  dir <- file.path(root_dir, "data/raw")
  url <- sources[[type]][[year]]
  destfile <- file.path(dir, glue::glue("{year}_{type}.xlsx"))
  if (file.exists(destfile)) {
    return(destfile)
  }
  dir.create(dirname(destfile), recursive = TRUE, showWarnings = FALSE)
  download.file(url, destfile, mode = "wb")
  return(destfile)
}

read_page_demographics <- function(file, page) {
  bands <- c(
    "<4",
    "4",
    "4.5",
    "5",
    "5.5",
    "6",
    "6.5",
    "7",
    "7.5",
    "8",
    "8.5",
    "9"
  )

  data <- readxl::read_excel(file, sheet = page, skip = 3) |>
    na.omit() # last row sometimes is blank

  colnames(data)[colnames(data) == "Below 4"] <- "<4"
  colnames(data) <- tolower(colnames(data))
  data[["statistic"]] <- NULL
  id <- colnames(data)[1]

  data |>
    tidyr::pivot_longer(cols = -1, names_to = "band", values_to = "percent")
}

read_page_performance <- function(file, page) {
  cols <- c("listening", "reading", "writing", "speaking", "overall")

  data <- readxl::read_excel(file, sheet = page, skip = 2) |>
    na.omit() |> # last row sometimes is blank
    dplyr::select(-2) # remove the "Statistic" column

  colnames(data)[2:6] <- cols
  colnames(data) <- tolower(colnames(data))
  id <- colnames(data)[1]

  data |>
    tidyr::pivot_longer(cols = -1, names_to = "part", values_to = "score")
}


prepare <- function(name, pages_groups, read_page) {
  dir <- file.path(root_dir, "data/cleaned")
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  out <- list()
  for (group in names(pages_groups)) {
    out[[group]] <- lapply(names(sources[[name]]), \(year) {
      file <- download(name, year)
      lapply(pages_groups[[group]], \(page) read_page(file, page)) |>
        setNames(c("Academic", "General_Training")) |>
        dplyr::bind_rows(.id = "type") |>
        dplyr::mutate(year = year)
    }) |>
      dplyr::bind_rows() 
  }
  return(out)
}

demo <- prepare(
  "demographic",
  list(
    reasons = 1:2,
    first_language = 3:4,
    nationality = 5:6
  ),
  read_page_demographics
)
demo_by_reasons <- demo$reasons
demo_by_first_language <- demo$first_language
demo_by_nationality <- demo$nationality

performance <- prepare(
  "performance",
  list(
    nationality = 1:2,
    first_language = 3:4
  ),
  read_page_performance
)

performance_by_nationality <- performance$nationality
performance_by_first_language <- performance$first_language

