# WHO TB Burden Data: Incidence, Mortality, and Population

This week, we explore global tuberculosis (TB) burden estimates from the World Health Organization, using data curated via [the getTBinR R package by Sam Abbott](https://samabbott.co.uk/getTBinR/). The dataset includes country-level indicators such as TB incidence, mortality, case detection rates, and population estimates across multiple years. These metrics help researchers, public health professionals, and learners understand the scale and distribution of TB worldwide.

> Tuberculosis remains one of the world’s deadliest infectious diseases. WHO estimates that 10.6 million people fell ill with TB in 2021, and 1.6 million died from the disease. Monitoring TB burden is essential to guide national responses and global strategies.

- Are there any years where global TB metrics show unusual spikes or drops?
- How does TB mortality differ between HIV-positive and HIV-negative populations?
- Which regions show consistent high TB burden across multiple years?

Thank you to [Darakhshan Nehal](https://github.com/darakhshannehal) for curating this week's dataset.

(Note: We removed the original dataset that was slated to run this week after being informed about the history of that dataset. See [Case Study of Pima Indian Diabetes Data: Intersection of Big Data & History](https://www.studocu.com/en-us/document/new-york-university/intro-to-media-studies/digital-natives-by-joanna-radin/12585855) by Dr. Joanna Radin, Associate Professor of History of Medicine and History at Yale University, for a detailed exploration of the issues inherint in that dataset and many like it, and [Diabetes — and Privacy — Meet 'Big Data'](https://researchblog.duke.edu/2016/10/24/diabetes-and-privacy-meet-big-data/) for a summary on the Duke Research Blog by Maya Iskandarani. If you recognize issues with any TidyTuesday dataset, we greatly appreciate an [issue](https://github.com/rfordatascience/tidytuesday/issues) or [pull request](https://github.com/rfordatascience/tidytuesday/blob/main/pr_instructions.md) letting us know!)

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-11-11')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 45)

who_tb_data <- tuesdata$who_tb_data

# Option 2: Read directly from GitHub

who_tb_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/who_tb_data.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-11-11')

# Option 2: Read directly from GitHub and assign to an object

who_tb_data = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/who_tb_data.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-11-11')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

who_tb_data = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/who_tb_data.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
who_tb_data = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-11-11/who_tb_data.csv", DataFrame)
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

### `who_tb_data.csv`

| variable | class | description |
|:---|:---|:---|
| country | character | Country or territory name |
| g_whoregion | character | WHO region |
| iso_numeric | integer | ISO numeric country/territory code |
| iso2 | character | ISO 2-character country/territory code. Note that Namibia's code ("'NA'") includes single quotes to avoid being encoded as missing |
| iso3 | character | ISO 3-character country/territory code |
| year | integer | Year of observation |
| c_cdr | double | Case detection rate (all forms) [also known as TB treatment coverage], percent |
| c_newinc_100k | double | Case notification rate, which is the total of new and relapse cases and cases with unknown previous TB treatment history per 100 000 population (calculated) |
| cfr | double | Estimated TB case fatality ratio |
| e_inc_100k | double | Estimated incidence (all forms) per 100 000 population |
| e_inc_num | integer | Estimated number of incident cases (all forms) |
| e_mort_100k | double | Estimated mortality of TB cases (all forms) per 100 000 population |
| e_mort_exc_tbhiv_100k | double | Estimated mortality of TB cases (all forms, excluding HIV) per 100 000 population |
| e_mort_exc_tbhiv_num | integer | Estimated number of deaths from TB (all forms, excluding HIV) |
| e_mort_num | integer | Estimated number of deaths from TB (all forms) |
| e_mort_tbhiv_100k | double | Estimated mortality of TB cases who are HIV-positive, per 100 000 population |
| e_mort_tbhiv_num | integer | Estimated number of deaths from TB in people who are HIV-positive |
| e_pop_num | integer | Estimated total population number |

## Cleaning Script

```r
# This data is a subset of WHO TB data via the getTBinR package (Sam Abbott)

# Import libraries
library(tidyverse)
library(devtools)

# Install getTBinR package
#devtools::install_github("seabbs/getTBinR")
library(getTBinR)

# Load WHO TB burden data
tb_burden <- get_tb_burden()

# Create a vector of variable of interest
vars_of_interest <- c(
  "country",
  "g_whoregion",
  "iso_numeric",
  "iso2",
  "iso3",
  "year",
  "c_cdr",
  "c_newinc_100k",
  "cfr",
  "e_inc_100k",
  "e_inc_num",
  "e_mort_100k",
  "e_mort_exc_tbhiv_100k",
  "e_mort_exc_tbhiv_num",
  "e_mort_num",
  "e_mort_tbhiv_100k",
  "e_mort_tbhiv_num",
  "e_pop_num"
)

# Subset the dataset 
who_tb_data <- tb_burden %>%
  select(all_of(vars_of_interest))

# No data cleaning needed

```
