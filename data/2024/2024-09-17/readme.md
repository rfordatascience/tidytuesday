# Shakespeare Dialogue

This week we're exploring dialogue in Shakespeare plays. The dataset this week comes from [shakespeare.mit.edu](https://shakespeare.mit.edu/) (via [github.com/nrennie/shakespeare](https://github.com/nrennie/shakespeare)) which is the Web's first edition of the Complete Works of William Shakespeare. The site has offered Shakespeare's plays and poetry to the internet community since 1993.

Dialogue from Hamlet, Macbeth, and Romeo and Juliet are provided for this week. Which play has the most stage directions compared to dialogue? Which play has the longest lines of dialogue? Which character speaks the most?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-09-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 38)

hamlet <- tuesdata$hamlet
macbeth <- tuesdata$macbeth
romeo_juliet <- tuesdata$romeo_juliet

# Option 2: Read directly from GitHub

hamlet <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-17/hamlet.csv')
macbeth <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-17/macbeth.csv')
romeo_juliet <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-17/romeo_juliet.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `hamlet.csv`

|variable    |class     |description                                                   |
|:-----------|:---------|:-------------------------------------------------------------|
|act         |character |Act number.                                                   |
|scene       |character |Scene number.                                                 |
|character   |character |Name of character speaking or whether it's a stage direction. |
|dialogue    |character |Text of dialogue or stage direction.                          |
|line_number |double    |Dialogue line number.                                         |

# `macbeth.csv`

|variable    |class     |description                                                   |
|:-----------|:---------|:-------------------------------------------------------------|
|act         |character |Act number.                                                   |
|scene       |character |Scene number.                                                 |
|character   |character |Name of character speaking or whether it's a stage direction. |
|dialogue    |character |Text of dialogue or stage direction.                          |
|line_number |double    |Dialogue line number.                                         |

# `romeo_juliet.csv`

|variable    |class     |description                                                   |
|:-----------|:---------|:-------------------------------------------------------------|
|act         |character |Act number.                                                   |
|scene       |character |Scene number.                                                 |
|character   |character |Name of character speaking or whether it's a stage direction. |
|dialogue    |character |Text of dialogue or stage direction.                          |
|line_number |double    |Dialogue line number.                                         |

### Cleaning Script

```r
# Clean data provided by <https://github.com/nrennie/shakespeare/tree/main/data>. No cleaning was necessary.
hamlet <- readr::read_csv("https://raw.githubusercontent.com/nrennie/shakespeare/main/data/hamlet.csv")
romeo_juliet <- readr::read_csv("https://raw.githubusercontent.com/nrennie/shakespeare/main/data/romeo_juliet.csv")
macbeth <- readr::read_csv("https://raw.githubusercontent.com/nrennie/shakespeare/main/data/macbeth.csv")
```
