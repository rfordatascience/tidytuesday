# Southern Resident Killer Whale Encounters

The data this week comes from the Center for Whale Research (CWR), the leading organization monitoring and studying Southern Resident killer whales in their critical habitat: the Pacific Northwest’s Salish Sea. Each encounter is hosted on its own webpage at [whaleresearch.com](https://www.whaleresearch.com/encounters). Jadey Ryan scraped the encounter data from CWR's website as a personal project to learn web scraping and [presented the process](https://jadeynryan.github.io/orcas/) at a Seattle R-Ladies meetup in 2023. The scraping functions and cleaning code for 2017 - 2024 encounters can be found in the [{orcas} R package](https://github.com/jadeynryan/orcas).

The dataset is mostly tidy but not completely clean. There are still missing values and typos, as evident from some encounters having a negative duration.

> An Encounter refers to any time we observe killer whales (orcas), from one of CWR's research boats or land, where at least one individual is identified and photographed. Typically, 2-4 staff are involved in an encounter. Once we come into contact with whales (ie. within distance of identifying individuals by sight) we have begun our encounter. During an encounter, our main goal is to photograph every individual present from both the left and right side.

Which pods or ecotypes have the longest duration encounters with CWR researchers? Are there trends in where orca encounters occur over time?

Thank you to [Jadey Ryan](https://github.com/jadeynryan) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-10-15')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 42)

orcas <- tuesdata$orcas

# Option 2: Read directly from GitHub

orcas <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-15/orcas.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `orcas.csv`

| variable           | class     | description                                                                                                                                                                   |
|:-------------------|:---------|:--------------------------------------|
| year               | double    | The year in which the encounter occurred.                                                                                                                                     |
| date               | double    | The date in which the encounter occurred.                                                                                                                                     |
| encounter_sequence | character | The number of the encounter sequence. Usually 1, but will sequentially increase if there are more encounters within the same outting.                                         |
| encounter_number   | double    | The number of the encounter, which resets to 1 each year.                                                                                                                     |
| begin_time         | double    | The time in which the encounter began.                                                                                                                                        |
| end_time           | double    | The time in which the encounter ended.                                                                                                                                        |
| duration           | character | The duration of the encounter as calculated in [data_cwr.R](https://github.com/jadeynryan/orcas/blob/cbf4c8f4a192a3c4b8fc1540de6e55ce5e8b4323/data-raw/data_cwr.R#L153-L166). |
| vessel             | character | The name of the vessel(s) used for the encounter observation.                                                                                                                 |
| observers          | character | The names of the CWR staff who observed the encounter.                                                                                                                        |
| pods_or_ecotype    | character | The pod(s) and/or ecotype observed. J, K, L, or Bigg's Transients.                                                                                                            |
| ids_encountered    | character | The IDs of the whales observed during the encounter.                                                                                                                          |
| location           | character | The location at which the encounter occurred.                                                                                                                                 |
| begin_latitude     | double    | The latitude at which the encounter began.                                                                                                                                    |
| begin_longitude    | double    | The longitude at which the encounter began.                                                                                                                                   |
| end_latitude       | double    | The latitude at which the encounter ended.                                                                                                                                    |
| end_longitude      | double    | The longitude at which the encounter ended.                                                                                                                                   |
| encounter_summary  | character | The summary of the encounter as written by the CWR staff observers.                                                                                                           |
| nmfs_permit        | character | The permit under which the photos were taken.                                                                                                                                 |
| link               | character | The link to the CWR webpage with the encounter details and photos.                                                                                                            |

### Cleaning Script

```r
# Data scraped from https://www.whaleresearch.com/ and cleaned (imperfectly) with the {orcas} R package (https://github.com/jadeynryan/orcas).

# Scraping and cleaning script can be found at https://github.com/jadeynryan/orcas/blob/master/data-raw/data_cwr.R.

orcas <- readr::read_csv(
  "https://raw.githubusercontent.com/jadeynryan/orcas/refs/heads/master/data-raw/cwr_tidy.csv"
)
```
