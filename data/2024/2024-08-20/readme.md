# English Monarchs and Marriages 

This week we are exploring [English Monarchs and Marriages](https://github.com/frankiethull/english_monarch_marriages)! 

> this dataset focuses on the names, ages, and marriages of various 'kings' and 'consorts'. the data ranges all the way back to 850 where the details are a bit fuzzy, spanning all the way to current day. names contain special characters; ages & years can be a bit of a regex puzzle as well. additionally, the age of kings and consorts may show quite a bit of an age gap. 

The data was scraped from [Ian Visits](https://www.ianvisits.co.uk/articles/a-list-of-monarchs-by-marriage-6857/) by [f. hull](https://github.com/frankiethull), who also curated this week's post!

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-08-20')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 34)

english_monarchs_marriages_df <- tuesdata$english_monarchs_marriages_df

# Option 2: Read directly from GitHub

english_monarchs_marriages_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-20/english_monarchs_marriages_df.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `english_monarchs_marriages_df.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|king_name        |character |male or female ruler        |
|king_age         |character |ruler's age         |
|consort_name     |character |consort chosen to marry king     |
|consort_age      |character |age of consort      |
|year_of_marriage |character |historical year of marriage |

### Cleaning Script

```r
library(rvest)

# url to scrape:
root <- "https://www.ianvisits.co.uk/articles/a-list-of-monarchs-by-marriage-6857/"

# get table
tables <- read_html(root) |> html_nodes("table")
df <- tables[1] |> html_table() |> as.data.frame()

df <- df[, -6]      # remove spoiler 
df <- df[-c(1,2), ] # remove double-header effect

cols <- c("king_name", "king_age", "consort_name", "consort_age", "year_of_marriage")
colnames(df) <- cols

english_monarchs_marriages_df <- df
```
