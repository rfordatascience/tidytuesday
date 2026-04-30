# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "crossref-state-of-metadata"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(metadata_coverage_stats_by_country, dir_name = dir_name)
ttsave(member_participation_stats_by_country, dir_name = dir_name)