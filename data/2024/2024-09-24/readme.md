# International Mathematical Olympiad (IMO) Data


The data for this week comes from International Mathematical Olympiad (IMO).

> The International Mathematical Olympiad (IMO) is the World Championship Mathematics Competition for High School students and is held annually in a different country. The first IMO was held in 1959 in Romania, with 7 countries participating. It has gradually expanded to over 100 countries from 5 continents. The competition consists of 6 problems and is held over two consecutive days with 3 problems each.

1. How have country rankings shifted over time?
2. What is the distribution of participation by gender? What's the distribution of top scores?
3. How does team size or team composition (e.g., number of first-time participants vs. veterans) relate to overall country performance?

Thank you to [Havisha Khurana](https://github.com/havishak) for curating this week's dataset.

## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-09-24')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 39)

country_results_df <- tuesdata$country_results_df
individual_results_df <- tuesdata$individual_results_df
timeline_df <- tuesdata$timeline_df

# Option 2: Read directly from GitHub

country_results_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-24/country_results_df.csv')
individual_results_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-24/individual_results_df.csv')
timeline_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-09-24/timeline_df.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../.github/pr_instructions.md)

### Data Dictionary

# `country_results_df.csv`

|variable                  |class     |description                           |
|:-------------------------|:---------|:-------------------------------------|
|year                      |double    |Year of IMO |
|country                   |character |Participating country |
|team_size_all             |double    |Participating contestants |
|team_size_male            |double    |Male contestants |
|team_size_female          |double    |Female contestants|
|p1                        |double    |Score on problem 1 |
|p2                        |double    |Score on problem 2 |
|p3                        |double    |Score on problem 3 |
|p4                        |double    |Score on problem 4 |
|p5                        |double    |Score on problem 5 |
|p6                        |double    |Score on problem 6 |
|total                     |double    |Total score on all problems |
|rank                      |double    |Country rank |
|awards_gold               |double    |Number of gold medals |
|awards_silver             |double    |Number of silver medals |
|awards_bronze             |double    |Number of bronze medals |
|awards_honorable_mentions |double    |Number of honorable mentions |
|leader                    |character |Leader of country team |
|deputy_leader             |character |Deputy leader of country team |

# `individual_results_df.csv`

|variable        |class     |description                           |
|:---------------|:---------|:-------------------------------------|
|year            |double    |Year of IMO  |
|contestant      |character |Participant's name |
|country         |character |Participant's country |
|p1              |integer   |Score on problem 1 |
|p2              |integer   |Score on problem 2 |
|p3              |integer   |Score on problem 3 |
|p4              |integer   |Score on problem 4 |
|p5              |integer   |Score on problem 5 |
|p6              |integer   |Score on problem 6 |
|total           |integer   |Total score on all problems |
|individual_rank |integer   |Individual rank |
|award           |character |Award won |

# `timeline_df.csv`

|variable          |class     |description                           |
|:-----------------|:---------|:-------------------------------------|
|edition           |double    |Edition of International Mathematical Olympiad (IMO) |
|year              |double    |Year of IMO |
|country           |character |Host country |
|city              |character |Host city |
|countries         |double    |Number of participating countries|
|all_contestant    |double    |Number of participating contestants|
|male_contestant   |double    |Number of participating male contestants |
|female_contestant |double    |Number of participating female contestants |
|start_date        |double    |Start date of IMO |
|end_date          |double    |End date of IMO |

### Cleaning Script

```r
# Scraping IMO results data

library(tidyverse)
library(rvest)
library(polite)
library(janitor)

# on the timeline page, clicking the year gets to country and individual results
# so I'll create a timeline dataframe. Then, extract links for each year's results
# then, scrape those pages.

timeline_url <- "https://www.imo-official.org/organizers.aspx"
timeline_page <- bow(
  timeline_url,
  user_agent = "HK scraping")

year_result_links <- scrape(timeline_page) %>%
  html_element("table") %>%
  html_elements("a") %>%
  html_attr("href")

year_result_links <- unique(year_result_links[grepl("year_info", year_result_links)])
  
timeline_df <- scrape(timeline_page) %>%
  html_table() %>%
  .[[1]] %>%
  clean_names() %>%
  rename(
    "all_contestant" = contestants,
    "male_contestant" = contestants_2,
    "female_contestant" = contestants_3,
    "edition" = number
  ) %>%
  filter(edition != "#") %>%
  mutate(
    link_to_page = paste0("https://www.imo-official.org/", year_result_links),
    start_date = paste0(gsub("(.*)(-)(.*)", "\\1", date),year),
    end_date = paste0(gsub("(.*)(-)(.*)", "\\3", date),year),
    across(c(start_date, end_date), ~as.Date(.x, format = "%d.%m.%Y"))
  ) %>%
  select(-date) %>%
  # only keeping records till current year
  filter(parse_number(year) < 2025)

# next, circulate through year's page and country and individual results

country_results_links <- map_chr(timeline_df$link_to_page,
                                ~nod(timeline_page, .x) %>%
                                  scrape(.) %>%
                                  html_elements("h3") %>%
                                  html_elements("a") %>%
                                  html_attr("href") %>%
                                  .[1])
country_results_links <- paste0("https://www.imo-official.org/", 
                                country_results_links)

individual_results_links <- map_chr(timeline_df$link_to_page,
                                ~nod(timeline_page, .x) %>%
                                  scrape(.) %>%
                                  html_elements("h3") %>%
                                  html_elements("a") %>%
                                  html_attr("href") %>%
                                  .[2])

individual_results_links <- paste0("https://www.imo-official.org/", 
                                   individual_results_links)

# circulate through country results link and rbind tables
country_results_df <- map2_df(country_results_links, timeline_df$year,
                                ~nod(timeline_page, .x) %>%
                                  scrape(.) %>%
                                  html_table() %>%
                                  .[[1]] %>%
                               clean_names() %>%
                               rename("team_size_all" = team_size,
                                      "team_size_male" = team_size_2,
                                      "team_size_female" = team_size_3,
                                      "awards_gold" = awards,
                                      "awards_silver" = awards_2,
                                      "awards_bronze" = awards_3,
                                      "awards_honorable_mentions" = awards_4
                                      ) %>%
                               filter(country != "Country") %>%
                               mutate(year = .y) %>%
                               select(year, everything())) %>%
  mutate(across(c(year, team_size_all:awards_honorable_mentions), 
                ~parse_number(.x)))


# circulate through individual results link and rbind tables
individual_results_df <- map2_df(individual_results_links, timeline_df$year,
                                ~nod(timeline_page, .x) %>%
                                  scrape(.) %>%
                                  html_table() %>%
                                  .[[1]] %>%
                                  clean_names() %>%
                                  mutate(year = .y) %>%
                                  select(year, everything())) %>%
  rename("individual_rank" = number_rank) %>%
  mutate(year = parse_number(year))

# removing links from timeline
timeline_df <- timeline_df %>%
  select(-link_to_page) %>%
  mutate(across(c(edition, year, countries:female_contestant), 
                ~parse_number(.x)))
```
