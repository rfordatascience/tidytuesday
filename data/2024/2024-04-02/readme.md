# Du Bois Visualization Challenge 2024 

This week we're inviting you to participate in the [2024 Du Bois Visualization Challenge](https://github.com/ajstarks/dubois-data-portraits/blob/master/challenge/2024/README.md).

> The goal of the challenge is to celebrate the data visualization legacy of W.E.B Du Bois by recreating the visualizations from the 1900 Paris Exposition using modern tools.

This year the challenge is organized around the colors of the [Pan African Flag](https://en.wikipedia.org/wiki/Pan-African_flag).
For this [final week](https://github.com/ajstarks/dubois-data-portraits/tree/master/challenge/2024/challenge10), use a combination of the colors from the flag to reproduce plate 37, "A Series Of Statistical Charts Illustrating The Conditions Of Descendants Of Formal African Slaves Now Resident In The Unites States."
Visit the challenge GitHub repository for more details!


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-04-02')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 14)

dubois_week10 <- tuesdata$dubois_week10

# Option 2: Read directly from GitHub

dubois_week10 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-04-02/dubois_week10.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `dubois_week10.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|Occupation |character |Occupations of the 330 "negro" graduates of Atlanta University as of 1900. |
|Percentage |double    |Percentage of graduates with this occupation. |


### Cleaning Script

No cleaning. This week's data comes directly from the [Du Bois Challenge GitHub](https://raw.githubusercontent.com/ajstarks/dubois-data-portraits/master/challenge/2024/challenge10/data.csv).
