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

# Bee Colonies

The data this week comes from the [USDA](https://usda.library.cornell.edu/concern/publications/rn301137d?locale=en), hat tip to [Georgios Karamanis](https://github.com/rfordatascience/tidytuesday/issues/404).

> This report provides information on honey bee colonies in terms of number of colonies, maximum, lost, percent lost, added, renovated, and percent renovated, as well as colonies lost with Colony Collapse Disorder symptoms with both over and less than five colonies. The report also identifies colony health stressors with five or more colonies. The data for operations with honey bee colonies are collected from a stratified sample of operations that responded as having honey bees on the Bee and Honey Inquiry and from the NASS list frame. For operations with five or more colonies, data was collected on a quarterly basis; operations with less than five colonies were collected with an annual survey.

More details on bee colony losses at:
- [Bee Informed](https://beeinformed.org/2021/06/21/united-states-honey-bee-colony-losses-2020-2021-preliminary-results/)  
- [Auburn University](https://ocm.auburn.edu/newsroom/news_articles/2021/06/241121-honey-bee-annual-loss-survey-results.php)  
- [The Guardian](https://www.theguardian.com/environment/2019/jun/19/us-beekeepers-lost-40-of-honeybee-colonies-over-past-year-survey-finds)  

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2022-01-11')
tuesdata <- tidytuesdayR::tt_load(2022, week = 2)

colony <- tuesdata$colony

# Or read in the data manually

colony <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-11/colony.csv')
stressor <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-11/stressor.csv')

```
### Data Dictionary

# `colony.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|year            |character |year |
|months          |character |month           |
|state           |character |State Name (note there is United States and Other States) |
|colony_n        |integer   | Number of colonies |
|colony_max      |integer   | Maximum colonies |
|colony_lost     |integer   | Colonies lost |
|colony_lost_pct |integer   | Percent of total colonies lost |
|colony_added    |integer   | Colonies added |
|colony_reno     |integer   | Colonies renovated |
|colony_reno_pct |integer   | Percent of colonies renovated  |

# `stressor.csv`

|variable   |class     |description |
|:----------|:---------|:-----------|
|year       |character | Year |
|months     |character | Month range |
|state           |character |State Name (note there is United States and Other States) |
|stressor   |character | Stress type |
|stress_pct |double    | Percent of colonies affected by stressors anytime during the quarter, colony can be affected by multiple stressors during same quarter. |

### Cleaning Script

```{r}
library(rvest)
library(tidyverse)
library(fs)

# download site
url <- "https://usda.library.cornell.edu/concern/publications/rn301137d?locale=en"

# raw html
raw_html <- read_html(url)

# all the download urls for zip files
all_urls <- raw_html %>% 
  html_elements("#content-wrapper > div.row.p-content > div.col-sm-7 > table") %>% 
  html_elements("a") %>% 
  html_attr("href") %>% 
  str_subset(".zip") 

# download to correct directory
download.file(all_urls, destfile = paste0("2022/2022-01-11/", basename(all_urls)))

# unzip into their respective folders
walk(basename(all_urls), ~ unzip(
  paste0("2022/2022-01-11/", .x),
  exdir = paste0("2022/2022-01-11/bee-", str_sub(.x, -6, -5))
))


#  Clean Colony data ------------------------------------------------------


clean_bee_colonies <- function(file){
  
  col_labs <- c("state", "colony_n", "colony_max", "colony_lost", 
    "colony_lost_pct", "colony_added", "colony_reno", "colony_reno_pct")
  
  raw_df <- read_csv(file,  skip = 2, col_names = FALSE)
  
  date_rng <- read_csv(file, skip = 0, col_names = FALSE) %>% 
    slice(2) %>% 
    pull(X3) %>% 
    str_replace(" [5-6]/$", "") %>% 
    word(-2, -1)
  
  clean_df <- suppressWarnings(raw_df %>% 
    filter(!is.na(X4))  %>%
    filter(X2 == "d") %>% 
    select(X3:X10) %>% 
    set_names(nm = col_labs) %>% 
    mutate(date_range = date_rng, .before = state) %>% 
    separate(date_range, into = c("months", "year"), sep = " ") %>% 
    select(year, months, state, everything()) %>% 
    mutate(across(contains("colony"), as.integer)))
  
  clean_df
}


# Clean stress data -------------------------------------------------------


clean_bee_stress <- function(file){
  
  col_labs <- c("state", "colony_n", "colony_max", "colony_lost", 
    "colony_lost_pct", "colony_added", "colony_reno", "colony_reno_pct")

  
  raw_df <- read_csv(file,  skip = 4, col_names = FALSE)
  
  date_rng <- read_csv(file, skip = 0, col_names = FALSE) %>% 
    slice(2) %>% 
    pull(X3) %>% 
    str_replace(" [5-6]/$", "") %>% 
    word(-2, -1)
  
  stress_nm <- c("state", "Varroa mites", "Other pests/parasites", "Disesases",
    "Pesticides", "Other", "Unknown")
  
  clean_df <- suppressWarnings(raw_df %>% 
      filter(!is.na(X4))  %>%
      filter(X2 == "d") %>% 
      select(X3:X9) %>% 
      set_names(nm = stress_nm) %>% 
      pivot_longer(cols = -state, names_to = "stressor", values_to = "stress_pct") %>% 
      mutate(date_range = date_rng, .before = state) %>% 
      separate(date_range, into = c("months", "year"), sep = " ") %>% 
      select(year, months, state, everything()) %>% 
      mutate(stress_pct = as.double(stress_pct)))
  
  clean_df
}


# Get the file index ------------------------------------------------------


all_html_index <- dir_ls("data/2022/2022-01-11", recurse = TRUE, glob = "*htm") %>% 
  str_subset("bee-") %>% 
  str_subset("index")

get_index <- function(index_file){
  ind_yr <- str_sub(index_file, -17, -16)
  
  raw_text <- index_file %>% 
    read_html() %>%
    html_text() %>% 
    str_split("\r\n[0-9]+") %>% 
    unlist() %>% 
    map(~str_split(.x, "\r\n")) 
  
  raw_text %>% 
    tibble(data = .) %>% 
    unchop(data) %>% 
    unnest_wider(data) %>% 
    select(file = ...2, desc = ...3) %>% 
    mutate(type = case_when(
      str_detect(desc, "Colonies, Maximum, Lost") ~ "Colony",
      str_detect(desc, "Colony Health Stressors") ~ "Stressor",
      TRUE ~ NA_character_
    )) %>% 
    filter(!is.na(type)) %>% 
    mutate(year = ind_yr, .before = file)
  
}

all_index_files <- map_dfr(all_html_index, get_index)

# Split data by type
split_files <- all_index_files %>% 
  mutate(dir_file = glue::glue("data/2022/2022-01-11/bee-{year}/{file}")) %>% 
  select(type, dir_file, year, file, desc) %>% 
  group_split(type)

# aggregate the clean data by type

all_colonies <-  map_dfr(split_files[[1]]$dir_file, clean_bee_colonies) %>% 
  distinct(year, months, state, .keep_all = TRUE) %>% 
  mutate(state = str_remove(state, " 4/| 5/")) %>% 
  filter(state %in% c(state.name, "Other States", "United States"))

all_stress <-  map_dfr(split_files[[2]]$dir_file, clean_bee_stress) %>% 
  distinct(year, months, state, stressor, .keep_all = TRUE) %>% 
  mutate(state = str_remove(state, " 4/| 5/")) %>% 
  filter(state %in% c(state.name, "Other States", "United States"))

# check data
all_colonies %>% 
  count(year, months) %>% 
  filter(n > 47)

all_stress %>% 
  count(year, months) %>% 
  filter(n > 282)

all_colonies %>% 
  write_csv("data/2022/2022-01-11/colony.csv")

all_stress %>% 
  write_csv("data/2022/2022-01-11/stressor.csv")
```
