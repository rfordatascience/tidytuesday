# Pixar Films

This week we're exploring Pixar films! The data this week comes from the {pixarfilms} R package by [Eric Leung](https://github.com/erictleung). 

> R data package to explore Pixar films, the people, and reception data. This package contains six data sets provided mostly in part by [Wikipedia](https://en.wikipedia.org/wiki/List_of_Pixar_films).

- Why are some values missing in the datasets?
- Which films have the highest score in each rating system? Are there distinct differences in ratings?
- Download the [`box_office` dataset](https://raw.githubusercontent.com/erictleung/pixarfilms/master/data-raw/box_office.csv) from the {pixarfilms} package. How does the `box_office_us_canada` value compare to the various ratings? Is the trend different for `box_office_worldwide`?

Thank you to [Jon Harmon](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-03-11')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 10)

pixar_films <- tuesdata$pixar_films
public_response <- tuesdata$public_response

# Option 2: Read directly from GitHub

pixar_films <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-11/pixar_films.csv')
public_response <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-11/public_response.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-03-11')

# Option 2: Read directly from GitHub and assign to an object

pixar_films = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-11/pixar_films.csv')
public_response = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-11/public_response.csv')
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

# `pixar_films.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|number       |integer   |Order of release. |
|film         |character |Name of film. |
|release_date |date      |Date film premiered. |
|run_time     |integer   |Film length in minutes. |
|film_rating  |character |Rating based on Motion Picture Association (MPA) film rating system. |

# `public_response.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|film            |character |Name of film. |
|rotten_tomatoes |integer   |Score from the American review-aggregation website Rotten Tomatoes; scored out of 100. |
|metacritic      |integer   |Score from Metacritic where scores are weighted average of reviews; scored out of 100. |
|cinema_score    |character |Score from market research firm CinemaScore; scored by grades A, B, C, D, and F. |
|critics_choice  |integer   |Score from Critics' Choice Movie Awards presented by the American-Canadian Critics Choice Association (CCA); scored out of 100. |

### Cleaning Script

```r
# Data saved for TidyTuesday using the new curation functions in the dev branch
# of the {tidytuesdayR} package. See
# https://dslc-io.github.io/tidytuesdayR/articles/curating.html for details.

# install.packages("pak")
# pak::pak("dslc-io/tidytuesdayR")
# library(tidytuesdayR)
# tidytuesdayR::tt_clean()

# Clean data provided by the {pixarfilms} package by Eric Leung. Additional
# datasets are available in the package or via the package's GitHub repository
# at https://erictleung.com/pixarfilms/

# install.packages("pixarfilms")
library(pixarfilms)

pixar_films <- pixarfilms::pixar_films |>
  dplyr::mutate(
    dplyr::across(
      c("number", "run_time"),
      as.integer
    )
  )
public_response <- pixarfilms::public_response |>
  dplyr::mutate(
    dplyr::across(
      c("rotten_tomatoes", "metacritic", "critics_choice"),
      as.integer
    )
  )

# tidytuesdayR::tt_save_dataset(pixar_films)
# tidytuesdayR::tt_save_dataset(public_response)
```
