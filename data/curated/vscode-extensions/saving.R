# Run this
source("data/curated/curation_scripts.R")

# Fill in the name of the folder you created in "curated", then run this.
dir_name <- "vscode-extensions"

# Run this for each of your datasets.
ttsave(vsx_extensions, dir_name = dir_name)
ttsave(vsx_publishers, dir_name = dir_name)
