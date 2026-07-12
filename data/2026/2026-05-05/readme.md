# Italian industrial production

[ISTAT (Istituto nazionale di statistica / Italian National Institute of Statistics)](https://www.istat.it/) is the primary source of official statistics in Italy. They publish long-running time series data on industrial production of food and beverages, transport equipment, and textiles covering over 100 years.

> Information on the volumes of some industrial products has been also collected over time by public and private Institutions and published by Istat in the previous Sommari di statistiche storiche (Historical statistics summaries), for the period between 1861 to 1985. This information does not provide a coherent reconstruction of the development of the Italian industrial system; however, for the purposes of completing the historical overview of the statistics in the sector, this chapter does present some parts of the material collected over the years, with specific reference to the food, textiles and transport industries

* Which industries have increased production, and which have decreased?
* How has the average weight per ship changed over time?

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-05-05')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 18)

food_beverages <- tuesdata$food_beverages
textiles <- tuesdata$textiles
transport <- tuesdata$transport

# Option 2: Read directly from GitHub

food_beverages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/food_beverages.csv')
textiles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/textiles.csv')
transport <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/transport.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-05-05')

# Option 2: Read directly from GitHub and assign to an object

food_beverages = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/food_beverages.csv')
textiles = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/textiles.csv')
transport = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/transport.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-05-05")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

food_beverages = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/food_beverages.csv")
textiles = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/textiles.csv")
transport = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/transport.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
food_beverages = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/food_beverages.csv", DataFrame)
textiles = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/textiles.csv", DataFrame)
transport = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-05-05/transport.csv", DataFrame)
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

### `food_beverages.csv`

|variable          |class  |description                           |
|:-----------------|:------|:-------------------------------------|
|Year              |integer |Year. The figures for the years between 1871 and 1950 refer to the fiscal year, which does not necessarily coincide with the calendar year; in particular, for the years between 1931 to 1950 the fiscal year began on 1st July. From 1951 onwards, the figures refer to the calendar year. |
|Sugar             |integer |Sugar produced (tons) |
|Glucose           |integer |Glucose, maltose, invert sugar produced (quintals) |
|Coffee_substitute |integer |Coffee substitute produced (quintals) |
|Seed_oil          |integer |Seed oil produced (quintals) |
|Ethyl_alcohol_1   |integer |Ethyl alcohol (1st category) produced (Ettanidro, 100 litres pure alcohol). |
|Ethyl_alcohol_2   |integer |Ethyl alcohol (2nd category) produced (Ettanidro, 100 litres pure alcohol). |
|Beer              |integer |Beer produced (hectolitres) |

### `textiles.csv`

|variable        |class  |description                           |
|:---------------|:------|:-------------------------------------|
|Year            |integer |Year. |
|Cotton_yarn     |integer |Cotton yarn produced (tons). |
|Flock_yarn      |integer |Flock cotton yarn produced (tons). |
|Other_yarn      |integer |Other fibres and fibre blend cotton yarn produced (tons). |
|Total_yarn      |integer |Total cotton yarn produced (tons). |
|Cotton_textiles |integer |Cotton textiles produced (tons). |
|Flock_textiles  |integer |Flock cotton textiles produced (tons). |
|Other_textiles  |integer |Other fibres and fibre blend cotton textiles produced (tons). |
|Total_textiles  |integer |Total cotton textiles produced (tons). |
|Raw_silk        |integer |Raw silk produced (tons). |

### `transport.csv`

|variable                           |class  |description                           |
|:----------------------------------|:------|:-------------------------------------|
|Year                               |integer |Year. |
|Ships_launched                     |integer |Number of ships launched. |
|Ships_weight                       |integer |Tons of gross tonnage. |
|Steam_and_electric_engine          |integer |Number of steam and electric engine rolling stock in the property of the Italian Railway Service. |
|Rail_cars_and_electric_locomotives |integer |Number of rail cars and electric locomotives rolling stock in the property of the Italian Railway Service. |
|Carriages_and_trailers             |integer |Number of carriages and trailers rolling stock in the property of the Italian Railway Service. |
|Mail_luggage_vans_and_carriages    |integer |Number of mail luggage vans and carriages rolling stock in the property of the Italian Railway Service. |
|Passenger_cars                     |integer |Number of passenger cars. |
|Other                              |integer |Number of other motor vehicles (e.g. lorries, vans and pick-ups, buses, trolleybuses, or special motor vehicles). |

## Cleaning Script

```r
library(tidyverse)
library(readxl)

# Download files ----------------------------------------------------------

download.file("https://seriestoriche.istat.it/fileadmin/documenti/Table_14.4.xls", "italian-industry-production/Table_14.4.xls")
download.file("https://seriestoriche.istat.it/fileadmin/documenti/Table_14.5.xls", "italian-industry-production/Table_14.5.xls")
download.file("https://seriestoriche.istat.it/fileadmin/documenti/Table_14.6.xls", "italian-industry-production/Table_14.6.xls")

# Food and beverages ------------------------------------------------------

raw_data1 <- read_xls("italian-industry-production/Table_14.4.xls",
                      skip = 5, sheet = 1)
raw_data2 <- read_xls("italian-industry-production/Table_14.4.xls",
                      skip = 5, sheet = 2)
data1 <- raw_data1 |>
  drop_na(YEARS) |>
  rename(Year = YEARS,
         Sugar = `Sugar (tons)`,
         Glucose = `Glucose, maltose, invert sugar \n(quintals)`,
         Coffee_substitute = `Coffee substitute (quintals)`,
         Seed_oil = `Seed oil (quintals)`,
         Ethyl_alcohol_1 = `Ethyl alcohol  (ettanidri) (c)`,
         Ethyl_alcohol_2 = `...11`,
         Beer = `Beer (hectolitres)`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)

data2 <- raw_data2 |>
  rename(Year = YEARS,
         Sugar = `Sugar (tons)`,
         Glucose = `Glucose, maltose, invert sugar\n (quintals)`,
         Coffee_substitute = `Coffee substitute (quintals)`,
         Seed_oil = `Seed oil \n(quintals)`,
         Ethyl_alcohol_1 = `Ethyl alcohol  (ettanidri) (c)`,
         Ethyl_alcohol_2 = `...11`,
         Beer = `Beer \n(hectolitres)`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)
food_beverages <- rbind(data1, data2) |>
  mutate(across(
    everything(), as.integer
  ))
write_csv(food_beverages, "italian-industry-production/food_beverages.csv")

# Textiles ----------------------------------------------------------------

raw_data1 <- read_xls("italian-industry-production/Table_14.5.xls",
                      skip = 6, sheet = 1)
raw_data2 <- read_xls("italian-industry-production/Table_14.5.xls",
                      skip = 7, sheet = 2)

data1 <- raw_data1 |>
  rename(Year = "...1",
         Raw_silk = "...12",
         Cotton_yarn = Cotton...2,
         Flock_yarn = Flock...3,
         Other_yarn = `Other fibres and fibre blend...4`,
         Total_yarn = Total...5,
         Cotton_textiles = Cotton...7,
         Flock_textiles = Flock...8,
         Other_textiles = `Other fibres and fibre blend...9`,
         Total_textiles = Total...10
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)

data2 <- raw_data2 |>
  rename(Year = "...1",
         Raw_silk = "...12",
         Cotton_yarn = Cotton...2,
         Flock_yarn = Flock...3,
         Other_yarn = `Other fibres and fibre blend...4`,
         Total_yarn = Total...5,
         Cotton_textiles = Cotton...7,
         Flock_textiles = Flock...8,
         Other_textiles = `Other fibres and fibre blend...9`,
         Total_textiles = Total...10
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year)

textiles <- rbind(data1, data2) |>
  mutate(across(
    everything(), as.integer
  ))
write_csv(textiles, "italian-industry-production/textiles.csv")

# Transport ---------------------------------------------------------------

raw_data1 <- read_xls("italian-industry-production/Table_14.6.xls",
                      skip = 7, sheet = 1)
raw_data2 <- read_xls("italian-industry-production/Table_14.6.xls",
                      skip = 7, sheet = 2)

data1 <- raw_data1 |>
  rename(Year = "...1",
         Ships_launched = Number,
         Ships_weight  = `Tons of gross\n tonnage`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year) |>
  pivot_longer(-Year) |>
  mutate(name = str_remove(name, "\\(c\\)"),
         name = str_trim(name),
         name = str_replace_all(name, "\n", ""),
         name = str_replace_all(name, " ", "_")) |>
  pivot_wider()

data2 <- raw_data2 |>
  rename(Year = "...1",
         Ships_launched = Number,
         Ships_weight  = `Tons of gross tonnage`
  ) |>
  select(!starts_with("...")) |>
  mutate(
    across(everything(), as.numeric)
  ) |>
  drop_na(Year) |>
  pivot_longer(-Year) |>
  mutate(name = str_remove(name, "\\(c\\)"),
         name = str_trim(name),
         name = str_replace_all(name, "\n", ""),
         name = str_replace_all(name, " ", "_")) |>
  pivot_wider()

transport <- rbind(data1, data2) |>
  mutate(across(
    everything(), as.integer
  ))
write_csv(transport, "italian-industry-production/transport.csv")

```
