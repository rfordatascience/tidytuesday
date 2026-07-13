library(tidyverse)

# Wildlife-vehicle collisions in Sweden reported to the National Wildlife
# Accident Council (Nationella viltolycksrådet), 2024-07-01 to 2026-06-30.
# Raw data exported manually from the council's statistics portal:
# https://statistik.viltolycka.se/statistik/excelrapport/
# (raw data / "Rådata" report for the period 2024-07-01 to 2026-07-01).
# The export is latin-1 encoded, ";"-separated, and uses decimal commas.
raw <- read_delim(
  "Rådata 2024-07-01 - 2026-07-01.csv",
  delim = ";",
  locale = locale(encoding = "latin1"),
  col_types = cols(.default = col_character())
)

# translate via named vector, leaving unmatched values untouched
tr <- function(x, map) coalesce(unname(map[x]), x)

species_en <- c(
  "Rådjur" = "Roe deer", "Vildsvin" = "Wild boar", "Älg" = "Moose",
  "Dovhjort" = "Fallow deer", "Kronhjort" = "Red deer",
  "Övriga djur" = "Other animals", "Utter" = "Otter", "Örn" = "Eagle",
  "Lo" = "Lynx", "Varg" = "Wolf", "Björn" = "Bear",
  "Mufflonfår" = "Mouflon", "Järv" = "Wolverine"
)

accident_type_en <- c("Väg" = "Road", "Järnväg" = "Railway")

sex_en <- c("Hondjur" = "Female", "Handjur" = "Male", "Okänt" = "Unknown")

yes_no_en <- c("Ja" = "Yes", "Nej" = "No", "Okänt" = "Unknown")

outcome_en <- c(
  "Dött på olycksplatsen"       = "Died at the scene",
  "Bedöms oskadat"              = "Assessed uninjured",
  "Avlivat"                     = "Euthanised",
  "Ej påträffat"                = "Not found",
  "Påträffat dött"              = "Found dead",
  "Bedöms skadat ej påträffats" = "Assessed injured, not found",
  "Olycksplats ej påträffad"    = "Accident site not found"
)

wildlife_accidents <- raw |>
  select(
    accident_id   = "OlycksID",
    accident_type = "Typ av olycka",
    datetime      = "Datum",
    county        = "Län",
    municipality  = "Kommun",
    species       = "Viltslag",
    lat           = "Lat WGS84",
    long          = "Long WGS84",
    lat_rt90      = "Lat RT90",
    long_rt90     = "Long RT90",
    sex           = "Kön",
    juvenile      = "Årsunge",
    outcome       = "Vad har skett med viltet"
  ) |>
  mutate(
    accident_id = as.integer(accident_id),
    datetime    = ymd_hm(datetime),
    # keep WGS84 coordinates exactly as recorded, decimal comma -> dot
    # (a numeric round trip prints float noise like 12.577819999999999);
    # a literal "0" means the coordinate is missing
    across(c(lat, long), \(x) if_else(x == "0", NA, str_replace(x, ",", "."))),
    across(c(lat_rt90, long_rt90), as.numeric),
    municipality  = str_squish(municipality),
    # "<Name>[s] län" -> "<Name> County", dropping the genitive -s
    county        = str_replace(county, "s? län$", " County"),
    accident_type = tr(accident_type, accident_type_en),
    species       = tr(species, species_en),
    sex           = tr(sex, sex_en),
    juvenile      = tr(juvenile, yes_no_en),
    outcome       = tr(outcome, outcome_en)
  )

# Rows with missing WGS84 coordinates carry valid RT90 2.5 gon V (EPSG:3021)
# coordinates; rebuild both lat and long from RT90 so the pair stays consistent.
wgs84 <- sf::sf_project(
  "EPSG:3021", "EPSG:4326",
  cbind(wildlife_accidents$long_rt90, wildlife_accidents$lat_rt90)
)

wildlife_accidents <- wildlife_accidents |>
  mutate(
    from_rt90 = is.na(lat) | is.na(long),
    long      = if_else(from_rt90, sprintf("%.5f", wgs84[, 1]), long),
    lat       = if_else(from_rt90, sprintf("%.5f", wgs84[, 2]), lat)
  ) |>
  select(-from_rt90, -lat_rt90, -long_rt90)

stopifnot(
  !anyNA(wildlife_accidents$datetime),
  !anyNA(wildlife_accidents$lat),
  all(between(as.numeric(wildlife_accidents$lat), 55, 70)),
  all(between(as.numeric(wildlife_accidents$long), 10, 25))
)
