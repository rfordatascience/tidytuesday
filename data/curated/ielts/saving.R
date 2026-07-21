# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "ielts"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(demo_by_reasons, dir_name = dir_name)
ttsave(demo_by_first_language, dir_name = dir_name)
ttsave(demo_by_nationality, dir_name = dir_name)
ttsave(performance_by_nationality, dir_name = dir_name)
ttsave(performance_by_first_language, dir_name = dir_name)
