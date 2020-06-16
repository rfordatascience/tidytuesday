# Food Consumption and CO2 Emissions

The data this week comes from [nu3](https://www.nu3.de/blogs/nutrition/food-carbon-footprint-index-2018) and was contributed by [Kasia Kulma](https://r-tastic.co.uk/post/from-messy-to-tidy/).

Kasia has put together a great guide on webscraping along with data cleaning and organization! Make sure to check out her [blog post](https://r-tastic.co.uk/post/from-messy-to-tidy/), and the raw code is duplicated as part of the cleaning script.

### Get the data here

```{r}
# Get the Data

food_consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-02-18')
tuesdata <- tidytuesdayR::tt_load(2020, week = 8)


food_consumption <- tuesdata$food_consumption
```
### Data Dictionary

# `food_consumption.csv`

|variable      |class     |description |
|:-------------|:---------|:-----------|
|country       |character | Country Name |
|food_category |character | Food Category |
|consumption   |double    | Consumption (kg/person/year) |
|co2_emmission |double    | Co2 Emission (Kg CO2/person/year) |

### Cleaning Script

```{r}
library(tidyverse)
library(janitor)
library(rvest)

# Credit to Kasia and minorly edited to create output file and test plot
# Blog post at https://r-tastic.co.uk/post/from-messy-to-tidy/

url <- "https://www.nu3.de/blogs/nutrition/food-carbon-footprint-index-2018"

# scrape the website
url_html <- read_html(url)

# extract the HTML table
whole_table <- url_html %>% 
  html_nodes('table') %>%
  html_table(fill = TRUE) %>%
  .[[1]]

table_content <- whole_table %>%
  select(-X1) %>% # remove redundant column
  filter(!dplyr::row_number() %in% 1:3) # remove redundant rows

raw_headers <- url_html %>%
  html_nodes(".thead-icon") %>%
  html_attr('title')

tidy_bottom_header <- raw_headers[28:length(raw_headers)]
tidy_bottom_header[1:10]

raw_middle_header <- raw_headers[17:27]
raw_middle_header

tidy_headers <- c(
  rep(raw_middle_header[1:7], each = 2),
  "animal_total",
  rep(raw_middle_header[8:length(raw_middle_header)], each = 2),
  "non_animal_total",
  "country_total")

tidy_headers

combined_colnames <- paste(tidy_headers, tidy_bottom_header, sep = ';')
colnames(table_content) <- c("Country", combined_colnames)
glimpse(table_content[, 1:10])

long_table <- table_content %>%
  # make column names observations of Category variable
  tidyr::pivot_longer(cols = -Country, names_to = "Category", values_to = "Values") %>%
  # separate food-related information from the metric
  tidyr::separate(col = Category, into = c("Food Category", "Metric"), sep = ';')

glimpse(long_table)

tidy_table <- long_table %>%
  tidyr::pivot_wider(names_from = Metric, values_from = Values) %>%
  janitor::clean_names('snake')

glimpse(tidy_table)

final_table <- tidy_table %>%
  rename(consumption = 3,
         co2_emmission = 4) %>%
  filter(!stringr::str_detect(food_category, "total"))

clean_table <- final_table %>% 
  mutate_at(vars(consumption, co2_emmission), parse_number)

clean_table %>% 
  write_csv(here::here("2020/2020-02-18", "food_consumption.csv"))

clean_table %>% 
  ggplot(aes(x = fct_reorder(food_category, consumption), y = consumption, color = country)) +
  geom_jitter() +
  theme(legend.position = "none") +
  coord_flip()

```