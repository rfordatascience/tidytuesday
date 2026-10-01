# build_dataset.R
# Constructs the catholic_miracles dataset by scraping primary sources:
#   1. miraclehunter.com — Marian apparitions, Eucharistic miracles, stigmata,
#      incorruptibles, and miraculous images
#   2. miracolieucaristici.org — Carlo Acutis Eucharistic Miracles Exhibition
#   3. lourdes-france.com — Official Lourdes Sanctuary recognized cures
#
# All data is scraped programmatically from these source websites.

library(tidyverse)
library(rvest)
library(httr)

# =============================================================================
# HELPER: Scrape miraclehunter.com period pages (table 9 pattern)
# =============================================================================

scrape_mh_pages <- function(base_url, pages, sleep = 0.5) {
  map_dfr(pages, function(p) {
    Sys.sleep(sleep)
    url <- paste0(base_url, p)
    page <- tryCatch(read_html(url), error = function(e) NULL)
    if (is.null(page)) return(tibble())
    tables <- page |> html_elements("table")
    if (length(tables) < 9) return(tibble())
    tbl <- tryCatch(html_table(tables[[9]], fill = TRUE), error = function(e) NULL)
    if (is.null(tbl) || nrow(tbl) < 2) return(tibble())
    tbl |> mutate(across(everything(), as.character), source_page = p)
  })
}

# =============================================================================
# 1. MARIAN APPARITIONS (approved/traditional) — miraclehunter.com
# =============================================================================

cat("--- [1/7] Scraping Marian apparitions (approved) from miraclehunter.com ---\n")

marian_approved_raw <- scrape_mh_pages(
  "https://www.miraclehunter.com/marian_apparitions/approved_apparitions/",
  c("apparitions_0040-0999.html", "apparitions_1000-1099.html",
    "apparitions_1100-1199.html", "apparitions_1200-1299.html",
    "apparitions_1300-1399.html", "apparitions_1400-1499.html",
    "apparitions_1500-1599.html", "apparitions_1600-1699.html",
    "apparitions_1700-1799.html", "apparitions_1800-1899.html")
)

# These are 3-col: year, place, details
if (ncol(marian_approved_raw) >= 4) {
  marian_approved <- marian_approved_raw |>
    select(year_raw = 1, place = 2, details = 3, source_page) |>
    filter(nchar(place) > 1) |>
    mutate(approval_status = "Approved (traditional/episcopal)")
}
cat(sprintf("  Approved/traditional apparitions: %d rows\n", nrow(marian_approved)))

# =============================================================================
# 2. MARIAN APPARITIONS (since 1900, with rulings) — miraclehunter.com
# =============================================================================

cat("--- [2/7] Scraping Marian apparitions (since 1900) from miraclehunter.com ---\n")

marian_page <- read_html(
  "https://www.miraclehunter.com/marian_apparitions/approved_apparitions/index.html")
marian_tables <- marian_page |> html_elements("table")
marian_modern_raw <- html_table(marian_tables[[9]], fill = TRUE)

# 4-col: Year, Place, People Involved, Approval
names(marian_modern_raw) <- c("year_raw", "place", "people_involved", "approval_status")
marian_modern <- marian_modern_raw[-1, ] |>  # remove header row

  mutate(
    details = people_involved,
    source_page = "unapproved_index"
  ) |>
  filter(nchar(place) > 1)

cat(sprintf("  Modern apparitions (since 1900): %d rows\n", nrow(marian_modern)))

# Combine both apparition datasets
marian_all <- bind_rows(
  marian_approved |> select(year_raw, place, details, approval_status, source_page),
  marian_modern |> select(year_raw, place, details, approval_status, source_page)
) |>
  mutate(
    category = "Marian Apparition",
    year = as.integer(str_extract(year_raw, "\\d{1,4}")),
    source_reference = "miraclehunter.com"
  ) |>
  filter(!is.na(year))

cat(sprintf("  Combined Marian apparitions: %d rows\n", nrow(marian_all)))

# =============================================================================
# 3. EUCHARISTIC MIRACLES — miraclehunter.com
# =============================================================================

cat("--- [3/7] Scraping Eucharistic miracles from miraclehunter.com ---\n")

euch_mh_raw <- scrape_mh_pages(
  "https://www.miraclehunter.com/eucharistic-miracles/",
  c("100-1000.html", "1000-1100.html", "1100-1200.html", "1200-1300.html",
    "1300-1400.html", "1400-1500.html", "1500-1600.html", "1600-1700.html",
    "1700-1800.html", "1800-1900.html", "1900-2000.html", "2000.html")
)

euch_mh <- euch_mh_raw |>
  select(year_raw = 1, place = 2, details = 3, source_page) |>
  filter(nchar(place) > 1) |>
  mutate(
    category = "Eucharistic Miracle",
    year = as.integer(str_extract(year_raw, "\\d{1,4}")),
    approval_status = "Approved",
    source_reference = "miraclehunter.com"
  ) |>
  filter(!is.na(year))

cat(sprintf("  Eucharistic miracles (miraclehunter.com): %d rows\n", nrow(euch_mh)))

# =============================================================================
# 4. EUCHARISTIC MIRACLES — miracolieucaristici.org (Carlo Acutis)
# =============================================================================

cat("--- [4/7] Scraping Eucharistic miracles from miracolieucaristici.org ---\n")

euch_acutis_page <- read_html("https://www.miracolieucaristici.org/en/Liste/list.html")
all_links <- euch_acutis_page |> html_elements("a")
link_hrefs <- all_links |> html_attr("href")
link_texts <- all_links |> html_text2()

miracle_mask <- str_detect(link_hrefs, regex("scheda", ignore_case = TRUE)) &
  !str_detect(link_hrefs, regex("pannello", ignore_case = TRUE))

euch_acutis_links <- tibble(href = link_hrefs[miracle_mask], text = link_texts[miracle_mask])
page_text <- euch_acutis_page |> html_text2()

euch_acutis_entries <- euch_acutis_links |>
  filter(str_detect(text, ",\\s*\\d|D\\.C\\.|cent\\.|sec\\.")) |>
  mutate(
    city = str_trim(str_extract(text, "^[^,]+")),
    year_raw = str_trim(str_extract(text, "(?<=,\\s?).*$")),
    year = case_when(
      str_detect(year_raw, "^\\d{4}") ~ as.integer(str_extract(year_raw, "^\\d{4}")),
      str_detect(year_raw, "750") ~ 750L,
      str_detect(year_raw, "VI-VII|VI") ~ 600L,
      str_detect(year_raw, "XI sec|XI cent") ~ 1050L,
      str_detect(year_raw, "III-V|III-IV") ~ 350L,
      str_detect(year_raw, "IV-V") ~ 450L,
      TRUE ~ NA_integer_
    )
  ) |>
  filter(!is.na(year))

# Assign country from page text position
assign_country <- function(city_text, page_text) {
  city_pos <- str_locate(page_text, fixed(city_text))[1, "start"]
  if (is.na(city_pos)) return(NA_character_)
  countries <- c("Argentina", "Austria", "Belgium", "Colombia", "Croatia",
                 "Egypt", "France", "Germany", "India", "Martinique",
                 "Reunion Islands", "Italy", "Mexico", "Holland", "Peru",
                 "Poland", "Portugal", "Spain", "Switzerland", "Venezuela")
  positions <- map_int(countries, ~ {
    p <- str_locate(page_text, fixed(.x))[1, "start"]
    if (is.na(p)) 0L else as.integer(p)
  })
  valid <- positions > 0 & positions < city_pos
  if (!any(valid)) return(NA_character_)
  result <- countries[valid][which.max(positions[valid])]
  if (result == "Holland") "Netherlands" else result
}

euch_acutis <- euch_acutis_entries |>
  mutate(
    country = map_chr(text, ~ assign_country(.x, page_text)),
    category = "Eucharistic Miracle",
    place = paste0(city, ", ", country),
    details = paste0("Listed in Carlo Acutis Exhibition catalog"),
    approval_status = "Approved",
    source_reference = "miracolieucaristici.org (Carlo Acutis Exhibition)"
  ) |>
  filter(!is.na(country))

cat(sprintf("  Eucharistic miracles (miracolieucaristici.org): %d rows\n", nrow(euch_acutis)))

# =============================================================================
# 5. STIGMATA — miraclehunter.com
# =============================================================================

cat("--- [5/7] Scraping Stigmata from miraclehunter.com ---\n")

stig_raw <- scrape_mh_pages(
  "https://www.miraclehunter.com/stigmata/",
  c("1200-1300.html", "1300-1400.html", "1400-1500.html", "1500-1600.html",
    "1600-1700.html", "1700-1800.html", "1800-1900.html", "1900-2000.html")
)

# Stigmata tables may have 3 or 4+ columns; normalize
if (nrow(stig_raw) > 0) {
  # Find the data columns — typically first few are Date, Place, People, Approval
  stig <- stig_raw |>
    select(year_raw = 1, place = 2, details = 3, source_page) |>
    filter(nchar(place) > 1, !str_detect(year_raw, "^Date$|^$")) |>
    mutate(
      category = "Stigmata",
      year = as.integer(str_extract(year_raw, "\\d{1,4}")),
      approval_status = NA_character_,
      source_reference = "miraclehunter.com"
    ) |>
    filter(!is.na(year))
} else {
  stig <- tibble()
}

cat(sprintf("  Stigmata: %d rows\n", nrow(stig)))

# =============================================================================
# 6. INCORRUPTIBLES — miraclehunter.com
# =============================================================================

cat("--- [6/7] Scraping Incorruptibles from miraclehunter.com ---\n")

inc_raw <- scrape_mh_pages(
  "https://www.miraclehunter.com/incorruptibles/",
  c("177-1000.html", "1000-1100.html", "1100-1200.html", "1200-1300.html",
    "1300-1400.html", "1400-1500.html", "1500-1600.html", "1600-1700.html",
    "1700-1800.html", "1800-1900.html", "1900-2000.html")
)

if (nrow(inc_raw) > 0) {
  # Incorruptibles have: Name, Dates, Location, Exhibition, Status (5 cols + source_page)
  inc <- inc_raw |>
    select(person = 1, dates = 2, place = 3, source_page) |>
    filter(nchar(person) > 1, !str_detect(person, "^Incorruptible$|^$")) |>
    mutate(
      category = "Incorrupt Body",
      # Extract death year from dates (format: "YYYY-YYYY" or "Unknown-YYYY")
      year = as.integer(str_extract(dates, "\\d{3,4}$")),
      details = person,
      approval_status = "Approved",
      source_reference = "miraclehunter.com"
    ) |>
    filter(!is.na(year))
} else {
  inc <- tibble()
}

cat(sprintf("  Incorruptibles: %d rows\n", nrow(inc)))

# =============================================================================
# 7. LOURDES HEALING CURES — lourdes-france.com
# =============================================================================

# =============================================================================
# 7. MIRACULOUS IMAGES — miraclehunter.com
# =============================================================================

cat("--- [7/8] Scraping Miraculous Images from miraclehunter.com ---\n")

img_raw <- scrape_mh_pages(
  "https://www.miraclehunter.com/miraculous_images/",
  c("icons_0040-0999.html", "icons_1000-1099.html", "icons_1100-1199.html",
    "icons_1200-1299.html", "icons_1300-1399.html", "icons_1400-1499.html",
    "icons_1500-1599.html", "icons_1600-1699.html", "icons_1700-1799.html",
    "icons_1800-1899.html")
)

if (nrow(img_raw) > 0) {
  img <- img_raw |>
    select(year_raw = 1, place = 2, details = 3, source_page) |>
    filter(nchar(place) > 1) |>
    mutate(
      category = "Miraculous Image",
      year = as.integer(str_extract(year_raw, "\\d{1,4}")),
      approval_status = NA_character_,
      source_reference = "miraclehunter.com"
    ) |>
    filter(!is.na(year))
} else {
  img <- tibble()
}

cat(sprintf("  Miraculous Images: %d rows\n", nrow(img)))

# =============================================================================
# 8. LOURDES HEALING CURES — lourdes-france.com
# =============================================================================

cat("--- [8/8] Scraping Lourdes cures from lourdes-france.com ---\n")

lourdes_page <- read_html("https://www.lourdes-france.com/en/miraculous-healings/")
lourdes_text <- lourdes_page |> html_text2()

list_start <- str_locate(lourdes_text, "miraculous by the Church at this time")[1, "end"]
list_section <- str_sub(lourdes_text, list_start + 1)

# Split into individual entries by looking for "from ... (Country)" patterns
# Each entry starts with a name and contains "from City (Country)"
entry_pattern <- "([A-Z][A-Za-z .()'-]+?)\\s+from\\s+([A-Za-z .'-]+)\\s*\\(([A-Za-z]+)\\)[^A-Z]*?(?:Date of recognition\\s*:?\\s*)?.*?(\\d{4})"
matches <- str_match_all(list_section, entry_pattern)[[1]]

lourdes_parsed <- tibble(
  person = str_trim(matches[, 2]),
  city = str_trim(matches[, 3]),
  country = str_trim(matches[, 4]),
  year_recognized = as.integer(matches[, 5])
) |>
  filter(!is.na(person), person != "", !is.na(year_recognized))

lourdes <- lourdes_parsed |>
  mutate(
    category = "Lourdes Healing",
    year = case_when(year_recognized == 1862 ~ 1858L, TRUE ~ year_recognized),
    place = paste0(city, ", ", country),
    details = paste0(person, "; recognized ", year_recognized),
    approval_status = "Approved (medically inexplicable)",
    source_reference = "lourdes-france.com"
  )

cat(sprintf("  Lourdes cures: %d rows\n", nrow(lourdes)))

# =============================================================================
# COMBINE ALL INTO FINAL DATASET
# =============================================================================

cat("\n--- Combining all sources ---\n")

# Standardize columns across all sources
standardize <- function(df, cat_name) {
  df |>
    transmute(
      category = category,
      year = as.integer(year),
      place = place,
      details = details,
      approval_status = approval_status,
      source_reference = source_reference
    )
}

combined <- bind_rows(
  standardize(marian_all, "Marian Apparition"),
  standardize(euch_mh, "Eucharistic Miracle") |> mutate(source_reference = "miraclehunter.com"),
  standardize(euch_acutis |> rename(details = details), "Eucharistic Miracle"),
  standardize(stig, "Stigmata"),
  standardize(inc, "Incorrupt Body"),
  standardize(img, "Miraculous Image"),
  standardize(lourdes, "Lourdes Healing")
)

# Deduplicate Eucharistic miracles (some appear in both miraclehunter + acutis)
combined <- combined |>
  mutate(dedup_key = paste(category, year, str_to_lower(str_extract(place, "^[^,]+")))) |>
  distinct(dedup_key, .keep_all = TRUE) |>
  select(-dedup_key)

# =============================================================================
# PARSE STRUCTURED FIELDS FROM RAW DATA
# =============================================================================

cat("--- Parsing structured fields ---\n")

combined <- combined |>
  mutate(
    # --- Country: extract from "(Country)" in place ---
    country = str_extract(place, "(?<=\\()[A-Za-z .]+(?=\\))"),
    # Fallback: check if place contains a known country name after comma
    country = case_when(
      !is.na(country) ~ country,
      str_detect(place, ",\\s*(Italy|France|Spain|Germany|Belgium|Poland|Portugal|India|Egypt|Algeria|Mexico|Austria|Ireland|Brazil|Netherlands|Switzerland|Croatia|Lebanon|England|Scotland|United States|USA|Philippines|Japan|Argentina|Colombia|Peru|Venezuela|Hungary|Czech Republic|Ukraine|Russia|Greece|Turkey|Syria|Rwanda|Ecuador|Bosnia|Chile|Senegal|Canada|Australia)") ~
        str_extract(place, "(Italy|France|Spain|Germany|Belgium|Poland|Portugal|India|Egypt|Algeria|Mexico|Austria|Ireland|Brazil|Netherlands|Switzerland|Croatia|Lebanon|England|Scotland|United States|USA|Philippines|Japan|Argentina|Colombia|Peru|Venezuela|Hungary|Czech Republic|Ukraine|Russia|Greece|Turkey|Syria|Rwanda|Ecuador|Bosnia|Chile|Senegal|Canada|Australia)$"),
      place %in% c("Italy", "France", "Spain", "Germany", "Belgium",
                   "Poland", "Portugal", "India", "Egypt", "Algeria",
                   "Constantinople", "Alexandria") ~ place,
      TRUE ~ NA_character_
    ),

    # --- City: text before "(Country)" or before "," ---
    city = case_when(
      str_detect(place, "\\(") ~ str_trim(str_extract(place, "^[^(]+")),
      str_detect(place, ",") ~ str_trim(str_extract(place, "^[^,]+")),
      TRUE ~ place
    ),

    # --- Person involved: parse from details ---
    person_involved = case_when(
      # Marian/Images: "Visionary: Name" or "Visionaries: Names"
      str_detect(details, "(?i)^Visionar") ~
        str_trim(str_remove(
          str_extract(details, "(?i)Visionar[yies]+:\\s*[A-Za-z .,'-]+"),
          "(?i)Visionar[yies]+:\\s*"
        )),
      # Stigmata/Incorrupt: name is the details (e.g., "St. Francis (1182-1226)")
      category %in% c("Stigmata", "Incorrupt Body") ~
        str_trim(str_extract(details, "^[A-Za-z .']+")),
      # Lourdes: "NAME; recognized YYYY"
      category == "Lourdes Healing" ~
        str_extract(details, "^[^;]+"),
      TRUE ~ NA_character_
    ),
    # Clean: remove trailing "Title" artifact from person names
    person_involved = str_remove(person_involved, "Title$"),
    person_involved = str_trim(person_involved),
    person_involved = str_trim(str_remove(person_involved, "\\s*\\(.*")),

    # --- Title (for Marian/Images): "Title: ..." ---
    title = case_when(
      str_detect(details, "Title:") ~
        str_trim(str_remove(str_extract(details, "Title:\\s*[A-Za-z .'(),0-9-]+"), "Title:\\s*")),
      TRUE ~ NA_character_
    ),

    # --- Century (derived) ---
    century = floor(year / 100) + 1L,

    # --- Clean country names ---
    country = str_to_title(country),
    country = case_when(
      country %in% c("Usa", "U.s.a.", "U.s.a") ~ "United States",
      country == "Uk" ~ "United Kingdom",
      TRUE ~ country
    )
  )

# Add event IDs
combined <- combined |>
  mutate(event_id = paste0(
    case_when(
      category == "Marian Apparition" ~ "MAR",
      category == "Eucharistic Miracle" ~ "EUC",
      category == "Stigmata" ~ "STG",
      category == "Incorrupt Body" ~ "INC",
      category == "Miraculous Image" ~ "IMG",
      category == "Lourdes Healing" ~ "LOU",
      TRUE ~ "OTH"
    ), "_", str_pad(row_number(), 4, pad = "0")
  )) |>
  select(event_id, category, year, century, city, country, person_involved,
         title, details, approval_status, source_reference)

# =============================================================================
# SUMMARY
# =============================================================================

cat(sprintf("\n=== Catholic Miracles Dataset ===\n"))
cat(sprintf("Total observations: %d\n", nrow(combined)))
cat(sprintf("\nBy category:\n"))
combined |> count(category, sort = TRUE) |> print(n = Inf)
cat(sprintf("\nBy source:\n"))
combined |> count(source_reference, sort = TRUE) |> print(n = Inf)
cat(sprintf("\nYear range: %d to %d\n",
            min(combined$year, na.rm = TRUE),
            max(combined$year, na.rm = TRUE)))

# Save
catholic_miracles <- combined
write_csv(catholic_miracles, "other/catholic_miracles/catholic_miracles.csv")
cat("\nDataset saved to other/catholic_miracles/catholic_miracles.csv\n")
