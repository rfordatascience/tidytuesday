# David Robinson's TidyTuesday Functions

This week we're seeing how [David Robinson has explored TidyTuesday data](https://github.com/dgrtwo/data-screencasts) in his [YouTube screencasts](https://youtube.com/playlist?list=PL19ev-r1GBwkuyiwnxoHTRC8TTqP8OEi8&si=jGBo0bcarEPV6cnn)!
Thanks to [Bryan Shalloway](https://github.com/brshallo) for the suggestion, the [{funspotr} package](https://brshallo.github.io/funspotr/), and the [blog posts about how to use funspotr](https://www.bryanshalloway.com/2022/01/18/identifying-r-functions-packages-used-in-github-repos/) (including [this one about making network graphs with the data](https://www.bryanshalloway.com/2022/03/17/network-plots-of-code-collections-funspotr-part-3/)).

> The goal of funspotr (R function spotter) is to make it easy to identify which R functions and packages are used in files and projects. It was initially written to create reference tables of the functions and packages used in a few popular github repositories.

What are David's most-used functions?
Can you find relationships between functions used and the variable types (using the [{ttmeta} package](https://r4ds.github.io/ttmeta/))?
How does his function graph compare to your own?

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-07-09')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 28)

drob_funs <- tuesdata$drob_funs

# Option 2: Read directly from GitHub

drob_funs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-09/drob_funs.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `drob_funs.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|funs             |character |Function names   |
|pkgs             |character |Package names    |
|in_multiple_pkgs |logical   |Boolean indicating whether this function is in multiple packages |
|contents         |character |File in which the function is used |
|urls             |character |URL to download the file in which the function is used |

### Cleaning Script

```r
# Clean data provided by Bryan Shalloway (@brshallo on GitHub)!
drob_funs <- readr::read_csv("https://raw.githubusercontent.com/brshallo/funspotr-examples/main/data/funs/drob-tidy-tuesdays-funs-20220114.csv")
```
