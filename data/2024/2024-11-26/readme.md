# U.S. Customs and Border Protection (CBP) Encounter Data

This week we're exploring [U.S. Customs and Border Protection (CBP) encounter data](https://www.cbp.gov/document/stats/nationwide-encounters):

> Encounter data includes U.S. Border Patrol Title 8 apprehensions, Office of Field Operations Title 8 inadmissibles, and all Title 42 expulsions for fiscal years 2020 to date. Data is available for the Northern Land Border, Southwest Land Border, and Nationwide (i.e., air, land, and sea modes of transportation) encounters. Data is extracted from live CBP systems and data sources. Statistical information is subject to change due to corrections, systems changes, change in data definition, additional information, or encounters pending final review. Final statistics are available at the conclusion of each fiscal year.

Thank you to [Tony Galván](https://www.linkedin.com/in/anthony-raul-galvan/) for curating this dataset and providing a [blog post](https://gdatascience.github.io/us_border_patrol_encounters/us_border_patrol_encounters.html) that explores the data in more detail.

-   How has the implementation (and potential end) of Title 42 affected migration and enforcement trends compared to Title 8 actions?
-   What are the key differences in migration patterns and enforcement activity between the Northern and Southwest Land Borders?
-   Are there seasonal or year-over-year trends in encounters that can help predict future migration patterns?

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-11-26')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 48)

cbp_resp <- tuesdata$cbp_resp
cbp_state <- tuesdata$cbp_state

# Option 2: Read directly from GitHub

cbp_resp <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-26/cbp_resp.csv')
cbp_state <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-11-26/cbp_state.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `cbp_resp.csv`

|variable               |class     |description                           |
|:----------------------|:---------|:-------------------------------------|
|fiscal_year            |integer   |The fiscal year the encounter took place |
|month_grouping         |character |Allows for comparisons between completed FY months vs. those remaining |
|month_abbv             |character |The month the encounter took place (abbreviated, eg "APR") |
|component              |character |Which part of CBP was involved in the encounter ("Office of Field Operations" or "U.S. Border Patrol") |
|land_border_region     |character |The border region in which the encounter occurred ("Northern Land Border", "Southwest Land Border", or "Other"); border regions are defined by each component. Nationwide numbers are calculated by adding together Northern Land Border, Southwest Land Border, and Other regions |
|area_of_responsibility |character |The field office or sector where the encounter occurred |
|aor_abbv               |character |The field office or sector where the encounter occurred (abbreviated) |
|demographic            |character |Categories under which individuals were encountered based on factors such as age, admissibility, and relationship (FMUA = Individuals in a Family Unit; UC = Unaccompanied Children) |
|citizenship            |character |Citizenship of the individual encountered |
|title_of_authority     |character |The authority under which the noncitizen was processed (Title 8: The standard U.S. immigration law governing the processing of migrants, including deportations, asylum procedures, and penalties for unauthorized border crossings. Title 42: A public health order used during the COVID-19 pandemic to rapidly expel migrants at the border without standard immigration processing, citing health concerns.) |
|encounter_type         |character |The category of encounter based on Title of Authority and component (Title 8 for USBP = Apprehensions; Title 8 for OFO = Inadmissibles; Title 42 = Expulsions) |
|encounter_count        |integer   |The number of individuals encountered |

# `cbp_state.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|fiscal_year        |integer   |The fiscal year the encounter took place |
|month_grouping     |character |Allows for comparisons between completed FY months vs. those remaining |
|month_abbv         |character |The month the encounter took place (abbreviated, eg "APR") |
|land_border_region |character |The border region in which the encounter occurred ("Northern Land Border", "Southwest Land Border", or "Other"); border regions are defined by each component. Nationwide numbers are calculated by adding together Northern Land Border, Southwest Land Border, and Other regions |
|state              |character |State of the encounter |
|demographic        |character |Categories under which individuals were encountered based on factors such as age, admissibility, and relationship (FMUA = Individuals in a Family Unit; UC = Unaccompanied Children) |
|citizenship        |character |Citizenship of the individual encountered |
|title_of_authority |character |The authority under which the noncitizen was processed (Title 8: The standard U.S. immigration law governing the processing of migrants, including deportations, asylum procedures, and penalties for unauthorized border crossings. Title 42: A public health order used during the COVID-19 pandemic to rapidly expel migrants at the border without standard immigration processing, citing health concerns.) |
|encounter_count    |integer   |The number of individuals encountered |

### Cleaning Script

```r
library(tidyverse)
library(janitor)

cbp_resp <- bind_rows(
  read_csv("https://www.cbp.gov/sites/default/files/assets/documents/2023-Nov/nationwide-encounters-fy20-fy23-aor.csv"),
  read_csv("https://www.cbp.gov/sites/default/files/2024-10/nationwide-encounters-fy21-fy24-aor.csv")
) |>
  janitor::clean_names() |>
  unique()

cbp_state <- bind_rows(
  read_csv("https://www.cbp.gov/sites/default/files/assets/documents/2023-Nov/nationwide-encounters-fy20-fy23-state.csv"),
  read_csv("https://www.cbp.gov/sites/default/files/2024-10/nationwide-encounters-fy21-fy24-state.csv")
) |>
  janitor::clean_names() |>
  unique()
```
