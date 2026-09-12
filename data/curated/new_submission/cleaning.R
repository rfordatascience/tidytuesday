# Dead Sea Scrolls Dataset
# Primary source: Leon Levy Dead Sea Scrolls Digital Library (Israel Antiquities Authority)
# Supplement: Wikipedia's List of the Dead Sea Scrolls (citing Fitzmyer 2008 / DJD series)
#
# This script queries the IAA's official catalog API for all known manuscript IDs
# across the 11 Qumran caves plus Masada, Wadi Murabba'at, and Nahal Hever.
# Manuscripts the API marks as "Unidentified" are supplemented with scholarly
# identifications from Wikipedia. Canon status enrichment classifies each
# manuscript as Protocanonical, Deuterocanonical, or Non-canonical based on
# the Catholic vs Protestant biblical canon.

library(httr)
library(jsonlite)
library(dplyr)
library(purrr)
library(stringr)
library(tidyr)
library(readr)
library(rvest)

# =============================================================================
# 1. SCRAPE LEON LEVY DIGITAL LIBRARY API
# =============================================================================

cave_ranges <- list(
  list(prefix = "1Q", start = 1, end = 72),
  list(prefix = "2Q", start = 1, end = 33),
  list(prefix = "3Q", start = 1, end = 15),
  list(prefix = "4Q", start = 1, end = 576),
  list(prefix = "5Q", start = 1, end = 25),
  list(prefix = "6Q", start = 1, end = 31),
  list(prefix = "7Q", start = 1, end = 19),
  list(prefix = "8Q", start = 1, end = 5),
  list(prefix = "9Q", start = 1, end = 1),
  list(prefix = "10Q", start = 1, end = 1),
  list(prefix = "11Q", start = 1, end = 31)
)

fetch_manuscript <- function(ms_id) {
  url <- sprintf("https://www.deadseascrolls.org.il/api/search?t=manuscript&q=%s",
                 URLencode(ms_id))
  resp <- tryCatch(
    GET(url, add_headers(`User-Agent` = "Mozilla/5.0 (R/tidytuesday)"), timeout(10)),
    error = function(e) NULL)
  if (is.null(resp) || status_code(resp) != 200) return(NULL)
  data <- content(resp, as = "text", encoding = "UTF-8") |> fromJSON(flatten = TRUE)
  if (data$length == 0) return(NULL)
  exact <- data$results |> filter(manuscript_number == ms_id)
  if (nrow(exact) > 0) return(exact[1, ])
  data$results[1, ]
}

all_manuscripts <- list()
for (cave in cave_ranges) {
  ids <- sprintf("%s%d", cave$prefix, cave$start:cave$end)
  cave_results <- compact(map(ids, ~ { Sys.sleep(0.08); fetch_manuscript(.x) }))
  if (length(cave_results) > 0) all_manuscripts[[cave$prefix]] <- bind_rows(cave_results)
}

# --- Non-Qumran sites: paginated text search ---
fetch_all_pages <- function(query) {
  first_url <- sprintf(
    "https://www.deadseascrolls.org.il/api/search?t=manuscript&q=%s&page=1",
    URLencode(query))
  resp <- tryCatch(GET(first_url,
    add_headers(`User-Agent` = "Mozilla/5.0 (R/tidytuesday)"),
    timeout(10)), error = function(e) NULL)
  if (is.null(resp) || status_code(resp) != 200) return(tibble())
  data <- content(resp, as = "text", encoding = "UTF-8") |> fromJSON(flatten = TRUE)
  if (data$length == 0) return(tibble())
  results <- data$results
  total_pages <- as.integer(data$totalpages)
  if (total_pages > 1) {
    for (p in 2:total_pages) {
      Sys.sleep(0.3)
      url <- sprintf(
        "https://www.deadseascrolls.org.il/api/search?t=manuscript&q=%s&page=%d",
        URLencode(query), p)
      r <- tryCatch(GET(url,
        add_headers(`User-Agent` = "Mozilla/5.0 (R/tidytuesday)"),
        timeout(10)), error = function(e) NULL)
      if (!is.null(r) && status_code(r) == 200) {
        pd <- content(r, as = "text", encoding = "UTF-8") |> fromJSON(flatten = TRUE)
        if (length(pd$results) > 0) results <- bind_rows(results, pd$results)
      }
    }
  }
  results
}

non_qumran_queries <- c("Mas", "Mur", "XHev", "5/6Hev", "8Hev")
for (q in non_qumran_queries) {
  Sys.sleep(0.5)
  site_results <- fetch_all_pages(q)
  if (nrow(site_results) > 0) all_manuscripts[[q]] <- site_results
}

leon_levy <- bind_rows(all_manuscripts) |>
  distinct(manuscript_number, .keep_all = TRUE) |>
  transmute(
    manuscript_id = manuscript_number,
    short_name = short_name,
    composition = composition_name,
    composition_type = composition_type,
    language = script_language,
    script_type = script_type,
    material = material,
    period = period,
    site = site,
    site_parent = if_else(!is.na(site_parent) & site_parent != "", site_parent,
                          str_extract(site, "^[^,]+")),
    cave = as.integer(str_extract(manuscript_number, "^(\\d+)(?=Q)")),
    num_images = num_images,
    keywords = if_else(is.na(keywords) | keywords == "", NA_character_, keywords)
  )

# =============================================================================
# 2. SUPPLEMENT WITH WIKIPEDIA IDENTIFICATIONS
# =============================================================================

page <- read_html("https://en.wikipedia.org/wiki/List_of_the_Dead_Sea_Scrolls")
tables <- page |> html_elements("table.wikitable")
raw_tables <- map(tables, ~ tryCatch(html_table(.x, fill = TRUE), error = function(e) NULL)) |>
  compact()

cave_assignments <- c(1, 2, 3, 4, 4, 4, 4, 5, 6, 7, 8, 9, 10, 11, NA, NA, NA)
wiki <- map2_dfr(raw_tables, seq_along(raw_tables), function(df, idx) {
  names(df) <- c("identifier", "scroll_name", "alt_identifier",
                 "bible_association", "language", "date_script", "description", "reference")
  df |> mutate(across(everything(), as.character), cave = cave_assignments[idx])
}) |>
  filter(!str_detect(identifier,
    "^Qumran Cave|^Fragment or scroll|^Wadi|^Nahal|^Masada$"), identifier != "")

wiki_lookup <- wiki |>
  filter(!is.na(alt_identifier), !str_detect(alt_identifier, "[\u2013-]\\d")) |>
  select(alt_identifier, scroll_name_wiki = scroll_name, description_wiki = description) |>
  distinct(alt_identifier, .keep_all = TRUE)

# Merge: fill unidentified Leon Levy manuscripts with Wikipedia identifications
dead_sea_scrolls <- leon_levy |>
  left_join(wiki_lookup, by = c("manuscript_id" = "alt_identifier")) |>
  mutate(composition = if_else(
    composition == "Unidentified" & !is.na(scroll_name_wiki),
    scroll_name_wiki, composition))

# =============================================================================
# 3. CANON STATUS ENRICHMENT
# =============================================================================

biblical_books <- tribble(
  ~pattern, ~book, ~canon_status, ~bible_section, ~testament,
  "(?i)genesis apocryphon|\\bapGen", "Genesis Apocryphon", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)\\benoch|\\bEn[- ]|\\b1 ?En", "1 Enoch", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)\\bjubilees|\\bjub\\b", "Jubilees", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)\\bgiants\\b", "Book of Giants", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)\\btemple scroll", "Temple Scroll", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)community rule|serekh|rule of the community", "Community Rule", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)war scroll|milhamah|sefer ha-milhamah|rule of war", "War Scroll", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)hodayot|thanksgiving hymn", "Thanksgiving Hymns", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)damascus|\\bCD\\b", "Damascus Document", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)\\bnoah\\b", "Book of Noah", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)testament of levi|\\bTLevi|\\bALD|aramaic levi", "Aramaic Levi Document", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)testament of qahat|\\bTKohath|\\bTQahat", "Testament of Qahat", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)new jerusalem", "New Jerusalem", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)copper scroll", "Copper Scroll", "Non-canonical", "Documentary", "Non-biblical",
  "(?i)pesher|\\bpHab|\\bpNah|\\bpMic|\\bpZeph|\\bpPs|\\bpIsa|\\bpHos", "Pesher (Commentary)", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)phylacter|\\bphyl|\\btefillin", "Phylactery (Tefillin)", "Non-canonical", "Liturgical", "Non-biblical",
  "(?i)mezuz", "Mezuzah", "Non-canonical", "Liturgical", "Non-biblical",
  "(?i)\\bMMT\\b|miqsat", "MMT", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)\\binstruction\\b|sapiential", "Instruction (Musar)", "Non-canonical", "Wisdom", "Non-biblical",
  "(?i)mysteries|\\bMyst", "Book of Mysteries", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)songs of.*sabbath|angelic liturgy|\\bShir", "Songs of Sabbath Sacrifice", "Non-canonical", "Liturgical", "Non-biblical",
  "(?i)\\bflorilegium|\\beschat", "Florilegium", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)\\btestimonia\\b", "Testimonia", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)\\bvisions of amram|\\bamram", "Visions of Amram", "Non-canonical", "Pseudepigrapha", "Non-biblical",
  "(?i)\\brule of the blessing|benediction", "Rule of the Blessing", "Non-canonical", "Sectarian", "Non-biblical",
  "(?i)\\btargum\\b", "Targum", "Non-canonical", "Biblical Translation", "Non-biblical",
  "(?i)\\bcalendar|\\bcalendric|\\botot\\b", "Calendrical Document", "Non-canonical", "Sectarian", "Non-biblical",
  # Deuterocanonical
  "(?i)\\btobit\\b|\\btob\\b|papTobit", "Tobit", "Deuterocanonical", "Deuterocanonical", "OT",
  "(?i)\\bsirach\\b|\\bben sira", "Sirach", "Deuterocanonical", "Deuterocanonical", "OT",
  "(?i)letter of jeremiah|epist.*jeremiah|\\bEpJer", "Letter of Jeremiah", "Deuterocanonical", "Deuterocanonical", "OT",
  # Torah
  "(?i)\\bgenesis\\b|\\bGen[- e]|paleo.?Gen", "Genesis", "Protocanonical", "Torah", "OT",
  "(?i)\\bexodus\\b|\\bExod[- u]", "Exodus", "Protocanonical", "Torah", "OT",
  "(?i)\\bleviticus\\b|\\bLev[- i]|paleoLev", "Leviticus", "Protocanonical", "Torah", "OT",
  "(?i)\\bnumbers\\b|\\bNum[- b]", "Numbers", "Protocanonical", "Torah", "OT",
  "(?i)\\bdeuteronomy\\b|\\bDeut[- e]", "Deuteronomy", "Protocanonical", "Torah", "OT",
  # Nevi'im
  "(?i)\\bjoshua\\b", "Joshua", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bjudges\\b", "Judges", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bsamuel\\b", "Samuel", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bkings\\b", "Kings", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bisaiah\\b", "Isaiah", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bjeremiah\\b", "Jeremiah", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bezekiel\\b", "Ezekiel", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bhosea\\b", "Hosea", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bjoel\\b", "Joel", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bamos\\b", "Amos", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bjonah\\b", "Jonah", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bmicah\\b", "Micah", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bnahum\\b", "Nahum", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bhabakkuk\\b", "Habakkuk", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bzephaniah\\b", "Zephaniah", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bhaggai\\b", "Haggai", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bzechariah\\b", "Zechariah", "Protocanonical", "Nevi'im", "OT",
  "(?i)\\bmalachi\\b", "Malachi", "Protocanonical", "Nevi'im", "OT",
  "(?i)minor prophets|twelve prophets", "Minor Prophets (Twelve)", "Protocanonical", "Nevi'im", "OT",
  # Ketuvim
  "(?i)\\bpsalm", "Psalms", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bproverbs\\b", "Proverbs", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bjob\\b", "Job", "Protocanonical", "Ketuvim", "OT",
  "(?i)song of s|canticles", "Song of Songs", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\becclesiastes\\b|\\bqoh", "Ecclesiastes", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\blamentations\\b", "Lamentations", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\besther\\b", "Esther", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bdaniel\\b", "Daniel", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bezra\\b", "Ezra", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bnehemiah\\b", "Nehemiah", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bchronicles\\b", "Chronicles", "Protocanonical", "Ketuvim", "OT",
  "(?i)\\bruth\\b", "Ruth", "Protocanonical", "Ketuvim", "OT",
  # Catch-all
  "(?i)\\bhymn|\\bhymnic", "Hymns", "Non-canonical", "Liturgical", "Non-biblical",
  "(?i)prayer|festival prayer", "Liturgical Prayer", "Non-canonical", "Liturgical", "Non-biblical"
)

identify_book <- function(composition, short_name, wiki_desc) {
  search_text <- paste(composition, short_name, wiki_desc, sep = " ")
  for (i in seq_len(nrow(biblical_books))) {
    if (str_detect(search_text, biblical_books$pattern[i])) {
      return(tibble(biblical_book = biblical_books$book[i],
                    canon_status = biblical_books$canon_status[i],
                    bible_section = biblical_books$bible_section[i],
                    testament = biblical_books$testament[i]))
    }
  }
  if (str_detect(search_text, "(?i)unident"))
    return(tibble(biblical_book = NA_character_, canon_status = "Unidentified",
                  bible_section = "Unidentified", testament = "Unknown"))
  tibble(biblical_book = NA_character_, canon_status = "Non-canonical",
         bible_section = "Other", testament = "Non-biblical")
}

book_info <- pmap_dfr(list(dead_sea_scrolls$composition,
                           replace_na(dead_sea_scrolls$short_name, ""),
                           replace_na(dead_sea_scrolls$description_wiki, "")),
                      identify_book)
dead_sea_scrolls <- dead_sea_scrolls |>
  mutate(
    biblical_book = book_info$biblical_book,
    canon_status = book_info$canon_status,
    bible_section = book_info$bible_section,
    testament = book_info$testament
  )

# Final cleanup
dead_sea_scrolls <- dead_sea_scrolls |>
  mutate(
    content_category = case_when(
      canon_status == "Protocanonical" ~ "Biblical",
      canon_status == "Deuterocanonical" ~ "Biblical (Deuterocanonical)",
      bible_section == "Pseudepigrapha" ~ "Parabiblical",
      bible_section == "Sectarian" ~ "Sectarian",
      bible_section == "Liturgical" ~ "Liturgical",
      bible_section == "Wisdom" ~ "Wisdom Literature",
      bible_section == "Documentary" ~ "Documentary",
      bible_section == "Biblical Translation" ~ "Biblical Translation",
      bible_section == "Unidentified" ~ "Unidentified",
      TRUE ~ "Other Non-biblical"
    ),
    language = case_when(
      str_detect(language, "(?i)hebrew") ~ "Hebrew",
      str_detect(language, "(?i)aramaic") ~ "Aramaic",
      str_detect(language, "(?i)greek") ~ "Greek",
      str_detect(language, "(?i)nabat") ~ "Nabataean",
      TRUE ~ language
    )
  ) |>
  select(-scroll_name_wiki, -description_wiki)
