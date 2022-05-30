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

# 2022 Axios-Harris Poll

The data this week comes from [Axios and Harris Poll](https://www.axios.com/2022/05/24/2022-axios-harris-poll-100-rankings). Also see [The Harris Poll overview for more details](https://theharrispoll.com/partners/media/axios-harrispoll-100/).

No poll is perfect, but methodology is included below, and see the links for [Axios and Harris Poll](https://www.axios.com/2022/05/24/2022-axios-harris-poll-100-rankings) or [The Harris Poll overview for more details](https://theharrispoll.com/partners/media/axios-harrispoll-100/).

> This survey is the result of a partnership between Axios and Harris Poll to gauge the reputation of the most visible brands in America, based on 20 years of Harris Poll research. From Trader Joe's to Disney, here's how this year's class stacks up.
> 
> Methodology: The Axios Harris Poll 100 is based on a survey of 33,096 Americans in a nationally representative sample conducted March 11-April 3, 2022. The two-step process starts fresh each year by surveying the public’s top-of-mind awareness of companies that either excel or falter in society.
> 
> These 100 “most visible companies” are then ranked by a second group of Americans across the seven key dimensions of reputation to arrive at the ranking. If a company is not on the list, it did not reach a critical level of visibility to be measured.

> Phase 1
> 
> In February 2022, The Harris Poll fielded three rounds of “nominations” among a nationally representative sample of Americans to determine which companies were top-of-mind for the public. Respondents were asked which two companies they think have the best reputation and which two have the worst reputation. Both sets of nominations were then combined into a single list, with subsidiaries and brands tallied added to their parent organizations. The 100 companies with the most nominations were then selected to be on the ‘Most Visible’ list.

> Phase 2
>
> The ”ratings” phase of the survey was conducted among 33,096 online interviews from March 11th to April 2nd, 2022 among a nationally representative sample of U.S. adults.
Respondents were randomly assigned two companies to rate for which they answered they were very or somewhat familiar with.
Each company received approximately 325 ratings.
An RQ score is calculated by:  [ (Sum of ratings of each of the 9 attributes)/(the total number of attributes answered x 7) ]  x 100. Score ranges: 80 & above: Excellent | 75-79: Very Good | 70-74: Good | 65-69: Fair | 55-64: Poor | 50-54: Very Poor | Below 50: Critical

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-05-31')
tuesdata <- tidytuesdayR::tt_load(2022, week = 22)

poll <- tuesdata$poll

# Or read in the data manually

poll <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/poll.csv')
reputation <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-31/reputation.csv')

```
### Data Dictionary

# `poll.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|company   |character | Company Name |
|industry  |character | Industry group |
|2022_rank |integer   | 2022 Rank (1 is better than 100) |
|2022_rq   |double    | 2022 RQ score. An RQ score is calculated by:  [ (Sum of ratings of each of the 9 attributes)/(the total number of attributes answered x 7) ]  x 100. Score ranges: 80 & above: Excellent; 75-79: Very Good ; 70-74: Good ; 65-69: Fair ; 55-64: Poor ; 50-54: Very Poor ; Below 50: Critical |
|change    |integer   | Change in rank from 2021         |
|year      |integer   | Year for that rank/RQ |
|rank      |integer   | Rank corresponding to the year|
|rq        |double    | RQ score corresponding to the year |

# `reputation.csv`
- All ranks in this for current year only

|variable  |class     |description |
|:---------|:---------|:-----------|
|company   |character | Company Name |
|industry  |character | Industry group |
|name      |character | Name of reputation category (P&S = Product and Service) |
|score     |double    | Score for reputation category |
|rank      |integer   | Rank for reputation category |

### Cleaning Script

``` r
library(rvest)
library(tidyverse)
library(jsonlite)
library(gt)
library(gtExtras)

tab_url <- "https://graphics.axios.com/2022-05-16-harris-poll/index.html?initialWidth=469&childId=av-2022-05-16-harris-poll-69AC2&parentTitle=The%202022%20Axios%20Harris%20Poll%20100%20reputation%20rankings&parentUrl=https%3A%2F%2Fwww.axios.com%2F2022%2F05%2F24%2F2022-axios-harris-poll-100-rankings"
tab_js <- "https://graphics.axios.com/2022-05-16-harris-poll/js/app.57adf1a5a55662f9bc9f.min.js?57adf1a5a55662f9bc9f"

raw_txt <- readLines(tab_js)

raw_json <- raw_txt |> 
  paste0(collapse = "") |> 
  gsub(
    x = _, 
    pattern = ".*o\\(M,n\\)\\}\\},function\\(n\\)\\{n\\.exports=JSON\\.parse\\('",
    replacement = ""
  ) |> 
  gsub(
    x = _,
    pattern = "'\\)\\},function\\(n,t,r\\)\\{n\\.exports.*",
    replacement = ""
  ) |> 
  str_remove_all("\\\\")


json_out <- jsonlite::fromJSON(raw_json, simplifyVector = FALSE)

raw_df <-json_out |> 
  tibble(data = _) |> 
  unnest_wider(data) 

glimpse(raw_df)

raw_df |> 
  write_rds("axios-harris-poll.rds")

js_df <- raw_df |> 
  unnest_longer(history) |> 
  unnest_wider(history) |> 
  select(-dimensions)

js_df

js_df |> write_csv("2022/2022-05-31/axios.csv")

js_df |> 
  filter(!is.na(rank) | year == 2021)

axios_vars <- raw_df |> 
  select(-history) |> 
  unnest_wider(dimensions) |> 
  pivot_longer(names_to = "name", values_to = "vals", cols = TRUST:CULTURE) |> 
  unnest_wider(vals)

axios_vars |> 
  select(company, industry, name, score, rank) |>   write_csv("2022/2022-05-31/reputation.csv")

raw_df |> 
  select(-history, -dimensions) |> 
  rename(change_icon = change) |> 
  head(20) |> 
  gt::gt() |> 
  gtExtras::gt_fa_rank_change(change_icon, font_color = "match") |> 
  gt::cols_label(change_icon = "")
```