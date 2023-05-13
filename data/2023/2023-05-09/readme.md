### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics
for `#TidyTuesday`.

Twitter provides
[guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions)
for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an
[article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81)
on writing *good* alt text for plots/graphs.

> Here's a simple formula for writing alt text for data visualization:
> \### Chart type It's helpful for people with partial sight to know
> what chart type it is and gives context for understanding the rest of
> the visual. Example: Line graph \### Type of data What data is
> included in the chart? The x and y axis labels may help you figure
> this out. Example: number of bananas sold per day in the last year
> \### Reason for including the chart Think about why you're including
> this visual. What does it show that's meaningful. There should be a
> point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales \### Link to data or
> source Don't include this in your alt text, but it should be included
> somewhere in the surrounding text. People should be able to click on a
> link to view the source data or dig further into the visual. This
> provides transparency about your source and lets people explore the
> data. Example: Data from the USDA

Penn State has an
[article](https://accessibility.psu.edu/images/charts/) on writing alt
text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users.
> But since they are images, these media provide serious accessibility
> issues to colorblind users and users of screen readers. See the
> [examples on this page](https://accessibility.psu.edu/images/charts/)
> for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post
tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with
alt text programatically.

Need a **reminder**? There are
[extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related)
that force you to remember to add Alt Text to Tweets with media.

# Childcare Costs

Happy Mothers Day! The data this week comes from the [National Database of Childcare Prices](https://www.dol.gov/agencies/wb/topics/featured-childcare).

> The National Database of Childcare Prices (NDCP) is the most comprehensive federal source of childcare prices at the county level. The database offers childcare price data by childcare provider type, age of children, and county characteristics. Data are available from 2008 to 2018.

Thanks this week to Thomas Mock for the submission, with a hat tip to [Jon Schwabish on Twitter](https://twitter.com/jschwabish/status/1626597782491639810?s=46&t=avwSC7an3lwX3FH35u0gMA) for pointing out the lack of labels on the original government-posted map.

Note: This dataset implies that "both parents" means one man and one woman. We recognize that this does not reflect the reality of every loving family.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-05-09')
tuesdata <- tidytuesdayR::tt_load(2023, week = 19)

childcare_costs <- tuesdata$childcare_costs
counties <- tuesdata$counties

# Or read in the data manually

childcare_costs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-09/childcare_costs.csv')
counties <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-09/counties.csv')
```

### Data Dictionary

# `childcare_costs.csv`

|variable                  |class  |description               |
|:-------------------------|:------|:-------------------------|
|county_fips_code          |double |Four- or five-digit number that uniquely identifies the county in a state. The first two digits (for five-digit numbers) or 1 digit (for four-digit numbers) refer to the FIPS code of the state to which the county belongs. |
|study_year                |double |Year the data collection began for the market rate survey and in which ACS data is representative of, or the study publication date. |
|unr_16                    |double |Unemployment rate of the population aged 16 years old or older.|
|funr_16                   |double |Unemployment rate of the female population aged 16 years old or older. |
|munr_16                   |double |Unemployment rate of the male population aged 16 years old or older. |
|unr_20to64                |double |Unemployment rate of the population aged 20 to 64 years old. |
|funr_20to64               |double |Unemployment rate of the female population aged 20 to 64 years old. |
|munr_20to64               |double |Unemployment rate of the male population aged 20 to 64 years old. |
|flfpr_20to64              |double |Labor force participation rate of the female population aged 20 to 64 years old. |
|flfpr_20to64_under6       |double |Labor force participation rate of the female population aged 20 to 64 years old who have children under 6 years old. |
|flfpr_20to64_6to17        |double |Labor force participation rate of the female population aged 20 to 64 years old who have children between 6 and 17 years old. |
|flfpr_20to64_under6_6to17 |double |Labor force participation rate of the female population aged 20 to 64 years old who have children under 6 years old and between 6 and 17 years old. |
|mlfpr_20to64              |double |Labor force participation rate of the male population aged 20 to 64 years old. |
|pr_f                      |double |Poverty rate for families. |
|pr_p                      |double |Poverty rate for individuals. |
|mhi_2018                  |double |Median household income expressed in 2018 dollars. |
|me_2018                   |double |Median earnings expressed in 2018 dollars for the population aged 16 years old or older. |
|fme_2018                  |double |Median earnings for females expressed in 2018 dollars for the population aged 16 years old or older. |
|mme_2018                  |double |Median earnings for males expressed in 2018 dollars for the population aged 16 years old or older. |
|total_pop                 |double |Count of the total population. |
|one_race                  |double |Percent of population that identifies as being one race. |
|one_race_w                |double |Percent of population that identifies as being one race and being only White or Caucasian. |
|one_race_b                |double |Percent of population that identifies as being one race and being only Black or African American. |
|one_race_i                |double |Percent of population that identifies as being one race and being only American Indian or Alaska Native. |
|one_race_a                |double |Percent of population that identifies as being one race and being only Asian. |
|one_race_h                |double |Percent of population that identifies as being one race and being only Native Hawaiian or Pacific Islander. |
|one_race_other            |double |Percent of population that identifies as being one race and being a different race not previously mentioned. |
|two_races                 |double |Percent of population that identifies as being two or more races. |
|hispanic                  |double |Percent of population that identifies as being Hispanic or Latino regardless of race. |
|households                |double |Number of households. |
|h_under6_both_work        |double |Number of households with children under 6 years old with two parents that are both working. |
|h_under6_f_work           |double |Number of households with children under 6 years old with two parents with only the father working. |
|h_under6_m_work           |double |Number of households with children under 6 years old with two parents with only the mother working. |
|h_under6_single_m         |double |Number of households with children under 6 years old with a single mother. |
|h_6to17_both_work         |double |Number of households with children between 6 and 17 years old with two parents that are both working. |
|h_6to17_fwork             |double |Number of households with children between 6 and 17 years old with two parents with only the father working. |
|h_6to17_mwork             |double |Number of households with children between 6 and 17 years old with two parents with only the mother working. |
|h_6to17_single_m          |double |Number of households with children between 6 and 17 years old with a single mother. |
|emp_m                     |double |Percent of civilians employed in management, business, science, and arts occupations aged 16 years old or older in the county. |
|memp_m                    |double |Percent of male civilians employed in management, business, science, and arts occupations aged 16 years old or older in the county. |
|femp_m                    |double |Percent of female civilians employed in management, business, science, and arts occupations aged 16 years old or older in the county. |
|emp_service               |double |Percent of civilians employed in service occupations aged 16 years old and older in the county. |
|memp_service              |double |Percent of male civilians employed in service occupations aged 16 years old and older in the county. |
|femp_service              |double |Percent of female civilians employed in service occupations aged 16 years old and older in the county. |
|emp_sales                 |double |Percent of civilians employed in sales and office occupations aged 16 years old and older in the county. |
|memp_sales                |double |Percent of male civilians employed in sales and office occupations aged 16 years old and older in the county. |
|femp_sales                |double |Percent of female civilians employed in sales and office occupations aged 16 years old and older in the county. |
|emp_n                     |double |Percent of civilians employed in natural resources, construction, and maintenance occupations aged 16 years old and older in the county. |
|memp_n                    |double |Percent of male civilians employed in natural resources, construction, and maintenance occupations aged 16 years old and older in the county. |
|femp_n                    |double |Percent of female civilians employed in natural resources, construction, and maintenance occupations aged 16 years old and older in the county. |
|emp_p                     |double |Percent of civilians employed in production, transportation, and material moving occupations aged 16 years old and older in the county. |
|memp_p                    |double |Percent of male civilians employed in production, transportation, and material moving occupations aged 16 years old and older in the county. |
|femp_p                    |double |Percent of female civilians employed in production, transportation, and material moving occupations aged 16 years old and older in the county. |
|mcsa                      |double |Weekly, full-time median price charged for Center-Based Care for those who are school age based on the results reported in the market rate survey report for the county or the rate zone/cluster to which the county is assigned. |
|mfccsa                    |double |Weekly, full-time median price charged for Family Childcare for those who are school age based on the results reported in the market rate survey report for the county or the rate zone/cluster to which the county is assigned.|
|mc_infant                 |double |Aggregated weekly, full-time median price charged for Center-based Care for infants (i.e. aged 0 through 23 months). |
|mc_toddler                |double |Aggregated weekly, full-time median price charged for Center-based Care for toddlers (i.e. aged 24 through 35 months). |
|mc_preschool              |double |Aggregated weekly, full-time median price charged for Center-based Care for preschoolers (i.e. aged 36 through 54 months). |
|mfcc_infant               |double |Aggregated weekly, full-time median price charged for Family Childcare for infants (i.e. aged 0 through 23 months). |
|mfcc_toddler              |double |Aggregated weekly, full-time median price charged for Family Childcare for toddlers (i.e. aged 24 through 35 months). |
|mfcc_preschool            |double |Aggregated weekly, full-time median price charged for Family Childcare for preschoolers (i.e. aged 36 through 54 months). |

# `counties.csv`

|variable           |class     |description        |
|:------------------|:---------|:------------------|
|county_fips_code   |double    |Four- or five-digit number that uniquely identifies the county in a state. The first two digits (for five-digit numbers) or 1 digit (for four-digit numbers) refer to the FIPS code of the state to which the county belongs. |
|county_name        |character |The full name of the county. |
|state_name         |character |The full name of the state in which the county is found. |
|state_abbreviation |character |The two-letter state abbreviation. |

### Cleaning Script

``` r
# All packages used in this script:
library(tidyverse)
library(here)
library(withr)

url <- "https://www.dol.gov/sites/dolgov/files/WB/media/nationaldatabaseofchildcareprices.xlsx"
temp_xlsx <- withr::local_tempfile(fileext = ".xlsx")
download.file(url, temp_xlsx, mode = "wb")

childcare_costs_raw <- readxl::read_xlsx(temp_xlsx) |>
  janitor::clean_names() |> 
  # There are 15 constant columns. Get rid of those.
  janitor::remove_constant(quiet = FALSE)

# The file is very large, but it contains a lot of duplicate data. Extract
# duplications into their own tables.
counties <- childcare_costs_raw |> 
  dplyr::distinct(county_fips_code, county_name, state_name, state_abbreviation)
childcare_costs <- childcare_costs_raw |> 
  dplyr::select(
    -county_name,
    -state_name,
    -state_abbreviation,
    # Original data also contained unadjusted + adjusted dollars, let's just
    # keep the 2018 adjustments.
    -mhi, -me, -fme, -mme,
    # A number of columns have fine-grained breakdowns by age, and then also
    # broader categories. Let's only keep the categories ("infant" vs 0-5
    # months, 6-11 monts, etc)
    -ends_with("bto5"), -ends_with("6to11"), -ends_with("12to17"), 
    -ends_with("18to23"), -ends_with("24to29"), -ends_with("30to35"),
    -ends_with("36to41"), -ends_with("42to47"), -ends_with("48to53"),
    -ends_with("54to_sa"),
    # Since we aren't worrying about the unaggregated columns, we can ignore the
    # flags indicating how those columns were aggregated into the combined
    # columns.
    -ends_with("_flag"),
    # Original data has both median and 75th percentile for a number of columns.
    # We'll simplify.
    -starts_with("x75"),
    # While important for wider research, we don't need to keep the (many)
    # variables describing whether certain data was imputed.
    -starts_with("i_")
  )

readr::write_csv(
  childcare_costs,
  here::here(
    "data",
    "2023",
    "2023-05-09",
    "childcare_costs.csv"
  )
)

readr::write_csv(
  counties,
  here::here(
    "data",
    "2023",
    "2023-05-09",
    "counties.csv"
  )
)
```
