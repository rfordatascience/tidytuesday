# A few world heritage sites

This week we're exploring a very small subset of [UNESCO World Heritage Sites](https://whc.unesco.org/en/list). 
The [1 dataset, 100 visualizations project](https://100.datavizproject.com/) used this dataset to explore different ways of visualizing a simple dataset. 
This is your chance to try that out too! Try recreating some of their plots, or make your own. You can add to your data visualization code toolbox by creating types of visualizations you could use with other datasets, or getting inspiration from others. Share your favorite ones!

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-02-06')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 6)

heritage <- tuesdata$heritage

# Option 2: Read directly from GitHub

heritage <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-06/heritage.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `heritage.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|country  |character   |Country |
|2004     |integer   |Number of UNESCO World Heritage sites in 2004 |
|2022     |integer   |Number of UNESCO World Heritage sites in 2022 |

### Cleaning Script

Data from [1 dataset, 100 visualizations](https://100.datavizproject.com/). No cleaning. 
