library(tidyverse)
library(rvest)

# The Internet Movie Cars Database (IMCDb, https://www.imcdb.org) rates every
# vehicle appearance in a movie or show from 1 star (background vehicle) to
# 5 stars ("The vehicle is part of the movie"). This scrapes all 5-star
# vehicles -- the true star cars, think Herbie or the DeLorean -- from the
# public search results (https://www.imcdb.org/search.php, role = 5,
# 200 results per page), plus the site's list of makes to split make
# from model.

user_agent <- "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
search_url <- paste0(
  "https://www.imcdb.org/search.php?resultsStyle=asList",
  "&titleMatch=1&yearMatch=-1&role=5&page=%d"
)
page_size <- 200

fetch_html <- function(url) {
  url |>
    httr2::request() |>
    httr2::req_user_agent(user_agent) |>
    httr2::req_perform() |>
    httr2::resp_body_html()
}

flag_titles <- function(cell, dir) {
  cell |>
    html_elements(xpath = sprintf(".//img[contains(@src, '/res/%s/')]", dir)) |>
    html_attr("title")
}

parse_row <- function(row) {
  tds <- html_elements(row, "td")

  # Vehicle cell: link text holds "1991 Acura NSX [NA1]", with trim/nickname
  # notes in <span class="extra"> that must not leak into the name
  vehicle_a <- html_element(tds[[1]], "a")
  extra_nodes <- html_elements(vehicle_a, "span.extra")
  extra <- extra_nodes |> html_text2() |> paste(collapse = "; ")
  xml2::xml_remove(extra_nodes)
  name_parts <- vehicle_a |>
    html_text2() |>
    str_match("^(?:(\\d{4}) )?(.*?)(?: \\[([^\\]]+)\\])?$")

  # Vehicle flags: first = model origin, second (when present) = country it
  # was built in; a different flag style marks the market it was made for
  # (e.g. Acura NSX: origin Japan, made for USA). Confirmed against the
  # labeled flags on individual vehicle pages.
  vehicle_flags <- flag_titles(tds[[3]], "flags")

  # Movie cell reads 'in <a>title</a>, Movie, 1992'; series carry a year
  # range like 1992-1998, or 2019-?? when still running
  movie_a <- html_element(tds[[5]], "a")
  tail_parts <- tds[[5]] |>
    html_elements(xpath = "a/following-sibling::text()") |>
    html_text() |>
    paste(collapse = "") |>
    str_squish() |>
    str_match("^,\\s*(?:([^,]*?),\\s*)?(\\d{4})(?:-(\\d{4}|\\?\\?))?$")

  tibble(
    vehicle = name_parts[3],
    vehicle_year = as.integer(name_parts[2]),
    chassis = name_parts[4],
    extra = extra,
    vehicle_class = html_text2(tds[[2]]),
    origin_country = vehicle_flags[1] %||% NA_character_,
    built_in = vehicle_flags[2] %||% NA_character_,
    made_for = flag_titles(tds[[3]], "countries")[1] %||% NA_character_,
    movie_title = html_text2(movie_a),
    movie_type = coalesce(tail_parts[2], "Movie"),
    movie_year = as.integer(tail_parts[3]),
    movie_year_end = as.integer(na_if(tail_parts[4], "??")),
    vehicle_url = paste0("https://www.imcdb.org/", html_attr(vehicle_a, "href")),
    movie_url = paste0("https://www.imcdb.org/", html_attr(movie_a, "href"))
  )
}

scrape_all <- function() {
  pages <- list()
  page <- 1
  repeat {
    rows <- fetch_html(sprintf(search_url, page)) |>
      html_elements(xpath = "//tr[td/a[starts-with(@href, 'vehicle_')]]")
    if (length(rows) == 0) break
    pages[[page]] <- map(rows, parse_row) |> list_rbind()
    message(sprintf("page %d: %d rows", page, length(rows)))
    if (length(rows) < page_size) break
    page <- page + 1
    Sys.sleep(1.5)
  }
  list_rbind(pages)
}

# All makes known to IMCDb, longest first so prefix matching picks
# "Iran Khodro" over "Iran". Pseudo-makes appear on vehicle pages but
# not in makes.php.
fetch_makes <- function() {
  makes <- fetch_html("https://www.imcdb.org/makes.php") |>
    html_elements("a[href^='vehicles_make']") |>
    html_text2() |>
    unique() |>
    c("Custom Made", "Made for Movie", "unknown")
  makes[order(-nchar(makes))]
}

# Case-insensitive longest-prefix match ("MINI Cooper" -> make "Mini"),
# keeping the make's casing as written in the vehicle name
split_make_model <- function(vehicles, makes) {
  makes_low <- str_to_lower(makes)
  match_make <- function(name) {
    key <- str_to_lower(name)
    hit <- makes[key == makes_low | startsWith(key, paste0(makes_low, " "))]
    if (length(hit) == 0) NA_character_ else str_sub(name, 1, nchar(hit[1]))
  }
  vehicles |>
    mutate(
      make = map_chr(vehicle, match_make),
      model = case_when(
        is.na(make) ~ vehicle,
        nchar(make) == nchar(vehicle) ~ NA_character_,
        .default = str_sub(vehicle, nchar(make) + 2)
      ),
      .before = vehicle
    ) |>
    select(-vehicle)
}

star_cars <- scrape_all() |>
  split_make_model(makes = fetch_makes()) |>
  mutate(across(where(is.character), \(x) na_if(x, "")))

stopifnot(
  nrow(star_cars) > 1500,
  !anyNA(star_cars$make),
  !anyNA(star_cars$movie_title),
  !anyNA(star_cars$movie_year)
)
