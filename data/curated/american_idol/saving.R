source("../curation_scripts.R")
dir_name <- "american_idol"


# Call this for each clean dataset.
ttsave(auditions, dir_name = dir_name)
ttsave(eliminations, dir_name = dir_name)
ttsave(finalists, dir_name = dir_name)
ttsave(ratings, dir_name = dir_name)
ttsave(seasons, dir_name = dir_name)
ttsave(songs, dir_name = dir_name)

