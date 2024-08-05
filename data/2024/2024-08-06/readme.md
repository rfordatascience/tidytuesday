# Olympics athletes and medals

This week we're exploring Olympics data! 

The data this week comes from the [RGriffin Kaggle dataset: 120 years of Olympic history: athletes and results](https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results/), basic bio data on athletes and medal results from Athens 1896 to Rio 2016. 

This is an intentional repeat of [TidyTuesday 2021-07-27](https://tidytues.day/2021/2021-07-27), since it's the Olympics!

> This is a historical dataset on the modern Olympic Games, including all the Games from Athens 1896 to Rio 2016. I scraped this data from www.sports-reference.com in May 2018. 
> 
> Note that the Winter and Summer Games were held in the same year up until 1992. After that, they staggered them such that Winter Games occur on a four year cycle starting with 1994, then Summer in 1996, then Winter in 1998, and so on. A common mistake people make when analyzing this data is to assume that the Summer and Winter Games have always been staggered.

> The Olympic data on www.sports-reference.com is the result of an incredible amount of research by a group of Olympic history enthusiasts and self-proclaimed 'statistorians'. Check out their [blog](http://olympstats.com/) for more information. All I did was consolidated their decades of work into a convenient format for data analysis.

Information from this year's Olympics, along with past games, are on the [Olympics results](https://olympics.com/en/olympic-games/olympic-results) page. 

If you were doing TidyTuesdays in 2021, what can you do differently now? Exploring for the first time? What are the patterns? Can you use this historical data to predict this year's results, and how correct are you? 



## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-08-06')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 32)

olympics <- tuesdata$olympics


# Option 2: Read directly from GitHub

olympics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-08-06/olympics.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `olympics.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|id       |double    | Athlete ID |
|name     |character | Athlete Name |
|sex      |character | Athlete Sex |
|age      |double    | Athlete Age |
|height   |double    | Athlete Height in cm|
|weight   |double    | Athlete weight in kg |
|team     |character | Country/Team competing for|
|noc      |character | noc region |
|games    |character | Olympic games name |
|year     |double    | Year of olympics |
|season   |character | Season either winter or summer |
|city     |character | City of Olympic host |
|sport    |character | Sport |
|event    |character | Specific event |
|medal    |character | Medal (Gold, Silver, Bronze or NA) |


### Cleaning Script

No cleaning, the same data as from [2021-07-27](https://tidytues.day/2021/2021-07-27).