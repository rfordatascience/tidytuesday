# Health metrics in urban centres worldwide

This week we're exploring the Global Human Settlement Urban Centre Database Produced by the Joint Research Centre (JRC) of the European Commission, part of the Copernicus Emergency Management Service. These are open and free data and tools to assess the human presence on the planet. The dataset covers more than 10,000 urban centres worldwide, each delineated using a population density, size, and grid-cell contiguity method called the Degree of Urbanisation. Here, we are specifically looking at the Health component which details information regarding hospitals and pharmacies in urban centers. 

> This dataset contains statistics on urban centres based on data from the Global Human Settlement Layer (GHSL) produced at the Joint Research Centre of the European Commission, unit E.1 (Disaster Risk Management). This release is based on the GHSL Data Package 2023, the Degree of Urbanisation to delineate spatial entities, and geospatial data integration from a variety of open source datasets to characterise them. The result is the most complete information system on cities to date with data for 11,422 quality-controlled urban centres across 15 thematic domains [Health is one of them], 471 indicators, and 2600 attributes. 

**Reference**

Mari Rivero, Ines;  Melchiorri, Michele;  Florio, Pietro;  Schiavina, Marcello;  Goch, Katarzyna;  Politis, Panagiotis;  Uhl, Johannes H;  Pesaresi, Martino;  Maffenini, Luca;  Sulis, Patrizia;  Crippa, Monica;  Guizzardi, Diego;  Pisoni, Enrico;  Belis, Claudio;  Jacome Felix Oom, Duarte;  Branco, Alfredo;  Mwaniki, Dennis;  Kochulem, Edwin;  Githira, Daniel;  Carioli, Alessandra;   Ehrlich, Daniele;  Tommasi, Pierpaolo;  Kemper, Thomas;  Dijkstra, Lewis (2026): GHS-UCDB R2024A - GHS Urban Centre Database 2025. European Commission, Joint Research Centre [Dataset] doi: 10.2905/JRC.05RDPR0; 10.2905/1a338be6-7eaf-480c-9664-3a8ade88cbcd PID: http://data.europa.eu/89h/1a338be6-7eaf-480c-9664-3a8ade88cbcd

**Questions**

- Which urban centre or country has the most number of hospitals and/or pharmacies per capita in 2025? 
- Do urban centres that belong to a higher income group have a higher density of hospitals compared to those in a lower income group? 
- Do cities with more hospitals also have more pharmacies, or are the two resources unrelated?
- Are there cities well-served by pharmacies but not hospitals (or the otherway around)?

Thank you to [Gabriela Palomo-Munoz](https://github.com/GabsPalomo) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-09-29')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 39)

health <- tuesdata$health

# Option 2: Read directly from GitHub

health <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-29/health.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-09-29')

# Option 2: Read directly from GitHub and assign to an object

health = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-29/health.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-09-29")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

health = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-29/health.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
health = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-09-29/health.csv", DataFrame)
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

### `health.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|ID_UC_G0        |double    |Unique ID. |
|GC_UCN_MAI_2025 |character |Urban Centre Main Name. |
|GC_CNT_GAD_2025 |character |Country name. GADM. |
|GC_UCA_KM2_2025 |double    |Urban centre area in 2025. |
|GC_POP_TOT_2025 |double    |Urban centre total population. |
|GC_DEV_WIG_2025 |character |World Bank Income Group. |
|GC_DEV_USR_2025 |character |UN SDG Region, geographic and statistical groupings of countries used by the UN. |
|HL_FCL_HOS_2024 |double    |Number of hospitals in 2024. |
|HL_FCL_PHA_2024 |double    |Number of pharmacies in 2024. |
|HL_FDE_HOS_2024 |double    |Number of hospitals per urban centre area (km2) in 2024. |
|HL_FDE_PHA_2024 |double    |Number of pharmacies per urban centre area (km2) in 2024. |
|HL_FPC_HOS_2025 |double    |Number of hospitals per capita in 2025. |
|HL_FPC_PHA_2025 |double    |Number of pharmacies per capita in 2025. |
|HL_POP_HOS_2025 |double    |Population living within 1 km buffer from a hospital in 2025. |
|HL_POP_PHA_2025 |double    |Population living within 1 km buffer from a pharmacy in 2025. |
|HL_SHP_HOS_2025 |double    |Share of the urban centre population living within 1 km buffer from a hospital in 2025. |
|HL_SHP_PHA_2025 |double    |Share of the urban centre population living within 1 km buffer from a pharmacy in 2025. |

## Cleaning Script

```r
# Packages 
library(readr)
library(dplyr)
library(tidyr)

url <- "https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_UCDB_GLOBE_R2024A/GHS_UCDB_THEME_GLOBE_R2024A/GHS_UCDB_THEME_HEALTH_GLOBE_R2024A/V1-2/GHS_UCDB_THEME_HEALTH_GLOBE_R2024A_V1_2.zip"

# let's set the path as a .zip 
zip_path <- tempfile(fileext = ".zip")

# mode = "wb" is essential on Windows to download the file, harmless elsewhere
download.file(url, 
              zip_path, 
              mode = "wb")   # uses fs 

# This creates a temporary file so the .zip file is stored there
(exdir <- tempfile())
unzip(zip_path, exdir = exdir)

list.files(exdir, recursive = TRUE)
# Now let's open the actual file we need. 
# Copy .csv from list.files() in the console
health <- readr::read_csv(file.path(exdir, 'GHS_UCDB_THEME_HEALTH_GLOBE_R2024A.csv'), 
                          na = '-')

# Let's check how many NAs each column has
health |>
  summarise(across(everything(), \(x) sum(is.na(x)))) |> 
  pivot_longer(everything(), names_to = "column", values_to = "n_missing") |>
  mutate(n_rows = nrow(health)) |>
  arrange(desc(n_missing))

```
