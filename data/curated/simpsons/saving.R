# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "simpsons"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(simpsons_characters, dir_name = dir_name)
ttsave(simpsons_episodes_filter, dir_name = dir_name)
ttsave(simpsons_locations, dir_name = dir_name)
ttsave(simpsons_script_lines_filter, dir_name = dir_name)
