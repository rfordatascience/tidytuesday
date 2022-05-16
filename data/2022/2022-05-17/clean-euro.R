library(rvest)
library(tidyverse)
library(countrycode)
library(stringi)
library(V8)

# Web Scraping Events by Year ----
url_events <- "https://eurovision.tv/events"

events <- url_events %>%
  read_html() %>%
  html_elements("div.relative") %>%
  html_elements("h4") %>%
  html_text() %>%
  str_squish()

event_links <- url_events %>%
  read_html() %>%
  html_elements("div.w-full") %>%
  html_elements("a.absolute") %>%
  html_attr("href")

countries <- url_events %>%
  read_html() %>%
  html_elements("div.relative") %>%
  html_elements("span.px-4") %>%
  html_text() %>%
  str_squish()

countries <- countries[-3]

by_year <- tibble(
  event = events,
  host_city = events,
  host_country = countries,
  url = event_links
) %>%
  separate(host_city, c("host_city", "year"), sep = " (?=[0-9])") %>%
  mutate(year = as.integer(year))

by_year



# Get Eurovision ----------------------------------------------------------

get_euro <- function(url, section) {
  cli::cli_alert_info("{url} at {section}\n")

  ctx <- v8()

  pg <- read_html(paste0(url, "/", section))

  html_nodes(pg, xpath = ".//table[contains(@x-data, 'JSON')]") |>
    html_attr("x-data") |>
    stri_replace_first_regex("^table\\(", "var tbl = ") |>
    stri_replace_last_regex("\\)$", "") |>
    ctx$eval()

  ctx$get("tbl") |>
    tibble::as_tibble()
}

get_euro("https://eurovision.tv/event/rotterdam-2021", "second-semi-final")
# https://eurovision.tv/event/rotterdam-2021/participants
# https://eurovision.tv/event/rotterdam-2021/first-semi-final
# https://eurovision.tv/event/rotterdam-2021/second-semi-final
# https://eurovision.tv/event/rotterdam-2021/grand-final


all_scores <- by_year |>
  mutate(section = case_when(
    year >= 2008 ~ list(c("first-semi-final", "second-semi-final", "grand-final")),
    between(year, 2004, 2007) ~ list(c("semi-final", "grand-final")),
    TRUE ~ list("final")
  )) |>
  unnest_longer(section) |>
  mutate(data = map2(url, section, ~ get_euro(.x, .y)))

all_scores_old <- all_scores

all_scores <- all_scores |>
  bind_rows(score_below_2000)

all_part <- all_scores |>
  rename(event_url = url) |>
  unchop(data) |>
  unnest_wider(data) |>
  unpack(participant) |>
  unpack(country)

clean_part <- all_part |>
  rename(
    artist = name,
    song = performance, artist_url = url, 
    artist_country = nickname, country_emoji = emoji
  )


clean_part |>
  count(year) |>
  arrange(desc(year)) |>
  ggplot(aes(x = year, y = n, group = 1)) +
  geom_line()

clean_part |>
  write_csv("2022/2022-05-17/eurovision.csv")

raw_df <- readxl::read_excel("2022/2022-05-17/eurovision_song_contest_1975_2022.xlsx")
