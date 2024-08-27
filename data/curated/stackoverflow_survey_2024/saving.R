# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of your directory, then run this.
dir_name <- "stackoverflow_survey_2024"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(stackoverflow_survey_single_response, dir_name = dir_name)
ttsave(qname_levels_single_response_crosswalk, dir_name = dir_name)
