# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of your directory, then run this.
dir_name <- "monster-movies"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(monster_movies, dir_name = dir_name)
ttsave(monster_movie_genres, dir_name = dir_name)
