# This week we're getting ready for the 2026 Winter Olympics!

This week we're exploring the event schedule for the 2026 Winter Olympics in Milan-Cortina, Italy. The dataset contains detailed information about all 1,866 Olympic events, including both competition and training sessions across various winter sport disciplines.

The dataset provides comprehensive scheduling information with start and end times in both local and UTC timezones, venue details, and metadata about each event such as whether it's a medal event or training session. This dataset captures the full scope of Olympic events taking place from early February through the closing ceremonies, including the new ski mountaineering event.

> Ciao from Milano Cortina 2026

Some questions to explore:
- Which sport disciplines have the most events scheduled?
- How are medal events distributed across the days of the Olympics?
- What is the typical duration of different types of events?
- Which venues host the most events?
- How does the schedule vary by day of the week?
- What proportion of scheduled sessions are training versus competition?

For more information about how the data was collected and example code for creating the table in R or Python you can go to this repository: <https://github.com/chendaniely/olympics-2026>

If you want the code that generated the example table:

```python
from pathlib import Path

from great_tables import GT, style, loc
import polars as pl

# Load the events data
dataset_url = "https://raw.githubusercontent.com/chendaniely/olympics-2026/refs/heads/main/data/final/olympics/olympics_events.csv"
df = pl.read_csv(data_file)

schedule = (
    df
    .group_by("date", "discipline_name")
    .agg(
        pl.len().alias("total_events"),
        pl.col("is_medal_event").sum().alias("medal_events"),
    )
    .sort("date", "discipline_name")
)

print(f"Schedule shape: {schedule.shape}")
print("\nFirst 20 rows:")
schedule.head(20)

schedule = schedule.with_columns(pl.col("date").str.to_date("%Y-%m-%d"))

print("Updated schema:")
print(schedule.schema)
print("\nFirst few rows:")
schedule.head(10)

# Pivot the schedule to have disciplines as rows and dates as columns
schedule_pivot = schedule.pivot(
    on="date",
    index="discipline_name",
    values="total_events",
).sort("discipline_name")

# Create the table
gt_table = (
    GT(schedule_pivot)
    .tab_header(
        title="Olympics 2026 Event Schedule",
        subtitle="Total events per sport by date",
    )
    .cols_label(discipline_name="Sport")
)

gt_table

```

```r
library(tidyverse)
library(gt)

# Load the events data

dataset_url <- "https://raw.githubusercontent.com/chendaniely/olympics-2026/refs/heads/main/data/final/olympics/olympics_events.csv"
df <- readr::read_csv(dataset_url)

# Create schedule summary
schedule <- df |>
  group_by(date, discipline_name) |>
  summarize(
    total_events = n(),
    medal_events = sum(is_medal_event),
    .groups = "drop"
  ) |>
  arrange(date, discipline_name)

cat("Schedule shape:", nrow(schedule), "x", ncol(schedule), "\n")
cat("\nFirst 20 rows:\n")
print(head(schedule, 20))

# Convert date column to Date type
schedule <- schedule |>
  mutate(date = as.Date(date))

cat("\nUpdated column types:\n")
print(str(schedule))
cat("\nFirst few rows:\n")
print(head(schedule, 10))

# Pivot the schedule to have disciplines as rows and dates as columns
schedule_pivot <- schedule |>
  select(date, discipline_name, total_events) |>
  pivot_wider(
    names_from = date,
    values_from = total_events,
    id_cols = discipline_name
  ) |>
  arrange(discipline_name)

# Create the table
gt_table <- schedule_pivot |>
  gt() |>
  tab_header(
    title = "Olympics 2026 Event Schedule",
    subtitle = "Total events per sport by date"
  ) |>
  cols_label(
    discipline_name = "Sport"
  )

gt_table

```

Thank you to [Daniel Chen, Posit PBC, University of British Columbia](https://github.com/chendaniely) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-02-10')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 6)

schedule <- tuesdata$schedule

# Option 2: Read directly from GitHub

schedule <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-10/schedule.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-02-10')

# Option 2: Read directly from GitHub and assign to an object

schedule = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-10/schedule.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-02-10")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

schedule = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-10/schedule.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
schedule = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-02-10/schedule.csv", DataFrame)
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

### `schedule.csv`

|variable             |class         |description                           |
|:--------------------|:-------------|:-------------------------------------|
|date                 |date          |Date of the Olympic event. |
|discipline_code      |character     |Abbreviated code for the sport discipline (e.g., ALP for Alpine Skiing, CUR for Curling). |
|discipline_name      |character     |Full name of the sport discipline. |
|event_code           |character     |Unique identifier code for the specific event. |
|event_description    |character     |Descriptive name of the event including gender, type, and round. |
|start_datetime_local |datetime<UTC> |Event start date and time in local timezone. |
|end_datetime_local   |datetime<UTC> |Event end date and time in local timezone. |
|start_datetime_utc   |datetime<UTC> |Event start date and time in UTC timezone. |
|end_datetime_utc     |datetime<UTC> |Event end date and time in UTC timezone. |
|is_medal_event       |logical       |Whether the event awards medals (TRUE) or not (FALSE). |
|is_training          |logical       |Whether the event is a training session (TRUE) or competition (FALSE). |
|venue_code           |character     |Abbreviated code for the venue location. |
|venue_name           |character     |Full name of the venue where the event takes place. |
|venue_slug           |character     |URL-friendly identifier for the venue. |
|location_name        |character     |Specific location or area within the venue (e.g., sheet, course). |
|location_code        |character     |Abbreviated code for the specific location within the venue. |
|session_code         |character     |Unique code identifying the event session. |
|estimated_start      |logical       |Whether the start time is estimated (TRUE) or confirmed (FALSE). |
|day_of_week          |character     |Day of the week the event occurs on. |
|start_time           |time          |Event start time without date component. |
|end_time             |time          |Event end time without date component. |

## Cleaning Script

```python
# Clean data provided by @chendaniely. No cleaning was necessary.
import pandas as pd

dataset_url = "https://raw.githubusercontent.com/chendaniely/olympics-2026/refs/heads/main/data/final/olympics/olympics_events.csv"
schedule = pd.read_csv(dataset_url)

```
