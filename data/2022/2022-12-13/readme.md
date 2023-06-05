### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> ### Chart type
> It's helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you're including this visual. What does it show that's meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don't include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Monthly State Retail Sales

The data this week comes from the [United States Census Bureau's Monthly State Retail Sales](https://www.census.gov/retail/state_retail_sales.html).

> The Monthly State Retail Sales (MSRS) is the Census Bureau's new experimental data product featuring modeled state-level retail sales.

The data updates monthly. We pulled the data on 2022-12-10, so this dataset runs through August of 2022.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-12-13')
tuesdata <- tidytuesdayR::tt_load(2022, week = 50)

state_retail <- tuesdata$state_retail
coverage_codes <- tuesdata$coverage_codes

# Or read in the data manually

state_retail <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-13/state_retail.csv',  col_types = "cciciiccc")
coverage_codes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-12-13/coverage_codes.csv')

```
### Data Dictionary

# `state_retail.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|fips          |character |2-digit State Federal Information Processing Standards (FIPS) code. For more information on FIPS Codes, please reference [this document](https://www.census.gov/library/reference/code-lists/ansi/ansi-codes-for-states.html). Note: The US is assigned a "00"" State FIPS code|
|state_abbr    |character |States are assigned 2-character official U.S. Postal
Service Code. The United States is assigned "USA" as its state_abbr value. For more information, please reference [this document](https://www.census.gov/library/reference/code-lists/ansi/ansi-codes-for-states.html).|
|naics         |integer   |Three-digit numeric NAICS value for retail subsector
code|
|subsector     |character |Retail subsector.|
|year          |integer   |year          |
|month         |integer   |month         |
|change_yoy    |character |Numeric year-over-year percent change in retail sales value|
|change_yoy_se |character |Numeric standard error for year-over-year percentage change in retail sales value|
|coverage_code |character |Character values assigned based on the non-imputed coverage of the data.|  

# `coverage_codes.csv`

|variable      |class     |description   |
|:-------------|:---------|:-------------|
|coverage_code |character |Character values assigned based on the non-imputed coverage of the data.|
|coverage      |character |Definition of the codes.|

### Cleaning Script

```r
library(tidyverse)
library(here)

# Read datasets
state_retail_yy <- read_csv(
  "https://www.census.gov/retail/mrts/www/statedata/state_retail_yy.csv"
)
state_retail_se <- read_csv(
  "https://www.census.gov/retail/mrts/www/statedata/state_retail_se.csv"
)
state_retail_coverage <- read_csv(
  "https://www.census.gov/retail/mrts/www/statedata/state_retail_coverage.csv"
)

state_retail_yy_clean <- state_retail_yy |> 
  pivot_longer(
    starts_with("yy"),
    names_to = "date_raw",
    values_to = "change_yoy"
  ) |> 
  mutate(
    year = as.integer(str_extract(date_raw, "yy(\\d{4})(\\d{2})", group = 1)),
    month = as.integer(str_extract(date_raw, "yy(\\d{4})(\\d{2})", group = 2)),
  ) |> 
  select(-date_raw)

state_retail_se_clean <- state_retail_se |> 
  pivot_longer(
    starts_with("se"),
    names_to = "date_raw",
    values_to = "change_yoy_se"
  ) |> 
  mutate(
    year = as.integer(str_extract(date_raw, "se(\\d{4})(\\d{2})", group = 1)),
    month = as.integer(str_extract(date_raw, "se(\\d{4})(\\d{2})", group = 2)),
  ) |> 
  select(-date_raw)

state_retail_coverage_clean <- state_retail_coverage |> 
  pivot_longer(
    starts_with("cov"),
    names_to = "date_raw",
    values_to = "coverage_code"
  ) |> 
  mutate(
    year = as.integer(str_extract(date_raw, "cov(\\d{4})(\\d{2})", group = 1)),
    month = as.integer(str_extract(date_raw, "cov(\\d{4})(\\d{2})", group = 2)),
  ) |> 
  select(-date_raw)

# There are only 5 coverage codes. Let's put them into a table, not just in the
# data dictionary, in case people want to use them in labels.
coverage_codes <- tibble::tribble(
  ~coverage_code, ~coverage,
  "A", "non-imputed coverage is less than 10% of the state/NAICS total.",
  "B", "non-imputed coverage is greater than or equal to 10% and less than 25% of the state/NAICS total",
  "C", "non-imputed coverage is greater than or equal to 25% and less than 50% of the state/NAICS total",
  "D", "non-imputed coverage is greater than or equal to 50% of the state/NAICS total.",
  "S", "Suppressed due to data quality concerns"
)

# Attempts to download a source of NAICS codes weren't fruitful, but there are
# only a handful so we'll get them from the documentation at
# https://www.census.gov/retail/mrts/www/statedata/msrs_overview.pdf.

# We are publishing year-over-year percent changes for each state and the
# District of Columbia for Total Retail Sales excluding Nonstore Retailers as
# well as for 11 three-digit retail subsectors as classified by the North
# American Industry Classification System (NAICS). These NAICS include Motor
# vehicle and parts dealers (NAICS 441), Furniture and Home Furnishing (NAICS
# 442), Electronics and Appliances (NAICS 443), Building Materials and Supplies
# Dealers (NAICS 444), Food and Beverage (NAICS 445), Health and Personal Care
# (NAICS 446), Gasoline Stations (NAICS 447), Clothing and Clothing Accessories
# (NAICS 448), Sporting Goods and Hobby (NAICS 451), General Merchandise (NAICS
# 452), and Miscellaneous Store Retailers (NAICS 453).
naics_code_text <- "Motor vehicle and parts dealers (NAICS 441), Furniture
and Home Furnishing (NAICS 442), Electronics and Appliances (NAICS 443), Building Materials and Supplies Dealers
(NAICS 444), Food and Beverage (NAICS 445), Health and Personal Care (NAICS 446), Gasoline Stations (NAICS 447),
Clothing and Clothing Accessories (NAICS 448), Sporting Goods and Hobby (NAICS 451), General Merchandise
(NAICS 452), Miscellaneous Store Retailers (NAICS 453)."
naics_codes <- tibble(
  raw = naics_code_text |> 
    str_squish() |> 
    strsplit(", ")
) |> 
  unnest(raw) |> 
  transmute(
    naics = str_extract(raw, "NAICS (\\d{3})", group = 1),
    subsector = str_extract(raw, "[^(]+") |> str_squish()
  )

# Combine the three tables.
state_retail <- state_retail_yy_clean |> 
  left_join(state_retail_se_clean) |> 
  left_join(state_retail_coverage_clean) |> 
  # Add the NAICS translations and clean some things up.
  left_join(naics_codes, by = "naics") |> 
  mutate(
    subsector = case_when(
      naics == "TOTAL" ~ "total",
      TRUE ~ subsector
    ),
    naics = as.integer(
      na_if(
        naics,
        "TOTAL"
      )
    )
  ) |> 
  select(
    fips,
    state_abbr = stateabbr,
    naics,
    subsector,
    year,
    month,
    change_yoy,
    change_yoy_se,
    coverage_code
  )

state_retail |> write_csv(
  here(
    "data",
    "2022",
    "2022-12-13",
    "state_retail.csv"
  )
)
coverage_codes |> write_csv(
  here(
    "data",
    "2022",
    "2022-12-13",
    "coverage_codes.csv"
  )
)
```
