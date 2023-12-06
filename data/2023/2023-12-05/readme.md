# Life Expectancy

Our World in Data released a [new report on life expectancy](https://ourworldindata.org/life-expectancy), and analysis and interpretations are making the rounds this week, and you can join in too! 

We had a dataset on Global Life Expectancy on [2018-07-03](https://github.com/rfordatascience/tidytuesday/tree/master/data/2018#readme), so if you're a long time tidytuesday-er, this is a chance for some new analyses. 

The data this week comes the [Our World in Data Life Expectancy report](https://ourworldindata.org/life-expectancy), specifically the figures in the [key insights](https://ourworldindata.org/life-expectancy#key-insights) section. The source for this data is from United Nations World Population Prospects (2022); Human Mortality Database (2023); Zijdeman, Richard and Filipa Ribeira da Silva (2015), [Life Expectancy at Birth (Total)](http://hdl.handle.net/10622/LKYT5); Riley, J.C. (2005), [Estimates of Regional and Global Life Expectancy 1800-2001](https://doi.org/10.1111/j.1728-4457.2005.00083.x), Population and Development Review, 31: 537-543. Minor processing by Our World in Data. 

>Across the world, people are living longer.
In 1900, the average life expectancy of a newborn was 32 years. By 2021 this had more than doubled to 71 years.
But where, when, how, and why has this dramatic change occurred?
To understand it, we can look at data on life expectancy worldwide.
The large reduction in child mortality has played an important role in increasing life expectancy. But life expectancy has increased at all ages. Infants, children, adults, and the elderly are all less likely to die than in the past, and death is being delayed.
This remarkable shift results from advances in medicine, public health, and living standards. Along with it, many predictions of the ‘limit’ of life expectancy have been broken.
On the Our World in Data Life Expectancy page, you will find global data and research on life expectancy and related measures of longevity: the probability of death at a given age, the sex gap in life expectancy, lifespan inequality within countries, and more.


## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-12-05')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 49)

life_expectancy <- tuesdata$life_expectancy
life_expectancy_different_ages <- tuesdata$life_expectancy_different_ages
life_expectancy_female_male <- tuesdata$life_expectancy_female_male

# Option 2: Read directly from GitHub

life_expectancy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy.csv')
life_expectancy_different_ages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy_different_ages.csv')
life_expectancy_female_male <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy_female_male.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `life_expectancy.csv`

|variable                                            |class     |description                                         |
|:---------------------------------------------------|:---------|:---------------------------------------------------|
|Entity                                              |character |Country or region entity                                             |
|Code                                                |character |Entity code                                                |
|Year                                                |double    |Year                                                |
|LifeExpectancy  |double    |Period life expectancy at birth - Sex: all - Age: 0 |

# `life_expectancy_different_ages.csv`

|variable                                            |class     |description                                         |
|:---------------------------------------------------|:---------|:---------------------------------------------------|
|Entity                                              |character |Country or region entity                                              |
|Code                                                |character |Entity code                                                |
|Year                                                |double    |Year                                                |
|LifeExpectancy0 |double    |Period life expectancy at birth - Sex: all - Age: 0 |
|LifeExpectancy10  |double    |Period life expectancy - Sex: all - Age: 10         |
|LifeExpectancy25 |double    |Period life expectancy - Sex: all - Age: 25         |
|LifeExpectancy45  |double    |Period life expectancy - Sex: all - Age: 45         |
|LifeExpectancy65   |double    |Period life expectancy - Sex: all - Age: 65         |
|LifeExpectancy80     |double    |Period life expectancy - Sex: all - Age: 80       |


# `life_expectancy_female_male.csv`

|variable                                                             |class     |description                                                          |
|:--------------------------------------------------------------------|:---------|:--------------------------------------------------------------------|
|Entity                                                               |character |Country or region entity                                                               |
|Code                                                                 |character |Entity code                                                                 |
|Year                                                                 |double    |Year                                                                 |
|LifeExpectancyDiffFM |double    |Life expectancy difference (f-m) - Type: period - Sex: both - Age: 0 |


### Cleaning Script

Data was downloaded from the tables for the figures in the [Key Insights section](https://ourworldindata.org/life-expectancy?insight=life-expectancy-has-surpassed-predictions-again-and-again#key-insights) of the Life Expectancy article.

* Life expectancy across the world is life_expectancy.csv.  
* Life expectancy has increased across all ages is life_expectancy_different_ages.csv
* Women tend to live longer than men, but this gap has changed over time is life_expectancy_female_male.csv.


Column names were changed to make the data easier to work with.


``` r
library(tidyverse)
library(here)

working_dir <- here::here("data", "2023", "2023-12-05")


le <- read_csv("life_expectancy.csv")
colnames(le)[4] <- "LifeExpectancy"
readr::write_csv(
  le,
  fs::path(working_dir, "life_expectancy.csv")
)

le_different_ages <- read_csv("life_expectancy_different_ages.csv")
colnames(le_different_ages)[4:9] <- c("LifeExpectancy0", "LifeExpectancy10", "LifeExpectancy25","LifeExpectancy45", "LifeExpectancy65", "LifeExpectancy80")
readr::write_csv(
  le_different_ages,
  fs::path(working_dir, "life_expectancy_different_ages.csv")
)

le_female_male <- read_csv("life_expectancy_female_male.csv")
colnames(le_female_male)[4] <- "LifeExpectancyDiffFM"
readr::write_csv(
  le_female_male,
  fs::path(working_dir, "life_expectancy_female_male.csv")
)



```

