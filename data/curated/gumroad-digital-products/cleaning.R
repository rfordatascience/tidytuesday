# Gumroad digital products — 1,344 products across 42 category searches.
#
# The published collection is one row per LISTING OBSERVATION, not per product: it is
# 42 category searches, and a product that ranks for three of them appears three times.
# So the cleaning splits it into two tables — a product table and a product-to-category
# table — which is both the tidy shape and the interesting thing about the data.

library(dplyr)
library(readr)
library(stringr)

raw <- read_csv(
  paste0(
    "https://raw.githubusercontent.com/sujeito-operator/gumroad-market-data/",
    "main/data/gumroad-latest.csv"
  ),
  show_col_types = FALSE
) |>
  mutate(card_text = str_trim(t))

# One id per distinct product, numbered in order of first appearance. The dedup key is
# the exact card text; the source repo documents that a normalised key (rating widget
# and price tokens stripped) yields the same 1,344, so this is not merging distinct
# products.
product_ids <- raw |>
  distinct(card_text) |>
  mutate(product_id = row_number())

gumroad_categories <- raw |>
  left_join(product_ids, by = "card_text") |>
  select(product_id, category = q)

gumroad_products <- raw |>
  left_join(product_ids, by = "card_text") |>
  distinct(product_id, .keep_all = TRUE) |>
  transmute(
    product_id,
    currency = cur,
    price_local = price,
    price_usd,
    is_free = price_usd == 0,
    is_recurring = recurring,
    # Gumroad renders the rating widget inside the card text as "4.9 (1.3K)".
    rating_score = as.numeric(
      str_match(card_text, "(\\d\\.\\d)\\s*\\(\\d+(?:\\.\\d+)?K?\\)")[, 2]
    ),
    # Use `n`, the parsed numeric count, NOT `nrat` — that column holds abbreviations
    # like "3.3K", and coercing it naively zeroes the most-rated products in the file.
    n_ratings = as.integer(n),
    is_rated = n > 0,
    top_creator = str_detect(card_text, fixed("Top creator")),
    card_text
  )
