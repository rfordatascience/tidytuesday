library(rvest)
library(tidyverse)

url <- "https://en.wikipedia.org/wiki/List_of_films_based_on_video_games"

page <- read_html(url)

parse_scaled <- function(x, fn) {
  mult <- case_when(
    str_detect(x, regex("billion", ignore_case = TRUE)) ~ 1e9,
    str_detect(x, regex("million", ignore_case = TRUE)) ~ 1e6,
    .default = 1
  )
  nums <- str_extract_all(x, "[0-9][0-9,]*(?:\\.[0-9]+)?")
  map_dbl(nums, ~ { v <- parse_number(.x); if (length(v) == 0) NA_real_ else fn(v) }) * mult
}



clean_film_table <- function(df, category, subcategory) {
  df |>
    janitor::clean_names() |>
    rename(any_of(c(cinema_score = "cinema_score_1"))) |>
    mutate(across(where(is.character), ~ str_remove_all(., "\\[.*?\\]"))) |>
    (\(d) if ("release_date" %in% names(d))
      d |> mutate(
        release_date_raw = as.character(release_date),
        release_date = release_date_raw |>
          str_remove("\\s*\\(.*") |>       # strip regional suffixes: "... (JP)..."
          str_remove("\\s*[–—-].*") |>     # strip date ranges: "... – end date"
          str_trim() |>
          parse_date_time(orders = c("mdy", "my", "Y"), quiet = TRUE) |>
          as.Date()
      ) |>
      relocate(release_date_raw, .after = release_date)
    else d)() |>
    mutate(across(any_of(c("worldwide_box_office", "budget")),
                  ~ str_extract(., "^[£$€¥₹]"), .names = "{.col}_currency")) |>
    mutate(across(any_of("worldwide_box_office"), parse_number)) |>
    (\(d) if ("budget" %in% names(d))
      d |>
        mutate(budget_low = parse_scaled(budget, first), budget_high = parse_scaled(budget, last)) |>
        select(-budget)
    else d)() |>
    mutate(across(any_of("rotten_tomatoes"), ~ parse_number(str_remove(., "%")))) |>
    mutate(across(any_of("metacritic"), ~ parse_number(str_remove(., "/100")))) |>
    rename(any_of(c(director = "direction", air_date_raw = "original_air_date_s"))) |>
    mutate(category = category, subcategory = subcategory) |>
    relocate(category, subcategory) |>
    relocate(any_of("worldwide_box_office_currency"), .before = any_of("worldwide_box_office")) |>
    relocate(any_of("budget_currency"), .before = any_of("budget_low"))
}

get_heading_text <- function(node) {
  text <- html_text2(html_element(node, ".mw-headline"))
  if (is.na(text) || nchar(str_trim(text)) == 0) text <- html_text2(node)
  str_trim(text)
}

game_films <- local({
  nodes <- xml2::xml_find_all(page, ".//h2 | .//h3 | .//table[contains(@class,'wikitable')]")
  current_h2 <- NA_character_
  current_h3 <- NA_character_
  raw_tables <- list()
  categories <- character()
  subcategories <- character()

  for (i in seq_along(nodes)) {
    node <- nodes[[i]]
    tag <- html_name(node)
    if (tag == "h2") {
      current_h2 <- get_heading_text(node)
      current_h3 <- NA_character_
    } else if (tag == "h3") {
      current_h3 <- get_heading_text(node)
    } else if (tag == "table") {
      tbl <- tryCatch(
        node |>
          as.character() |>
          str_replace_all("<hr\\s*/?\\s*>\\s*", " | ") |>
          read_html() |>
          html_element("table") |>
          html_table(),
        error = function(e) NULL
      )
      if (!is.null(tbl) && nrow(tbl) > 0) {
        raw_tables <- c(raw_tables, list(tbl))
        categories <- c(categories, current_h2)
        subcategories <- c(subcategories, current_h3)
      }
    }
  }

  pmap(list(raw_tables, categories, subcategories), clean_film_table) |>
    bind_rows() |>
    relocate(any_of("air_date_raw"), .after = any_of("release_date_raw"))
})

