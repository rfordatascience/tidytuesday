# Run this
source("data/curated/power_rangers/cleaning.R")

# Fill in the name of your directory, then run this.
dir_name <- "power_rangers"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(power_rangers_seasons, dir_name = dir_name)
ttsave(power_rangers_episodes, dir_name = dir_name)
