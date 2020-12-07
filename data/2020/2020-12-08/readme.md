![](https://ichef.bbci.co.uk/news/976/cpsprodpb/073B/production/_115615810_100_women_2020_index_promo.jpg)

# Women of 2020

The data this week comes from the [BBC](https://www.bbc.com/news/world-55042935) by way of [Joshua Feldman](https://twitter.com/joshuafeidman?lang=en).

> The BBC has revealed its list of 100 inspiring and influential women from around the world for 2020.
> 
> This year 100 Women is highlighting those who are leading change and making a difference during these turbulent times.
> 
> The list includes Sanna Marin, who leads Finland's all-female coalition government, Michelle Yeoh, star of the new Avatar and Marvel films and Sarah Gilbert, who heads the Oxford University research into a coronavirus vaccine, as well as Jane Fonda, a climate activist and actress.
> 
> And in an extraordinary year - when countless women around the world have made sacrifices to help others - one name on the 100 Women list has been left blank as a tribute.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-12-08')
tuesdata <- tidytuesdayR::tt_load(2020, week = 50)

women <- tuesdata$women

# Or read in the data manually

women <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-08/women.csv')

```
### Data Dictionary

# `women.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|name        |character | Name of woman |
|img         |character | Link to headshot |
|category    |character | Category for award |
|country     |character | Country of residence |
|role        |character | Role/Career |
|description |character | Description of the woman and their achievements |

### Cleaning Script

```{r}
# Load packages

library(rvest)
library(tidyverse)

# Load web page

bbc_women <- html("https://www.bbc.co.uk/news/world-55042935")

# Save even and odd indices for data extraction later

odd_index <- seq(1,200,2)
even_index <- seq(2,200,2)

# Extract name

name <- bbc_women %>% 
  html_nodes("article h4") %>% 
  html_text()

# Extract image

img <- bbc_women %>% 
  html_nodes(".card__header") %>% 
  html_nodes("img") %>% 
  html_attr("src")

img <- img[odd_index]

# Extract category

category <- bbc_women %>% 
  html_nodes("article .card") %>% 
  str_extract("card category--[A-Z][a-z]+") %>% 
  str_remove_all("card category--")

# Extract country & role

country_role <- bbc_women %>% 
  html_nodes(".card__header__strapline__location") %>% 
  html_text()

country <- country_role[odd_index]
role <- country_role[even_index]

# Extract description

description <- bbc_women %>% 
  html_nodes(".first_paragraph") %>% 
  html_text()

# Finalise data frame

df <- data.frame(
  name,
  img,
  category,
  country,
  role,
  description
)

# Export

write.csv(df, "data.csv", row.names=FALSE)
```