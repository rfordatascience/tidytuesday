# National Park Visits

This week's data is from [dataisplural/data.world](https://data.world/inform8n/us-national-parks-visitation-1904-2016-with-boundaries).

There are some additional datasets that may be interesting in relation to this data - namely US population and gas prices over time.

There's also some shapefiles you might be able to use with the [`sf` package](https://r-spatial.github.io/sf/articles/sf2.html).

* [geojson](https://data.world/codefordc/national-parks/workspace/file?filename=National+Parks.geojson)  
* [Regional Boundaries](https://public-nps.opendata.arcgis.com/datasets/national-park-service-regional-boundaries/data)  
* [Centroids](https://public-nps.opendata.arcgis.com/datasets/national-park-service-park-unit-centroids)  
* [Boundaries](https://data.world/inform8n/us-national-parks-visitation-1904-2016-with-boundaries)  

Lastly, a [`fivethirtyeight` article](https://fivethirtyeight.com/features/the-national-parks-have-never-been-more-popular/) covered this dataset with lots of great visualizations to copy or build off of.

# Get the data!

```
park_visits <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/national_parks.csv")
state_pop <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/state_pop.csv")
gas_price <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-17/gas_price.csv")
```

# Data Dictionary

## `national_parks.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|year_raw          |integer | Year of record |
|gnis_id           |character | ID for shapefile and long-lat lookup |
|geometry          |character | Geometric shape for shapefile |
|metadata          |character | URL to metadata about the park |
|number_of_records |double    | Number of records |
|parkname          |character | Full park name |
|region            |character | US Region where park is located |
|state             |character | State abbreviation |
|unit_code         |character | Park code abbreviation |
|unit_name         |character | Park Unit name |
|unit_type         |character | Park unit type |
|visitors          |double    | Number of visitors |

## `state_pop.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|year     |integer   | Jan 1st of year |
|state    |character | State abbreviation |
|pop      |double    | Population |

## `gas_price.csv`

|variable     |class  |description |
|:------------|:------|:-----------|
|year         |double | Year (Jan 1st) |
|gas_current  |double | Gas price in that year (dollars/gallon) |
|gas_constant |double | Gas price (constant 2015 dollars/gallon) |


# Cleaning Script

```{r}

library(tidyverse)
library(rvest)

df_raw <- read_csv(here::here("2019/2019-09-17/All National Parks Visitation 1904-2016.csv")) 

df <- df_raw %>% 
  janitor::clean_names() %>%
  mutate(date = lubridate::mdy_hms(year)) %>% 
  select(date, gnis_id, geometry:year_raw)

df %>% 
  write_csv(here::here("2019/2019-09-17/national_parks.csv"))


# Get pop data

url <- "https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_historical_population"

raw_html <- url %>% 
  read_html() %>% 
  html_table()

pop_df <- raw_html %>% 
  chuck(5) %>% 
  gather(key = "state", value = "pop", AL:DC) %>% 
  rename("year" = 1) %>% 
  mutate(pop = str_remove_all(pop, ","),
         pop = as.double(pop))

pop_df %>% 
  write_csv(here::here("2019/2019-09-17", "state_pop.csv"))

# Get gas prices

url2 <- "https://www.energy.gov/eere/vehicles/fact-915-march-7-2016-average-historical-annual-gasoline-pump-price-1929-2015"

raw_gas <- url2 %>% 
  read_html() %>% 
  html_table()

gas <- raw_gas %>% 
  chuck(1) %>% 
  set_names(nm = c("year", "gas_current", "gas_constant")) %>%   
  as_tibble() %>% 
  filter(!str_detect(year, "Source")) %>% 
  mutate(year = as.double(year),
         gas_current = as.double(gas_current),
         gas_constant = as.double(gas_constant))

```