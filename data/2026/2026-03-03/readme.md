# Golem Grad Tortoise Data

The datasets this week come from the paper "[Sex Ratio Bias Triggers Demographic Suicide in a Dense Tortoise Population](https://onlinelibrary.wiley.com/doi/10.1111/ele.70296)".
This topic seemed so interesting that even media like the New York Times picked it up:
"[Constant Sexual Aggression Drives Female Tortoises to Walk Off Cliffs](https://www.nytimes.com/2026/02/14/science/tortoises-island-sex-cliff.html)".

> In an exceptionally dense island population of Hermann's tortoises 
> in Lake Prespa in North Macedonia, sexually coercive males 
> dramatically overnumber females, inflict severe copulatory injuries 
> and put them at risk of fatal falls from the island plateau's sheer 
> rock faces. Harassed females are emaciated, reproduce less frequently,
> produce smaller clutches and have lower annual survival rates compared 
> to females from a neighbouring mainland population. Sixteen years of 
> capture-recapture data reveal an ongoing extinction event and predict
> that the last island female will die in 2083. 

- Do recaptures happen more often in spring or summer? 
- Does it seem easier to recapture male or female tortoises?
- What are the differences among tortoises from the mainland vs the ones from the island in terms of body mass or carapace length?

Thank you to [Novica Nakov, Free Software Macedonia](https://github.com/novica) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-03-03')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 9)

clutch_size_cleaned <- tuesdata$clutch_size_cleaned
tortoise_body_condition_cleaned <- tuesdata$tortoise_body_condition_cleaned

# Option 2: Read directly from GitHub

clutch_size_cleaned <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/clutch_size_cleaned.csv')
tortoise_body_condition_cleaned <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/tortoise_body_condition_cleaned.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-03-03')

# Option 2: Read directly from GitHub and assign to an object

clutch_size_cleaned = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/clutch_size_cleaned.csv')
tortoise_body_condition_cleaned = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/tortoise_body_condition_cleaned.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-03-03")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

clutch_size_cleaned = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/clutch_size_cleaned.csv")
tortoise_body_condition_cleaned = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/tortoise_body_condition_cleaned.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
clutch_size_cleaned = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/clutch_size_cleaned.csv", DataFrame)
tortoise_body_condition_cleaned = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/tortoise_body_condition_cleaned.csv", DataFrame)
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

### `clutch_size_cleaned.csv`

|variable                    |class     |description                           |
|:---------------------------|:---------|:-------------------------------------|
|individual                  |integer   |The ID of the individual. |
|age                         |integer   |The age of the individual. |
|date                        |date      |Date of the record. |
|locality                    |character |Locality. |
|eggs                        |integer   |Number of eggs. |
|body_mass_grams             |integer   |The body mass of the individual in grams. |
|straight_carapace_length_mm |integer   |The carapace length in millimeters. |

### `tortoise_body_condition_cleaned.csv`

|variable                    |class     |description                           |
|:---------------------------|:---------|:-------------------------------------|
|individual                  |character |The ID of the individual. Here it is a character type because some IDs include letters. |
|year                        |integer   |The year the measurement was taken. |
|year_recode                 |integer   |Per-individual observation index: 1 for the first year an individual was observed, 2 for the second, and so on, ordered by year/recapture. |
|season                      |character |Season of the year. |
|locality                    |character |Locality. |
|sex                         |character |Sex. |
|body_mass_grams             |double    |The body mass of the individual in grams. |
|body_condition_index        |double    |The index for the body condition. |
|straight_carapace_length_mm |double    |The carapace length in millimeters. |

## Cleaning Script

```r
# The data is part of the supplemental material released with the paper
# Paper: https://onlinelibrary.wiley.com/doi/10.1111/ele.70296
# Data and code: https://figshare.com/articles/journal_contribution/Sex_ratio_bias_triggers_demographic_suicide_in_a_dense_tortoise_population/30752687

# It seems it is not possible to download programatically, therefore I am
# downloading and unziping the file into
# data-raw/Sex_ratio_bias_triggers_demographic_suicide-main/R/input in two files
# body_condition.csv and clutch_size.csv

library(dplyr)
library(readr)

# Clean body_condition.csv
tortoise_body_condition <- readr::read_csv(
  "data-raw/Sex_ratio_bias_triggers_demographic_suicide-main/R/input/body_condition.csv"
)

# The dataset is not documented within the released zip file

tortoise_body_condition_cleaned <- tortoise_body_condition |>
  # remove the column that seems like a row number
  # remove the column that is probably a modeling residual,,
  # the column that is pasting together location and sex,
  # and the log_BCI column
  dplyr::select(-c(...1, res, log_BCI, loc_sex_cohort)) |>
  # gruoup by individual and arrange by year_recode which
  # increments for every measurement of the individual
  dplyr::group_by(ind) |>
  dplyr::arrange(year_recode, .by_group = TRUE) |>
  dplyr::ungroup() |>
  # rename columns so it's clearer what they mean
  dplyr::rename(
    straight_carapace_length_mm = SCL,
    body_mass_grams = BM, # we are assuming it's grams
    body_condition_index = BCI,
    individual = ind,
    locality = loc
  ) |>
  # arrange column in more meaningful order
  dplyr::relocate(
    individual,
    year,
    year_recode,
    season,
    locality,
    sex,
    body_mass_grams,
    body_condition_index,
    straight_carapace_length_mm
  ) |>
  # add more then initial so some columns
  dplyr::mutate(
    locality = locality |>
      dplyr::recode_values(
        "b" ~ "Beach",
        "p" ~ "Plateau",
        "k" ~ "Konjsko"
      )
  ) |>
  dplyr::mutate(
    season = season |>
      dplyr::recode_values(
        "sum" ~ "Summer",
        "sp" ~ "Spring"
      )
  )

# Clean body_condition.csv
clutch_size <- readr::read_csv(
  "data-raw/Sex_ratio_bias_triggers_demographic_suicide-main/R/input/clutch_size.csv"
)

# Smaller and easier dataset to clean
# with excel dates the only major issue.
clutch_size_cleaned <- clutch_size |>
  dplyr::rename(
    individual = ind,
    locality = Locality,
    straight_carapace_length_mm = SCL,
    body_mass_grams = BM,
    eggs = Eggs,
    date = Date,
    age = Age
  ) |>
  dplyr::mutate(date = as.Date(date, origin = "1899-12-30")) |>
  dplyr::relocate(
    individual,
    age,
    date,
    locality,
    eggs,
    body_mass_grams,
    straight_carapace_length_mm
  )

```
