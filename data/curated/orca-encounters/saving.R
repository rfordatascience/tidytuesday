# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of your directory, then run this.
dir_name <- "orca-encounters"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(orcas, dir_name = dir_name)
