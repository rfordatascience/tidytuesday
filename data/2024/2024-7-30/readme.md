# mtcars

<!-- 
1. Describe the dataset. See previous weeks for the general format
of the DESCRIPTION. The description is the part of the readme.md file above "The
Data"; everything else will be filled in from the other md files in this
directory + automatic scripts. We usually include brief introduction along the lines of "This week we're exploring DATASET" or "The dataset this week comes from SOURCE", then a quote starting with ">", then a few questions participants might seek to answer using the data.
2. Delete this comment block.
--> 

Intro to my mtcars dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-7-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 31)

mtcars <- tuesdata$mtcars

# Option 2: Read directly from GitHub

mtcars <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-7-30/mtcars.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `mtcars.csv`

|variable |class  |description |
|:--------|:------|:-----------|
|mpg      |double |mpg         |
|cyl      |double |cyl         |
|disp     |double |disp        |
|hp       |double |hp          |
|drat     |double |drat        |
|wt       |double |wt          |
|qsec     |double |qsec        |
|vs       |double |vs          |
|am       |double |am          |
|gear     |double |gear        |
|carb     |double |carb        |

### Cleaning Script

```r
# Clean data provided by the {datasets} R package. No cleaning was necessary.
mtcars <- mtcars
```
