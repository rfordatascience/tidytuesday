# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "stat-performance-data"

# Run this for each of your datasets, replacing YOUR_DATASET_DF with the name of
# a data.frame from cleaning.R.
ttsave(spi_indicators, dir_name = dir_name)
