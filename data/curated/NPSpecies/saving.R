# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of your directory, then run this.
dir_name <- "NPSpecies"

# top parks df
ttsave(most_visited_nps_species_data, dir_name = dir_name)
