library(tidyverse)
# source for seasons
"https://www.kaggle.com/datasets/karetnikovn/power-rangers-dataset/data"

# Source for episodes
"https://www.kaggle.com/datasets/karetnikovn/power-rangers-dataset/data"

power_rangers_seasons <- readr::read_csv("data/curated/power_rangers/seasons.csv")

power_rangers_episodes <- readr::read_csv("data/curated/power_rangers/episodes.csv") %>%
  mutate(air_date = mdy(air_date))
