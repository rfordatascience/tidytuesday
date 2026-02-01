# This is very much a work in progress. Eventually this will be extracted into a
# package or maybe GitHub workflow commands.

# Set these variables ----------------------------------------------------------

# src_folder_name <- "new_submission"
# src_folder_name <- "template"
# target_date <- NULL

# Run these scripts ------------------------------------------------------------

library(dplyr, warn.conflicts = FALSE)
source(here::here(".github", "scripts", "parse_readme.R"), local = TRUE)
source(here::here(".github", "scripts", "dates.R"), local = TRUE)
source(here::here(".github", "scripts", "metadata.R"), local = TRUE)

## Sources and targets ---------------------------------------------------------

src_dir <- here::here("data", "curated", src_folder_name)
target_date <- check_date(target_date)
target_year <- lubridate::year(target_date)
target_week <- lubridate::week(target_date)
target_dir <- here::here("data", target_year, target_date)
fs::dir_create(target_dir)
cleaning_src <- fs::dir_ls(src_dir, regexp = "cleaning\\.(R|r|py|jl)$")

## metadata --------------------------------------------------------------------

metadata <- read_metadata(fs::path(src_dir, "meta.yaml"))

dataset_files <- fs::dir_ls(src_dir, glob = "*.csv") |> unname()
dataset_filenames <- basename(dataset_files)

title <- metadata$title %||% stop("missing data")
data_title <- metadata$data_source$title %||% stop("missing data")
data_link <- metadata$data_source$url %||% stop("missing data")
article_title <- metadata$article$title %||% stop("missing data")
article_link <- metadata$article$url %||% stop("missing data")
credit <- metadata$credit$post
credit_github <- metadata$credit$github
if (length(credit_github)) {
  # Normalize in case they gave full path vs just handle or included @.
  credit_handle <- sub("github.com", "", credit_github) |>
    sub("https://", "", x = _) |>
    gsub("/", "", x = _) |>
    sub("@", "", x = _)
  credit_github <- glue::glue("https://github.com/{credit_handle}")
  if (length(credit)) {
    credit <- glue::glue("[{credit}]({credit_github})")
  } else {
    credit <- glue::glue("@credit_handle")
  }
}

## Copy files ------------------------------------------------------------------

fs::file_copy(fs::path(src_dir, "meta.yaml"), target_dir)
fs::file_copy(dataset_files, target_dir)

### Keep these files even though they're also added to the readme. -------------
md_files <- fs::dir_ls(src_dir, glob = "*.md")
files_to_resave <- c(md_files, cleaning_src)

purrr::walk(files_to_resave, \(resave_me) {
  # Get rid of comments, make sure there's a trailing newline, make sure there
  # *isn't* a newline at the start.
  read_piece(resave_me) |>
    writeLines(fs::path(target_dir, basename(resave_me)))
})

### Resize images --------------------------------------------------------------
max_bsky_size <- fs::fs_bytes("976.56KB")
metadata$images |>
  purrr::walk(
    \(image) {
      original_img_path <- fs::path(src_dir, image$file)
      original_img_size <- fs::file_size(original_img_path)
      if (original_img_size >= max_bsky_size) {
        # Round down to make sure we're *under* 1MB. This isn't actually
        # guaranteed to work because image size isn't directly proportional to
        # file size, but it seems to err on the side of making things smaller
        # than they need to be.
        ratio <- floor(
          as.integer(max_bsky_size) / as.integer(original_img_size) * 90
        )
        magick::image_read(original_img_path) |>
          magick::image_resize(
            magick::geometry_size_percent(ratio)
          ) |>
          magick::image_write(fs::path(target_dir, image$file))
      } else {
        fs::file_copy(original_img_path, target_dir)
      }
    }
  )

## Create readme ---------------------------------------------------------------

title_line <- glue::glue("# {title}")
intro <- read_piece(fs::path(src_dir, "intro.md"))
credit_line <- glue::glue(
  "Thank you to {credit} for curating this week's dataset."
)
if (length(credit_line)) {
  intro <- paste(intro, credit_line, sep = "\n")
}

the_data_template <- read_piece(here::here(
  "static",
  "templates",
  "the_data.md"
))
how_to_participate <- read_piece(here::here(
  "static",
  "templates",
  "how_to_participate.md"
))

data_dictionaries <- purrr::map(
  dataset_filenames,
  \(dataset_filename) {
    dictionary_filename <- fs::path_ext_set(dataset_filename, "md")
    dictionary <- fs::path(src_dir, dictionary_filename) |>
      read_piece()
    dictionary_md <- glue::glue(
      "### `{dataset_filename}`",
      dictionary,
      .sep = "\n\n"
    )
  }
) |>
  glue::glue_collapse(sep = "\n\n") |>
  unclass()

data_dictionary <- glue::glue(
  "## Data Dictionary",
  data_dictionaries,
  .sep = "\n\n"
)

cleaning_ext <- fs::path_ext(cleaning_src)
language_tag <- switch(
  tolower(cleaning_ext),
  r = "r",
  py = "python",
  jl = "julia",
  cli::cli_abort("Unknown cleaning script extension: {cleaning_ext}")
)

cleaning_script <- paste(
  "## Cleaning Script\n",
  paste0("```", language_tag),
  read_piece(cleaning_src),
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

full_readme <- paste(
  title_line,
  intro,
  the_data,
  how_to_participate,
  data_dictionary,
  cleaning_script,
  sep = "\n\n"
) |>
  stringr::str_replace_all("\n{3,}", "\n\n")

cat(full_readme, file = fs::path(target_dir, "readme.md"))

## Update the YEAR readme ------------------------------------------------------

year_readme_datasets <- get_readme_datasets(
  here::here("data", target_year, "readme.md")
)

year_readme_datasets <- dplyr::bind_rows(
  year_readme_datasets,
  tibble::tibble(
    Week = target_week,
    Date = target_date,
    Data = glue::glue("[{title}]({target_date}/readme.md)"),
    Source = glue_comma("[{data_title}]({data_link})"),
    Article = glue_comma("[{article_title}]({article_link})")
  )
) |>
  dplyr::arrange(.data$Date)

cat(
  glue::glue(
    "# {target_year} Data",
    "Archive of datasets and articles from the {target_year} series of `#TidyTuesday` events.",
    .sep = "\n\n"
  ),
  paste(knitr::kable(year_readme_datasets), collapse = "\n"),
  sep = "\n\n",
  file = here::here("data", target_year, "readme.md")
)

## Update the MAIN readme ------------------------------------------------------

main_readme <- readLines(here::here("README.md"))
dataset_lines <- stringr::str_which(
  main_readme,
  "^\\| "
)
dataset_lines_start <- dataset_lines[[1]]
dataset_lines_end <- dataset_lines[[length(dataset_lines)]]
main_readme_start <- main_readme[1:(dataset_lines_start - 1)]
main_readme_end <- main_readme[(dataset_lines_end + 1):length(main_readme)]

main_readme_datasets <- get_readme_datasets()
main_readme_datasets <- dplyr::bind_rows(
  main_readme_datasets,
  tibble::tibble(
    Week = target_week,
    Date = target_date,
    Data = glue::glue("[{title}](data/{target_year}/{target_date}/readme.md)"),
    Source = glue::glue("[{data_title}]({data_link})"),
    Article = glue::glue("[{article_title}]({article_link})")
  )
) |>
  dplyr::arrange(.data$Date)

cat(
  main_readme_start,
  paste(knitr::kable(main_readme_datasets), collapse = "\n"),
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
