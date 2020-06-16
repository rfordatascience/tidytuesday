# You can make it in R

This week's data is a meta collection of data sources and code from Rafael Irizarry - his recent blog post [You can replicate almost any plot with R](https://simplystatistics.org/2019/08/28/you-can-replicate-almost-any-plot-with-ggplot2/) covered a few news articles and how to replicate them in R. I included 4 datasets, but please note that there are many more datasets in his [DS Labs package](https://github.com/rafalab/dslabs).

I'd recommend checking out his [blog post](https://simplystatistics.org/2019/08/28/you-can-replicate-almost-any-plot-with-ggplot2/) for plot examples and metadata.

# Get the Data

```
murders <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/international_murders.csv")

gun_murders <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/gun_murders.csv")

diseases <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")

nyc_regents <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/nyc_regents.csv")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!
# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load("2019-12-10")
tuesdata <- tidytuesdayR::tt_load(2019, week = 50)

diseases <- tuesdata$diseases
```

# Dictionary

### `diseases.csv`
|variable        |class     |description |
|:---------------|:---------|:-----------|
|disease         |integer   | Disease name |
|state           |character | State |
|year            |double    | Year |
|weeks_reporting |integer   | N of weeks reporting |
|count           |double    | Count of disease observed |
|population      |double    | Total population |

### `nyc_regents.csv`
|variable           |class  |description |
|:------------------|:------|:-----------|
|score              |double | Grading score (0 - 100)|
|integrated_algebra |double | Total observations |
|global_history     |double | Total observations |
|living_environment |double | Total observations |
|english            |double | Total observations |
|us_history         |double | Total observations |

### `international_murders.csv`
|variable           |class     |description |
|:------------------|:---------|:-----------|
|country            |character | country |
|count              |double    | Total observations |
|label              |character | Total observations |
|code               |character | 2 letter country code |


### `gun_murders.csv`
|variable           |class  |description |
|:------------------|:------|:-----------|
|country            |character | country |
|count              |double | gun related homicides per 100,000 people |

# Cleaning

```
devtools::install_github("rafalab/dslabs")

library(dslabs)
library(tidyverse)
library(here)

murders <- tibble(country = toupper(c("US", "Italy", "Canada", "UK", "Japan", "Germany", "France", "Russia")),
              count = c(3.2, 0.71, 0.5, 0.1, 0, 0.2, 0.1, 0),
              label = c(as.character(c(3.2, 0.71, 0.5, 0.1, 0, 0.2, 0.1)), "No Data"),
              code = c("us", "it", "ca", "gb", "jp", "de", "fr", "ru"))

gun_murders <- tibble(country = toupper(c("United States", "Canada", "Portugal", "Ireland", "Italy", "Belgium", "Finland", "France", "Netherlands", "Denmark", "Sweden", "Slovakia", "Austria", "New Zealand", "Australia", "Spain", "Czech Republic", "Hungry", "Germany", "United Kingdom", "Norway", "Japan", "Republic of Korea")),
              count = c(3.61, 0.5, 0.48, 0.35, 0.35, 0.33, 0.26, 0.20, 0.20, 0.20, 0.19, 0.19, 0.18, 0.16,
                        0.16, 0.15, 0.12, 0.10, 0.06, 0.04, 0.04, 0.01, 0.01))

diseases <- dslabs::us_contagious_diseases

nyc <- dslabs::nyc_regents_scores


murders %>% 
  write_csv(here("2019", "2019-12-10","international_murders.csv"))

gun_murders %>% 
  write_csv(here("2019", "2019-12-10","gun_murders.csv"))


diseases %>% 
  write_csv(here("2019", "2019-12-10","diseases.csv"))

nyc %>% 
  write_csv(here("2019", "2019-12-10","nyc_regents.csv"))


```