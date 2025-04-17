# data/curated/wa-cannabis/cleaning.R

library(readr)
library(tidyverse)
library(lubridate)

# Load dataset from your GitHub raw link
dataset_url <- "https://raw.githubusercontent.com/Ensign-Analytics/tidytuesday-wa-cannabis/main/wa_cannabis_sample.csv"

wa_cannabis_sample <- readr::read_csv(dataset_url)