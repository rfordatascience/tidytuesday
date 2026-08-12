# Philippine PCSO historical draw results, independently compiled by
# LottoLens PH and released as a fixed CC BY 4.0 snapshot.
# https://remo65588-boop.github.io/lottolens-ph-public-data/

library(readr)
library(dplyr)

dataset_url <- paste0(
  "https://remo65588-boop.github.io/lottolens-ph-public-data/",
  "data/verified-pcso-draw-results-snapshot.csv"
)

pcso_draws <- read_csv(
  dataset_url,
  col_types = cols(.default = col_character()),
  na = ""
) |>
  mutate(
    draw_date = as.Date(draw_date),
    jackpot_amount = parse_double(jackpot_amount)
  )

# The fixed v2.0.1 snapshot has one row per game/date/time draw record.
stopifnot(nrow(pcso_draws) == 13457)
stopifnot(n_distinct(pcso_draws$lottery_slug) == 9)
stopifnot(
  nrow(pcso_draws) ==
    n_distinct(pcso_draws$lottery_slug, pcso_draws$draw_date, pcso_draws$draw_time)
)
stopifnot(all(!is.na(pcso_draws$winning_numbers)))
stopifnot(all(!is.na(pcso_draws$source_url)))

