# Measles cases across the world

This week we are exploring measles and rubella cases across the world. This data was downloaded from 
the World Health Organisation [Provisional monthly measles and rubella data](https://immunizationdata.who.int/global?topic=Provisional-measles-and-rubella-data&location=) on 
2025-06-12. 

> Please note that all data contained within is provisional. The number of cases of measles and 
> rubella officially reported by a WHO Member State is only available by July of each year 
> (through the joint WHO UNICEF annual data collection exercise). If any numbers from this provisional
> data are quoted, they should be properly sourced with a date (i.e. "provisional data based on 
> monthly data reported to WHO (Geneva) as of June 2025"). For official data from 1980, please visit our website: 
> https://immunizationdata.who.int/global/wiise-detail-page/measles-reported-cases-and-incidence


The [measles outbreak in the USA](https://abcnews.go.com/Health/measles-cases-reach-1046-us-infections-confirmed-30/story?id=122108194) 
has been the subject of much media coverage in the past few months, however, [measles continues to be a threat across the world](https://www.cdc.gov/global-measles-vaccination/data-research/global-measles-outbreaks/index.html)

- How have global measles cases changed over time?
- Which regions or countries consistently report the highest measles burden?
- Are there seasonal patterns in measles outbreaks across different regions?
- Does the ratio of laboratory-confirmed cases to total cases reveal differences in healthcare capacity across countries?

Thank you to [Jen Richmond (R-Ladies Sydney)](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-06-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 25)

cases_month <- tuesdata$cases_month
cases_year <- tuesdata$cases_year

# Option 2: Read directly from GitHub

cases_month <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_month.csv')
cases_year <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_year.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-06-24')

# Option 2: Read directly from GitHub and assign to an object

cases_month = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_month.csv')
cases_year = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_year.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-06-24')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

cases_month = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_month.csv")
cases_year = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_year.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
cases_month = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_month.csv", DataFrame)
cases_year = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-24/cases_year.csv", DataFrame)
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

### `cases_month.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|region                |character |Region name  |
|country               |character |Country name |
|iso3                  |character |Three letter country code |
|year                  |double    |Year|
|month                 |double    |Month |
|measles_suspect       |double    |Suspected measles cases: A suspected case is one in which a patient with fever and maculopapular (non-vesicular) rash, or in whom a health-care worker suspects measles  |
|measles_clinical      |double    |Clinically-compatible measles cases: A suspected case with fever and maculopapular (non-vesicular) rash and at least one of cough, coryza or conjunctivitis, but no adequate clinical specimen was taken and the case has not been linked epidemiologically to a laboratory-confirmed case of measles or other communicable disease  |
|measles_epi_linked    |double    |Epidemiologically-linked measles cases: A suspected case of measles that has not been confirmed by a laboratory, but was geographically and temporally related with dates of rash onset occurring 7–23 days apart from a laboratory-confirmed case or another epidemiologically linked measles case |
|measles_lab_confirmed |double    |Laboratory-confirmed measles cases: A suspected case of measles that has been confirmed positive by testing in a proficient laboratory, and vaccine-associated illness has been ruled out  |
|measles_total         |double    |Total measles cases: the sum of clinically-compatible, epidemiologically linked and laboratory-confirmed cases  |
|rubella_clinical      |double    |Clinically-compatible rubella cases  |
|rubella_epi_linked    |double    |Epidemiologically-linked rubella cases |
|rubella_lab_confirmed |double    |Laboratory-confirmed rubella cases |
|rubella_total         |double    |Total rubella cases |
|discarded             |double    |Discarded cases: A suspected case that has been investigated and discarded as a non-measles (and non-rubella) |

### `cases_year.csv`

|variable                                                        |class     |description                           |
|:---------------------------------------------------------------|:---------|:-------------------------------------|
|region                                                          |character |Region name  |
|country                                                         |character |Country name |
|iso3                                                            |character |Three letter country code |
|year                                                            |character |Year |
|total_population                                                |character |Country population |
|annualized_population_most_recent_year_only                     |character |Annualized population 2025 |
|total_suspected_measles_rubella_cases                           |character |Suspected measles/rubella cases: A suspected case is one in which a patient with fever and maculopapular (non-vesicular) rash, or in whom a health-care worker suspects measles (or rubella) |
|measles_total                                                   |character |Total measles cases: the sum of clinically-compatible, epidemiologically linked and laboratory-confirmed cases |
|measles_lab_confirmed                                           |character |Laboratory-confirmed measles cases: A suspected case of measles that has been confirmed positive by testing in a proficient laboratory, and vaccine-associated illness has been ruled out |
|measles_epi_linked                                              |character |Epidemiologically-linked measles cases: A suspected case of measles that has not been confirmed by a laboratory, but was geographically and temporally related with dates of rash onset occurring 7–23 days apart from a laboratory-confirmed case or another epidemiologically linked measles case |
|measles_clinical                                                |character |Clinically-compatible measles cases: A suspected case with fever and maculopapular (non-vesicular) rash and at least one of cough, coryza or conjunctivitis, but no adequate clinical specimen was taken and the case has not been linked epidemiologically to a laboratory-confirmed case of measles or other communicable disease |
|measles_incidence_rate_per_1000000_total_population             |character |Measles cases per million population |
|rubella_total                                                   |character |Total rubella cases |
|rubella_lab_confirmed                                           |character |Laboratory-confirmed rubella cases |
|rubella_epi_linked                                              |character |Epidemiologically-linked rubella cases |
|rubella_clinical                                                |character |Clinically-compatible rubella cases |
|rubella_incidence_rate_per_1000000_total_population             |character |Rubella cases per million population |
|discarded_cases                                                 |character |Discarded cases: A suspected case that has been investigated and discarded as a non-measles (and non-rubella) |
|discarded_non_measles_rubella_cases_per_100000_total_population |character |Discarded cases per million population |

## Cleaning Script

```r
# Data provided by WHO Provisional measles and rubella data. Cleaning variable
# names and fixing data types.

library(tidyverse)
library(here)
library(readxl)
library(janitor)

cases_month <- read_xlsx(here("404-table-web-epi-curve-data.xlsx"), 2) %>%
  janitor::clean_names() %>%
  dplyr::mutate(
    dplyr::across(year:discarded, as.numeric)
  )

cases_year <- read_xlsx(here("403-table-web-reporting-data.xlsx"), 2) %>%
  row_to_names(1) %>%
  clean_names() %>%
  rename(
    country = member_state,
    iso3 = iso_country_code,
    measles_total= number_of_measles_cases_by_confirmation_method,
    measles_lab_confirmed = na,
    measles_epi_linked = na_2,
    measles_clinical = na_3,
    rubella_total = number_of_rubella_cases_by_confirmation_method,
    rubella_lab_confirmed = na_4,
    rubella_epi_linked = na_5,
    rubella_clinical = na_6
  ) %>%
  slice(-1)

```
