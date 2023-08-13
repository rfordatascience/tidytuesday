# Spam E-mail

The data this week comes from Vincent Arel-Bundock's Rdataset package(https://vincentarelbundock.github.io/Rdatasets/index.html). 

> Rdatasets is a collection of 2246 datasets which were originally distributed alongside the statistical software environment R and some of its add-on packages. The goal is to make these data more broadly accessible for teaching and statistical software development.

We're working with the [spam email](https://vincentarelbundock.github.io/Rdatasets/doc/DAAG/spam7.html) dataset. This is a subset of the [spam e-mail database](https://search.r-project.org/CRAN/refmans/kernlab/html/spam.html).

This is a dataset collected at Hewlett-Packard Labs by Mark Hopkins, Erik Reeber, George Forman, and Jaap Suermondt and shared with the [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/94/spambase). The dataset classifies 4601 e-mails as spam or non-spam, with additional variables indicating the frequency of certain words and characters in the e-mail.



## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-08-15')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 33)

spam <- tuesdata$spam

# Option 2: Read directly from GitHub

spam <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-15/spam.csv')
```

### Data Dictionary

# `spam.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|crl.tot  |double    | Total length of uninterrupted sequences of capitals     |
|dollar   |double    | Occurrences of the dollar sign, as percent of total number of characters     |
|bang     |double    | Occurrences of ‘!’, as percent of total number of characters    |
|money    |double    | Occurrences of ‘!’, as percent of total number of characters    |
|n000     |double    | Occurrences of the string ‘000’, as percent of total number of words    |
|make     |double    | Occurrences of ‘make’, as a percent of total number of words       |
|yesno    |character | Outcome variable, a factor with levels 'n' not spam, 'y' spam |

### Cleaning Script

``` r
library(rvest)
library(tidyverse)
library(here)

# Load basic state data from Wikipedia.
states <- read_html("https://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States") |> 
  html_table(header = TRUE) |> 
  # Try out the new-ish use of _ for subsetting with the base pipe.
  _[[2]][-1,]
colnames(states) <- c(
  "state",
  "postal_abbreviation",
  "capital_city",
  "largest_city",
  "admission",
  "population_2020",
  "total_area_mi2",
  "total_area_km2",
  "land_area_mi2",
  "land_area_km2",
  "water_area_mi2",
  "water_area_km2",
  "n_representatives"
)
glimpse(states)

# Clean types.
states <- states |> 
  mutate(
    across(
      c(population_2020, contains("area"), n_representatives),
      ~ parse_number(.x) |> as.integer()
    ),
    admission = parse_date(admission, format = "%b %d, %Y"),
    state = str_remove(state, fixed("[B]"))
  )

state_demonyms <- read_html("https://en.wikipedia.org/wiki/List_of_demonyms_for_US_states_and_territories") |> 
  html_table() |> 
  _[[1]][-1,1:2]
colnames(state_demonyms) <- c("state", "demonym")
states <- states |> 
  left_join(state_demonyms, by = "state")

# Confirm that the join worked!

states |> 
  filter(is.na(demonym))

state_name_etymology <- read_html("https://en.wikipedia.org/wiki/List_of_state_and_territory_name_etymologies_of_the_United_States") |> 
  html_table() |> 
  _[[1]]
colnames(state_name_etymology) <- c(
  "state",
  "date_named",
  "language",
  "words_in_original",
  "meaning"
)
state_name_etymology <- state_name_etymology |>
  mutate(
    date_named = if_else(
      date_named == "1743",
      "January 1, 1743",
      date_named
    ) |> 
      parse_date(format = "%B %d, %Y"),
    # We remove footnotes, but will reference them in the dictionary.
    across(
      c(words_in_original, meaning),
      ~ str_remove_all(.x, "\\[\\d+\\]")
    )
  )

# Confirm that the tables match up.
states |> 
  full_join(state_name_etymology, by = "state") |> 
  filter(is.na(date_named))
states |> 
  full_join(state_name_etymology, by = "state") |> 
  filter(is.na(admission))

write_csv(
  states,
  here(
    "data",
    "2023",
    "2023-08-01",
    "states.csv"
  )
)
write_csv(
  state_name_etymology,
  here(
    "data",
    "2023",
    "2023-08-01",
    "state_name_etymology.csv"
  )
)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
