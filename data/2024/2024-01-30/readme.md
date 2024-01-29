# Groundhog predictions

Happy Groundhog Day! This week we're exploring Groundhog Day Predictions from [groundhog-day.com](https://groundhog-day.com)!
See if you can find a better way to present the annual data than their [table of predictions by year](https://groundhog-day.com/predictions)!
For anyone not familiar with the Groundhog Day tradition, if the groundhog sees its shadow and goes back into its burrow, that is a prediction of six more weeks of winter.
Otherwise spring will come early.
We attempted to provide weather data to accompany this dataset, but so far we've been unsuccessful.
Watch for a follow-up dataset in the future!

Note: "Oil Springs Ollie" (groundhog #55) has been succeeded by "Heaven's Wildlife Harvey" (groundhog #70).

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-01-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 5)

groundhogs <- tuesdata$groundhogs
predictions <- tuesdata$predictions

# Option 2: Read directly from GitHub

groundhogs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-30/groundhogs.csv')
predictions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-01-30/predictions.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `groundhogs.csv`

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|id                 |integer   |A numeric id for this groundhog. |
|slug               |character |The name of the groundhog, in simplified kebab case. |
|shortname          |character |A short version of the name of the groundhog or groundhog substitute. |
|name               |character |The full name of the groundhog or groundhog substitute. |
|city               |character |The city in which the prediction takes place. |
|region             |character |The state or province of the prediction. |
|country            |character |The country of the prediction (USA or Canada). |
|latitude           |double    |The latitude of the city. |
|longitude          |double    |The longitude of the city. |
|source             |character |A url with information about this groundhog. |
|current_prediction |character |A url with information about the most recent prediction. |
|is_groundhog       |logical   |A logical value indicating whether this predictor is a living groundhog. |
|type               |character |A short description of the type of animal or other thing that is said to make the prediction. |
|active             |logical   |A logical value indicating whether this predictor is active (as of 2023). |
|description        |character |A free-text description of the predictor. |
|image              |character |A URL with an image of the predictor. |
|predictions_count  |integer   |The number of predictions available for this predictor. |

# `predictions.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|id       |integer   |A numeric id for this groundhog. |
|year     |integer   |The year of the prediction. |
|shadow   |logical   |Whether the groundhog saw its shadow, and thus predicts 6 more weeks of winter. |
|details  |character |Free text with more information about this prediction. |

### Cleaning Script

``` r
library(tidyverse)
library(here)
library(fs)
library(httr2)

working_dir <- here::here("data", "2024", "2024-01-30")

groundhogs_all <- httr2::request("https://groundhog-day.com/api/v1/groundhogs/") |> 
  httr2::req_perform() |> 
  httr2::resp_body_json() |> 
  _$groundhogs |> 
  tibble::tibble(data = _) |> 
  tidyr::unnest_wider(data)

groundhogs <- groundhogs_all |> 
  dplyr::select(
    -predictions,
    -successor, # Only 1 groundhog has a successor, we'll mention it in the post.
    -contact
  ) |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    # At least one has a stray comma at the end
    coordinates = stringr::str_remove(coordinates, ",$")
  ) |> 
  tidyr::separate_wider_delim(
    coordinates,
    ",",
    names = c("latitude", "longitude")
  ) |> 
  dplyr::mutate(
    # Correct types
    latitude = as.double(latitude),
    longitude = as.double(longitude),
    is_groundhog = as.logical(is_groundhog),
    active = as.logical(active)
  )

predictions <- groundhogs_all |> 
  dplyr::select(id, predictions) |> 
  tidyr::unnest_longer(predictions) |> 
  tidyr::unnest_wider(predictions) |> 
  dplyr::mutate(shadow = as.logical(shadow))

readr::write_csv(
  groundhogs,
  fs::path(working_dir, "groundhogs.csv")
)
readr::write_csv(
  predictions,
  fs::path(working_dir, "predictions.csv")
)
```
