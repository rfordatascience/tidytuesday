# Clean data provided by @chendaniely. No cleaning was necessary.
dataset_url <- "https://raw.githubusercontent.com/chendaniely/olympics-2026/refs/heads/main/data/final/olympics/olympics_events.csv"
schedule <- readr::read_csv(dataset_url)
