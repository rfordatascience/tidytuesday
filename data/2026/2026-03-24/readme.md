# One Million Digits of Pi

This week we're exploring the digits of π with a [dataset submission](https://dslc-io.github.io/tidytuesdayR/articles/curating.html) in celebration of Pi Day (March 14).
The dataset contains the first one million digits of π, beginning with 3.14159 …,
collected from publicly available sources and curated for analysis and visualization.

One million digits of Pi represents an incredible achievement in mathematical computation. While we know Pi is infinite and irrational, having access to a million digits allows for:

- Advanced mathematical research
- Testing computational algorithms
- Statistical analysis of number patterns
- Educational purposes and demonstrations

> "Pi is an irrational number, meaning its decimal representation never ends and never settles into a permanent repeating pattern."" — Eve Andersson, collector of the one million digits dataset

The digits are available from multiple open sources, including:

- [PiDay](https://piday.co/million/)  
- [Eneko Pi (one-million)](https://github.com/eneko/Pi/blob/master/one-million.txt)

These files provide the canonical sequence of π digits, starting with 3.14159, and have been tidied into a structured dataset for this week’s challenge.

- Where does your birthday first appear in π?
- Are the digits of π uniformly distributed across 0–9?
- What patterns or runs of repeated digits occur in the first million digits?
- How can we visualize π creatively (spirals, radial plots, or color-coded art)?
- Does each digit appear exactly 1/10 of the time, or are some more common than others?
- Does the frequency distribution change as you use more digits — does it converge to uniform?
- At what position does the distribution first "stabilise" around 10% each?

Thank you to [Manasseh, #TidyTuesday Community](https://github.com/manassehoduor) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-03-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 12)

pi_digits <- tuesdata$pi_digits

# Option 2: Read directly from GitHub

pi_digits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-24/pi_digits.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-03-24')

# Option 2: Read directly from GitHub and assign to an object

pi_digits = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-24/pi_digits.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-03-24")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

pi_digits = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-24/pi_digits.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
pi_digits = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-24/pi_digits.csv", DataFrame)
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

### `pi_digits.csv`

| variable       | class   | description                                      |
|:---------------|:--------|:-------------------------------------------------|
| digit_position | integer | The sequential index of each digit in the series |
| digit          | integer | The numeric value of the digit (0–9)             |

## Cleaning Script

```r
library(tidyverse)

# Read raw file
pi_raw <- read_file(
  "https://raw.githubusercontent.com/eneko/Pi/master/one-million.txt"
)

# Data cleaning ----

# The file contains a header, then a line with "3.", then 1 million digits of
# pi, with 50 digits per line.

# Keep only the part after "3."
pi_raw_clean <- str_split(pi_raw, "3\\.")[[1]][2]

# Add the leading 3 back
pi_digits_str <- paste0("3", gsub("\\s+", "", pi_raw_clean))

# Extract digits only
pi_digits_clean <- str_extract_all(pi_digits_str, "[0-9]") %>% unlist()

# Convert to tibble
pi_digits <- tibble(
  digit_position = seq_along(pi_digits_clean),
  digit = as.integer(pi_digits_clean)
)

glimpse(pi_digits)

```
