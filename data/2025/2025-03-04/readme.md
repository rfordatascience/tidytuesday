# Long Beach Animal Shelter

This week we're exploring the [Long Beach Animal Shelter Data](https://data.longbeach.gov/explore/dataset/animal-shelter-intakes-and-outcomes/information/)! 

The dataset comes from the [City of Long Beach Animal Care Services](https://www.longbeach.gov/acs/) via the [{animalshelter}](https://emilhvitfeldt.github.io/animalshelter/) R package.

> This dataset comprises of the intake and outcome record from Long Beach Animal Shelter.

- How has the number of pet adoptions changed over the years?
- Which type of pets are adopted most often?



Thank you to [Lydia Gibson](https://github.com/lgibson7) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-03-04')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 9)

longbeach <- tuesdata$longbeach

# Option 2: Read directly from GitHub

longbeach <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-04/longbeach.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-03-04')

# Option 2: Read directly from GitHub and assign to an object

longbeach = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-03-04/longbeach.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)  

## PydyTuesday: A Posit collaboration with TidyTuesday  

- Exploring the TidyTuesday data in Python?  Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

### Data Dictionary

# `longbeach.csv`

|variable          |class         |description                           |
|:-----------------|:-------------|:-------------------------------------|
|animal_id         |character     |Unique identification for each animal. |
|animal_name       |character     |Name of the Animal (Blank value means name not known). Animals with "*" are given by shelter staff.  |
|animal_type       |factor        |Species name of the animal. |
|primary_color     |factor        |The predominant color of the animal. |
|secondary_color   |factor        |Additional coloring, less predominant than the primary color. |
|sex               |factor        |Altered Sex of the animal. |
|dob               |date          |Date of Birth (if blank, DOB unknown). |
|intake_date       |date          |Date on which Animal was brought to the shelter . |
|intake_condition  |factor        |Condition of animal at intake. |
|intake_type       |factor        |The reason for intake such as stray capture, wildlife captures, adopted but returned, owner surrendered etc. |
|intake_subtype    |factor        |The method or secondary manner in which the animal was admitted to the shelter. |
|reason_for_intake |factor        |The reason an owner surrendered their animal. |
|outcome_date      |date          |Exit or Outcome date such as date of adoption or date animal died. |
|crossing          |character     |Intersection/Cross street of intake or capture. |
|jurisdiction      |factor        |Geographical jurisdiction of where an animal originated. |
|outcome_type      |factor        |Outcome associated with animal - adopted, died, euthanized etc. |
|outcome_subtype   |factor        |Secondary manner in which the animal left the shelter, usually used to identify which program, group, or other data useful in measuring program efficiency. |
|latitude          |double        |The latitude of the crossing. |
|longitude         |double        |The longitude of the crossing. |
|outcome_is_dead   |logical       |Whether animal is dead at outcome. |
|was_outcome_alive |logical       |Whether animal was alive at outcome. |
|geopoint          |character     |Latitude and longitude of crossing. |

### Cleaning Script

```r
# Clean data provided by {animalshelter} R package (https://emilhvitfeldt.github.io/animalshelter/). No cleaning was necessary.
# install.packages("devtools")
# devtools::install_github("EmilHvitfeldt/animalshelter")
library(dplyr)
library(animalshelter)

longbeach <- animalshelter::longbeach |>
  dplyr::mutate(
    was_outcome_alive = as.logical(was_outcome_alive),
    dplyr::across(
      c(
        "animal_type",
        "primary_color",
        "secondary_color",
        "sex",
        "intake_condition",
        "intake_type",
        "intake_subtype",
        "reason_for_intake",
        "jurisdiction",
        "outcome_type",
        "outcome_subtype"
      ),
      as.factor
    )
  ) |> 
    dplyr::select(-"intake_is_dead")
```
