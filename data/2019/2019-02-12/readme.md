# Federal Research and Development Spending by Agency

The NY Times has a recent article on federal Research and Development spending by agency. Cheers to [Costa Samaras](@CostaSamaras) for making us aware of this data source and the article. Their take on the data is that Energy spending and Climate Change Research spending is lagging compared to other departments.

Data comes directly from the American Association for the Advancement of Science [Historical Trends](https://www.aaas.org/programs/r-d-budget-and-policy/historical-trends-federal-rd) - there are dozens if not hundreds of ways to break this data down - we have presented a relatively high-level overview, but if you are interested take a look at the raw Excel sheets to get at even more data.

[EVEN MORE DATA](https://www.aaas.org/programs/r-d-budget-and-policy/historical-rd-data)

### Grab the Data Here

[Federal Research and Development Spending by Agency](fed_r_d_spending.csv)  

or read the data directly into R!

```
fed_rd <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/fed_r_d_spending.csv")
energy_spend <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/energy_spending.csv")
climate_spend <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/climate_spending.csv")
```

# Data Dictionary

For reference:
* DOD - Deparment of Defense
* NASA - National Aeronautics and Space Administration
* DOE - Department of Energy
* HHS - Department of Health and Human Services
* NIH - National Institute of Health
* NSF - National Science Foundation
* USDA - US Department of Agriculture
* Interior - Department of Interior
* DOT - Deparment of Transportation
* EPA - Environmental Protection Agency
* DOC - Department of Corrections
* DHS - Department of Homeland Security
* VA - Department of Veterands Affairs
* Other - other research and development spending

### Total Federal R&D Spending by agency/deparment

|variable              |class     |description |
|:---|:---|:-----------|
|department            |character | US agency/department          |
|year                  |date/integer   | Fiscal Year           |
|rd_budget             |double    | Research and Development Dollars in inflation-adjusted (constant) dollars           |
|total_outlays         |double    | Total Federal Government spending in inflation-adjusted (constant) dollars         |
|discretionary_outlays |double    | Total Discretionary Federal Government spending in inflation-adjusted (constant) dollars           |
|gdp                   |double    | Total US Gross Domestic Product in inflation-adjusted (constant) dollars         |

#### Energy Departments Data

|variable     |class     |description |
|:------------|:---------|:-----------|
|department   |character |Sub-agency of Energy Spending          |
|year         |date/integer   | Fiscal Year           |
|energy_spending |double    | Research and Development Dollars in inflation-adjusted (constant) dollars           |


#### Global Climate Change Research Program Spending

|variable     |class     |description |
|:------------|:---------|:-----------|
|department   |character |Sub-agency of Global Climate Change Spending          |
|year         |date/integer   | Fiscal Year           |
|gcc_spending |double    | Research and Development Dollars in inflation-adjusted (constant) dollars           |


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

### Energy Data

```
energy_raw <- read_excel(here::here("2019", "2019-02-12", "DOE%3B.xlsx"), skip = 2)

energy_clean <- energy_raw %>% 
  slice(1:15) %>% 
  na.omit() %>% 
  gather(year, energy_spending, `1997`:`2018**`) %>% 
  select(department = `Fiscal Years`, year, energy_spending) %>% 
  mutate(year = str_extract(year, "[:digit:]+"),
         year = as.integer(year),
         energy_spending = as.numeric(energy_spending),
         energy_spending = energy_spending * 1*10^6)

gcc_raw <- read_excel(here::here("2019", "2019-02-12", "USGCRP.xlsx"), skip = 2)

gcc_clean <- gcc_raw %>% 
  slice(2:8) %>% 
  gather(year, gcc_spending, `FY 2000`:`FY 2017`) %>% 
  mutate(year = str_extract(year, "[:digit:]+")) %>% 
  select(department = X__1, year, gcc_spending) %>% 
  mutate(year = as.integer(year),
         gcc_spending = as.numeric(gcc_spending),
         gcc_spending = gcc_spending * 1*10^6)

```