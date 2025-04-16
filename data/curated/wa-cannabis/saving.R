# data/curated/wa-cannabis/saving.R

# Load the local ttsave helper
source("data/curated/wa-cannabis/save_utils.R")

# Define directory
dir_name <- "wa-cannabis"

# Save the loaded dataset
ttsave(wa_cannabis_sample, dir = dir_name)
