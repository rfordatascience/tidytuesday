# Data provided by my (Gregory Vander Vinne's) GitHub. 

# PDFs originally downloaded from 
# https://ir.aboutamazon.com/annual-reports-proxies-and-shareholder-letters/default.aspx

# Code used to turn PDFs into the uncleaned data downloaded below found here 
# https://gregoryvdvinne.github.io/Text-Mining-Amazon-Budgets.html

# Load packages for cleaning
library(arrow)
library(tidytext)
library(tidyverse)

# Download the messy data
url <- "https://raw.githubusercontent.com/GregoryVdvinne/gregoryvdvinne.github.io/main/Amazon_Budgets/Data/Intermediate/all_reports_ocr_uncleaned.feather"  # Replace with actual URL
destfile <- tempfile(fileext = ".feather")  # Temporary file path
download.file(url, destfile, mode = "wb")   # Download file
unclean_data <- read_feather(destfile)  # Read .feather file

# Tokenize into single words
report_words_clean <-  unclean_data |>
  unnest_tokens(
    word, # Name of column of words in new dataframe
    text  # Name of column containing text in original dataframe
  ) |>
  # Remove stop words
  anti_join(stop_words, by = "word") |>
  # Remove some additional 'words'
  filter(!(word %in% c(letters, LETTERS)),  # Single letters
         !str_detect(word, "\\d"),          # Words containing a number
         !str_detect(word, "_"))

