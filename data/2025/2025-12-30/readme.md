# Christmas Novels

This week we're exploring "Christmas" novels from Project Gutenberg via the [{gutenbergr}](https://docs.ropensci.org/gutenbergr/) R package! 
We're seeking a new maintainer (or new maintainer *team*) to take over stewardship of the package, so this is a great opportunity to get familiar with the package's functionality.
If you enjoy working with text data and R, consider stepping up to help maintain this useful package!
See [the New Maintainer Wanted issue in the gutenbergr repo](https://github.com/ropensci/gutenbergr/issues/95) for details.

You might find [*Text Mining with R*](https://www.tidytextmining.com/) helpful for analyzing this data.

- Which is mentioned more often in these novels: "spirit" or "santa"?
- What is the overall sentiment of each novel?
- How does the text sentiment change over the course of each novel?

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-12-30')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 52)

christmas_novel_authors <- tuesdata$christmas_novel_authors
christmas_novel_text <- tuesdata$christmas_novel_text
christmas_novels <- tuesdata$christmas_novels

# Option 2: Read directly from GitHub

christmas_novel_authors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_authors.csv')
christmas_novel_text <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_text.csv')
christmas_novels <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novels.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-12-30')

# Option 2: Read directly from GitHub and assign to an object

christmas_novel_authors = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_authors.csv')
christmas_novel_text = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_text.csv')
christmas_novels = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novels.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-12-30')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

christmas_novel_authors = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_authors.csv")
christmas_novel_text = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_text.csv")
christmas_novels = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novels.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
christmas_novel_authors = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_authors.csv", DataFrame)
christmas_novel_text = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novel_text.csv", DataFrame)
christmas_novels = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-30/christmas_novels.csv", DataFrame)
```


## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.


## Data Dictionary

### `christmas_novel_authors.csv`

|variable            |class     |description                           |
|:-------------------|:---------|:-------------------------------------|
|gutenberg_author_id |integer   |Project Gutenberg author ID. |
|author              |character |The `agent_name` field from the original metadata. |
|birthdate           |integer   |Year of birth, if known. |
|deathdate           |integer   |Year of death, if known. |
|wikipedia           |character |Link to Wikipedia article on the author. If there are multiple, they are "|"-delimited. |
|aliases             |character |Character vector of aliases. If there are multiple, they are "/"-delimited. |

### `christmas_novel_text.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|gutenberg_id |integer   |Numeric ID, used to retrieve works from Project Gutenberg |
|text         |character |A line of text from the work (`NA` indicates an empty line) |

### `christmas_novels.csv`

|variable            |class     |description                           |
|:-------------------|:---------|:-------------------------------------|
|gutenberg_id        |integer   |Numeric ID, used to retrieve works from Project Gutenberg. |
|title               |character |Title of the work. |
|gutenberg_author_id |integer   |Project Gutenberg author ID. |

## Cleaning Script

```r
library(gutenbergr)
library(tidyverse)

# I do this as a separate step so I can be sure the option has resolved before I
# do anything in bulk.
gutenbergr::gutenberg_get_mirror()

christmas_novels_raw <- gutenbergr::gutenberg_works(
  dplyr::if_all(dplyr::everything(), ~ !is.na(.)),
  stringr::str_detect(.data$gutenberg_bookshelf, "Novels"),
  stringr::str_detect(.data$title, "Christmas"),
  stringr::str_detect(.data$gutenberg_bookshelf, "Christmas")
)

christmas_novels <- christmas_novels_raw |>
  dplyr::distinct(.data$gutenberg_id, .data$title, .data$gutenberg_author_id)

christmas_novel_authors <- christmas_novels_raw |>
  dplyr::distinct(.data$gutenberg_author_id) |>
  dplyr::left_join(gutenbergr::gutenberg_authors, by = "gutenberg_author_id") |>
  # Just use the "aliases" column, "alias" is redundant.
  dplyr::select(-"alias")

christmas_novel_text <- gutenbergr::gutenberg_download(christmas_novels)

```
