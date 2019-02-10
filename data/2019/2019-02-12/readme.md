# Federal Research and Development Spending by Agency

The NY Times has a recent article on federal Research and Development spending by agency. Cheers to [Costa Samaras](@CostaSamaras) for making us aware of this data source and the article. 

Data comes directly from the American Association for the Advancement of Science [Historical Trends](https://www.aaas.org/programs/r-d-budget-and-policy/historical-trends-federal-rd) - there are dozens if not hundreds of ways to break this data down - we have presented a relatively high-level overview, but if you are interested take a look at the raw Excel sheets to get at even more data.

[EVEN MORE DATA](https://www.aaas.org/programs/r-d-budget-and-policy/historical-rd-data)

### Grab the Data Here

[Federal Research and Development Spending by Agency](fed_r_d_spending.csv)  

or read the data directly into R!

```
state_hpi <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/fed_r_d_spending.csv")
```

# Data Dictionary

|variable              |class     |description |
|:---|:---|:-----------|
|department            |character | US agency/department          |
|year                  |date/integer   | Fiscal Year           |
|rd_budget             |double    | Research and Development Dollars in inflation-adjusted (constant) dollars           |
|total_outlays         |double    | Total Federal Government spending in inflation-adjusted (constant) dollars         |
|discretionary_outlays |double    | Total Discretionary Federal Government spending in inflation-adjusted (constant) dollars           |
|gdp                   |double    | Total US Gross Domestic Product in inflation-adjusted (constant) dollars         |


# (SPOILERS) How I cleaned data 

```
library(tidyverse)
library(readxl)

# Read in the by-agency spending data
rd_raw <- read_excel(here::here("2019", "2019-02-12", "Agencies%3B.xlsx"), skip = 2)

rd_clean <- rd_raw %>% 
  slice(1:14) %>% 
  mutate(department = str_extract(`Fiscal Year`, "[:alpha:]+")) %>% 
  select(department, everything(), -`Fiscal Year`) %>% 
  gather(year, rd_budget, `1976`:`2018**`) %>% 
  select(-`'08-'18`) %>% 
  mutate(year = str_extract(year, "[:digit:]+"),
         year = as.integer(year),
         rd_budget = rd_budget * 1*10^6)

# read in the spending as % of total federal budget
rd_fed_budget_raw <- read_excel(here::here("2019", "2019-02-12", "Budget%3B.xlsx"), skip = 3)

rd_fed_budget_clean <- rd_fed_budget_raw %>% 
  select(1:3) %>% 
  set_names(nm = c("year", "total_outlays", "discretionary_outlays")) %>% 
  mutate(year = str_extract(year, "[:digit:]+")) %>% 
  mutate_at(vars(2, 3), as.numeric) %>% 
  mutate(year = as.integer(year)) %>% 
  na.omit() %>% 
  filter(year >= 1976 & year <= 2018) %>% 
  mutate(total_outlays = total_outlays * 1*10^9,
         discretionary_outlays = discretionary_outlays * 1*10^9)

# read in the spending as % of GDP
rd_gdp_raw <- read_excel(here::here("2019", "2019-02-12", "RDGDP%3B.xlsx"), skip = 3)

rd_gdp_clean <- rd_gdp_raw %>% 
  slice(9) %>% 
  gather(year, gdp, `1976`:`2017**`) %>% 
  select(year, gdp) %>% 
  mutate(year = str_extract(year, "[:digit:]+"),
         year = as.integer(year),
         gdp = gdp * 1*10^9)

# combine by agency spending, federal budget and gdp data into one dataframe
final_df <- left_join(rd_clean, rd_fed_budget_clean, by = "year") %>% 
  left_join(., rd_gdp_clean, by = "year") %>% 
  filter(year <= 2017)

# write to csv
final_df %>% 
  write_csv("fed_r_d_spending.csv")
```
