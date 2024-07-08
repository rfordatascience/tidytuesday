# tidyRainbow Datasets

Happy Pride Month! 
Check out the [{gglgbtq}](https://github.com/turtletopia/gglgbtq) package for LGBTQ-related themes and color palettes!

The data this week comes from the [tidyRainbow](https://github.com/r-lgbtq/tidyrainbow/tree/main), "a data project for the LGBTQ+ community who use the R language ecosystem."

> The data sets in this repository focus on data pertaining to the LGBTQ+ community. We also look for data sets where LGBTQ+ folk are explicitly represented and where it is not assumed that gender is binary. Additionally, we include data sets that are relevant to LGBTQ+ folk because of the impact it has on the community.

We're including their [LGBTQ Movies database](https://github.com/r-lgbtq/tidyrainbow/tree/main/data/LGBTQ-movie-database) dataset curated by [Cara Cuiule (She/Her)](https://github.com/cacalc), but we invite you to explore their other datasets, or to [submit any LGBTQ+ related datatsets you know about](https://github.com/r-lgbtq/tidyrainbow/issues)! 

Where do the most popular LGBTQ+ movies come from?
Are more LGBTQ+ movies being released over time?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-06-25')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 26)

lgbtq_movies <- tuesdata$lgbtq_movies

# Option 2: Read directly from GitHub

lgbtq_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-25/lgbtq_movies.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `lgbtq_movies.csv`

|variable           |class      |description                          |
|:------------------|:----------|:------------------------------------|
| id                | integer   | unique ID                           |
| title             | character | title of record in English          |
| original_title    | character | non-English characters              |
| original_language | character | language of the record              |
| overview          | character | description of the record           |
| release_date      | Date      | release date of movie               |
| popularity        | numeric   | popularity rating                   |
| vote_average      | numeric   | average rating                      |
| vote_count        | integer   | the number of votes                 |
| adult             | logical   | Boolean to indicate an adult movie. |
| video             | logical   | Boolean to indicate video           |
| genre_ids         | character | a comma-separated array of integers |


### Cleaning Script

Data was collected and cleaned by [Cara Cuiule (She/Her)](https://github.com/cacalc/tidyRainbowScratch).
