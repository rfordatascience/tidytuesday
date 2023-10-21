# Horror Legends

Happy Halloween! 
To celebrate, this week we're exploring horror legends from [Snopes.com](https://www.snopes.com/)!

> Since urban legends are often a means of expressing our fears about the dangers that ripple just beneath the surface of our seemingly calm and untroubled world, it should come as no surprise that horror legends are one of urban folklore's richest veins. We worry about the terrible accidents we're powerless to prevent, and we fear anonymous killers who choose victims at random. We cannot protect ourselves from the venomous animals who slither undetected into the places where we work, play, and shop, nor can we stop the onslaught of insects who invade our homes and our bodies. We're repulsed by the contaminants that may lurk in our food. We're afraid of foreigners and foreign places. We fear for our childrens' safety in a world full of drugs, kidnappers, and poisons. We never know what gruesome discovery may be waiting around the next corner. And even if we somehow escape all of these horrors, our own vanities may do us in.

You might want to dig into the details of the articles this week -- particularly if the rating is "mixture".
Each observation includes the URL to that article, which you can open directly from R with the `utils::browseURL()` function.

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-10-31')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 44)

horror_articles <- tuesdata$horror_articles

# Option 2: Read directly from GitHub

horror_articles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-31/horror_articles.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `horror_articles.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|title     |character |The title of this article. |
|url       |character |The url for this article. |
|rating    |character |Whether the claim was found to be "false", "true", or somewhere in-between. |
|subtitle  |character |A subtitle for this article. |
|author    |character |The researcher who investigated this claim. |
|published |Date      |The date when the article first appeared on Snopes. |
|claim     |character |The claim being investigated. |

### Cleaning Script

``` r
library(tidyverse)
library(here)
library(fs)
library(rvest)

working_dir <- here::here("data", "2023", "2023-10-31")

urls <- paste0(
  "https://www.snopes.com/fact-check/category/horrors/?pagenum=",
  1:15
)

extract_rating <- function(article_page) {
  rating <- article_page |> 
    rvest::html_element(".rating_title_wrap") |> 
    rvest::html_text2() |> 
    stringr::str_remove("About this rating")
  if (is.na(rating)) {
    rating <- article_page |> 
      rvest::html_element(".status_color") |> 
      rvest::html_text2()
  }
  if (is.na(rating)) {
    rating <- article_page |> 
      rvest::html_elements("noindex") |> 
      rvest::html_text2() |> 
      stringr::str_squish() |> 
      stringr::str_subset("^Status:") |> 
      stringr::str_remove("Status:")
  }
  rating <- tolower(rating) |> 
    stringr::str_squish() |> 
    stringr::str_remove("\\.|\\:")
  rating <- dplyr::case_match(
    rating,
    c(
      "a number of real entries, one unknown, and one fiction",
      "multiple",
      "multiple — see below",
      "two real entries, the others are fiction"
    ) ~ "mixture",
    .default = rating
  )
  return(rating)
}

extract_claim <- function(article_page) {
  claim <- article_page |> 
    rvest::html_element(".claim_cont") |> 
    rvest::html_text2() |> 
    stringr::str_squish()
  if (is.na(claim)) {
    claim <- rvest::html_elements(article_page, "p") |> 
      rvest::html_text2() |> 
      stringr::str_subset("^Claim:") |> 
      stringr::str_remove("Claim:") |> 
      stringr::str_squish()
  }
  return(claim)
}

horror_articles <- urls |>
  purrr::map(
    \(article_list_url) {
      article_list_url |> 
        rvest::read_html() |> 
        rvest::html_elements(".article_wrapper") |> 
        purrr::map(
          \(article) {
            # Grabbbing info from this page can result in truncation. Instead grab the
            # URL and dig into that.
            url <- article |>
              rvest::html_element("a") |>
              rvest::html_attr("href")
            article_page <- rvest::read_html(url)
            tibble::tibble(
              title = article_page |>
                rvest::html_element("h1") |> 
                rvest::html_text2(),
              url = url,
              # Failed for some articles <= 2015-05-16
              rating = extract_rating(article_page),
              subtitle = article_page |>
                rvest::html_element("h2") |> 
                rvest::html_text2(),
              author = article_page |> 
                rvest::html_element(".author_name") |> 
                rvest::html_text() |> 
                stringr::str_squish(),
              published = article |> 
                rvest::html_element(".article_date") |> 
                rvest::html_text2() |> 
                lubridate::mdy(),
              # Failed for some articles <= 2015-05-16
              claim = extract_claim(article_page)
            )
          }
        ) |> 
        purrr::list_rbind()
    }
  ) |> 
  purrr::list_rbind()

readr::write_csv(
  horror_articles,
  fs::path(working_dir, "horror_articles.csv")
)
```
