# data/curated/wa-cannabis/cleaning.R

library(readr)

# Load dataset from your GitHub raw link
wa_cannabis_sample <- read_csv(
  "https://raw.githubusercontent.com/Ensign-Analytics/tidytuesday-wa-cannabis/main/wa_cannabis_sample.csv"
)
