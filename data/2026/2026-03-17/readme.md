# Salmonid Mortality Data

The datasets this week come from the suite of Salmonid mortality  datasets published by the Norwegian Veterinary Institute. A total of five datasets are published on the [Laksetap Shiny App](https://apps.vetinst.no/laksetap/) and [API](https://apps.vetinst.no/salmonid-mortality-public-api/). This data captures the public interest as the Norwegian government [goal](https://blog.manolinaqua.com/en/norways-5-percent-goal-for-lower-salmon-mortality) is to push for lower mortality. Here, two datasets are shared, the monthly mortality  data, and the monthly loses data. TidyTuesday users can explore the other datasets  if they wish. Data is available from 2020.

> The Fish Health Report is the Norwegian Veterinary Institute's 
> annual status report on the health and welfare situation for 
> Norwegian farmed fish and is based on official statistics, 
> data from the Norwegian Veterinary Institute and private laboratories. 
> The report also contains results from a survey among fish health 
> personnel and inspectors from the Norwegian Food Safety Authority, 
> as well as assessments of the situation, trends and risks.

- How does monthly mortality differ across the time period data is available for?
- Which region has lowest mortality?
- What other types of loses may be significant in addition to death of fish?

Thank you to [Novica Nakov](https://github.com/novica) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-03-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 11)

monthly_losses_data <- tuesdata$monthly_losses_data
monthly_mortality_data <- tuesdata$monthly_mortality_data

# Option 2: Read directly from GitHub

monthly_losses_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_losses_data.csv')
monthly_mortality_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_mortality_data.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-03-17')

# Option 2: Read directly from GitHub and assign to an object

monthly_losses_data = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_losses_data.csv')
monthly_mortality_data = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_mortality_data.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-03-17")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

monthly_losses_data = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_losses_data.csv")
monthly_mortality_data = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_mortality_data.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
monthly_losses_data = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_losses_data.csv", DataFrame)
monthly_mortality_data = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-17/monthly_mortality_data.csv", DataFrame)
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

### `monthly_losses_data.csv`

|variable  |class     |description                           |
|:---------|:---------|:-------------------------------------|
|species   |character |The species of fish. |
|date      |date      |The month for the observation in format YYYY-MM-DD. |
|geo_group |character |Country, county or area level for the data. |
|region    |character |The name of the geo_group. |
|losses    |integer   |Total number fish losses. |
|dead      |integer   |Number of dead fish. |
|discarded |integer   |Number of discarded fish. |
|escaped   |integer   |Number of escaped fish. |
|other     |integer   |Number of other losses. |

### `monthly_mortality_data.csv`

|variable  |class     |description                           |
|:---------|:---------|:-------------------------------------|
|species   |character |The species of fish. |
|date      |date      |The month for the observation in format YYYY-MM-DD. |
|geo_group |character |Country, county or area level for the data. |
|region    |character |The name of the geo_group. |
|median    |double    |Median mortality. |
|q1        |double    |Lower quartile. |
|q3        |double    |Upper quartile. |

## Cleaning Script

```r
# Clean data provided by Norwegian Veterinary Institute. No cleaning was
# necessary. The data is published at https://apps.vetinst.no/laksetap/ Here
# only two datasets are shared, but people may investigate the other datasets as
# well. Manually download data to local path tt_submission/data-raw/

monthly_mortality_data <- readr::read_csv(
  "tt_submission/data-raw/monthly_mortality_data_2026-03-09.csv"
)

monthly_losses_data <- readr::read_csv(
  "tt_submission/data-raw/monthly_losses_data_2026-03-09.csv"
)

```
