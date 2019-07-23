# FAA Wildlife Strike Database

'The FAA Wildlife Strike Database contains records of reported wildlife strikes since 1990. Strike reporting is voluntary. Therefore, this database only represents the information we have received from airlines, airports, pilots, and other sources.
Report on wildlife impacts". To keep things simple I just took data from the big 4: American Airlines, Delta, Southwest, and United as they account for [~ 70% of passengers in the USA](https://en.wikipedia.org/wiki/List_of_largest_airlines_in_North_America) but there are many many more available airlines.

A [report](https://www.faa.gov/airports/airport_safety/wildlife/media/Wildlife-Strike-Report-1990-2017.pdf) on the full dataset.

[Source](https://wildlife.faa.gov/)  
[Full data dictionary](https://wildlife.faa.gov/downloads/fieldlist.xls)

h/t to my colleague Katie Masiello for sharing this dataset!

# Get the data!

```
wildlife_impacts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-23/wildlife_impacts.csv")

```

# Data Dictionary

### `wildlife_impacts.csv`

|variable              |class     |description |
|:---|:---|:-----------|
|incident_date         | date    | Date of incident |
|state                 |character | State|
|airport_id            |character | Airport ID|
|airport               |character | Airport Name |
|operator              |character | Operator/Airline |
|atype                 |character | Airline type |
|type_eng              |character | Engine type |
|species_id            |character | Species ID|
|species               |character | Species |
|damage                |character | Damage: N None M Minor, M Uncertain, S Substantial, D Destroyed |
|num_engs              |character | Number of engines |
|incident_month        |double    | Incident month |
|incident_year         |double    | Incident year |
|time_of_day           |character |  Incident Time of day|
|time                  |double    | Incident time|
|height                |double    | Plane height at impact |
|speed                 |double    | Plane speed at impact |
|phase_of_flt          |character | Phase of flight at impact |
|sky                   |character | Sky condition |
|precip                |character | Precipitation |
|cost_repairs_infl_adj |double    | Cost of repairs adjusted for inflation |



```{r}
library(tidyverse)
library(here)
library(rvest)

df_aa <- readxl::read_excel(here("2019", "2019-07-23", "wildlife_aa.xlsx"))

df_delta <- readxl::read_excel(here("2019", "2019-07-23", "wildlife_delta.xlsx"))

df_southwest <- readxl::read_excel(here("2019", "2019-07-23", "wildlife_southwest.xlsx"))

df_united <- readxl::read_excel(here("2019", "2019-07-23", "wildlife_united.xlsx"))

df_all <- bind_rows(df_aa, df_delta) %>% 
  bind_rows(df_southwest) %>% 
  bind_rows(df_united) %>% 
  janitor::clean_names() %>% 
  select(incident_date:airport, operator:damage, num_engs,incident_month:time,
         height, speed, phase_of_flt, sky, precip, cost_repairs_infl_adj)

df_all %>% 
  write_csv(here("2019" , "2019-07-23", "wildlife_impacts.csv"))

# create dictionary
tomtom::create_dictionary(df_all)

# test plot
df_all %>% 
  ggplot(aes(x = incident_date)) +
  geom_histogram() +
  facet_wrap(~operator)

# scrape airline size
url <- "https://en.wikipedia.org/wiki/List_of_largest_airlines_in_North_America"

raw_html <- url %>% 
  read_html() %>% 
  html_table(fill = TRUE)

clean_pass <- raw_html %>% .[[1]] %>% 
  as_tibble() %>% 
  select(Rank:`2018`) %>% 
  rename("passengers" = `2018`) %>% 
  janitor::clean_names() %>% 
  mutate(passengers = parse_number(passengers),
         group = c(rep("big 4", 4), rep("Other", 13))) 

total_sum <- clean_pass %>% 
  pull(passengers) %>% 
  sum()

clean_pass %>% 
  group_by(group) %>% 
  summarize(sum = sum(passengers)) %>% 
  mutate(percent_of_total = paste0(round(sum/total_sum * 100, 1), "%"))

|group |       sum|percent_of_total |
|:-----|---------:|:----------------|
|big 4 | 718146104|70.3%            |
|Other | 304031622|29.7%            |

```