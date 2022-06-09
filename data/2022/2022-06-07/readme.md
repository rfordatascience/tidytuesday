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

# Pride Donations

The data this week comes from [Data For Progress](https://www.dataforprogress.org/accountable-allies).

> Each year, hundreds of corporations around the country participate in Pride, an annual celebration of the LGBTQ+ community’s history and progress. They present themselves as LGBTQ+ allies, but new research from Data for Progress finds that in between their yearly parade appearances, dozens of these corporations are giving to state politicians behind some of the most bigoted and harmful policies in over a decade. 
> 
> Activists and allies wishing to hold these politicians accountable for bigotry can begin by holding their corporate backers accountable. In a new project series, Data for Progress has compiled a set of resources for activists, employees, community leaders, and lawmakers to push back on these policies and the prejudice powering them. We provide research tying the political giving of specific Fortune 500 companies to anti-LGBTQ+ politicians in six states, polling showing that such giving hurts the brands’ favorability, and upcoming policy memos to understand the issue and to take action.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-06-07')
tuesdata <- tidytuesdayR::tt_load(2022, week = 23)

donations <- tuesdata$pride_aggregates

# Or read in the data manually

pride_aggregates <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-07/pride_aggregates.csv')
fortune_aggregates <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-07/fortune_aggregates.csv')
static_list <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-07/static_list.csv')
pride_sponsors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-07/pride_sponsors.csv')
corp_by_politician <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-07/corp_by_politician.csv')
donors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-06-07/donors.csv')



```
### Data Dictionary

# `pride_aggregates.csv`
- Pride sponsors who have donated to Anti-LQBTQ Campaigns

|variable                             |class     |description |
|:------------------------------------|:---------|:-----------|
|Company                              |character |Company    |
|Total Contributed                    |double    |Total Contributed to anti-LBGTQ politicians   |
|# of Politicians Contributed to      |double    |# of politicians contributed, anti-LBGTQ   |
|# of States Where Contributions Made |double    |# of states where contributions were made to anti-LBGTQ    |

# `fortune_aggregates.csv`
- Fortune 500, Pride sponsors who have donated to Anti-LQBTQ Campaigns

|variable                             |class     |description |
|:------------------------------------|:---------|:-----------|
|Company                              |character |Company name    |
|Total Contributed                    |double    | Total contributed to anti-LBGTQ politicians   |
|# of Politicians Contributed to      |double    | # of politicians contributed to    |
|# of States Where Contributions Made |double    | # of states where contributions made  to anti-LBGTQ  |

# `static_list.csv`
- Overview of company, pride sponsors, HRC Business pledge

|variable                             |class     |description |
|:------------------------------------|:---------|:-----------|
|Company                              |character |Company    |
|Pride?                               |logical   | Donated to pride    |
|HRC Business Pledge                  |character | HRC Business pledge    |
|Amount Contributed Across States     |double    | Amount contributed across states to anti-LBGTQ politicians   |
|# of Politicians Contributed to      |double    | # of politicians contributed    |
|# of States Where Contributions Made |double    | # of states     |

# `pride_sponsors.csv`  


|variable                            |class     |description |
|:-----------------------------------|:---------|:-----------|
|Company                             |character |Company     |
|Pride Event Sponsored               |character | Event sponsored    |
|Sponsorship Amount, where available |character | Sponsorship amount level    |
|Year                                |double    | Year    |
|Source                              |character | Source    |
|True donor value                    |character |True donor name/value    |

# `corp_by_politician.csv` 

|variable      |class     |description |
|:-------------|:---------|:-----------|
|Politician    |character | Politician    |
|SUM of Amount |double    | Sum of amount in USD to anti-LBGTQ   |
|Title         |character | Title of politician    |
|State         |character | State    |
 
# `donors.csv`

|variable                                |class     |description |
|:---------------------------------------|:---------|:-----------|
|Donor Name                              |character |variable    |
|"True" Donor - Pride Sponsor Match Only |character |variable    |
|"True" Donor - Fortune Match Only       |logical   |variable    |
|Pride and Sponsor Match?                |character |variable    |
|Donor Name - Combined                   |character |variable    |

# `contribution_data_all_states.csv`

|variable                                                                  |class     |description |
|:-------------------------------------------------------------------------|:---------|:-----------|
|Company                                                                   |character | Company    |
|Pride and Sponsor Match?                                                  |character | Pride and Sponsorship Match    |
|Pride?                                                                    |logical   | Pride event sponsor    |
|HRC Business Pledge                                                       |character | HRC Busines pledge    |
|Donor Name                                                                |character | Donor name    |
|Politician                                                                |character | Politician    |
|State                                                                     |character | state    |
|Amount                                                                    |double    | Amount in USD     |
|Date                                                                      |double    | Date    |
|Citation                                                                  |logical   | Citation    |
|Donor Type                                                                |character | Donor Type    |
|Comments                                                                  |logical   | Comments    |
|ARCHIVE - Company Manually Determined (May Not Match Pride Sponsors List) |logical   | Archive    |

### Cleaning Script

```r
library(httr)
library(tidyverse)

# overall URL
orig_url <- "https://www.dataforprogress.org/accountable-allies"

# direct link to the iFrame that builds the table
iframe_url <- "https://dfp-accountable-allies.netlify.app/fortune"

# Found the link to the GoogleSheets
par_url <- "https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw"

# Extract data from JSON
get_content <- function(url){
  raw_content <- GET(url) |> content()
  
  nm_content <- raw_content$values[1] |> unlist() |> janitor::make_clean_names()
  
  raw_df <- raw_content$values[2:length(raw_content$values)] |>
    tibble(data = _) |>
    mutate(data = map(data, ~set_names(.x, nm = nm_content[1:length(.x)]))) |>
    unnest_wider(data) |>
    readr::type_convert()
  
  raw_df
}


# get individual datasets
fort_agg_url <- "https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/Fortune%20Aggregates"

fort_agg_df <- get_content(pride_agg_url)

pride_agg_url <- "https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/Pride%20Aggregates"

pride_agg_df <- get_content(pride_agg_url)

static_list_url <- "https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/Static%20List"

static_list_df <- get_content(static_list_url)

pride_sponsor_url <- "https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/Pride%20Sponsors"

pride_sponsor_df <- get_content(pride_sponsor_url)

pride_sponsor_df |> glimpse()


raw_fort_agg <- GET(fort_agg_url) |> content()

fort_agg_nm <- raw_fort_agg$values[1] |> unlist() |> janitor::make_clean_names()

raw_fort_agg_df <- raw_fort_agg$values[2:length(raw_fort_agg$values)] |>
  tibble(data = _) |>
  mutate(data = map(data, ~set_names(.x, nm = fort_agg_nm))) |>
  unnest_wider(data) |>
  readr::type_convert() |>
  mutate(total_contributed = parse_number(total_contributed))

url_builder <- function(text){
  
  text <- stringr::str_replace_all(text, " ", "%20")
  text <- stringr::str_replace_all(text, "/", "%2F")
  glue::glue("https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/{text}")
}

corp_pol_df <- url_builder("Corp by Politician") |>
  get_content()

library(httr)
library(tidyverse)
raw_sheet <- "https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw" |>
  GET() |>
  content()

all_sheets <- raw_sheet |>
  tibble(data = _) |>
  unnest_longer(data) |>
  unnest_wider(data) |>
  unnest_wider(properties) |>
  unnest_wider(gridProperties) |>
  janitor::clean_names() |>
  select(sheet_id, title, row_count:column_count)

all_sheets

url_builder <- function(text){
  
  text <- stringr::str_replace_all(text, " ", "%20")
  text <- stringr::str_replace_all(text, "/", "%2F")
  glue::glue("https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/{text}")
}

all_sheets |>
  pull(title) |>
  url_builder()

all_sheets |>
  mutate(sheet_url = url_builder(title)) |>
  pull(sheet_url)

https://sheets.googleapis.com/v4/spreadsheets/1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw/values/Fortune%201000%20List/Search%20Keys

all_sheets |>
  slice(11) |>
  pull(title) |>
  url_builder()

###### googlesheets

library(googlesheets4)

gs4_deauth()

# courtesty of Jenny Bryan
ssid <- "1Bj8YMaqxYrh2PxVhI1M1kLSbIMSN7vTpR2OZxg1DoXw"
(ss <- gs4_get(ssid))

read_sheet(ss, "Fortune Aggregates") |> 
  write_csv('2022/2022-06-07/fortune_agg.csv')

read_sheet(ss, "Pride Sponsors")

# grab and clean sheets
sub_sheets <- ss$sheets |> 
  slice(2:6, 12:13) |> 
  select(name) |> 
  mutate(title = paste0(janitor::make_clean_names(name), ".csv")) 

all_df <- sub_sheets |> 
  mutate(data = map(name, ~read_sheet(ss, .x)))

write_df <- function(title, data){
  write_csv(x = data, file =glue::glue("2022/2022-06-07/{title}"))
}

# write out the datasets
all_df |> 
  select(title, data) |> 
  pwalk(write_df)
  
all_df |> 
  pull(data) |> 
  map(create_tidytuesday_dictionary)
  


```
