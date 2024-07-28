source("data/curated/curation_scripts.R")
dir_name <- "summer"

# Call this for each clean dataset.
ttsave(summer_movies, dir_name = dir_name)
ttsave(summer_movie_genres, dir_name = dir_name)
