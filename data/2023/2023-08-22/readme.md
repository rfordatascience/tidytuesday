# Refugees

The data this week comes from PopulationStatistics {refugees} R package. 

> {refugees} is an R package designed to facilitate access to the United Nations High Commissioner for Refugees (UNHCR) Refugee Data Finder. It provides an easy-to-use interface to the database, which covers forcibly displaced populations, including refugees, asylum-seekers, internally displaced people, stateless people, and others over a span of more than 70 years.

This package provides data from three major sources:

- Data from UNHCR’s annual statistical activities dating back to 1951.
- Data from the United Nations Relief and Works Agency for Palestine Refugees in the Near East (UNRWA), specifically for registered Palestine refugees under UNRWA’s mandate.
- Data from the Internal Displacement Monitoring Centre (IDMC) on people displaced within their country due to conflict or violence.

The {refugees} package includes eight datasets. We're working with `population` with data from 2010 to 2022. 



## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-08-22')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 34)

population <- tuesdata$population

# Option 2: Read directly from GitHub

population <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-08-22/population.csv')
```

### Data Dictionary

# `population.csv`

|variable          |class     |description       |
|:-----------------|:---------|:-----------------|
|year              |double    |The year.              |
|coo_name          |character |Country of origin name.        |
|coo               |character |Country of origin UNHCR code.   |
|coo_iso           |character |Country of origin ISO code.  |
|coa_name          |character |Country of asylum name.    |
|coa               |character |Country of asylum UNHCR code.  |
|coa_iso           |character |Country of asylum ISO code.    |
|refugees          |double    |The number of refugees.   |
|asylum_seekers    |double    |The number of asylum-seekers.  |
|returned_refugees |double    |The number of returned refugees. |
|idps              |double    |The number of internally displaced persons.     |
|returned_idps     |double    |The number of returned internally displaced persons.  |
|stateless         |double    |The number of stateless persons.  |
|ooc               |double    |The number of others of concern to UNHCR.   |
|oip               |double    |The number of other people in need of international protection.     |
|hst               |double    |The number of host community members.     |


### Cleaning Script

``` r
### Data from the {refugees} R package

library(tidyverse)
library(refugees)

populations <- refugees::population

# Get just the years from 2010 to 2022

populations2010 <- filter(populations, year >= 2010)

write_csv(populations2010, "population.csv")
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
