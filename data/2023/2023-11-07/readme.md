# US House Election Results

It's election day in the United States! To celebrate, the data this week comes from the [MIT Election Data and Science Lab](https://electionlab.mit.edu/) (MEDSL). Hat tip this week to the [RStudio GitHub Copilot integration](https://docs.posit.co/ide/user/ide/guide/tools/copilot.html), which suggested the MEDSL.

From the MEDSL's report [New Report: How We Voted in 2022](https://electionlab.mit.edu/articles/new-report-how-we-voted-2022):

> The Survey of the Performance of American Elections (SPAE) provides information about how Americans experienced voting in the most recent federal election. The survey has been conducted after federal elections since 2008, and is the only public opinion project in the country that is dedicated explicitly to understanding how voters themselves experience the election process.

We're specifically providing data on House elections from 1976-2022. Check out the [MEDSL website](https://electionlab.mit.edu/) for additional datasets and tools.

Be sure to cite the MEDSL in your work:

```
@data{DVN/IG0UN2_2017,
author = {MIT Election Data and Science Lab},
publisher = {Harvard Dataverse},
title = {{U.S. House 1976–2022}},
UNF = {UNF:6:A6RSZvlhh8eRZ4+mvT/HRQ==},
year = {2017},
version = {V12},
doi = {10.7910/DVN/IG0UN2},
url = {https://doi.org/10.7910/DVN/IG0UN2}
}
```

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-11-07')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 45)

house <- tuesdata$house

# Option 2: Read directly from GitHub

house <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-07/house.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `house.csv`

|variable       |class     |description    |
|:--------------|:---------|:--------------|
|year           |double    |year in which election was held |
|state          |character |state name |
|state_po       |character |U.S. postal code state abbreviation |
|state_fips     |double    |State FIPS code |
|state_cen      |double    |U.S. Census state code |
|state_ic       |double    |ICPSR state code |
|office         |character |U.S. House (constant) |
|district       |character |district number. At-large districts are coded as 0 (zero) |
|stage          |character |electoral stage (gen = general elections, pri = primary elections) |
|runoff         |logical   |runoff election |
|special        |logical   |special election |
|candidate      |character |name of the candidate as it appears in the House Clerk report |
|party          |character |party of the candidate (always entirely lowercase) (Parties are as they appear in the House Clerk report. In states that allow candidates to appear on multiple party lines, separate vote totals are indicated for each party. Therefore, for analysis that involves candidate totals, it will be necessary to aggregate across all party lines within a district. For analysis that focuses on two-party vote totals, it will be necessary to account for major party candidates who receive votes under multiple party labels. Minnesota party labels are given as they appear on the Minnesota ballots. Future versions of this file will include codes for candidates who are endorsed by major parties, regardless of the party label under which they receive votes.) |
|writein        |logical   |vote totals associated with write-in candidates |
|mode           |character |mode of voting; states with data that doesn't break down returns by mode are marked as "total" |
|candidatevotes |double    |votes received by this candidate for this particular party |
|totalvotes     |double    |total number of votes cast for this election |
|unofficial     |logical   |TRUE/FALSE indicator for unofficial result (to be updated later); this appears only for 2018 data in some cases |
|version        |double    |date when this dataset was finalized |
|fusion_ticket  |logical   |A TRUE/FALSE indicator as to whether the given candidate is running on a fusion party ticket, which will in turn mean that a candidate will appear multiple times, but by different parties, for a given election. States with fusion tickets include Connecticut, New Jersey, New York, and South Carolina. |


### Cleaning Script

Clean data and dictionary downloaded from the [Harvard Dataverse ](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/IG0UN2)
