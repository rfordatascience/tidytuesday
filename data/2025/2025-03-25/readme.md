# Text Data From Amazon's Annual Reports

This week we're exploring text data from 
[Amazon's annual reports.](https://ir.aboutamazon.com/annual-reports-proxies-and-shareholder-letters/default.aspx)
The PDFs were read into R using the {pdftools} R package, and explored by TidyTuesday
participant Gregory Vander Vinne in 
[a post on his website](https://gregoryvdvinne.github.io/Text-Mining-Amazon-Budgets.html).
Note that stop words (e.g., "and", "the", "a") have been removed from the data.

> As a publicly-traded company, Amazon releases an annual report every year (with a December 31st year end). An annual report is essentially a summary of the company’s performance over the past year. It includes details on how well the company did financially, what goals were achieved, and what challenges it faced.

- How have the words used change over time? 

- Are there meaningful changes in sentiment from year to year? 

- Which words are likely to appear together in the same annual report?

Thank you to [Gregory Vander Vinne](https://github.com/GregoryVdvinne) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-03-25')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 12)

report_words_clean <- tuesdata$report_words_clean

# Option 2: Read directly from GitHub

report_words_clean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-25/report_words_clean.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-03-25')

# Option 2: Read directly from GitHub and assign to an object

report_words_clean = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-25/report_words_clean.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)  

## PydyTuesday: A Posit collaboration with TidyTuesday  

- Exploring the TidyTuesday data in Python?  Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


### Data Dictionary

# `report_words_clean.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|year     |character |The year of the annual report. |
|word     |character |A single word extracted from the annual report. Each row represents one occurrence of the word, meaning that if a word appears n times in a given report, it will be recorded in n separate rows for that year|

### Cleaning Script

```r
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
url <- "https://raw.githubusercontent.com/GregoryVdvinne/gregoryvdvinne.github.io/main/Amazon_Budgets/Data/Intermediate/all_reports_ocr_uncleaned.feather"
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
  dplyr::filter(!(word %in% c(letters, LETTERS)),  # Single letters
         !str_detect(word, "\\d"),          # Words containing a number
         !str_detect(word, "_"))

```
