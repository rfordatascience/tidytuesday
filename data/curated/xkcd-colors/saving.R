# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "xkcd-colors"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(color_ranks, dir_name = dir_name)
ttsave(answers, dir_name = dir_name)
ttsave(users, dir_name = dir_name)
