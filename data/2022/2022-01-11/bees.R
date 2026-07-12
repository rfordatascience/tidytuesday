library(rvest)
library(tidyverse)
library(fs)

# download site
url <- "https://usda.library.cornell.edu/concern/publications/rn301137d?locale=en"

# raw html
raw_html <- read_html(url)

# all the download urls for zip files
all_urls <- raw_html %>% 
  html_elements("#content-wrapper > div.row.p-content > div.col-sm-7 > table") %>% 
  html_elements("a") %>% 
  html_attr("href") %>% 
  str_subset(".zip") 

# download to correct directory
download.file(all_urls, destfile = paste0("2022/2022-01-11/", basename(all_urls)))

# unzip into their respective folders
walk(basename(all_urls), ~ unzip(
  paste0("2022/2022-01-11/", .x),
  exdir = paste0("2022/2022-01-11/bee-", str_sub(.x, -6, -5))
))


#  Clean Colony data ------------------------------------------------------


clean_bee_colonies <- function(file){
  
  col_labs <- c("state", "colony_n", "colony_max", "colony_lost", 
    "colony_lost_pct", "colony_added", "colony_reno", "colony_reno_pct")
  
  raw_df <- read_csv(file,  skip = 2, col_names = FALSE)
  
  date_rng <- read_csv(file, skip = 0, col_names = FALSE) %>% 
    slice(2) %>% 
    pull(X3) %>% 
    str_replace(" [5-6]/$", "") %>% 
    word(-2, -1)
  
  clean_df <- suppressWarnings(raw_df %>% 
    filter(!is.na(X4))  %>%
    filter(X2 == "d") %>% 
    select(X3:X10) %>% 
    set_names(nm = col_labs) %>% 
    mutate(date_range = date_rng, .before = state) %>% 
    separate(date_range, into = c("months", "year"), sep = " ") %>% 
    select(year, months, state, everything()) %>% 
    mutate(across(contains("colony"), as.integer)))
  
  clean_df
}


# Clean stress data -------------------------------------------------------


clean_bee_stress <- function(file){
  
  col_labs <- c("state", "colony_n", "colony_max", "colony_lost", 
    "colony_lost_pct", "colony_added", "colony_reno", "colony_reno_pct")

  
  raw_df <- read_csv(file,  skip = 4, col_names = FALSE)
  
  date_rng <- read_csv(file, skip = 0, col_names = FALSE) %>% 
    slice(2) %>% 
    pull(X3) %>% 
    str_replace(" [5-6]/$", "") %>% 
    word(-2, -1)
  
  stress_nm <- c("state", "Varroa mites", "Other pests/parasites", "Disesases",
    "Pesticides", "Other", "Unknown")
  
  clean_df <- suppressWarnings(raw_df %>% 
      filter(!is.na(X4))  %>%
      filter(X2 == "d") %>% 
      select(X3:X9) %>% 
      set_names(nm = stress_nm) %>% 
      pivot_longer(cols = -state, names_to = "stressor", values_to = "stress_pct") %>% 
      mutate(date_range = date_rng, .before = state) %>% 
      separate(date_range, into = c("months", "year"), sep = " ") %>% 
      select(year, months, state, everything()) %>% 
      mutate(stress_pct = as.double(stress_pct)))
  
  clean_df
}


# Get the file index ------------------------------------------------------


all_html_index <- dir_ls("data/2022/2022-01-11", recurse = TRUE, glob = "*htm") %>% 
  str_subset("bee-") %>% 
  str_subset("index")

get_index <- function(index_file){
  ind_yr <- str_sub(index_file, -17, -16)
  
  raw_text <- index_file %>% 
    read_html() %>%
    html_text() %>% 
    str_split("\r\n[0-9]+") %>% 
    unlist() %>% 
    map(~str_split(.x, "\r\n")) 
  
  raw_text %>% 
    tibble(data = .) %>% 
    unchop(data) %>% 
    unnest_wider(data) %>% 
    select(file = ...2, desc = ...3) %>% 
    mutate(type = case_when(
      str_detect(desc, "Colonies, Maximum, Lost") ~ "Colony",
      str_detect(desc, "Colony Health Stressors") ~ "Stressor",
      TRUE ~ NA_character_
    )) %>% 
    filter(!is.na(type)) %>% 
    mutate(year = ind_yr, .before = file)
  
}

all_index_files <- map_dfr(all_html_index, get_index)

# Split data by type
split_files <- all_index_files %>% 
  mutate(dir_file = glue::glue("data/2022/2022-01-11/bee-{year}/{file}")) %>% 
  select(type, dir_file, year, file, desc) %>% 
  group_split(type)

# aggregate the clean data by type

all_colonies <-  map_dfr(split_files[[1]]$dir_file, clean_bee_colonies) %>% 
  distinct(year, months, state, .keep_all = TRUE) %>% 
  mutate(state = str_remove(state, " 4/| 5/")) %>% 
  filter(state %in% c(state.name, "Other States", "United States"))

all_stress <-  map_dfr(split_files[[2]]$dir_file, clean_bee_stress) %>% 
  distinct(year, months, state, stressor, .keep_all = TRUE) %>% 
  mutate(state = str_remove(state, " 4/| 5/")) %>% 
  filter(state %in% c(state.name, "Other States", "United States"))

# check data
all_colonies %>% 
  count(year, months) %>% 
  filter(n > 47)

all_stress %>% 
  count(year, months) %>% 
  filter(n > 282)

all_colonies %>% 
  write_csv("data/2022/2022-01-11/colony.csv")

all_stress %>% 
  write_csv("data/2022/2022-01-11/stressor.csv")
