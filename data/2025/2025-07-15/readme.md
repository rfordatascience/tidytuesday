# British Library Funding

This week we're looking into British Library funding! 
Thank you to Andy Jackson for [compiling this data](https://anjackson.net/2024/11/27/updating-the-data-on-british-library-funding/) (and [updating it with more information](https://anjackson.net/2024/11/29/british-library-funding-breakdown-trends/)) and [posting it on BlueSky](https://bsky.app/profile/anjacks0n.bsky.social/post/3lbyvepb5oc22)!
Also thanks to [David Rosenthal's 2017 blog](https://blog.dshr.org/2017/08/preservation-is-not-technical-problem.html) for inspiring Andy's efforts!

> I often refer back to [this 2017 analysis by DSHR](https://blog.dshr.org/2017/08/preservation-is-not-technical-problem.html), 
> which documents how the inflation-adjusted income of the British Library fell 
> between 1999 and 2016. I referenced it in [Invisible Memory Machines](https://anjackson.net/2024/05/14/invisible-memory-machines/), 
> but of course I was missing the data from the last eight years. Perhaps it’s 
> all turned around since then!

It hadn't all turned around, and he had to jump through some hoops to compile the data. 
Thanks for the efforts to preserve the data, Andy!

- What is the most variable source of data? 
- What is the most consistent? 
- Does that analysis change when adjusted for inflation?

See [Andy Jackson's Google Sheet](https://docs.google.com/spreadsheets/d/1uxjiuWYZrALF2mthmiYbUPieu1dEdEwv9GB8dEAizso/edit?gid=0#gid=0) (where we got this dataset) for some sample charts.

Thank you to [Jon Harmon, Data Science Learning Community](https://github.com/jonthegeek) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2025-07-15')
## OR
tuesdata <- tidytuesdayR::tt_load(2025, week = 28)

bl_funding <- tuesdata$bl_funding

# Option 2: Read directly from GitHub

bl_funding <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-15/bl_funding.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2025-07-15')

# Option 2: Read directly from GitHub and assign to an object

bl_funding = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-15/bl_funding.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download files from the week, which you can then read in locally
download_dataset('2025-07-15')

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

bl_funding = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-15/bl_funding.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
bl_funding = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-07-15/bl_funding.csv", DataFrame)
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

### `bl_funding.csv`

|variable                      |class   |description                           |
|:-----------------------------|:-------|:-------------------------------------|
|year                          |integer |First year of the annual report. Eg, 2016 is for the 2016/2017 annual report. |
|nominal_gbp_millions          |double  |Total reported funding in millions of Great Britain Pounds (GBP). |
|gia_gbp_millions              |double  |Reported funding from grant-in-aid (the official term for the core funding from the UK government). |
|voluntary_gbp_millions        |double  |Reported funding covering all voluntary contributions and donations, including the valuation of donated collection items. |
|investment_gbp_millions       |double  |Reported funding from returns on savings and investments. |
|services_gbp_millions         |double  |Reported funding from service delivery within the remit of being a charity. The main part of this over the years has been the document supply service, which started out as the National Lending Library for Science and Technology. |
|other_gbp_millions            |double  |Reported funding from anything that doesn’t fit into the above categories. |
|year_2000_gbp_millions        |double  |Funding values from the original blog post at https://blog.dshr.org/2017/08/preservation-is-not-technical-problem.html. |
|inflation_adjustment          |double  |The cost in each given year of 1,000,000 GBP in terms of year 2000 GBP. Figures come from the the current (2024) Bank of England inflation calculator: https://www.bankofengland.co.uk/monetary-policy/inflation/inflation-calculator. |
|total_y2000_gbp_millions      |double  |Total reported funding adjusted to Y2000 GBP. |
|percentage_of_y2000_income    |double  |`total_y2000_gbp_millions` / `total_y2000_gbp_millions` for `year == 2000`. |
|gia_y2000_gbp_millions        |double  |Grant-in-aid funding in Y2000 GBP. |
|voluntary_y2000_gbp_millions  |double  |Voluntary funding in Y2000 GBP. |
|investment_y2000_gbp_millions |double  |Investment funding in Y2000 GBP. |
|services_y2000_gbp_millions   |double  |Services funding in Y2000 GBP. |
|other_y2000_gbp_millions      |double  |Other funding in Y2000 GBP. |
|gia_as_percent_of_peak_gia    |double  |`gia_y2000_gbp_millions / max(gia_y2000_gbp_millions)` |

## Cleaning Script

```r
# Data provided by Andy Jackson. See
# https://anjackson.net/2024/11/27/updating-the-data-on-british-library-funding/
# Minimal cleaning required.

library(tidyverse)
library(googlesheets4)
library(janitor)

# Call the auth function to make things run without prompts.
googlesheets4::gs4_auth("jonthegeek@gmail.com")
bl_funding <- googlesheets4::read_sheet(
  "1uxjiuWYZrALF2mthmiYbUPieu1dEdEwv9GB8dEAizso"
) |>
  janitor::clean_names() |>
  dplyr::mutate(
    year = as.integer(.data$year)
  )

```
