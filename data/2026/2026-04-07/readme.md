# Repair Cafes Worldwide

The dataset this week comes from the [Repair Monitor](https://dashboard.repairmonitor.org/?language=en), which has been compiling data from Repair Cafes worldwide since 2015.
Repair Cafe branches bring together volunteer fixers to help people learn how to repair household items that are broken. 

Note: There appears to be some uncertainty (by submitters to the source data) of what to put in `repair_info_source` and `repair_info_url`. We included the questions for these fields to aid in the interpretation of the data.

> As carbon-hungry consumer production and its subsequent waste surge to all-time highs, experts say that the concept can help curb pollution while promoting a more circular economy. 

- What kinds of items are most easily repaired?
- What are the most common reasons that items can't be repaired? 
- Which countries have seen the most growth in Repair Cafe branches?
- Is GenAI becoming more popular than YouTube as a source of useful information for repairers?

Thank you to [Jen Richmond](https://github.com/jenrichmond) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-04-07')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 14)

repairs <- tuesdata$repairs
repairs_text <- tuesdata$repairs_text

# Option 2: Read directly from GitHub

repairs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs.csv')
repairs_text <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs_text.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-04-07')

# Option 2: Read directly from GitHub and assign to an object

repairs = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs.csv')
repairs_text = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs_text.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-04-07")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

repairs = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs.csv")
repairs_text = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs_text.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
repairs = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs.csv", DataFrame)
repairs_text = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-07/repairs_text.csv", DataFrame)
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

### `repairs.csv`

|variable                     |class     |description                                            |
|:----------------------------|:---------|:------------------------------------------------------|
|repair_id                    |character |Repair case ID number                                  |
|repair_date                  |date      |Date                                                   |
|repair_cafe_number           |integer   |Repair cafe branch number                              |
|repair_cafe_name             |character |Repair cafe branch name                                |
|country                      |character |Country                                                |
|kind_of_product              |character |Product type                                           |
|category                     |character |Product category                                       |
|brand                        |character |Product brand                                          |
|estimated_year_of_production |integer   |Estimated year of production                           |
|repaired                     |character |Whether the product was repaired                       |
|repairability                |integer   |Rating of repair ease, from 1 (difficult) to 10 (easy)|

### `repairs_text.csv`

|variable             |class     |description                                           |
|:--------------------|:---------|:-----------------------------------------------------|
|repair_id            |character |Repair case ID number                                 |
|model                |character |Product model or serial number                        |
|defect_found         |character |Description of defect                                 |
|problem_description  |character |Description of repair problem or probable cause       |
|repair_method        |character |Description of successful repair method               |
|partial_repair_notes |character |Description of partial repair method or advice        |
|failure_reasons      |character |Reason(s) repair was not completed (list)             |
|failure_reason_open  |character |Reason repair was not completed (open answer)         |
|used_repair_info     |character |Whether repair information was consulted              |
|repair_info_source   |character |"Where did this information come from?"               |
|repair_info_url      |character |"Source repair information (url website)"             |
|suggestions          |character |Advice for other repairers of similar products        |

## Cleaning Script

```r
# Data downloaded from https://dashboard.repairmonitor.org/?language=en as
# "repairs-en.xlsx". Cleaning applied to fix variable names and data types.

library(tidyverse)
library(readxl)
library(janitor)

# Update this to point to your downloaded file.
repairs_xlsx_file <- "repairs-en.xlsx"

repairs_all <- readxl::read_xlsx(repairs_xlsx_file, col_types = "text") %>%
  janitor::clean_names() %>%
  dplyr::rename(
    model = model_type_number_and_or_serial_number,
    problem_description = problem_description_probable_cause,
    repaired = has_the_product_been_repaired,
    repair_method = if_yes_what_did_you_do_to_repair_it,
    partial_repair_notes = if_half_repaired_what_did_you_do_what_advice_did_you_give,
    failure_reasons = if_not_repaired_why_could_you_not_repair_it_list,
    failure_reason_open = if_not_repaired_why_could_you_not_repair_it_open_answer,
    repairability = reparability_of_product_1_difficult_10_easy,
    used_repair_info = did_you_use_repair_information,
    repair_info_source = where_did_this_information_come_from,
    repair_info_url = source_repair_information_url_website,
    suggestions = do_you_have_any_suggestions_for_other_repairers_of_this_or_similar_product
  ) %>%
  dplyr::mutate(
    repair_date = ymd(repair_date),
    repair_cafe_number = as.integer(repair_cafe_number),
    estimated_year_of_production = as.integer(estimated_year_of_production),
    repairability = as.integer(repairability)
  )

# Split off detail/free-text columns to keep repairs.csv under 20 MB.
repairs_text_cols <- c(
  "model",
  "defect_found",
  "problem_description",
  "repair_method",
  "partial_repair_notes",
  "failure_reasons",
  "failure_reason_open",
  "used_repair_info",
  "repair_info_source",
  "repair_info_url",
  "suggestions"
)

repairs <- dplyr::select(repairs_all, -tidyselect::all_of(repairs_text_cols))
repairs_text <- dplyr::select(
  repairs_all,
  repair_id,
  tidyselect::all_of(repairs_text_cols)
)

```
