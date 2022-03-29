### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Collegiate sports

The data this week comes from [Equity in Athletics Data Analysis](https://ope.ed.gov/athletics/#/datafile/list), hattip to [Data is Plural](https://www.data-is-plural.com/archive/2020-10-21-edition/).

An additional article can be found at [USA Facts](https://usafacts.org/articles/coronavirus-college-football-profit-sec-acc-pac-12-big-ten-millions-fall-2020/).

Please note that I have only used a subset of all available columns, there are MANY other columns of interest like coaching staff and other statistics. Please see the Schoolsdoc file in each folder (EADA_2016-2017, etc) for the definitions of additional columns.

Additional articles from [US News](https://www.usnews.com/news/sports/articles/2021-10-26/second-ncaa-gender-equity-report-shows-spending-disparities#:~:text=The%20NCAA%20spent%20%244%2C285%20per,championships%20than%20for%20the%20women's.) and [NPR](https://www.npr.org/2021/10/27/1049530975/ncaa-spends-more-on-mens-sports-report-reveals).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-03-29')
tuesdata <- tidytuesdayR::tt_load(2022, week = 13)

sports <- tuesdata$sports

# Or read in the data manually

sports <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-29/sports.csv')

```
### Data Dictionary

# `sports.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|year                 |integer   | year, which is year: year + 1, eg 2015 is 2015 to 2016 |
|unitid               |double    | School ID |
|institution_name     |character | School name |
|city_txt             |character | City name |
|state_cd             |character | State abbreviation |
|zip_text             |character | Zip of school |
|classification_code  |double    | Code for school classification |
|classification_name  |character | School classification |
|classification_other |character | School classification other |
|ef_male_count        |double    | Total male student  |
|ef_female_count      |double    | Total Female student  |
|ef_total_count       |double    | Total student  for binary male/female gender (sum of previous two cols) |
|sector_cd            |double    | Sector code |
|sector_name          |character | Sector name |
|sportscode           |double    | Sport code |
|partic_men           |double    | Participation men  |
|partic_women         |double    | Participation women |
|partic_coed_men      |double    | Participation as coed men |
|partic_coed_women    |double    | Participation for coed women|
|sum_partic_men       |double    | Sum of participation for men |
|sum_partic_women     |double    | Sum of participation women |
|rev_men              |double    | Revenue in USD for men |
|rev_women            |double    | Revenue in USD for women |
|total_rev_menwomen   |double    | Total revenue for both|
|exp_men              |double    | Expenditures in USD for men |
|exp_women            |double    | Expenditures in USD for women |
|total_exp_menwomen   |double    | Total Expenditure for both |
|sports               |character | Sport name |


### Cleaning Script

```
library(tidyverse)

read_clean <- function(year) {
  raw_df <- readxl::read_excel(glue::glue("2022/2022-03-29/EADA_{year}-{as.double(year)+1}/Schools.xlsx"))

  clean_df <- raw_df %>%
    select(
      unitid, institution_name, city_txt:SUM_PARTIC_WOMEN,
      REV_MEN:TOTAL_REV_MENWOMEN, EXP_MEN:TOTAL_EXP_MENWOMEN, Sports
    ) %>%
    janitor::clean_names() %>%
    mutate(year = as.integer(year), .before = 1) %>%
    type_convert()

  clean_df
}

all_df <- 2015:2019 %>%
  map_dfr(read_clean)

all_df %>% 
  write_csv("2022/2022-03-29/sports.csv")
```

