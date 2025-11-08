# The Complete Sherlock Holmes

This week we're exploring the complete line-by-line text of the Sherlock Holmes stories and novels, made available through the {[sherlock](https://github.com/EmilHvitfeldt/sherlock)} R package by Emil Hvitfeldt. The dataset includes the full collection of Holmes texts, organized by book and line number, and is ideal for stylometry, sentiment analysis, and literary exploration.

> "The name is Sherlock Holmes and the address is 221B Baker Street." Holmes is a consulting detective known for his keen observation, logical reasoning, and use of forensic science to solve complex cases. Created by Sir Arthur Conan Doyle, Holmes has become one of the most famous fictional detectives in literature.

- Are there patterns in how Watson narrates versus how Holmes speaks?
- How does sentence length vary between stories?
- Can we detect shifts in tone when Watson is the narrator versus when Holmes speaks directly?
- Does sentiment shift as the mystery unfolds?

Thank you to [Darakhshan Nehal](https://github.com/darakhshannehal) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-11-25')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 47)

holmes <- tuesdata$holmes

# Option 2: Read directly from GitHub

holmes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-25/holmes.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-11-25')

# Option 2: Read directly from GitHub and assign to an object

holmes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-25/holmes.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-11-25')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

holmes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-25/holmes.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
holmes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-25/holmes.csv", DataFrame)
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

### `holmes.csv`

| variable | class     | description                                  |
|:---------|:----------|:---------------------------------------------|
| book     | character | Title of the Sherlock Holmes story or novel. |
| text     | character | Line of text extracted from the book.        |
| line_num | integer   | Narrative-preserving line index. When you load the data, blank lines (`""`) may appear as `NA`.|

## Cleaning Script

```r
# Imports
library(tidyverse)
library(devtools)

#devtools::install_github("EmilHvitfeldt/sherlock")
library(sherlock)

# Load the dataset
holmes <- sherlock::holmes |>
  # Add line numbers to preserve narrative order
  mutate(line_num = row_number(), .by = "book") |>
  # Reorder columns
  select("book", "text", "line_num")

```
