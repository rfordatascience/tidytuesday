# This is very much a work in progress. Eventually this will be extracted into a
# package or maybe GitHub workflow commands.

# Set these variables ----------------------------------------------------------

# src_folder_name <- "american_idol"
# target_date <- "2024-07-23"

# Run these scripts ------------------------------------------------------------

## Sources and targets ---------------------------------------------------------

src_dir <- here::here("data", "curated", src_folder_name)
target_year <- lubridate::year(target_date)
target_week <- lubridate::week(target_date)
target_dir <- here::here("data", target_year, target_date)
fs::dir_create(target_dir)

## metadata --------------------------------------------------------------------

metadata <- yaml::read_yaml(fs::path(src_dir, "meta.yaml"))

dataset_files <- fs::dir_ls(src_dir, glob = "*.csv") |> unname()
dataset_filenames <- basename(dataset_files)

intro <- readLines(fs::path(src_dir, "intro.md"))

title <- metadata$title %||% stop("missing data")
data_title <- metadata$data_source$title %||% stop("missing data")
data_link <- metadata$data_source$url %||% stop("missing data")
article_title <- metadata$article$title %||% stop("missing data")
article_link <- metadata$article$url %||% stop("missing data")

## Copy files ------------------------------------------------------------------

fs::file_copy(fs::path(src_dir, "meta.yaml"), target_dir)

metadata$images |> 
  purrr::walk(
    \(image) {
      fs::file_copy(fs::path(src_dir, image$file), target_dir)
    }
  )

fs::file_copy(dataset_files, target_dir)

## Create readme ---------------------------------------------------------------

read_piece <- function(filename) {
  paste(readLines(filename, warn = FALSE), collapse = "\n")
}

title_line <- glue::glue("# {title}")
intro <- read_piece(fs::path(src_dir, "intro.md"))
the_data_template <- read_piece(here::here("static", "templates", "the_data.md"))
how_to_participate <- read_piece(here::here("static", "templates", "how_to_participate.md"))

data_dictionaries <- purrr::map(
  dataset_filenames,
  \(dataset_filename) {
    dictionary_filename <- fs::path_ext_set(dataset_filename, "md")
    dictionary <- fs::path(src_dir, dictionary_filename) |> 
      read_piece()
    dictionary_md <- glue::glue(
      "# `{dataset_filename}`",
      dictionary,
      .sep = "\n\n"
    )
  }
) |> 
  glue::glue_collapse(sep = "\n\n") |> unclass()

data_dictionary <- glue::glue(
  "### Data Dictionary",
  data_dictionaries,
  .sep = "\n\n"
)
cleaning_script <- paste(
  "### Cleaning Script\n",
  "```r",
  read_piece(fs::path(src_dir, "cleaning.R")),
  "```",
  sep = "\n"
)

the_data <- whisker::whisker.render(
  the_data_template,
  list(
    date = target_date,
    year = target_year,
    week = target_week,
    datasets = purrr::map(
      dataset_filenames,
      \(dataset_file) {
        list(
          dataset_name = fs::path_ext_remove(dataset_file),
          dataset_file = dataset_file
        )
      }
    )
  )
)

if (!stringr::str_ends(cleaning_script, "\n")) {
  cleaning_script <- paste0(cleaning_script, "\n")
}

paste(
  title_line,
  intro,
  the_data,
  how_to_participate,
  data_dictionary,
  cleaning_script,
  sep = "\n\n"
) |> 
  cat(file = fs::path(target_dir, "readme.md"))

## Update the YEAR readme ------------------------------------------------------

this_row_year <- glue::glue(
  "| {target_week}",
  "`{target_date}`",
  "[{title}]({target_date}/readme.md)",
  "[{data_title}]({data_link})",
  "[{article_title}]({article_link})",
  "",
  .sep = " | "
) |> unclass()
this_row_main <- glue::glue(
  "| {target_week}",
  "`{target_date}`",
  "[{title}](data/{target_year}/{target_date}/readme.md)",
  "[{data_title}]({data_link})",
  "[{article_title}]({article_link})",
  "",
  .sep = " | "
) |> unclass()

cat(
  this_row_year,
  "\n",
  file = here::here("data", target_year, "readme.md"),
  append = TRUE
)

main_readme <- readLines(here::here("README.md"))
dataset_lines <- stringr::str_which(
  main_readme,
  "^\\| "
)
dataset_lines_start <- dataset_lines[[1]]
dataset_lines_end <- dataset_lines[[length(dataset_lines)]]
main_readme_start <- main_readme[1:(dataset_lines_start - 1)]
main_readme_end <- main_readme[(dataset_lines_end + 1):length(main_readme)]
main_readme_datasets <- c(
  main_readme[dataset_lines], this_row_main
)
cat(
  main_readme_start,
  main_readme_datasets,
  main_readme_end,
  sep = "\n",
  file = here::here("README.md")
)

## Add information about these datasets to the tt_data_type.csv file -----------

tt_data_types_file <- here::here("static", "tt_data_type.csv")

these_types <- tibble::tibble(
  Week = target_week,
  Date = lubridate::ymd(target_date),
  year = target_year,
  data_files = dataset_filenames,
  data_type = "csv",
  delim = ","
)

tt_data_types <- dplyr::bind_rows(
  these_types,
  readr::read_csv(
    tt_data_types_file,
    col_types = "iDiccc"
  )
)

readr::write_csv(tt_data_types, tt_data_types_file)

# Delete the used directory ----------------------------------------------------
 
fs::dir_delete(src_dir)
