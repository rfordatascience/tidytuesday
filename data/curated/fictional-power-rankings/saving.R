# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "fictional-power-rankings"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(fiction_rankings, dir_name = dir_name)
ttsave(fiction_citations, dir_name = dir_name)
ttsave(fiction_deaths, dir_name = dir_name)
