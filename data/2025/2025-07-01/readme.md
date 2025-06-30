# Weekly US Gas Prices

This week we're exploring weekly US gas prices! The data comes from the U.S. Energy Information Administration (EIA), which publishes average retail gasoline and diesel prices each Monday. The original data (including additional datasets) can be found at [eia.gov/petroleum/gasdiesel](https://www.eia.gov/petroleum/gasdiesel/), and the weekly time series used here was downloaded from [this XLS file](https://www.eia.gov/dnav/pet/xls/PET_PRI_GND_DCUS_NUS_W.xls).

Gas price methodology:
> "Every Monday, retail prices for all three grades of gasoline are collected mainly by telephone and email from a sample of approximately 1,000 retail gasoline outlets. The prices are published around 5:00 p.m. ET Monday, except on government holidays, when the data are released on Tuesday (but still represent Monday's price). The reported price includes all taxes and is the cash pump price paid by a consumer as of 8:00 a.m. Monday. This price represents the self-serve price except in areas having only full-serve. The price data from the sample are used to calculate volume-weighted average gasoline price estimates at the national, regional, and selected city and state levels for all gasoline grades and formulations."


Diesel price methodology:
> "Every Monday, cash self-serve on-highway diesel prices (including taxes) are collected from a sample of approximately 590 retail diesel outlets in the continental United States. The sample includes a combination of truck stops and service stations that sell on-highway diesel fuel. The data represent the price of ultra low sulfur diesel (ULSD), which contains less than 15 parts-per-million sulfur. All collected prices are subjected to automated edit checks during data collection and data processing. Data flagged by the edits are verified with the respondents. Imputation is used for companies that cannot be contacted and for reported prices that are extreme outliers. The average survey response rate for 2020 was 98%. Average national and regional prices are released around 5:00 p.m. ET on Mondays, except on government holidays, in which case the data are released on Tuesday (but still represent Monday's price)."


- How did gas prices behave during major events like the 2008 recession or COVID-19 pandemic?
- Are diesel prices more or less volatile than gasoline prices?
- Do different grades or formulations of gasoline follow similar trends?

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-07-01')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 26)

weekly_gas_prices <- tuesdata$weekly_gas_prices

# Option 2: Read directly from GitHub

weekly_gas_prices <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-01/weekly_gas_prices.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-07-01')

# Option 2: Read directly from GitHub and assign to an object

weekly_gas_prices = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-01/weekly_gas_prices.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-07-01')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

weekly_gas_prices = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-01/weekly_gas_prices.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
weekly_gas_prices = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-01/weekly_gas_prices.csv", DataFrame)
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

### `weekly_gas_prices.csv`

|variable    |class  |description                                                                 |
|:-----------|:------|:---------------------------------------------------------------------------|
|date        |date   |The week-ending date for the reported fuel price.                          |
|fuel        |factor |The type of fuel reported (gasoline or diesel).                            |
|grade       |factor |The grade or specification of the fuel (for gasoline: all, regular, midgrade, or premium; for diesel: all, ultra_low_sulfur, low_sulfur). |
|formulation |factor |The formulation of the gasoline (all, conventional, or reformulated). Only applies to gasoline.        |
|price       |double |The average U.S. retail price per gallon in U.S. dollars for that fuel type.|

## Cleaning Script

```r
# Data downloaded manually from
# https://www.eia.gov/dnav/pet/xls/PET_PRI_GND_DCUS_NUS_W.xls to tempdir.
file_path <- fs::path_temp("PET_PRI_GND_DCUS_NUS_W.xls")

weekly_gas_prices <- readxl::read_xls(file_path, sheet = "Data 1", skip = 2) |>
  dplyr::select(
    date = "Date",
    gasoline.all.all = "Weekly U.S. All Grades All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.all.conventional = "Weekly U.S. All Grades Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.all.reformulated = "Weekly U.S. All Grades Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.regular.all = "Weekly U.S. Regular All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.regular.conventional = "Weekly U.S. Regular Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.regular.reformulated = "Weekly U.S. Regular Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.midgrade.all = "Weekly U.S. Midgrade All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.midgrade.conventional = "Weekly U.S. Midgrade Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.midgrade.reformulated = "Weekly U.S. Midgrade Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.premium.all = "Weekly U.S. Premium All Formulations Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.premium.conventional = "Weekly U.S. Premium Conventional Retail Gasoline Prices  (Dollars per Gallon)",
    gasoline.premium.reformulated = "Weekly U.S. Premium Reformulated Retail Gasoline Prices  (Dollars per Gallon)",
    diesel.all = "Weekly U.S. No 2 Diesel Retail Prices  (Dollars per Gallon)",
    diesel.ultra_low_sulfur = "Weekly U.S. No 2 Diesel Ultra Low Sulfur (0-15 ppm) Retail Prices  (Dollars per Gallon)",
    diesel.low_sulfur = "Weekly U.S. No 2 Diesel Low Sulfur (15-500 ppm) Retail Prices  (Dollars per Gallon)"
  ) |>
  dplyr::mutate(date = as.Date(date)) |>
  tidyr::pivot_longer(
    cols = -date,
    names_to = "fuel_spec",
    values_to = "price"
  ) |>
  dplyr::filter(!is.na(price)) |>
  tidyr::separate_wider_delim(
    cols = fuel_spec,
    delim = ".",
    names = c("fuel", "grade", "formulation"),
    too_few = "align_start"
  ) |>
  dplyr::mutate(
    dplyr::across(c(fuel, grade, formulation), as.factor)
  )

```
