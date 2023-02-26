### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# African Language Sentiment

The data this week comes from [AfriSenti: Sentiment Analysis dataset for 14 African languages](https://github.com/afrisenti-semeval/afrisent-semeval-2023) via [@shmuhammad2004](https://github.com/shmuhammad2004) (the corresponding author on the [associated paper](https://arxiv.org/pdf/2302.08956.pdf), and an active member of the [R4DS Online Learning Community Slack](https://r4ds.io/join)).

> This repository contains data for the SemEval 2023 Shared Task 12: Sentiment Analysis in African Languages (AfriSenti-SemEval).

The source repository also includes sentiment lexicons for several languages.


### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-02-28')
tuesdata <- tidytuesdayR::tt_load(2023, week = 9)

afrisenti <- tuesdata$afrisenti
languages <- tuesdata$languages
language_scripts <- tuesdata$language_scripts
language_countries <- tuesdata$language_countries
country_regions <- tuesdata$country_regions

# Or read in the data manually

afrisenti <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/afrisenti.csv')
languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/languages.csv')
language_scripts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/language_scripts.csv')
language_countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/language_countries.csv')
country_regions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/country_regions.csv')
```

### Data Dictionary

# `afrisenti.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|language_iso_code |character |The unique code used to identify the language |
|tweet             |character |The text content of a tweet |
|label             |character |A sentiment label of positive, negative, or neutral assigned by a native speaker of that language |
|intended_use      |character |Whether the data came from the dev, test, or train set for that language |

# `languages.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|language_iso_code |character |The unique code used to identify the language |
|language          |character |The name of the language |

# `language_scripts.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|language_iso_code |character |The unique code used to identify the language |
|script            |character |The script used to write the language |

# `language_countries.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|language_iso_code |character |The unique code used to identify the language |
|country           |character |A country in which the language is spoken |

# `country_regions.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|country  |character |A country in which the language is spoken |
|region   |character |The region of Africa in which that country is categorized. Note that Mozambique is categorized as "East Africa", "Southern Africa", and "Southeastern Africa" |


### Cleaning Script

```r
library(tidyverse)

# Read in the data
language_abbrevs <- c(
  "amh", "arq", "ary", 
  "hau", "ibo", "kin",
  "oro", "pcm", "por",
  "swa", "tir", "tso", 
  "twi", "yor"
)
# amh == ama, por == pt-MZ, oro == orm

splits <- c("dev", "test", "train")

afrisenti <- purrr::map(
  language_abbrevs,
  \(language_abbr) {
    purrr::map(
      splits,
      \(split) {
        readr::read_tsv(
          paste0(
            "https://raw.githubusercontent.com/afrisenti-semeval/afrisent-semeval-2023/main/data/",
            language_abbr, "/", split, ".tsv"
          )
        ) |> 
          dplyr::mutate(
            language_abbreviation = language_abbr,
            intended_use = split
          )
      }
    ) |> 
      purrr::list_rbind()
  }
) |> 
  purrr::list_rbind()

glimpse(afrisenti)

# oro has an extra column.
afrisenti |> 
  dplyr::filter(!is.na(ID)) |> 
  dplyr::count(language_abbreviation)

# Drop the extra column, and arrange the columns. Also recode the
# language_abbreviation to formal ISO codes.
afrisenti <- afrisenti |> 
  dplyr::mutate(
    language_iso_code = dplyr::recode(
      language_abbreviation,
      por = "pt-MZ",
      oro = "orm"
    )
  ) |> 
  dplyr::select(
    language_iso_code,
    tweet,
    label,
    intended_use
  ) |> 
  dplyr::arrange(language_iso_code, label, intended_use)

# Also include information about the languages. Start with Table 2 from
# https://arxiv.org/pdf/2302.08956.pdf but make it tidy.
languages_untidy <- tibble::tribble(
  ~language, ~language_iso_code, ~region, ~country, ~script,
  "Amharic", "amh", "East Africa", "Ethiopia", "Ethiopic",
  "Algerian Arabic/Darja", "arq", "North Africa", "Algeria", "Arabic",
  "Hausa", "hau", "West Africa", "Nigeria", "Latin",
  "Hausa", "hau", "West Africa", "Ghana", "Latin",
  "Hausa", "hau", "West Africa", "Cameroon", "Latin",
  "Igbo", "ibo", "West Africa", "Nigeria", "Latin",
  "Kinyarwanda", "kin", "East Africa", "Rwanda", "Latin",
  "Moroccan Arabic/Darija", "ary", "Northern Africa", "Morocco", "Arabic",
  "Moroccan Arabic/Darija", "ary", "Northern Africa", "Morocco", "Latin",
  "Mozambican Portuguese", "pt-MZ", "Southeastern Africa", "Mozambique", "Latin",
  "Nigerian Pidgin", "pcm", "West Africa", "Nigeria", "Latin",
  "Nigerian Pidgin", "pcm", "West Africa", "Ghana", "Latin",
  "Nigerian Pidgin", "pcm", "West Africa", "Cameroon", "Latin",
  "Oromo", "orm", "East Africa", "Ethiopia", "Latin",
  "Swahili", "swa", "East Africa", "Tanzania", "Latin",
  "Swahili", "swa", "East Africa", "Kenya", "Latin",
  "Swahili", "swa", "East Africa", "Mozambique", "Latin",
  "Tigrinya", "tir", "East Africa", "Ethiopia", "Ethiopic",
  "Twi", "twi", "West Africa", "Ghana", "Latin",
  "Xitsonga", "tso", "Southern Africa", "Mozambique", "Latin",
  "Xitsonga", "tso", "Southern Africa", "South Africa", "Latin",
  "Xitsonga", "tso", "Southern Africa", "Zimbabwe", "Latin",
  "Xitsonga", "tso", "Southern Africa", "Eswatini", "Latin",
  "Yorùbá", "yor", "West Africa", "Nigeria", "Latin"
)

languages <- languages_untidy |> 
  dplyr::distinct(language_iso_code, language) |> 
  dplyr::arrange(language_iso_code, language)

language_countries <- languages_untidy |> 
  dplyr::distinct(language_iso_code, country) |> 
  dplyr::arrange(language_iso_code, country)

language_scripts <- languages_untidy |> 
  dplyr::distinct(language_iso_code, script) |> 
  dplyr::arrange(language_iso_code, script)

country_regions <- languages_untidy |> 
  dplyr::distinct(country, region) |> 
  dplyr::arrange(country, region)

# Save the data.
write_csv(
  afrisenti,
  here::here(
    "data", "2023", "2023-02-28",
    "afrisenti.csv"
  )
)

write_csv(
  languages,
  here::here(
    "data", "2023", "2023-02-28",
    "languages.csv"
  )
)

write_csv(
  language_scripts,
  here::here(
    "data", "2023", "2023-02-28",
    "language_scripts.csv"
  )
)

write_csv(
  language_countries,
  here::here(
    "data", "2023", "2023-02-28",
    "language_countries.csv"
  )
)

write_csv(
  country_regions,
  here::here(
    "data", "2023", "2023-02-28",
    "country_regions.csv"
  )
)
```