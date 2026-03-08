# Lead concentration in Flint water samples in 2015

This week we are exploring lead levels in water samples collected in Flint, Michigan in 2015. 
The data comes from a paper by [Loux and Gibson (2018)](https://onlinelibrary.wiley.com/doi/pdf/10.1111/test.12187?casa_token=av3lP7OmqS0AAAAA:QAF3yU5kGzsUkqi1VlXkMlIN8ExolHZBSkdJ3hIHnlptUES57dGVoXjE3qdwPPHtLHNRd9VvX1x8f6VN) 
who advocate for using this data as a teaching example in introductory statistics courses. 

> The Flint lead data provide a compelling example for introducing students to simple univariate descriptive statistics. In addition, they provide examples for discussion
of sampling and data collection, as well as ethical data handling.

The data this week includes samples collected by the Michigan Department of Environment (MDEQ) and data from a citizen science project coordinated by Prof Marc Edwards and colleagues at Virginia Tech. 
Community-sourced samples were collected after concerns were raised about the MDEQ excluding samples from their data. You can read about the ["murky" story behind this data here](https://academic.oup.com/jrssig/article/14/2/16/7029247). 

Thank you to @nzgwynn for submitting this dataset in #23!

- How does the distribution of lead levels differ between MDEQ and Virginia Tech datasets?
- How do key statistics (mean, median, 90th percentile) change with/without excluded samples in the MDEQ sample?

Thank you to [Jen Richmond](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-11-04')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 44)

flint_mdeq <- tuesdata$flint_mdeq
flint_vt <- tuesdata$flint_vt

# Option 2: Read directly from GitHub

flint_mdeq <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_mdeq.csv')
flint_vt <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_vt.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-11-04')

# Option 2: Read directly from GitHub and assign to an object

flint_mdeq = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_mdeq.csv')
flint_vt = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_vt.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-11-04')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

flint_mdeq = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_mdeq.csv")
flint_vt = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_vt.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
flint_mdeq = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_mdeq.csv", DataFrame)
flint_vt = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-04/flint_vt.csv", DataFrame)
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

### `flint_mdeq.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|sample   |double |sample number |
|lead     |double |lead level in parts per billion (all samples) |
|lead2    |double |lead level in parts per billion (2 samples removed) |
|notes    |character |comment about data removal |

### `flint_vt.csv`

|variable |class   |description                           |
|:--------|:-------|:-------------------------------------|
|sample   |integer |sample number |
|lead     |double  |lead levels in parts per billion (ppb)|

## Cleaning Script

```r
# data downloaded from https://onlinelibrary.wiley.com/doi/10.1111/test.12187 
# notes variable added to flint_mdeq to explain why samples were removed

# Set the data directory. Change this if your data is in a different location.
data_dir <- "tt_submission"  # Expected structure: data_dir contains test12187-supp-0001-flint.rdata

load(here::here(data_dir, "test12187-supp-0001-flint.rdata"))

# add notes

flint_mdeq <- flint_mdeq %>% 
  mutate(notes = case_when(lead == 104 & is.na(lead2) ~ "sample removed: house had a filter",
                           lead == 20 & is.na(lead2) ~ "sample removed: business not residence"))

```
