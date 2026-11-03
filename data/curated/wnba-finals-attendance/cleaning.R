# WNBA Finals attendance by game and by series, 2002-2025.
# Compiled by Full Court Buckets by hand from the official WNBA.com box score of
# every WNBA Finals game (each game row links to its record in `source_url`).
# Released under CC0 1.0. The files are hosted on Hugging Face:
# https://huggingface.co/datasets/fullcourtbuckets/wnba-finals-attendance
# No cleaning was necessary; the data are loaded with explicit column types.
# Attendance is NA for the three 2020 bubble games (no fans admitted).

base_url <- "https://huggingface.co/datasets/fullcourtbuckets/wnba-finals-attendance/resolve/main/"

wnba_finals_games <- readr::read_csv(
  paste0(base_url, "wnba-finals-attendance-by-game-2002-2025.csv"),
  col_types = readr::cols(
    season = readr::col_integer(),
    game = readr::col_integer(),
    date = readr::col_date(),
    away = readr::col_character(),
    away_score = readr::col_integer(),
    home = readr::col_character(),
    home_score = readr::col_integer(),
    winner = readr::col_character(),
    margin = readr::col_integer(),
    overtime_periods = readr::col_integer(),
    arena = readr::col_character(),
    attendance = readr::col_integer(),
    source_url = readr::col_character(),
    note = readr::col_character()
  )
)

wnba_finals_series <- readr::read_csv(
  paste0(base_url, "wnba-finals-attendance-2002-2025.csv"),
  col_types = readr::cols(
    year = readr::col_integer(),
    teams = readr::col_character(),
    champion = readr::col_character(),
    runner_up = readr::col_character(),
    series_result = readr::col_character(),
    games = readr::col_integer(),
    games_with_attendance = readr::col_integer(),
    total_attendance = readr::col_integer(),
    avg_per_game = readr::col_integer(),
    max_game_attendance = readr::col_integer(),
    min_game_attendance = readr::col_integer(),
    game_attendance = readr::col_character(),
    overtime_games = readr::col_integer(),
    arenas = readr::col_character(),
    notes = readr::col_character(),
    source_note = readr::col_character()
  )
)

# Image: wnba_finals_avg_attendance.png
library(ggplot2)
all_years <- data.frame(year = 2002:2025)
attendance_plot <- ggplot(
  merge(all_years, wnba_finals_series, all.x = TRUE),
  aes(year, avg_per_game)
) +
  geom_line(colour = "grey60") +
  geom_point(aes(size = games), colour = "#1f4e79", na.rm = TRUE) +
  annotate("text", x = 2020, y = 2500, label = "2020: bubble,\nno fans", size = 3.2, colour = "grey30") +
  scale_y_continuous(labels = scales::comma, limits = c(0, NA)) +
  scale_size_continuous(name = "Games in series", breaks = 2:5, range = c(2, 5)) +
  labs(
    title = "WNBA Finals average attendance per game, 2002-2025",
    subtitle = "Published attendance from official WNBA.com box scores",
    x = "Finals year", y = "Average attendance per game"
  ) +
  theme_minimal(base_size = 12)
