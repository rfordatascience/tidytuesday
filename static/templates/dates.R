check_date <- function(target_date) {
  used_dates <- get_readme_dates()
  expected_used_dates <- purrr::accumulate(
    rep(lubridate::days(7), length(used_dates) + 1),
    `+`,
    .init = used_dates[[1]]
  )
  next_available <- setdiff(expected_used_dates, used_dates) |> 
    lubridate::as_date() |> 
    min()
  if (!length(target_date) || !nzchar(target_date)) {
    return(next_available)
  }
  target_date <- lubridate::as_date(target_date)
  if (target_date %in% used_dates) {
    cli::cli_abort("Date already used.")
  }
  if (lubridate::wday(target_date, label = TRUE) == "Tue") {
    return(target_date)
  }
  cli::cli_abort("Bad target_date.")
}

get_readme_dates <- function(path = here::here("README.md")) {
  datasets <- get_readme_datasets(path)
  return(datasets$Date)
}
