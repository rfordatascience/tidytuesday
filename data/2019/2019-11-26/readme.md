# Student Loan Payments

This week's data is from the [Department of Education](https://studentaid.ed.gov/sa/about/data-center/student/default) courtesy of [Alex Albright](https://twitter.com/AllbriteAllday).

Data idea comes from [Dignity and Debt](https://www.dignityanddebt.org/projects/student-debt-racial-disparities/) who is running a [contest](https://docs.google.com/forms/d/e/1FAIpQLSckHpk5xJwqW0_sIEnCs-tScxttMV5WVqGjP0Ws8bD0x_LZHA/viewform) around data viz for understanding and spreading awareness around Student Loan debt. 

There are already some gorgeous plots in the style of [DuBois](https://www.dignityanddebt.org/projects/student-debt-racial-disparities/).

I have uploaded the raw data and the clean data - definitely a nice dive into some data cleansing if you want to have a go at the raw Excel files.

# Get the data!

```
loans <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-11-26/loans.csv")

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# Either ISO-8601 date or year/week works!
# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load("2019-11-26")
tuesdata <- tidytuesdayR::tt_load(2019, week = 48)

loans <- tuesdata$loans
```

# Data Dictionary

## `loans.csv`

|variable           |class     |description |
|:------------------|:---------|:-----------|
|agency_name        |character | Name of loan agency |
|year               |integer   | two digits year |
|quarter            |integer   | Quarter (3 month period) |
|starting           |double    | Total value in dollars at start of quarter |
|added              |double    | Total value added during quarter |
|consolidation      |double    | Consolidation reflects the dollar value of loands consolidated|
|rehabilitation     |double    | Rehabilitation reflects the dollar value of loans rehabilitated|
|voluntary_payments |double    | Voluntary payments reflects the total amount of payments received from borrowers|
|wage_garnishments  |double    | Wage Garnishments reflect the total amount of wage garnishment payments|
|total              |double    | Total dollars repaid |

# Scripts

```{r}
library(tidyverse)
library(here)
library(readxl)


# Read in and aquire names of specific files if Excel
short_file_names <- list.files(here("2019", "2019-11-26")) %>%
  str_remove_all(".xls|.xlsx") %>%
  str_remove_all("PCA_Report_|pca-report-") %>%
  tolower() %>%
  str_replace("default_recoveries_pca", "fy15q4")

# Get short file names
short_files <-  short_file_names %>% 
  str_detect(".r") %>%
  discard(short_file_names, .)

# all file names
all_files <- list.files(here("2019", "2019-11-26")) %>%
  map_chr(~ paste0("2019/2019-11-26/", .x))

# files excluding .R files
files <- all_files %>% 
  str_detect("loans.R") %>% 
  discard(all_files, .)

# clean names for input
names_clean <- files[[1]] %>%
  read_excel(skip = 4) %>%
  janitor::clean_names() %>%
  names()

# read in names, filter erroneous lines
# convert to numeric
# separate out quarter and year
all_df <- map(.x = files, .f = read_excel, skip = 4) %>%
  setNames(short_files) %>%
  map(set_names, nm = names_clean) %>%
  map(~ filter(.x, !is.na(starting))) %>%
  map(~ filter(.x, starting != "At Start of Quarter")) %>%
  map(~ mutate_at(.x,
    .vars = vars(starting:total),
    .funs = as.double
  )) %>%
  map2(.x = ., .y = names(.), ~ mutate(.x, quarter = .y)) %>%
  map(~ select(.x, agency_name, quarter, everything()))

# Combine all datasets
# clean up rows
clean_df <- all_df %>%
  reduce(.f = bind_rows) %>% 
  mutate(quarter = str_remove(quarter, "fy")) %>% 
  separate(col = quarter,
           into = c("year", "quarter"),
           sep = "q") %>% 
  mutate(quarter = str_remove(quarter, "x")) %>% 
  mutate(quarter = as.integer(quarter),
         year = as.integer(year)) %>%
  filter(agency_name != "Total") %>% 
  na_if(0)
  
# check out data
clean_df %>% 
  View()

# write final data
clean_df %>% 
  write_csv(here("2019", "2019-11-26", "loans.csv"))

```
