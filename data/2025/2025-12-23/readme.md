# The Languages of the World

This week we're exploring **The Languages of the World**, curated from [Glottolog 5.2.1](https://glottolog.org), an open-access database in linguistics, maintained by the Max Planck Institute for Evolutionary Anthropology.

> Glottolog is the most comprehensive language database in linguistics, and contains information (names, genealogy, geographical information, endangerment status, etc.) of over 8,000 languages of the world.

-   Which macroareas have the highest concentration of endangered languages?
-   Are language isolates more likely to be endangered?
-   Which language families span the widest geographic range?
-   What geographic patterns emerge when mapping endangered languages?

Thank you to Darakhshan Nehal for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-12-23')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 51)

endangered_status <- tuesdata$endangered_status
families <- tuesdata$families
languages <- tuesdata$languages

# Option 2: Read directly from GitHub

endangered_status <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/endangered_status.csv')
families <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/families.csv')
languages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/languages.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-12-23')

# Option 2: Read directly from GitHub and assign to an object

endangered_status = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/endangered_status.csv')
families = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/families.csv')
languages = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/languages.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-12-23')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

endangered_status = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/endangered_status.csv")
families = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/families.csv")
languages = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/languages.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
endangered_status = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/endangered_status.csv", DataFrame)
families = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/families.csv", DataFrame)
languages = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-12-23/languages.csv", DataFrame)
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

### `endangered_status.csv`

| Variable | Class | Description |
|----------------|-----------|-------------------------------------------------|
| `id` | character | Unique identifier for language |
| `status_code` | character | Code of the agglomerated endangerment status (1–6) |
| `status_label` | character | Descriptive label of endangerment category |

### `families.csv`

| Variable | Class     | Description                           |
|----------|-----------|---------------------------------------|
| `id`     | character | Unique identifier for language family |
| `name`   | character | Language family name                  |

### `languages.csv`

| Variable | Class | Description |
|----|----|----|
| `id` | character | Unique identifier for language |
| `name` | character | Language name |
| `macroarea` | character | General geographic area in which the language is found |
| `latitude` | double | Latitude of language location (as point) |
| `longitude` | double | Longitude of language location (as point) |
| `iso639p3code` | character | ISO 639-3 identifier of language (if available) |
| `countries` | character | Countries in which language is used (separated by ";") |
| `is_isolate` | logical | Whether language is an isolate (i.e. has no known relatives) |
| `family_id` | character | Unique identifier of family that the language is part of (if not isolate) |

## Cleaning Script

```r
# Imports
library(tidyverse)

# Download raw data and filter to endangered status
endangered_status <- 
  readr::read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/refs/heads/master/cldf/values.csv") |> 
  dplyr::filter(Parameter_ID == "aes") |> 
  dplyr::select(Language_ID, Value, Code_ID) |> 
  dplyr::rename(id = Language_ID,
                status_code = Value,
                status_label = Code_ID) |> 
  dplyr::mutate(status_label = stringr::str_replace(stringr::str_remove(status_label, "^aes-"), "_", " "))

# Download language and family data
fam_lgs <- 
  readr::read_csv("https://raw.githubusercontent.com/glottolog/glottolog-cldf/refs/heads/master/cldf/languages.csv")

# Filter and clean language family data
families <- 
  fam_lgs |> 
  dplyr::filter(Level == "family") |> 
  dplyr::select(ID, Name) |> 
  dplyr::rename(Family = Name) |> 
  dplyr::rename_with(stringr::str_to_lower, dplyr::everything())

# Filter and clean language data
languages <- 
  fam_lgs |> 
  dplyr::filter(Level == "language") |> 
  dplyr::select(ID, Name, Macroarea, Latitude, Longitude, ISO639P3code, Countries, Is_Isolate, Family_ID) |> 
  dplyr::rename_with(stringr::str_to_lower, dplyr::everything())

```
