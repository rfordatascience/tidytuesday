# Income Inequality Before and After Taxes

This week we're exploring Income Inequality Before and After Taxes, as processed and visualized by Joe Hasell at Our World in Data: ["Income inequality before and after taxes: how much do countries redistribute income?"](https://ourworldindata.org/income-inequality-before-and-after-taxes)

All data was processed by [Our World in Data]](https://ourworldindata.org), using these sources:
- [Luxembourg Income Study (2025)](https://www.lisdatacenter.org/our-data/lis-database/)
- [OECD (2024)](https://www.oecd.org/en/data/datasets/income-and-wealth-distribution-database.html)
- [HYDE (2023)](https://public.yoda.uu.nl/geo/UU01/AEZZIT.html)
- [Gapminder - Population v7 (2022)](https://www.gapminder.org/data/documentation/gd003/)
- [UN, World Population Prospects (2024)](https://population.un.org/wpp/downloads?folder=Standard%20Projections&group=Most%20used)
- [Gapminder - Systema Globalis (2022)](https://github.com/open-numbers/ddf--gapminder--systema_globalis)

> The Gini coefficient measures inequality on a scale from 0 to 1. Higher values indicate higher inequality. Inequality is measured here in terms of income before and after taxes and benefits.

- Which countries have the highest Gini coefficient before taxes?
- Which countries have the highest Gini coefficient after taxes?
- Which countries have the highest shifts in Gini coefficient?
- Which countries have the lowest shifts in Gini coefficient?
- Which countries have had the highest changes in redistribution in the available data?

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-08-05')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 31)

income_inequality_processed <- tuesdata$income_inequality_processed
income_inequality_raw <- tuesdata$income_inequality_raw

# Option 2: Read directly from GitHub

income_inequality_processed <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_processed.csv')
income_inequality_raw <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_raw.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-08-05')

# Option 2: Read directly from GitHub and assign to an object

income_inequality_processed = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_processed.csv')
income_inequality_raw = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_raw.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-08-05')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

income_inequality_processed = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_processed.csv")
income_inequality_raw = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_raw.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
income_inequality_processed = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_processed.csv", DataFrame)
income_inequality_raw = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-05/income_inequality_raw.csv", DataFrame)
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

### `income_inequality_processed.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|Entity      |character |Country (or other region) name. |
|Code        |character |Three-digit code when available. |
|Year        |integer   |Year to which the data applies. |
|gini_mi_eq  |double    |The Gini coefficient measures inequality on a scale from 0 to 1. Higher values indicate higher inequality. Income is "pre-tax" — measured before taxes have been paid and most government benefits have been received. Income has been equivalized – adjusted to account for the fact that people in the same household can share costs like rent and heating. |
|gini_dhi_eq |double    |The Gini coefficient measures inequality on a scale from 0 to 1. Higher values indicate higher inequality. Income is "post-tax" — measured after taxes have been paid and most government benefits have been received. Income has been equivalized – adjusted to account for the fact that people in the same household can share costs like rent and heating. |

### `income_inequality_raw.csv`

|variable                   |class     |description                           |
|:--------------------------|:---------|:-------------------------------------|
|Entity                     |character |Country (or other region) name. |
|Code                       |character |Three-digit code when available. Some entities do not have codes, and some have special "OWID" codes, such as "OWID_AKD". |
|Year                       |integer   |Year to which the data applies. |
|gini_disposable__age_total |double    |The Gini coefficient measures inequality on a scale from 0 to 1. Higher values indicate higher inequality. Income is 'post-tax' — measured after taxes have been paid and most government benefits have been received. Income has been equivalized – adjusted to account for the fact that people in the same household can share costs like rent and heating. The entire population of each country is considered, and also the income definition is the newest from the OECD since 2012. For more information on the methodology, visit the [OECD Income Distribution Database (IDD)](http://www.oecd.org/social/income-distribution-database.htm). Survey estimates for 2020 are subject to additional uncertainty and are to be treated with extra caution, as in most countries the survey fieldwork was affected by the Coronavirus (COVID-19) pandemic. |
|gini_market__age_total     |double    |The Gini coefficient measures inequality on a scale from 0 to 1. Higher values indicate higher inequality. Income is 'pre-tax' — measured before taxes have been paid and most government benefits have been received. However, data for China, Hungary, Mexico, Turkey as well as part of the data for Greece refer to the income post taxes and before transfers. Income has been equivalized – adjusted to account for the fact that people in the same household can share costs like rent and heating. The entire population of each country is considered, and also the income definition is the newest from the OECD since 2012. For more information on the methodology, visit the [OECD Income Distribution Database (IDD)](http://www.oecd.org/social/income-distribution-database.htm). Survey estimates for 2020 are subject to additional uncertainty and are to be treated with extra caution, as in most countries the survey fieldwork was affected by the Coronavirus (COVID-19) pandemic. |
|population_historical      |double    |Population by country, available from 10,000 BCE to 2023, based on data and estimates from different sources. |
|owid_region                |character |World regions according to [Our World in Data](https://ourworldindata.org/). |

## Cleaning Script

```r
# Clean data *and* sample instructions for use in R provided by Our World in
# Data via https://ourworldindata.org/income-inequality-before-and-after-taxes.
# Minimal cleaning applied.

library(tidyverse)
library(jsonlite)

income_inequality_raw <- readr::read_csv(
  "https://ourworldindata.org/grapher/inequality-of-incomes-before-and-after-taxes-and-transfers-scatter.csv?v=1&csvType=full&useColumnShortNames=true"
) |>
  dplyr::mutate(
    Year = as.integer(Year)
  )

income_inequality_processed <- readr::read_csv(
  "https://ourworldindata.org/grapher/gini-coefficient-before-and-after-tax-lis.csv?v=1&csvType=full&useColumnShortNames=true"
) |>
  dplyr::mutate(
    Year = as.integer(Year)
  )

# Download metadata for use in construction of data dictionaries.
metadata_raw <- jsonlite::fromJSON(
  "https://ourworldindata.org/grapher/inequality-of-incomes-before-and-after-taxes-and-transfers-scatter.metadata.json?v=1&csvType=full&useColumnShortNames=true"
)

metadata_processed <- jsonlite::fromJSON(
  "https://ourworldindata.org/grapher/gini-coefficient-before-and-after-tax-lis.metadata.json?v=1&csvType=full&useColumnShortNames=true"
)

```
