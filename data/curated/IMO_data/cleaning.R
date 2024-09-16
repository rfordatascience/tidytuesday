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
