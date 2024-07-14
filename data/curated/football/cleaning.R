# Clean data provided by the [English Womens Football (EWF)
# Database](https://github.com/probjects/ewf-database). No cleaning was
# necessary, but the files were resaved to simplify the csvs.
ewf_appearances <- readr::read_csv(
  "https://raw.githubusercontent.com/probjects/ewf-database/main/data/ewf_appearances.csv"
)
ewf_matches <- readr::read_csv(
  "https://raw.githubusercontent.com/probjects/ewf-database/main/data/ewf_matches.csv"
)
ewf_standings <- readr::read_csv(
  "https://raw.githubusercontent.com/probjects/ewf-database/main/data/ewf_standings.csv"
)
