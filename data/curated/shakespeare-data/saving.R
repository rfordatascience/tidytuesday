# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of your directory, then run this.
dir_name <- "shakespeare-data"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(hamlet, dir_name = dir_name)
ttsave(romeo_juliet, dir_name = dir_name)
ttsave(macbeth, dir_name = dir_name)
