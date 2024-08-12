source("data/curated/enmoma/cleaning.R")

# like this?
dir_name <- "data/curated/enmoma/english-monarchs-and-marriages.csv"

# ??ttsave ?? 
# how do I use ttsave, tried looking around tidytuesdayR::: ? 
# ttsave(df, dir_name = dir_name)
readr::write_csv(df, dir_name)
