# Can an exploding snowman predict the summer season?

This week we're exploring the weather prediction of Zurich's infamous exploding snowman!

> The Boeoegg is a snowman effigy made of cotton wool and stuffed with fireworks, created every year for Zurich's "Sechselaeuten" spring festival. The saying goes that the quicker the Boeoeg's head explodes, the finer the summer will be. 

- Check the burn duration of our snowman against the average summer temperature. Does folk science stand its ground against hard science?
- Can you find a number of successive years so that our snowman's predictions seem more accurate? 
- Does our snowman's forecasting ability improve if you choose climate variables other than temperature?
- What happened in the years for which there was no duration recorded? You can check the Wikipedia entry for "Sechselaeuten" for some funny anecdotes!

Thank you to [Matt](https://github.com/econmaett) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-12-02')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 48)

sechselaeuten <- tuesdata$sechselaeuten

# Option 2: Read directly from GitHub

sechselaeuten <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/sechselaeuten.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-12-02')

# Option 2: Read directly from GitHub and assign to an object

sechselaeuten = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/sechselaeuten.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-12-02')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

sechselaeuten = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/sechselaeuten.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
sechselaeuten = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-02/sechselaeuten.csv", DataFrame)
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

### `sechselaeuten.csv`

|variable |class   |description                           |
|:--------|:-------|:-------------------------------------|
|year     |double  |Year of Sechselauten festival. |
|duration |double  |Time elapsed from ignition of Boeoeg effigy until explosion, in minutes. |
|tre200m0 |double  |Average air temperature 2 m above ground in degrees Celsius (monthly mean). |
|tre200mn |double  |Minimum air temperature 2 m above ground in degrees Celsius (absolute monthly minimum). |
|tre200mx |double  |Maximum air temperature 2 m above ground in degrees Celsius (absolute monthly maximum). |
|sre000m0 |double  |Total sunshine duration in hours (monthly total). |
|sremaxmv |double  |Total sunshine duration as a percentage of the possible maximum. |
|rre150m0 |double  |Total precipitation in mm (monthly total). |
|record   |logical |Years with average summer temperature above 19 degrees Celsius. |

## Cleaning Script

```r
libary(tidyverse)

## burn duration ----
# https://github.com/philshem/Sechselaeuten-data
burn_duration <- readr::read_csv(
  file = "https://raw.githubusercontent.com/philshem/Sechselaeuten-data/refs/heads/master/boeoegg_burn_duration.csv"
) |>
  dplyr::mutate(duration = round(burn_duration_seconds / 60, digits = 2)) |>
  dplyr::select(year, duration)

## variable selection ----
variable_selection <- c(
  "tre200m0",
  "tre200mn",
  "tre200mx",
  "sre000m0",
  "sremaxmv",
  "rre150m0"
)

## climate data ----
climate_data <- readr::read_delim(
  file = "https://data.geo.admin.ch/ch.meteoschweiz.ogd-smn/sma/ogd-smn_sma_m.csv",
  delim = ";"
) |>
  dplyr::select(
    date = reference_timestamp,
    dplyr::any_of(variable_selection)
  ) |>
  dplyr::mutate(
    date = lubridate::dmy_hm(date),
    year = lubridate::year(date),
    month = lubridate::month(date)
  ) |>
  dplyr::filter(month %in% 6:8) |>
  dplyr::group_by(year) |>
  dplyr::summarise(dplyr::across(.cols = -c(date, month), .fns = \(x) {
    mean(x, na.rm = TRUE)
  })) |>
  dplyr::ungroup() |>
  dplyr::mutate(sre000m0 = sre000m0 / 60) |>
  dplyr::mutate(dplyr::across(.cols = -c(year), .fns = \(x) {
    round(x, digits = 2)
  })) |>
  dplyr::mutate(dplyr::across(.cols = -c(year), .fns = \(x) {
    ifelse(is.nan(x), NA, x)
  }))

## combine datasets ----
sechselaeuten <- dplyr::left_join(
  x = burn_duration,
  y = climate_data,
  by = dplyr::join_by(year)
) |>
  dplyr::mutate(record = ifelse(tre200m0 >= 19, TRUE, FALSE))

```
