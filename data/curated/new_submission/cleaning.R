library(tidyverse)
library(rvest)
library(httr)
library(janitor)

# ============================================================
# Dataset 1: encyclicals
# Paragraph-level text from two papal encyclicals
# ============================================================

# Fetch Rerum Novarum (Leo XIII, 1891)
rn_url <- "https://www.vatican.va/content/leo-xiii/en/encyclicals/documents/hf_l-xiii_enc_15051891_rerum-novarum.html"
rn_response <- GET(rn_url, user_agent("Mozilla/5.0"))
rn_html <- read_html(content(rn_response, as = "text", encoding = "UTF-8"))
rn_raw <- rn_html |> html_nodes("p") |> html_text2()

# Fetch Magnifica Humanitas (Leo XIV, 2026)
mh_url <- "https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html"
mh_response <- GET(mh_url, user_agent("Mozilla/5.0"))
mh_html <- read_html(content(mh_response, as = "text", encoding = "UTF-8"))
mh_raw <- mh_html |> html_nodes("p") |> html_text2()

# Parse numbered paragraphs from Rerum Novarum
rn_numbered <- grep("^[0-9]+[.]", rn_raw, value = TRUE)
rn_first <- rn_raw[8]  # Opening paragraph (unnumbered)

rn_df <- tibble(
  paragraph = c(1L, as.integer(str_extract(rn_numbered, "^[0-9]+"))),
  text = c(rn_first, str_replace(rn_numbered, "^[0-9]+[.] ?", ""))
)

# Parse numbered paragraphs from Magnifica Humanitas
mh_numbered <- grep("^[0-9]+[.]", mh_raw, value = TRUE)

mh_df <- tibble(
  paragraph = as.integer(str_extract(mh_numbered, "^[0-9]+")),
  text = str_replace(mh_numbered, "^[0-9]+[.] ?", "")
)

# Combine into final dataset
encyclicals <- bind_rows(
  rn_df |> mutate(encyclical = "Rerum Novarum", pope = "Leo XIII", year = 1891L),
  mh_df |> mutate(encyclical = "Magnifica Humanitas", pope = "Leo XIV", year = 2026L)
) |>
  mutate(
    word_count = as.integer(str_count(text, "\\S+")),
    sentence_count = as.integer(str_count(text, "[.!?]+"))
  ) |>
  select(encyclical, pope, year, paragraph, text, word_count, sentence_count)

# ============================================================
# Dataset 2: scripture_references
# Biblical citations extracted from both encyclicals
# ============================================================

# Magnifica Humanitas: parenthetical refs like (cf. Gen 11:1-9)
mh_paren_pattern <- "\\(cf[.]\\s*([^)]+)\\)"

mh_scripture <- mh_df |>
  mutate(paren_refs = str_extract_all(text, mh_paren_pattern)) |>
  unnest(paren_refs, keep_empty = FALSE) |>
  mutate(paren_refs = str_replace_all(paren_refs, "^\\(cf[.]\\s*|\\)$", "")) |>
  separate_longer_delim(paren_refs, delim = ";") |>
  mutate(reference = str_trim(paren_refs)) |>
  select(paragraph, reference) |>
  mutate(encyclical = "Magnifica Humanitas", pope = "Leo XIV", year = 2026L)

# Magnifica Humanitas: inline refs like Jn 10:10
mh_inline_pattern <- "(?<!\\()(?:Jn|Mt|Mc|Lc|Is|Ps|Ap|Rm|Gn|Ex|Ac|Ef|Col|Ga|Ph)\\s+[0-9]+[,:][0-9]+"

mh_inline <- mh_df |>
  mutate(inline_refs = str_extract_all(text, mh_inline_pattern)) |>
  unnest(inline_refs, keep_empty = FALSE) |>
  mutate(reference = str_trim(inline_refs)) |>
  select(paragraph, reference) |>
  mutate(encyclical = "Magnifica Humanitas", pope = "Leo XIV", year = 2026L)

mh_all_scripture <- bind_rows(mh_scripture, mh_inline) |>
  distinct(encyclical, pope, year, paragraph, reference)

# Rerum Novarum: manually mapped from the footnotes section
rn_scripture <- tribble(
  ~paragraph, ~reference,
  11L, "Deut 5:21",
  12L, "Gen 1:28",
  17L, "Gen 3:17",
  20L, "James 5:4",
  21L, "2 Tim 2:12",
  21L, "2 Cor 4:17",
  22L, "Matt 19:23-24",
  22L, "Luke 6:24-25",
  22L, "Luke 11:41",
  22L, "Acts 20:35",
  22L, "Matt 25:40",
  23L, "2 Cor 8:9",
  23L, "Mark 6:3",
  24L, "Matt 5:3",
  24L, "Matt 11:28",
  25L, "Rom 8:17",
  28L, "1 Tim 6:10",
  29L, "Acts 4:34",
  40L, "Gen 1:28",
  40L, "Rom 10:12",
  41L, "Exod 20:8",
  41L, "Gen 2:2",
  44L, "Gen 3:19",
  50L, "Eccl 4:9-10",
  50L, "Prov 18:19",
  57L, "Matt 16:26",
  57L, "Matt 6:32-33",
  63L, "1 Cor 13:4-7"
) |>
  mutate(encyclical = "Rerum Novarum", pope = "Leo XIII", year = 1891L)

# Combine and standardize book names
scripture_references <- bind_rows(
  rn_scripture |> select(encyclical, pope, year, paragraph, reference),
  mh_all_scripture
) |>
  mutate(
    book = case_when(
      str_detect(reference, "^Gen") ~ "Genesis",
      str_detect(reference, "^Gn") ~ "Genesis",
      str_detect(reference, "^Exod") ~ "Exodus",
      str_detect(reference, "^Ex\\b") ~ "Exodus",
      str_detect(reference, "^Deut") ~ "Deuteronomy",
      str_detect(reference, "^Neh") ~ "Nehemiah",
      str_detect(reference, "^Prov") ~ "Proverbs",
      str_detect(reference, "^Eccl") ~ "Ecclesiastes",
      str_detect(reference, "^Ps") ~ "Psalms",
      str_detect(reference, "^Is") ~ "Isaiah",
      str_detect(reference, "^Jer") ~ "Jeremiah",
      str_detect(reference, "^Ezek") ~ "Ezekiel",
      str_detect(reference, "^Dan") ~ "Daniel",
      str_detect(reference, "^Matt") ~ "Matthew",
      str_detect(reference, "^Mt\\b") ~ "Matthew",
      str_detect(reference, "^Mark") ~ "Mark",
      str_detect(reference, "^Mk\\b") ~ "Mark",
      str_detect(reference, "^Mc\\b") ~ "Mark",
      str_detect(reference, "^Luke") ~ "Luke",
      str_detect(reference, "^Lc\\b") ~ "Luke",
      str_detect(reference, "^Lk\\b") ~ "Luke",
      str_detect(reference, "^John") ~ "John",
      str_detect(reference, "^Jn\\b") ~ "John",
      str_detect(reference, "^Acts") ~ "Acts",
      str_detect(reference, "^Ac\\b") ~ "Acts",
      str_detect(reference, "^Rom") ~ "Romans",
      str_detect(reference, "^Rm\\b") ~ "Romans",
      str_detect(reference, "^1 Cor") ~ "1 Corinthians",
      str_detect(reference, "^1\\s*Co\\b") ~ "1 Corinthians",
      str_detect(reference, "^2 Cor") ~ "2 Corinthians",
      str_detect(reference, "^2\\s*Co\\b") ~ "2 Corinthians",
      str_detect(reference, "^Gal") ~ "Galatians",
      str_detect(reference, "^Eph") ~ "Ephesians",
      str_detect(reference, "^Ef\\b") ~ "Ephesians",
      str_detect(reference, "^Phil") ~ "Philippians",
      str_detect(reference, "^Ph\\b") ~ "Philippians",
      str_detect(reference, "^Col") ~ "Colossians",
      str_detect(reference, "^1 Tim") ~ "1 Timothy",
      str_detect(reference, "^2 Tim") ~ "2 Timothy",
      str_detect(reference, "^Heb") ~ "Hebrews",
      str_detect(reference, "^James") ~ "James",
      str_detect(reference, "^1 Pet") ~ "1 Peter",
      str_detect(reference, "^1\\s*P\\b") ~ "1 Peter",
      str_detect(reference, "^Rev") ~ "Revelation",
      str_detect(reference, "^Ap\\b") ~ "Revelation",
      .default = NA_character_
    ),
    testament = case_when(
      book %in% c("Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
                  "Nehemiah", "Psalms", "Proverbs", "Ecclesiastes", "Isaiah",
                  "Jeremiah", "Ezekiel", "Daniel") ~ "Old Testament",
      !is.na(book) ~ "New Testament",
      .default = NA_character_
    )
  ) |>
  select(encyclical, pope, year, paragraph, reference, book, testament)

# ============================================================
# Dataset 3: papal_encyclicals
# Catalog of all papal encyclicals from 1878-2026
# ============================================================

# Scrape the Vatican's alphabetical papal documents list
catalog_url <- "https://www.vatican.va/offices/papal_docs_list.html"
catalog_resp <- GET(catalog_url, user_agent("Mozilla/5.0"))
catalog_html <- read_html(content(catalog_resp, as = "text", encoding = "UTF-8"))

# Extract all 4-column HTML tables (Title, Author, Year, Type)
tables <- catalog_html |> html_table(fill = TRUE)
four_col_tables <- keep(tables, ~ ncol(.x) == 4)

all_docs <- bind_rows(four_col_tables, .id = "table_id") |>
  rename(title = X1, author = X2, year_raw = X3, type = X4) |>
  filter(title != "Title", title != "", nchar(title) > 2, type == "Encyclical") |>
  mutate(year = as.integer(str_extract(year_raw, "[0-9]{4}"))) |>
  filter(!is.na(year)) |>
  distinct(title, author, year, .keep_all = TRUE) |>
  mutate(
    pope = case_when(
      str_detect(author, "Leo XIII") ~ "Leo XIII",
      str_detect(author, "Pius X($|[^I])") ~ "Pius X",
      str_detect(author, "Pius XI($|[^I])") ~ "Pius XI",
      str_detect(author, "Pius XII") ~ "Pius XII",
      str_detect(author, "Benedict XV($|[^I])") ~ "Benedict XV",
      str_detect(author, "Benedict XVI") ~ "Benedict XVI",
      str_detect(author, "John XXIII") ~ "John XXIII",
      str_detect(author, "John Paul II") ~ "John Paul II",
      str_detect(author, "Paul VI") ~ "Paul VI",
      .default = author
    )
  ) |>
  select(title, pope, year)

# Add encyclicals missing from the Vatican's legacy list
missing_encyclicals <- tribble(
  ~title, ~pope, ~year,
  "Lumen Fidei", "Francis", 2013L,
  "Laudato Si'", "Francis", 2015L,
  "Fratelli Tutti", "Francis", 2020L,
  "Dilexit Nos", "Francis", 2024L,
  "Magnifica Humanitas", "Leo XIV", 2026L
)

# Papal biographical metadata
papal_metadata <- tribble(
  ~pope, ~papal_number, ~birth_name, ~birth_country, ~pontificate_start, ~pontificate_end,
  "Leo XIII", 256L, "Vincenzo Gioacchino Pecci", "Italy", "1878-02-20", "1903-07-20",
  "Pius X", 257L, "Giuseppe Melchiorre Sarto", "Italy", "1903-08-04", "1914-08-20",
  "Benedict XV", 258L, "Giacomo della Chiesa", "Italy", "1914-09-03", "1922-01-22",
  "Pius XI", 259L, "Achille Ratti", "Italy", "1922-02-06", "1939-02-10",
  "Pius XII", 260L, "Eugenio Maria Giuseppe Pacelli", "Italy", "1939-03-02", "1958-10-09",
  "John XXIII", 261L, "Angelo Giuseppe Roncalli", "Italy", "1958-10-28", "1963-06-03",
  "Paul VI", 262L, "Giovanni Battista Montini", "Italy", "1963-06-21", "1978-08-06",
  "John Paul II", 264L, "Karol Jozef Wojtyla", "Poland", "1978-10-16", "2005-04-02",
  "Benedict XVI", 265L, "Joseph Aloisius Ratzinger", "Germany", "2005-04-19", "2013-02-28",
  "Francis", 266L, "Jorge Mario Bergoglio", "Argentina", "2013-03-13", "2025-04-21",
  "Leo XIV", 267L, "Robert Francis Prevost", "United States", "2025-05-08", NA_character_
) |>
  mutate(
    pontificate_start = as.Date(pontificate_start),
    pontificate_end = as.Date(pontificate_end)
  )

# Combine and enrich
papal_encyclicals <- bind_rows(all_docs, missing_encyclicals) |>
  distinct(title, pope, year) |>
  left_join(papal_metadata, by = "pope") |>
  mutate(
    pontificate_year = as.integer(year - as.integer(format(pontificate_start, "%Y")) + 1L)
  ) |>
  arrange(year, title) |>
  select(title, pope, year, papal_number, birth_name, birth_country,
         pontificate_start, pontificate_end, pontificate_year)
