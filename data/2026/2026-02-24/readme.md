# Science Foundation Ireland Grants Commitments

This week we're exploring Irish STEM research and ancillary projects funded by Science
Foundation Ireland (SFI) since its foundation in 2000 to its dissolution on 31st
July 2024. The data comes from [Ireland's Open Data Portal](https://data.gov.ie/dataset/science-foundation-ireland-grants-commitments)

> SFI was the national foundation in Ireland for investment in scientific and
> engineering research. Consequently, SFI invested in those academic
> researchers and research teams who were most likely to generate new
> knowledge, leading edge technologies and competitive enterprises in the
> fields of science, technology, engineering and maths (STEM).

- Which Higher Education Institute received the most grant funding?
- How much did Science Foundation Ireland invest into research each year?

Thank you to [Cormac Monaghan](https://github.com/C-Monaghan) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-02-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 8)

sfi_grants <- tuesdata$sfi_grants

# Option 2: Read directly from GitHub

sfi_grants <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-24/sfi_grants.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-02-24')

# Option 2: Read directly from GitHub and assign to an object

sfi_grants = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-24/sfi_grants.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-02-24")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

sfi_grants = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-24/sfi_grants.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
sfi_grants = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-24/sfi_grants.csv", DataFrame)
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

### `sfi_grants.csv`

|variable                    |class     |description                                                                                              |
|:---------------------------|:---------|:--------------------------------------------------------------------------------------------------------|
|start_date                  |date      |Grant start date.                                                                                        |
|end_date                    |date      |Grant end date.                                                                                          |
|proposal_id                 |character |Unique identifier associated with individual awards.                                                     |
|programme_name              |character |Programme group that the awards falls under. In August 2024, a cleaning exercise was carried out on programme naming fields. As such, some programme names may vary slightly from previous iterations of this dataset. |
|sub_programme               |character |Programme subdivisions. In August 2024, a cleaning exercise was carried out on programme naming fields. As such, some sub-programme names may vary slightly from previous iterations of this dataset. |
|supplement                  |character |Where further funding is awarded to supplement existing grants, the type of supplement is detailed here. In August 2024, a cleaning exercise was carried out on programme naming fields. As such, some awards may have been recategorised as supplements and the supplement names may vary slightly from previous iterations of this dataset. "STTF" refers to "Short Term Travel Fellowship" supplements. |
|research_body               |character |Higher Education Institute to which the award was made.                                                  |
|research_body_ror_id        |character |Research Organization Registry (ROR) ID of the Organisation.                                             |
|funder_name                 |character |Name of funder.                                                                                          |
|crossref_funder_registry_id |character |Unique identifier associated with funder.                                                                |
|proposal_title              |character |Title of the grant application.                                                                          |
|current_total_commitment    |double    |Full value of the grant.                                                                                 |

## Cleaning Script

```r
################################################################################
# Science Foundation Ireland (SFI) Grants Commitments
# https://www.sfi.ie/about-us/governance/open-data/Open-Data-2024-07-31.csv
# Accessed 2026-02-22
################################################################################

# Packages ---------------------------------------------------------------------
library(readr)
library(dplyr)
library(stringr)

# Loading and tidying dataset --------------------------------------------------
sfi_grants_raw <- readr::read_csv(
  "https://www.sfi.ie/about-us/governance/open-data/Open-Data-2024-07-31.csv"
)
sfi_grants <- sfi_grants_raw |>
  janitor::clean_names() |>
  dplyr::select(
    start_date,
    end_date,
    proposal_id,
    programme_name,
    sub_programme,
    supplement,
    research_body,
    research_body_ror_id,
    funder_name,
    crossref_funder_registry_id,
    proposal_title,
    current_total_commitment
  ) |>
  # 1. Change dates from character format to date format
  # 2. current_total_commitment is currently as character but for some values has
  #   a comma and or () in it. We will remove these before converting to a numeric.
  dplyr::mutate(
    start_date = as.Date(start_date),
    end_date = as.Date(end_date),
    current_total_commitment = stringr::str_remove_all(
      current_total_commitment,
      "\\(|,|\\)"
    ),
    current_total_commitment = as.double(current_total_commitment)
  ) |>
  # 3. A few columns sometimes code NA as "#N/A" rather than "".
  dplyr::mutate(
    dplyr::across(
      c(programme_name, sub_programme, supplement),
      \(x) {
        dplyr::na_if(x, "#N/A")
      }
    )
  )

```
