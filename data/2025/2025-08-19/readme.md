# Scottish Munros

A Munro is a Scottish mountain with an elevation of over 3,000 feet, whereas a Munro Top is a subsidiary summit of a Munro that also exceeds 3,000 feet in height but is not considered a distinct mountain in its own right. The most famous Munro is Ben Nevis.

In 1891, Sir Hugh Munro produced the first list of these hills. However, unlike other classification schemes in Scotland which require a peak to have a prominence of at least 500 feet for inclusion, the Munros lack a rigid set of criteria for inclusion. And so, re-surveying can lead to changes in which peaks are included on the list.

* How many peaks currently listed as Munros have always been included on the list?
* Which year saw the largest number of changes to the classification?
* Which Munro is the most remote?

The Database of British and Irish Hills is licensed under a Creative Commons Attribution 4.0 International Licence. Please reference The Database of British and Irish Hills v18.2 and link to [www.hills-database.co.uk](https://www.hills-database.co.uk/).

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-08-19')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 33)

scottish_munros <- tuesdata$scottish_munros

# Option 2: Read directly from GitHub

scottish_munros <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-19/scottish_munros.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-08-19')

# Option 2: Read directly from GitHub and assign to an object

scottish_munros = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-19/scottish_munros.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-08-19')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

scottish_munros = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-19/scottish_munros.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
scottish_munros = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-19/scottish_munros.csv", DataFrame)
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

### `scottish_munros.csv`

|variable     |class     |description                           |
|:------------|:---------|:-------------------------------------|
|DoBIH_number |character |ID Number in the Database of British and Irish hills |
|Name         |character |Name of the Munro. |
|Height_m     |double    |The height of the Munro in metres. |
|Height_ft    |double    |The height of the Munro in feet. |
|xcoord       |double    |x-coordinate of Munro, using British National Grid (OSGB36) projection which uses easting/northing in metres. |
|ycoord       |double    |y-coordinate of Munro, using British National Grid (OSGB36) projection which uses easting/northing in metres. |
|1891         |character |Classification of the Munro in 1891. Either *Munro*, *Munro Top*, or `NA`. |
|1921         |character |Classification of the Munro in 1921. Either *Munro*, *Munro Top*, or `NA`.  |
|1933         |character |Classification of the Munro in 1933. Either *Munro*, *Munro Top*, or `NA`.  |
|1953         |character |Classification of the Munro in 1953. Either *Munro*, *Munro Top*, or `NA`.  |
|1969         |character |Classification of the Munro in 1969. Either *Munro*, *Munro Top*, or `NA`.  |
|1974         |character |Classification of the Munro in 1974. Either *Munro*, *Munro Top*, or `NA`.  |
|1981         |character |Classification of the Munro in 1981. Either *Munro*, *Munro Top*, or `NA`.  |
|1984         |character |Classification of the Munro in 1984. Either *Munro*, *Munro Top*, or `NA`. |
|1990         |character |Classification of the Munro in 1990. Either *Munro*, *Munro Top*, or `NA`. |
|1997         |character |Classification of the Munro in 1997. Either *Munro*, *Munro Top*, or `NA`. |
|2021         |character |Classification of the Munro in 2021. Either *Munro*, *Munro Top*, or `NA`. |
|Comments     |character |Free text field describing any changes to the data over time. |

## Cleaning Script

```r
library(tidyverse)

raw_data <- read_csv("https://www.hills-database.co.uk/munrotab_v8.0.1.csv")

scottish_munros <- raw_data |>
  select(
    `DoBIH Number`, Name,
    `Height (m)`, `Height\n(ft)`, xcoord, ycoord,
    `1891`:`2021`, Comments
  ) |>
  drop_na(`DoBIH Number`) |> 
  rename(
    Height_m = `Height (m)`,
    Height_ft = `Height\n(ft)`,
    DoBIH_number = `DoBIH Number`
  ) |> 
  mutate(
    Comments = case_when(
      Comments %in% c("See named worksheet", "See named worksheet for old mapping") ~ NA_character_,
      TRUE ~ Comments
    )
  ) |> 
  mutate(
    across(`1891`:`2021`, ~case_when(
      .x == "MUN" ~ "Munro",
      .x == "TOP" ~ "Munro Top"
    ))
  )

```
