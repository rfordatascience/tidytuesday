# Valentine's Day Consumer Data

Happy Valentine's Day! This week we're exploring [Valentine's Day survey data](https://www.kaggle.com/datasets/infinator/happy-valentines-day-2022). The National Retail Federation in the United States conducts surveys and has created a [Valentine's Day Data Center](https://nrf.com/research-insights/holiday-data-and-trends/valentines-day/valentines-day-data-center) so you can explore the data on how consumers celebrate. 

> The NRF has surveyed consumers about how they plan to celebrate Valentine’s Day annually for over a decade. Take a deeper dive into the data from the last 10 years, and use the interactive charts to explore a demographic breakdown of total spending, average spending, types of gifts planned and spending per type of gift. 

The NRF has continued to collect data. The data for this week is from 2010 to 2022, as organized by Suraj Das for a Kaggle dataset. In the historical surveys gender was collected as only 'Men' and 'Women', which does not accurately include all genders. 

If you're looking for other Valentine's Day type datasets, check out previous datasets on [chocolate](https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-01-18) or [board games](https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-01-25) (a good Valentine's Day activity!).

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-02-13')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 7)

historical_spending <- tuesdata$historical_spending
gifts_age <- tuesdata$gifts_age
gifts_gender <- tuesdata$gifts_gender


# Option 2: Read directly from GitHub

historical_spending <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-13/historical_spending.csv')
gifts_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-13/gifts_age.csv')
gifts_gender <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-02-13/gifts_gender.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `historical_spending.csv`

|variable           |class  |description        |
|:------------------|:------|:------------------|
|Year               |double |Year               |
|PercentCelebrating |double |Percent of people celebrating Valentines Day |
|PerPerson          |double |Average amount each person is spending          |
|Candy              |double |Average amount spending on candy              |
|Flowers            |double |Average amount spending on flowers            |
|Jewelry            |double |Average amount spending on jewelry            |
|GreetingCards      |double |Average amount spending on greeting cards      |
|EveningOut         |double |Average amount spending on an evening out         |
|Clothing           |double |Average amount spending on clothing           |
|GiftCards          |double |Average amount spending on gift cards          |

# `gifts_age.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|Age                 |character |Age                 |
|SpendingCelebrating |double    |Percent spending money on or celebrating Valentines Day |
|Candy               |double    |Average percent spending on candy               |
|Flowers             |double    |Average percent spending on flowers         |
|Jewelry             |double    |Average percent spending on jewelry           |
|GreetingCards       |double    |Average percent spending on greeting cards    |
|EveningOut          |double    |Average percent spending on an evening out       |
|Clothing            |double    |Average percent spending on clothing          |
|GiftCards           |double    |Average percent spending on gift cards           |

# `gifts_gender.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|Gender                 |character |Gender only including Men or Women                 |
|SpendingCelebrating |double    |Percent spending money on or celebrating Valentines Day |
|Candy               |double    |Average percent spending on candy               |
|Flowers             |double    |Average percent spending on flowers         |
|Jewelry             |double    |Average percent spending on jewelry           |
|GreetingCards       |double    |Average percent spending on greeting cards    |
|EveningOut          |double    |Average percent spending on an evening out       |
|Clothing            |double    |Average percent spending on clothing          |
|GiftCards           |double    |Average percent spending on gift cards           |

### Cleaning Script

Data was downloaded from [Sunja aa Kaggle dataset](https://www.kaggle.com/datasets/infinator/happy-valentines-day-2022). 

Data from historical_gift_trends_per_person_spending.csv, historical_spending_average_expected_spending.csv and historical_spending_percent_celebrating.csv were combined into historical_spending.csv.

Data from planned_gifts_age.csv and spending_or_celebrating_age_1.csv were combined into gifts_age.csv. 

Data from planned_gifts_gender.csv and spending_or_celebrating_gender_1.csv were combined into gifts_gender.csv.

Percentage signs and dollar signs were removed from all numerical values. 
