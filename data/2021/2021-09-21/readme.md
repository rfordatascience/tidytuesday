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

![An image of the Emmy award, it is a golden trophy with lightning-shaped angel wings. The figure is holding a hollow sphere with extended arms.](https://static-wmwm.warnermediacdn.com/styles/story_header_image_1920x1080_cropped/s3/2020-09/Emmy-Awards-Header_0.png?h=920929c4&itok=hQ_EzZel)

# Emmy Awards and Nominees

The data this week comes from [emmys.com](https://www.emmys.com/awards/nominations/award-search).

[Susie Lu](https://www.susielu.com/data-viz/emmy-2017) has a nice visualization of similar data. [Statista](https://www.statista.com/chart/11114/netflixs-nominations-and-wins-at-the-emmys/) also has a nice visualization looking at Netflix specifically, and an older one segmented by [Network](https://www.statista.com/chart/2562/2014-emmy-nominations-by-network/).

The [Emmy Award](https://en.wikipedia.org/wiki/Emmy_Awards): 

> An Emmy Award, or simply Emmy, is a trophy presented at one of the numerous annual American events or competitions that each recognize achievements in a particular sector of the television industry. The Emmy is considered one of the four major entertainment awards in the United States, the others being the Grammy (for music), the Oscar (Academy Award) (for film), and the Tony (for theatre). The two events that receive the most media coverage are the Primetime Emmy Awards and the Daytime Emmy Awards, which recognize outstanding work in American primetime and daytime entertainment programming, respectively.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-09-21')
tuesdata <- tidytuesdayR::tt_load(2021, week = 39)

nominees <- tuesdata$nominees

# Or read in the data manually

nominees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-21/nominees.csv')

```
### Data Dictionary

# `nominees.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|category    |character | Award Category |
|logo        |character | Logo or headshot |
|production  |character | Production Team |
|type        |character | Type - either nominee or winner |
|title       |character | Title of show |
|distributor |character | Distributor of show |
|producer    |character | Producer of show |
|year        |integer   | Year of award |
|page        |integer   | Page number |
|page_id     |integer   | Page ID (unique count/page) |

### Cleaning Script

```
library(tidyverse)
library(rvest)

clean_nominee <- function(x){
  
  trimmed_nom <- str_trim(x) %>% 
    str_split("\n") %>% 
    pluck(1) %>%
    str_trim()
  
  out_len <- length(trimmed_nom)
  
  names_add <- c(
    c("type", "title", "distributor", "producer"),rep("blank", out_len - 4)
  )
  
  trimmed_nom %>% 
    set_names(nm = names_add)
}

clean_production <- function(raw_html){
  
  data_out <- map2(
    1:10, rep(c("odd", "even"), 5),
    ~raw_html %>% 
      html_nodes(glue::glue("div.views-row.views-row-{.x}.views-row-{.y}")) %>% 
      html_nodes(".winner-list") %>% 
      map(~html_nodes(.x, "li")) %>% 
      map(html_text) 
  ) %>% 
    map(pluck, 1)
  
  data_out
  
}


scrape_pages <- function(page_num){
  
  cat(scales::percent_format()(page_num/1000), "\n")
  
  url <- glue::glue("https://www.emmys.com/awards/nominations/award-search?page={page_num}")
  
  raw_html <- url %>% 
    read_html() %>% 
    html_nodes("#block-system-main > div > div > section:nth-child(3) > div > div")
  
  category <- raw_html %>% 
    # html_node("#block-system-main > div > div > section:nth-child(3) > div > div") %>% 
    html_nodes("h5") %>% 
    html_text()
  
  logos <- raw_html %>% 
    html_nodes("div.image.img.col-4.col-md-3.col-xl-2 > a > img") %>% 
    html_attr("src")
  
  outcome <- raw_html %>% 
    html_nodes("ul.nominee, ul.winner") %>% 
    html_text() %>% 
    map(clean_nominee)
  
  out_len <- map(outcome, length)
  
  production <- clean_production(raw_html)
  
  tibble(
    category = category,
    logo = logos,
    production = production,
    outcome = outcome
  ) %>%
    mutate(year = str_sub(category, -4, -1) %>% as.integer(),
           page = page_num,
           page_id = row_number())
  
}

safe_scrape <- safely(scrape_pages)

map_all <- 0:2362 %>% map(safe_scrape)

all_results <- map_all %>% 
  map_dfr("result") 

clean_df <- all_results %>%
  rowwise() %>% 
  mutate(
    fix = ifelse(str_detect(title, ", as"), 1, 0),
    title = ifelse(fix == 1, distributor, title),
    distributor = ifelse(fix == 1 && !is.na(producer), producer, distributor),
    producer = ifelse(fix == 1 && !is.na(blank), blank, producer),
    producer = ifelse(!is.na(blank), blank, producer)
  ) 

final_df <- clean_df %>% 
  select(-contains("blank"), -fix)
```