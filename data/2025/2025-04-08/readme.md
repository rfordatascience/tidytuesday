# Timely and Effective Care by US State

This week we're exploring state-level results for medicare.gov "timely and effective care" measurements.
As of 2025-04-06, the data is available at the [Centers for Medicare and Medicaid Services (CMS) website](https://data.cms.gov/provider-data/dataset/apyc-v239).
Thanks to former TidyTuesday team member Tracy Teal (@tracykteal) for the dataset suggestion and the link to [a visualization by Kayla Zhu and Christina Kostandi at the Visual Capitalist](https://www.visualcapitalist.com/mapped-emergency-room-visit-times-by-state/).

> Emergency room wait times vary significantly across the United States 
> depending on factors such as hospital resources, patient volume, and staffing 
> levels, with some states facing delays that can stretch for more than three 
> hours.

- Is there a connection between state populations and wait times?
- Which conditions have the longest wait times? The shortest?


Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-04-08')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 14)

care_state <- tuesdata$care_state

# Option 2: Read directly from GitHub

care_state <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-08/care_state.csv')
```

```python
# Using Python
# Option 1: PyDyTuesday python library
## pip install PyDyTuesday

import PyDyTuesday

# Download files from the week, which you can then read in locally
PyDyTuesday.get_date('2025-04-08')

# Option 2: Read directly from GitHub and assign to an object

care_state = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-08/care_state.csv')
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

### `care_state.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|state        |character |The two-letter code for the state (or territory, etc) where the hospital is located. |
|condition    |character |The condition for which the patient was admitted. Six categories of conditions are included in the data. |
|measure_id   |character |The ID of the thing being measured. Note that there are 22 unique IDs but only 21 unique names. |
|measure_name |character |The name of the thing being measured. Note that there are 22 unique IDs but only 21 unique names. |
|score        |double    |The score of the measure. |
|footnote     |character |Footnotes that apply to this measure: 5 = "Results are not available for this reporting period.", 25 = "State and national averages include Veterans Health Administration (VHA) hospital data.", 26 = "State and national averages include Department of Defense (DoD) hospital data.". |
|start_date   |date      |The date on which measurement began for this measure. |
|end_date     |date      |The date on which measurement ended for this measure. |

## Cleaning Script

```r
# Data downloaded manually from https://data.cms.gov/provider-data/dataset/apyc-v239
library(tidyverse)
library(here)
library(janitor)

care_state <- readr::read_csv(
  here::here("Timely_and_Effective_Care-State.csv")
) |> 
  janitor::clean_names() |> 
  dplyr::mutate(
    score = dplyr::na_if(score, "Not Available") |> 
      as.double(),
    dplyr::across(
      dplyr::ends_with("_date"),
      lubridate::mdy
    )
  )

```
