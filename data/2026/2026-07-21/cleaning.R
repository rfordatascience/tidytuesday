# Near-Death Experience (NDE) data scraped from the NDERF Search site
# Source: https://search.nderf.org/
#
# The Near Death Experience Research Foundation (NDERF) collects firsthand NDE
# accounts submitted online. Their search site embeds structured JSON metadata
# for each experience page. This script extracts that metadata (no narrative
# text is reproduced, respecting NDERF's copyright).
#
# The scrape covers IDs 1–10,100. Only ~6% of IDs contain valid structured data,
# yielding ~589 records spanning 1999–2025.

library(httr2)
library(jsonlite)
library(stringr)
library(tibble)
library(purrr)
library(dplyr)
library(readr)

# --- Scraping function ---
# Each NDERF search page embeds a JSON object in a <script> tag: `var exp = {...}`
# We extract structured fields only (no narrative text).
fetch_nderf_record <- function(id) {
  url <- paste0("https://search.nderf.org/en/exp/", id)

  resp <- tryCatch(
    request(url) |>
      req_retry(max_tries = 3, backoff = ~2) |>
      req_throttle(rate = 3 / 1) |>
      req_perform(),
    error = function(e) NULL
  )
  if (is.null(resp)) return(NULL)

  html <- resp_body_string(resp)

  # Extract JSON from "var exp = {...};" line
  json_match <- str_match(html, 'var exp = (\\{.+?\\});\\s*\\n')
  if (is.na(json_match[1, 2])) return(NULL)

  d <- tryCatch(
    fromJSON(json_match[1, 2], simplifyVector = FALSE),
    error = function(e) NULL
  )
  if (is.null(d)) return(NULL)
  if (is.null(d$GENDER)) return(NULL)

  # All types explicitly enforced to prevent bind_rows mismatches

  tibble(
    entry_id = as.integer(id),
    gender = as.character(d$GENDER %||% NA),
    classification = as.character(paste(d$CLASSIFICATION %||% "NA", collapse = ";")),
    country = as.character(d$COUNTRY_AI %||% NA),
    category = as.character(d$Category %||% NA),
    language = as.character(d$LANGUAGE %||% NA),
    greyson_score = as.integer(d$experiences[[1]]$greyson %||% NA),
    post_date = as.character(d$experiences[[1]]$POSTDATE %||% NA),
    exp_date = as.character(d$experiences[[1]]$EXPDATE %||% NA),
    narrative_length = as.integer(d$EXPLEN %||% NA),
    ai_obe = as.logical(d$ai_categories$OBE_AI %||% NA),
    ai_unity = as.logical(d$ai_categories$UNITY_AI %||% NA),
    ai_hellish = as.logical(d$ai_categories$HELLISH_AI %||% NA),
    ai_clinical = as.logical(d$ai_categories$CLINICAL_AI %||% NA),
    ai_esp = as.logical(d$ai_categories$ESP_AI %||% NA),
    ai_past_lives = as.logical(d$ai_categories$PASTLIVES_AI %||% NA),
    ai_world_future = as.logical(d$ai_categories$WORLDFUTURE_AI %||% NA),
    ai_aliens = as.logical(d$ai_categories$ALIENS_AI %||% NA)
  )
}

# --- Scrape with periodic saves (every 250 IDs) ---
cache_path <- "nde_experiences.csv"

all_ids <- 1:10100
batch_size <- 250

for (batch_start in seq(1, length(all_ids), by = batch_size)) {
  batch_end <- min(batch_start + batch_size - 1, length(all_ids))
  batch_ids <- all_ids[batch_start:batch_end]

  # Skip IDs already scraped

  if (file.exists(cache_path)) {
    existing_ids <- read_csv(cache_path, show_col_types = FALSE)$entry_id
    batch_ids <- setdiff(batch_ids, existing_ids)
  }
  if (length(batch_ids) == 0) next

  batch_results <- map(batch_ids, \(id) {
    tryCatch(fetch_nderf_record(id), error = function(e) NULL)
  })

  valid_results <- compact(batch_results)

  if (length(valid_results) > 0) {
    new_batch_df <- bind_rows(valid_results)

    if (file.exists(cache_path)) {
      existing <- read_csv(cache_path, show_col_types = FALSE) |>
        mutate(post_date = as.character(post_date),
               exp_date = as.character(exp_date))
      combined <- bind_rows(existing, new_batch_df) |>
        distinct(entry_id, .keep_all = TRUE) |>
        arrange(entry_id)
    } else {
      combined <- new_batch_df |> arrange(entry_id)
    }
    write_csv(combined, cache_path)
  }

  total <- if (file.exists(cache_path)) nrow(read_csv(cache_path, show_col_types = FALSE)) else 0
  cat(sprintf("[%s] IDs %d-%d | %d valid | Total: %d\n",
              format(Sys.time(), "%H:%M:%S"),
              min(batch_ids), max(batch_ids),
              length(valid_results), total))
}

# --- Load final dataset ---
nde_experiences <- read_csv(cache_path, show_col_types = FALSE)
cat("\nFinal dataset:", nrow(nde_experiences), "records x", ncol(nde_experiences), "columns\n")

