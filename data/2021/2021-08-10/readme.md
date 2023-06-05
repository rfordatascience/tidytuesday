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

![Logo for the Bureau of Economic Analysis - it's the letters "b" "e" "a" in blue with an increasing line chart in blue/orange to the left](https://upload.wikimedia.org/wikipedia/commons/9/9a/Bea-final-logo-blue-backing.png)

# BEA Infrastructure Investment

The data this week comes from [Bureau of Economic Analysis](https://www.bea.gov/system/files/papers/BEA-WP2020-12.pdf). The raw `.xlsx` file is included, or can be downloaded directly from the [BEA Working paper series](https://www.bea.gov/system/files/2021-01/infrastructure-data-may-2020.xlsx).

Note that there are additional datasets in the Excel file, but the 3 primary datasets are already cleaned and saved as individual `.csv` files.

h/t to [Donald Schneider](https://twitter.com/DonFSchneider/status/1367181077316575236?s=20) and [DataIsPlural](https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit#gid=0)

The Working Paper by [Jennifer Bennett et al](https://www.bea.gov/system/files/papers/BEA-WP2020-12.pdf)

> Infrastructure provides critical support for economic activity, and assessing its role requires reliable measures. This paper provides an overview of U.S. infrastructure data in the National Economic Accounts. After developing definitions of basic, social, and digital infrastructure, we assess trends in each of these categories and their components. Results are mixed depending on the category. Investment in some important types of basic infrastructure has barely or not kept up with depreciation and population growth in recent decades, while some other categories look better. We also show that the average age of most types of infrastructure in the U.S. has been rising, and the remaining service life has been falling. This paper also presents new prototype estimates of state-level investment in highways, highlighting the wide variation across states. In addition, we present new prototype data on maintenance expenditures for highways. In terms of future research, we believe that deprecation rates warrant additional attention given that current estimates are based on 40-year old research and are well below those used in Canada and other countries. We also believe that additional creative work on price indexes for infrastructure would be valuable. Finally, all of the data in this paper are downloadable, and we hope that the analysis in this paper and the availability of data will spur additional research.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-08-10')
tuesdata <- tidytuesdayR::tt_load(2021, week = 33)

investment <- tuesdata$investment

# Or read in the data manually

investment <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-10/investment.csv')
chain_investment <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-10/chain_investment.csv')
ipd <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-08-10/ipd.csv')

```
### Data Dictionary

# `investment.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|category      |character | Category of investment |
|meta_cat      |character | Group category of investment |
|group_num     |double    | Group number of investment |
|year          |integer   | Year of investment |
|gross_inv |double    | Gross investment in millions of USD |

# `chain_investment.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|category      |character | Category of investment |
|meta_cat      |character | Group category of investment |
|group_num     |double    | Group number of investment |
|year          |integer   | Year of investment |
|gross_inv_chain |double    | Gross investment (chained 2021 dollars) in millions of USD |


# `ipd.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|category      |character | Category of investment |
|meta_cat      |character | Group category of investment |
|group_num     |double    | Group number of investment |
|year          |integer   | Year of investment |
|gross_inv_ipd |double    | Implicit Price Deflators (IPDs) An implicit price deflator is the ratio of the current-dollar value of a series, such as gross domestic product (GDP), to its corresponding chained-dollar value, multiplied by 100. |



### Cleaning Script

```
library(readxl)
library(tidyverse)

raw_df  <- readxl::read_excel("2021/2021-08-10/infrastructure-data-may-2020.xlsx", sheet = 2, skip = 2)

gross_inv <- raw_df %>% 
  rename(group = ...1, category = ...2) %>% 
  filter(!is.na(category)) %>% 
  mutate(
    meta_cat = if_else(!is.na(group), category, NA_character_), 
    group_num = group,
    .after = "category"
    ) %>% 

  fill(meta_cat, group_num) %>%
  pivot_longer(names_to = "year", values_to = "gross_inv", cols = `1947`:`2017`,
               names_transform = list(year = as.integer)) %>% 
  filter(is.na(group)) %>% 
  select(-group)


raw_df2  <- readxl::read_excel("2021/2021-08-10/infrastructure-data-may-2020.xlsx", sheet = 3, skip = 2)

chain_inv <- raw_df2 %>% 
  rename(group = ...1, category = ...2) %>%
  mutate(
    meta_cat = if_else(!is.na(group), category, NA_character_), 
    group_num = group,
    .after = "category"
  ) %>% 
  
  fill(meta_cat, group_num) %>%
  pivot_longer(names_to = "year", values_to = "gross_inv_chain", cols = `1947`:`2017`,
               names_transform = list(year = as.integer)) %>% 
  filter(is.na(group)) %>% 
  select(-group)


raw_df3  <- readxl::read_excel("2021/2021-08-10/infrastructure-data-may-2020.xlsx", sheet = 4, skip = 2)

ipd <- raw_df3 %>% 
  rename(group = ...1, category = ...2) %>% 
  filter(!is.na(category)) %>% 
  mutate(
    meta_cat = if_else(!is.na(group), category, NA_character_), 
    group_num = group,
    group_num = if_else(category == "GDP", 0, group_num),
    .after = "category"
  ) %>% 
  
  fill(meta_cat, group_num) %>%
  pivot_longer(names_to = "year", values_to = "gross_inv_ipd", cols = `1947`:`2017`,
               names_transform = list(year = as.integer)) %>% 
  filter(is.na(group)) %>% 
  select(-group) %>% 
  mutate(meta_cat = if_else(category == "GDP", "GDP", meta_cat))

gross_inv %>% write_csv("2021/2021-08-10/investment.csv")
chain_inv %>% write_csv("2021/2021-08-10/chain_investment.csv")


```
