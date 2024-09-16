# Source: Clean data provided by Kaggle Mitchell J.
# https://www.kaggle.com/datasets/datasnaek/chess/data

library(tidyverse)

# Data saved from Kaggle as "chess_game_dataset/chess_games.csv"

chess <- readr::read_csv("chess_game_dataset/chess_games.csv") %>%
  rename("game_id" = "id",
         "start_time" = "created_at",
         "end_time" = "last_move_at",
         "time_increment" = "increment_code")
