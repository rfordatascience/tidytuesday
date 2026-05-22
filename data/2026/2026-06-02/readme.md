# European Parenting Leave Policies

This week we're exploring European Parenting Leave Policies. The European Parenting Leave Policies (EPLP) Dataset provides harmonised data on maternity, co-parent, paid parental, and job-protected leave regulations across 21 European countries from 1970 to 2024.

> The dataset enables quantitative analyses of policy trends, cross-national differences, and the effects of major reforms – for researchers, policymakers, and others interested in family policy.

Given the variety of parental leave schemes across countries, the dataset considers three different dimensions of parental leave duration for each country, if applicable. Dimension 1 (par1) identifies the paid parental leave scheme with the longest possible duration. Dimension 2 (par2) identifies the paid parental leave duration with the highest monthly flat rate payment. Dimension 3 (par3) identifies the duration with the highest replacement rate. 

Values that are missing are represented as `NA`. Some values are missing because they are not applicable. These values are encoded as `"Not applicable"` for character vectors, and `-98` for numeric variables.

* Which countries were the first to implement co-parent leave policies?
* Has parenting leave decreased in any countries?

Cite the dataset as: S. Spitzer et al., “The European Parenting Leave Policies (EPLP) Dataset”. Zenodo, Nov. 19, 2025. doi: 10.5281/zenodo.17648712.

Thank you to [Nicola Rennie](https://github.com/nrennie) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-06-02')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 22)

eplp <- tuesdata$eplp

# Option 2: Read directly from GitHub

eplp <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-02/eplp.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-06-02')

# Option 2: Read directly from GitHub and assign to an object

eplp = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-02/eplp.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-06-02")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

eplp = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-02/eplp.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
eplp = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-02/eplp.csv", DataFrame)
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

### `eplp.csv`

|variable           |class     |description                           |
|:------------------|:---------|:-------------------------------------|
|country            |character |Two-letter country code. |
|year               |double    |Year. |
|mat_m_ld_bb        |double    |Mandatory maternity leave duration before birth. |
|mat_m_ld_ab        |double    |Mandatory maternity leave duration after birth. |
|mat_v_ld_bb        |double    |Voluntary maternity leave duration before birth (maximum duration). |
|mat_v_ld_ab        |double    |Voluntary maternity leave duration after birth (maximum duration). |
|co_ld              |double    |Co-parent leave duration (maximum duration). |
|jp_ld_m            |double    |Job-protected leave duration for birth mothers (maximum duration). |
|jp_ld_co           |double    |Job-protected leave duration for co-parents (maximum duration). |
|jp_part_time       |character |Job-protected leave is longer if taken part-time. |
|jp_later           |character |Possibility to take (parts of) the leave at a later point in time. |
|par1_ld            |double    |Paid parental leave duration (maximum duration). |
|par1_fr            |double    |Amount of benefits per month (with maximum duration). |
|par1_rr            |double    |Replacement rate (with maximum duration). |
|par1_cap           |double    |Monthly cap (with maximum duration). |
|par1_for_whom      |character |Mothers only, co-parents only, or both. |
|par1_second_parent |double    |Additional time for second parent if the first parent takes the maximum leave duration. |
|par1_work          |character |Possibility to work/earn money during parts of the leave. |
|par1_later         |character |Possibility to take (parts of) the leave at a later point in time. |
|par2_ld            |double    |Paid parental leave duration (with highest flat rate). |
|par2_fr            |double    |Amount of benefits per month (with highest flat rate). |
|par2_for_whom      |character |Mothers only, co-parents only, or both. |
|par2_second_parent |double    |Additional time for second parent if the first parent takes the maximum leave duration. |
|par2_work          |character |Possibility to work/earn money during parts of the leave. |
|par2_later         |character |Possibility to take (parts of) the leave at a later point in time. |
|par3_ld            |double    |Paid parental leave duration (with highest replacement rate). |
|par3_rr            |double    |Replacement rate (with highest replacement rate). |
|par3_cap           |double    |Monthly cap (with highest replacement rate). |
|par3_for_whom      |character |Mothers only, co-parents only, or both. |
|par3_second_parent |double    |Additional time for second parent if the first parent takes the maximum leave duration. |
|par3_work          |character |Possibility to work/earn money during parts of the leave. |
|par3_later         |character |Possibility to take (parts of) the leave at a later point in time. |
|par_incentives     |character |Incentives for parents to share parental leave. |
|user_note          |character |Whether there are additional user notes for this row of the data. |
|currency           |character |Country currency. Note this changes over time for some countries. |

## Cleaning Script

```r
library(tidyverse)
library(readxl)

# If you don't want to automatically download unknown files, download the XLSX file from https://zenodo.org/records/17648712
xlsx_url <- "https://zenodo.org/records/17648712/files/EPLP_Dataset_Workbook_v2.xlsx?download=1"
xlsx_file <- "EPLP_Dataset_Workbook_v2.xlsx"
if (!file.exists(xlsx_file)) {
  download.file(xlsx_url, destfile = xlsx_file, mode = "wb")
}
raw_data <- read_xlsx(xlsx_file, sheet = 2, skip = 1)

eplp <- raw_data |>
  # Missing
  mutate(
    across(
      where(is.numeric), ~replace_values(.x, -99 ~ NA)
    )
  ) |>
  mutate(
    across(
      where(is.character), ~replace_values(.x, "-99" ~ NA)
    )
  ) |>
  # Not applicable
  mutate(
    across(
      where(is.character), ~replace_values(.x, "-98" ~ "Not applicable")
    )
  )

```
