library(tidyverse)
library(here)
library(readxl)

short_file_names <- list.files(here("2019", "2019-11-26")) %>%
  str_remove_all(".xls|.xlsx") %>%
  str_remove_all("PCA_Report_|pca-report-") %>%
  tolower() %>%
  str_replace("default_recoveries_pca", "fy15q4")

short_files <-  short_file_names %>% 
  str_detect(".r") %>%
  discard(short_file_names, .)

all_files <- list.files(here("2019", "2019-11-26")) %>%
  map_chr(~ paste0("2019/2019-11-26/", .x))

files <- all_files %>% 
  str_detect("loans.R") %>% 
  discard(all_files, .)

names_clean <- files[[1]] %>%
  read_excel(skip = 4) %>%
  janitor::clean_names() %>%
  names()

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

clean_df <- all_df %>%
  reduce(.f = bind_rows) %>% 
  mutate(quarter = str_remove(quarter, "fy")) %>% 
  separate(col = quarter,
           into = c("year", "quarter"),
           sep = "q") %>% 
  filter(agency_name != "Total") %>% 
  na_if(0)
  

clean_df %>% 
  View()


# Consolidation reflects the dollar value of loands consolidated
# Rehabilitation reflects the dollar value of loans rehabilitated
# Voluntary payments reflects the total amount of payments received from borrowers
# Wage Garnishments reflect the total amount of wage garnishment payments (involuntary payments sent by employed)

