source("data/curated/curation_scripts.R")
dir_name <- "football"

ewf_appearances <- readr::read_csv(
  here::here("data", "curated", dir_name, "ewf_appearances.csv")
)
ewf_matches <- readr::read_csv(
  here::here("data", "curated", dir_name, "ewf_matches.csv")
)
ewf_standings <- readr::read_csv(
  here::here("data", "curated", dir_name, "ewf_standings.csv")
)

# Call this for each clean dataset.
ttsave(ewf_appearances, dir_name = dir_name)
ttsave(ewf_matches, dir_name = dir_name)
ttsave(ewf_standings, dir_name = dir_name)
