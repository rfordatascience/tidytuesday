# IKEA Sofas and Their Swedish Places

This week's data is IKEA sofas and armchairs and the Swedish places they are named after. Ingvar Kamprad, IKEA's founder, had dyslexia and found names easier to remember than number codes. Since December 2020, new products get Swedish names only, and sofas and armchairs are named after places in Sweden. KLIPPAN is a town in Skåne and EKTORP a suburb of Stockholm, but many are hamlets of a few houses. 

One table lists every sofa and armchair on ikea.com in 50 countries on 28 September 2026, with prices in local currency and US dollars. The other has the places in Sweden that share each name, from OpenStreetMap.

Sources: product listings from ikea.com; places from OpenStreetMap via Nominatim, © OpenStreetMap contributors (ODbL); exchange rates from the fawazahmed0 currency API (CC0).

- Where in Sweden do the names come from? Do they cluster anywhere, for example around Älmhult in Småland, where IKEA started?
- Which names are sold in the most countries, and which only in a few?
- How does the price of the same product (`item_no`) differ between countries in US dollars (`price_usd`)?
- What kinds of places are they: villages, single farms, lakes, islets?

Thank you to [Georgios Karamanis](https://github.com/gkaramanis) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-10-27')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 43)

ikea_places <- tuesdata$ikea_places
ikea_seating <- tuesdata$ikea_seating

# Option 2: Read directly from GitHub

ikea_places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_places.csv')
ikea_seating <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_seating.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-10-27')

# Option 2: Read directly from GitHub and assign to an object

ikea_places = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_places.csv')
ikea_seating = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_seating.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-10-27")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

ikea_places = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_places.csv")
ikea_seating = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_seating.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
ikea_places = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_places.csv", DataFrame)
ikea_seating = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-10-27/ikea_seating.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `ikea_places.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|name         |character |Upper-case product name that matches the place (`EKTORP`), the key for joining to `ikea_seating`. |
|place        |character |Place name as written in OpenStreetMap (`Ektorp`, `Södra Esseboda`). |
|municipality |character |Swedish municipality (kommun) the place lies in (`Nacka kommun`). |
|county       |character |Swedish county (län) the place lies in (`Stockholms län`). |
|place_type   |character |OpenStreetMap feature type (`hamlet`, `village`, `isolated_dwelling`, `lake`, `islet`). |
|latitude     |double    |Latitude in decimal degrees (WGS 84). |
|longitude    |double    |Longitude in decimal degrees (WGS 84). |
|osm_id       |character |OpenStreetMap object (`node/7455615607`), viewable at `openstreetmap.org/<osm_id>`. Missing for the three places located by hand. |

### `ikea_seating.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|country      |character |Two-letter code of the IKEA market, as used in ikea.com addresses (`se`, `us`, `jp`). `gb` is the United Kingdom. |
|language     |character |Language of the listing, English (`en`) wherever the market offers it, otherwise the local language (`fr`, `pl`). |
|category     |character |Category page the product is listed under, `sofas` or `armchairs`. IKEA sometimes files a product outside its type, such as a sofa-bed under `armchairs`. |
|product_name |character |Product name as listed (`EKTORP`, `STOCKHOLM 2025`, `HOLMSTA / FRÖKNABO`), with the Japanese transliteration removed. |
|name         |character |Upper-case first word of the product name (`EKTORP`, `HOLMSTA`), the key for joining to `ikea_places`. Missing for the IKEA PS range. |
|product_type |character |Product description in the listing language (`3-seat sofa`, `Armchair and footstool`, `Fauteuil`). |
|item_no      |character |IKEA article number, shared by the same product in every market (`09509013`). |
|price        |double    |Current price in the local currency. |
|price_usd    |double    |Price converted to US dollars at the exchange rate for 28 September 2026, the download date. |
|currency     |character |ISO 4217 currency code of the price (`SEK`, `EUR`, `USD`). |
|variants     |integer   |Number of other variants of the product, such as different covers or colours. |
|url          |character |Product page on ikea.com. |

## Cleaning Script

```r
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

```
