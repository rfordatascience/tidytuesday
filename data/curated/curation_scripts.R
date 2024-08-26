# Scripts to aid in dataset curation.

tt_dict <- function(x) {
  rlang::check_installed(c("tibble", "dplyr", "knitr"))
  tibble::tibble(variable = names(x)) |>
    dplyr::mutate(
      class = purrr::map(x, \(var) typeof(var)),
      description = "Describe this field in sentence case."
    ) |>
    knitr::kable()
}

ttsave <- function(dataset,
                   dir_name,
                   dataset_name = rlang::caller_arg(dataset)) {
  rlang::check_installed(c("here", "fs", "readr"))
  dataset_filename <- paste0(dataset_name, ".csv")
  dictionary_filename <- paste0(dataset_name, ".md")
  dir_path <- here::here("data", "curated", dir_name)
  
  dataset_path <- fs::path(dir_path, dataset_filename)
  readr::write_csv(dataset, dataset_path)
  
  dictionary <- tt_dict(dataset)
  dictionary_path <- fs::path(dir_path, dictionary_filename)
  cat(dictionary, file = dictionary_path, sep = "\n")
}
