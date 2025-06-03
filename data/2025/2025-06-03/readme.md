# Project Gutenberg

This week we're exploring books from Project Gutenberg and the {[gutenbergr](https://docs.ropensci.org/gutenbergr/)} R package!

> [{gutenbergr} allows you to] Download and process public domain works in the 
> Project Gutenberg collection <https://www.gutenberg.org/>. Includes metadata 
> for all Project Gutenberg works, so that they can be searched and retrieved.

- How many different languages are available in the Project Gutenberg collection? How many books are available in each language?
- Do any authors appear under more than one `gutenberg_author_id`?
- How might the {gutenbergr} package authors further refine the data for greater ease-of-use?

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-06-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 22)

gutenberg_authors <- tuesdata$gutenberg_authors
gutenberg_languages <- tuesdata$gutenberg_languages
gutenberg_metadata <- tuesdata$gutenberg_metadata
gutenberg_subjects <- tuesdata$gutenberg_subjects

# Option 2: Read directly from GitHub

gutenberg_authors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_authors.csv')
gutenberg_languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_languages.csv')
gutenberg_metadata <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_metadata.csv')
gutenberg_subjects <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_subjects.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-06-03')

# Option 2: Read directly from GitHub and assign to an object

gutenberg_authors = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_authors.csv')
gutenberg_languages = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_languages.csv')
gutenberg_metadata = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_metadata.csv')
gutenberg_subjects = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_subjects.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-06-03')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

gutenberg_authors = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_authors.csv")
gutenberg_languages = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_languages.csv")
gutenberg_metadata = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_metadata.csv")
gutenberg_subjects = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_subjects.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
gutenberg_authors = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_authors.csv", DataFrame)
gutenberg_languages = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_languages.csv", DataFrame)
gutenberg_metadata = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_metadata.csv", DataFrame)
gutenberg_subjects = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-03/gutenberg_subjects.csv", DataFrame)
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

### `gutenberg_authors.csv`

|variable            |class     |description                           |
|:-------------------|:---------|:-------------------------------------|
|gutenberg_author_id |integer   |Unique identifier for the author that can be used to join with the gutenberg_metadata dataset. |
|author              |character |The agent_name field from the original metadata. |
|alias               |character |Alias. |
|birthdate           |integer   |Year of birth. |
|deathdate           |integer   |Year of death. |
|wikipedia           |character |Link to Wikipedia article on the author. If there are multiple, they are "\|"-delimited. |
|aliases             |character |Character vector of aliases. If there are multiple, they are "/"-delimited. |

### `gutenberg_languages.csv`

|variable        |class         |description                           |
|:---------------|:-------------|:-------------------------------------|
|gutenberg_id    |integer       |Unique identifier for the work that can be used to join with the gutenberg_metadata dataset. |
|language        |factor        |Language ISO 639 code. Two letter code if one exists, otherwise three letter. |
|total_languages |integer       |Number of languages for this work. |

### `gutenberg_metadata.csv`

|variable            |class         |description                           |
|:-------------------|:-------------|:-------------------------------------|
|gutenberg_id        |integer       |Numeric ID, used to retrieve works from Project Gutenberg. |
|title               |character     |Title. |
|author              |character     |Author, if a single one given. Given as last name first (e.g. "Doyle, Arthur Conan"). |
|gutenberg_author_id |integer       |Project Gutenberg author ID. |
|language            |factor        |Language ISO 639 code, separated by / if multiple. Two letter code if one exists, otherwise three letter. See https://en.wikipedia.org/wiki/List_of_ISO_639-2_codes. |
|gutenberg_bookshelf |character     |Which collection or collections this is found in, separated by / if multiple. |
|rights              |factor        |Generally one of three options: "Public domain in the USA." (the most common by far), "Copyrighted. Read the copyright notice inside this book for details.", or "None". |
|has_text            |logical       |Whether there is a file containing digits followed by `.txt` in Project Gutenberg for this record (as opposed to, for example, audiobooks). |

### `gutenberg_subjects.csv`

|variable     |class         |description                           |
|:------------|:-------------|:-------------------------------------|
|gutenberg_id |integer       |ID describing a work that can be joined with gutenberg_metadata. |
|subject_type |factor        |Either "lcc" (Library of Congress Classification) or "lcsh" (Library of Congress Subject Headings). |
|subject      |character     |Subject. |

## Cleaning Script

```r
# Mostly clean data provided by the {gutenbergr} package.
# install.packages("gutenbergr")
library(gutenbergr)
library(dplyr)
gutenberg_metadata <- gutenbergr::gutenberg_metadata
gutenberg_authors <- gutenbergr::gutenberg_authors
gutenberg_languages <- gutenbergr::gutenberg_languages |>
  # Fix a typo in the current CRAN version of the package.
  dplyr::mutate(language = as.factor(language))
gutenberg_languages$lanuage <- NULL
gutenberg_subjects <- gutenbergr::gutenberg_subjects

```
