library(tidyverse)
library(httr2)

# Sofas and armchairs listed on ikea.com in every market, from the
# undocumented API behind IKEA's own category pages. Downloaded 2026-09-28.
locales <- c(
  "ae/ar", "ae/en", "at/de", "at/en", "au/en", "be/en", "be/fr", "be/nl",
  "bh/ar", "bh/en", "ca/en", "ca/fr", "ch/de", "ch/en", "ch/fr", "ch/it",
  "cl/es", "co/es", "cz/cs", "cz/en", "de/de", "de/en", "dk/da", "ee/en",
  "ee/et", "ee/ru", "eg/ar", "eg/en", "es/ca", "es/en", "es/es", "es/eu",
  "es/gl", "fi/en", "fi/fi", "fi/sv", "fr/fr", "gb/en", "hr/hr", "hu/hu",
  "ie/en", "il/he", "in/en", "it/it", "jo/ar", "jo/en", "jp/en", "jp/ja",
  "kr/en", "kr/ko", "kw/ar", "kw/en", "lt/en", "lt/lt", "lt/ru", "lv/en",
  "lv/lv", "lv/ru", "ma/ar", "ma/en", "ma/fr", "mx/en", "mx/es", "my/en",
  "my/ms", "nl/en", "nl/nl", "no/en", "no/no", "nz/en", "om/ar", "om/en",
  "ph/en", "pl/pl", "pt/en", "pt/pt", "qa/ar", "qa/en", "ro/ro", "rs/sr",
  "sa/ar", "sa/en", "se/en", "se/sv", "sg/en", "si/sl", "sk/sk", "th/en",
  "th/th", "ua/uk", "us/en", "us/es"
)

# One locale per country, English where the market offers it
markets <- tibble(locale = locales) |>
  separate_wider_delim(locale, "/", names = c("country", "language")) |>
  arrange(country, language != "en") |>
  slice_head(n = 1, by = country)

fetch_listing <- function(country, language, category) {
  Sys.sleep(0.3)
  request("https://sik.search.blue.cdtapps.com") |>
    req_url_path_append(country, language, "product-list-page") |>
    req_url_query(category = category, size = 500, sort = "RELEVANCE") |>
    req_retry(max_tries = 3) |>
    req_perform() |>
    resp_body_json() |>
    pluck("productListPage", "productWindow") |>
    map(\(p) {
      tibble(
        product_name = p$name,
        product_type = p$typeName %||% NA_character_,
        item_no = p$itemNoGlobal,
        price = p$salesPrice$numeral %||% NA_real_,
        currency = p$salesPrice$currencyCode %||% NA_character_,
        variants = p$gprDescription$numberOfVariants %||% NA_integer_,
        url = p$pipUrl
      )
    }) |>
    list_rbind()
}

ikea_seating <- markets |>
  cross_join(tibble(
    category_id = c("fu003", "fu006"),
    category = c("sofas", "armchairs")
  )) |>
  mutate(
    listing = pmap(
      list(country, language, category_id),
      fetch_listing,
      .progress = TRUE
    )
  ) |>
  select(-category_id) |>
  unnest(listing) |>
  mutate(
    # Japanese listings add a transliteration ("VIMLE ヴィムレ"), and
    # anniversary editions a year ("STOCKHOLM 2025")
    product_name = product_name |>
      str_remove("\\s+[^\\p{Latin}\\d\\s/].*$") |>
      str_squish(),
    # Sets ("HOLMSTA / FRÖKNABO", "LYCKSELE LÖVÅS") go by their first name;
    # the IKEA PS range names no place
    name = product_name |>
      str_extract("^\\S+") |>
      str_to_upper() |>
      na_if("IKEA"),
    variants = as.integer(variants)
  ) |>
  relocate(name, .after = product_name)

# Prices in US dollars at the exchange rates of the download date, from the
# fawazahmed0 currency API (github.com/fawazahmed0/exchange-api)
usd_rates <- request(
  "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@2026-09-28/v1/currencies/usd.json"
) |>
  req_perform() |>
  resp_body_json() |>
  pluck("usd") |>
  unlist() |>
  enframe(name = "currency", value = "per_usd") |>
  mutate(currency = str_to_upper(currency))

ikea_seating <- ikea_seating |>
  left_join(usd_rates, by = "currency") |>
  mutate(price_usd = round(price / per_usd, 2), .after = price) |>
  select(-per_usd)

# Swedish places each product name could come from, geocoded with
# OpenStreetMap's Nominatim at its limit of one request a second. A match must
# carry exactly the product name and be a place-like feature (not a road, shop
# or building), keeping one per municipality.
place_classes <- c(
  "place", "boundary", "natural", "water", "waterway", "landuse", "historic"
)

geocode_name <- function(name) {
  Sys.sleep(1.1)
  request("https://nominatim.openstreetmap.org/search") |>
    req_url_query(
      q = str_to_title(name),
      countrycodes = "se",
      format = "json",
      addressdetails = 1,
      limit = 5
    ) |>
    req_user_agent("tidytuesday ikea_place_names (github.com/gkaramanis)") |>
    req_perform() |>
    resp_body_json() |>
    map(\(r) {
      tibble(
        place = r$name,
        municipality = r$address$municipality %||% r$address$city %||%
          NA_character_,
        county = r$address$county %||% NA_character_,
        osm_class = r$class,
        place_type = r$type,
        latitude = as.numeric(r$lat),
        longitude = as.numeric(r$lon),
        osm_id = str_c(r$osm_type, "/", r$osm_id)
      )
    }) |>
    list_rbind()
}

# Product names that are words, not places: a point, a ball game, two birds
not_places <- c(
  "POÄNG", "BRÄNNBOLL", "BJÖRKTRAST", "SMÅSKRAKE", "BROBOCK", "STRANDMON"
)

geocoded <- ikea_seating |>
  distinct(name) |>
  drop_na() |>
  filter(!name %in% not_places) |>
  mutate(results = map(name, geocode_name, .progress = TRUE)) |>
  unnest(results)

# Places OpenStreetMap lacks or names differently, located by hand
hand_placed <- tribble(
  ~name, ~place, ~municipality, ~county, ~place_type, ~latitude, ~longitude,
  "LILLESÄTER", "Lillesäter", "Färgelanda kommun", "Västra Götalands län",
    "hamlet", 58.6, 12.033333,
  "ESSEBODA", "Södra Esseboda", "Osby kommun", "Skåne län",
    "hamlet", 56.3602234, 14.3820932,
  "SOTENÄS", "Sotenäs", "Sotenäs kommun", "Västra Götalands län",
    "municipality", 58.416667, 11.333333
)

ikea_places <- geocoded |>
  filter(
    osm_class %in% place_classes,
    str_to_lower(place) == str_to_lower(name),
    # City blocks are too weak a match to count
    place_type != "city_block"
  ) |>
  distinct(name, municipality, .keep_all = TRUE) |>
  select(-osm_class) |>
  filter(!name %in% hand_placed$name) |>
  bind_rows(hand_placed) |>
  arrange(name, municipality)

