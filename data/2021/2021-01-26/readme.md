!Break free from plastic header](https://www.breakfreefromplastic.org/wp-content/uploads/2019/08/header_bffp_2019w.jpg)

# Plastic Pollution

The data this week comes from [Break Free from Plastic](https://www.breakfreefromplastic.org) courtesy of [Sarah Sauve]( https://sarahasauve.wordpress.com).

Sarah put together a nice [Blogpost](https://github.com/sarahsauve/TidyTuesdays/blob/master/BFFPDashboard/BlogPost.md) on her approach to this data, which includes cleaning the data and a Shiny app!

Per Sarah:

> I found out about [Break Free From Plastic](https://www.breakfreefromplastic.org/)’s Brand Audits through my involvement with the local [Social Justice Cooperative of Newfoundland and Labrador](https://www.sjcnl.ca/)’s Zero Waste Action Team.
> 
> One of my colleagues and friends proposed an audit in St. John’s, partially to contribute to the global audit and as part of a bigger project to understand the sources of plastic in our city. We completed our audit in October 2020 and are the first submission to BFFP from Newfoundland! You can find our data presented in [this](https://sarahsauve.shinyapps.io/BrandAuditDashboard/) Shiny dashboard.
 
> It’s an interesting dataset, with lots of room to play around and so many options for visualization, plus plastic pollution is an important topic to talk about and raise awareness of! You can read BFFP’s Brand Audit Reports for [2018](https://www.breakfreefromplastic.org/globalbrandauditreport2018/), [2019](https://www.breakfreefromplastic.org/globalbrandauditreport2019/) and [2020](https://www.breakfreefromplastic.org/globalbrandauditreport2020/) to get an idea of what they’ve done with the data.

I downloaded the raw data from her Google Drive, and have a short cleaning script at the bottom of this readme. Note that the data has already been combined, but feel free to play around with the raw data itself.

> The data is available through Google Drive; you can find the 2019 data [here](https://drive.google.com/drive/folders/1O75ekNUQPbAAZ8KE5kb2EdbKgxIhz7HP) and the 2020 data [here](https://drive.google.com/drive/folders/1mdIsoaj5vW368YWw7-vD2hDFANqaS_Lh).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-01-26')
tuesdata <- tidytuesdayR::tt_load(2021, week = 5)

plastics <- tuesdata$plastics

# Or read in the data manually

plastics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv')

```

### Data Dictionary

Note that the plastic types are not in tidy format, and you'll likely want to `pivot_longer()`.

The plastic is categorized by [recycling codes](https://en.wikipedia.org/wiki/Recycling_codes).

# `plastics.csv`

|variable       |class     |description |
|:---|:---|:-----------|
|country        |character |Country of cleanup |
|year           |double    | Year (2019 or 2020) |
|parent_company |character | Source of plastic |
|empty          |double    | Category left empty count |
|hdpe           |double    | High density polyethylene count (Plastic milk containers, plastic bags, bottle caps, trash cans, oil cans, plastic lumber, toolboxes, supplement containers) |
|ldpe           |double    | Low density polyethylene count (Plastic bags, Ziploc bags, buckets, squeeze bottles, plastic tubes, chopping boards) |
|o              |double    | Category marked other count |
|pet            |double    | Polyester plastic count (Polyester fibers, soft drink bottles, food containers (also see plastic bottles) |
|pp             |double    | Polypropylene count (Flower pots, bumpers, car interior trim, industrial fibers, carry-out beverage cups, microwavable food containers, DVD keep cases) |
|ps             |double    | Polystyrene count (Toys, video cassettes, ashtrays, trunks, beverage/food coolers, beer cups, wine and champagne cups, carry-out food containers, Styrofoam) |
|pvc            |double    | PVC plastic count (Window frames, bottles for chemicals, flooring, plumbing pipes) |
|grand_total    |double    | Grand total count (all types of plastic) |
|num_events     |double    | Number of counting events |
|volunteers     |double    | Number of volunteers |

### Cleaning Script

NOTE: This is not necessary to use this data, but is just an example of how I prepared the `plastics.csv` dataset, which is already available.

```{r}
library(tidyverse)
library(fs)

files_2020 <- fs::dir_ls("2020 BFFP National Data Results") %>% 
  str_subset("csv")

files_2019 <- fs::dir_ls("2019 Brand Audit Appendix _ Results by Country/Countries") %>% 
  str_subset("csv")

data_2020 <- files_2020 %>% 
  map_dfr(read_csv, col_types = cols(
    Country = col_character(),
    Parent_company = col_character(),
    Empty = col_double(),
    HDPE = col_double(),
    LDPE = col_double(),
    O = col_double(),
    PET = col_double(),
    PP = col_double(),
    PS = col_double(),
    PVC = col_double(),
    Grand_Total = col_character(),
    num_events = col_double(),
    volunteers = col_double()
  )) %>% 
  mutate(year = 2020, .after = Country) %>% 
  mutate(Grand_Total = parse_number(Grand_Total)) %>% 
  janitor::clean_names()

data_2019 <- files_2019 %>% 
  set_names(str_replace(., ".*[/]([^.]+)[.].*", "\\1")) %>% 
  map_dfr(read_csv, .id = "country", col_types = cols(
    Country = col_character(),
    Parent_company = col_character(),
    Empty = col_double(),
    HDPE = col_double(),
    LDPE = col_double(),
    O = col_double(),
    PET = col_double(),
    PP = col_double(),
    PS = col_double(),
    PVC = col_double(),
    Grand_Total = col_double(),
    num_events = col_double(),
    volunteers = col_double()
  )) %>% 
  select(country, everything()) %>% 
  mutate(year = 2019, .after = country) %>% 
  janitor::clean_names()  %>% 
  mutate(pp = if_else(is.na(pp_2), pp, pp_2 + pp),
         ps = if_else(is.na(ps_2), ps, ps + ps_2)) %>% 
  rename(parent_company = parent_co_final, num_events = number_of_events, volunteers= number_of_volunteers) %>% 
  select(-ps_2, -pp_2)

combo_data <- bind_rows(data_2019, data_2020) 

combo_data %>% 
  write_csv("2021/2021-01-26/plastics.csv")


```