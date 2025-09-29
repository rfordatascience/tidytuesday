# Download the full CSV from the bottom of
# https://www.hornborga.com/naturen/transtatistik/ as "Transtatistik.csv".
#
# Cleaning code extracts comments in English, adds a variable related to weather
# disruption, selects relevant columns and filters the data to include only 30
# years (1994-2024).

# Read CSV (update path as needed)
csv_path <- "Transtatistik.csv"
cranes <- readr::read_csv(csv_path)

# Extract information from comments (relevant labels into English)
cranes <- cranes |>
  dplyr::mutate(
    comment = dplyr::case_when(
      stringr::str_detect(
        Anteckning,
        "[Ii]nga siffror|[Ii]ngen siffra|[Ii]ngen räkn|[Ii]nst[.ä]|[Ii]nat"
        # no numbers, no number, no count, cancelled, innumerable
      ) ~
        "Canceled/No count",
      stringr::str_detect(Anteckning, "[Ss]vårräkn|[Oo]säk") ~
        "Uncertain count",
      stringr::str_detect(Anteckning, "[Rr]ekord") ~ "Record observation",
      stringr::str_detect(Anteckning, "[Ff]örsta") ~ "First count of season",
      stringr::str_detect(Anteckning, "[Ss]ista|[Aa]vslut") ~
        "Last count of season",
      stringr::str_detect(Anteckning, "[Dd]åligt [Vv]äder") ~ "Bad weather",
      stringr::str_detect(Anteckning, "[Kk]raftig [Ss]törning") ~
        "Severe interference"
    )
  ) |>
  # Extract weather-related disruptions from comments into logical column
  dplyr::mutate(
    weather_disruption = dplyr::case_when(
      stringr::str_detect(
        Anteckning,
        "[Rr]egn|[Vv]äd|[Ss]nö|[Dd]imma|[Åå]ska"
        # rain, weather, snow, fog, thunder
      ) ~
        TRUE,
      .default = FALSE
    )
  ) |>
  # Rename to English lowercase
  dplyr::rename(date = Datum, observations = Antal) |>
  # Select relevant columns
  dplyr::select(date, observations, comment, weather_disruption) |>
  # Filter to dates before 2025 (to get 30-year anniversary data, 1994—2024)
  dplyr::filter(date < "2025-01-01")
