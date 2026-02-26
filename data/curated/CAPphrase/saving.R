# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "CAPphrase"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(absolute_judgements, dir_name = dir_name)
ttsave(pairwise_comparisons, dir_name = dir_name)
ttsave(respondent_metadata, dir_name = dir_name)
