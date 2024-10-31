# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "iso-country"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(countries, dir_name = dir_name)
ttsave(country_subdivisions, dir_name = dir_name)
ttsave(former_countries, dir_name = dir_name)
