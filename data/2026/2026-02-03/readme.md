# Edible Plants Database

This week we're exploring edible plants! The Edible Plant Database (EPD) is an outcome of the GROW Observatory, a European Citizen Science project on growing food, soil moisture sensing and land monitoring. It contains information on 146 edible plant species, including their ideal growing conditions and time to harvest and germination.

> The Edible Plant Database provides data based on geographical location and growing season to answer questions such as "What can I plant now" and "what can I plant that will yield a crop on some future date".

* Do plants that require more sunlight also require higher temperatures?
* What cultivation classes require the most water?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-02-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 5)

edible_plants <- tuesdata$edible_plants

# Option 2: Read directly from GitHub

edible_plants <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-03/edible_plants.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-02-03')

# Option 2: Read directly from GitHub and assign to an object

edible_plants = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-03/edible_plants.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-02-03")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

edible_plants = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-03/edible_plants.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
edible_plants = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-03/edible_plants.csv", DataFrame)
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

### `edible_plants.csv`

|variable                |class     |description                           |
|:-----------------------|:---------|:-------------------------------------|
|taxonomic_name          |character |Full taxonomic name. |
|common_name             |character |Common name. |
|cultivation             |character |Cultivation class. |
|sunlight                |character |How much sunlight the plant requires. |
|water                   |character |How much water the plant requires. |
|preferred_ph_lower      |double    |Preferred pH (lower limit). |
|preferred_ph_upper      |double    |Preferred pH (upper limit). |
|nutrients               |character |The nutrient level the plant requires. |
|soil                    |character |The type of soil the plant requires. |
|season                  |character |The season the plant grows in. |
|temperature_class       |character |The temperature class of the plant. |
|temperature_germination |character |Optimal germination temperature (Celsius). Often a range of values. |
|temperature_growing     |character |Optimal growing temperature (Celsius). |
|days_germination        |character |Days to germination at optimum temperature. Often a range of values. |
|days_harvest            |character |Days of growing to harvest. |
|nutritional_info        |character |The nutrients found in the plant. |
|energy                  |double    |Energy Value per 100g raw (Kcal). |
|sensitivities           |character |Sensitivities i.e. issues the plant might face. |
|description             |character |General description of the plant. |
|requirements            |character |Longer text description of the plant requirements. |

## Cleaning Script

```r
library(tidyverse)
library(RODBC)

# Source https://discovery.dundee.ac.uk/en/datasets/edible-plant-database/
# does not allow automatic downloads, so the data was downloaded locally. Here
# we assume the data is saved in your `tempdir()`.

download_dir <- tempdir()
data_path <- file.path(download_dir, "plant1.accdb")
raw_data <- odbcConnectAccess2007(data_path)
plants <- sqlFetch(raw_data, "Edible plants")
edible_plants <- plants |>
  as_tibble() |>
  select(
    taxonomic_name = `Full taxonomic name`,
    common_name = `Common name`,
    cultivation = `Cultivation group (Rotational information)`,
    # Requirements
    sunlight = `Sunlight requirements`,
    water = `Water Requirements`,
    preferred_ph = `Preferred pH`,
    nutrients = `Nutrient requirements`,
    soil = Soil,
    season = `Descriptive Growing Season`,
    temperature_class = `Temperature class`,
    temperature_germination = `Optimum Germination Temerature`,
    temperature_growing = `Plant growing ideal temperature`,
    days_germination = `Days to germination at optimum temperature`,
    days_harvest = `Length of gorwing to harvest`,
    # Info
    nutritional_info = `Nutritional information`,
    energy = `Energy Value per 100g raw Kcal`,
    sensitivities = Sensitivities,
    description = `General Description`,
    requirements = `Plant Requirements`
  ) |>
  mutate(
    across(where(is.character), ~ na_if(.x, "Currently no data available."))
  ) |>
  mutate(soil = str_trim(soil)) |>
  mutate(
    energy = if_else(
      is.na(nutritional_info) & energy == 0,
      NA,
      energy
    )
  ) |>
  separate(
    preferred_ph,
    into = c("preferred_ph_lower", "preferred_ph_upper"),
    sep = "-|–",
    fill = "right"
  ) |>
  mutate(
    across(starts_with("preferred"), as.numeric)
  ) |>
  mutate(temperature_growing = str_remove_all(temperature_growing, " ")) |>
  mutate(across(where(is.character), ~ str_squish(.x)))

odbcCloseAll()

```
