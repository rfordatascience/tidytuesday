#basic url
# https://www.bls.gov/cps/aa2020/cpsaat17.xlsx

library(tidyverse)
library(glue)



get_bls_report <- function(year){
  
  report_url <- glue::glue("https://www.bls.gov/cps/aa{year}/cpsaat17.xlsx")
  
  download.file(report_url, destfile = glue("2021/2021-02-23/bls-{year}.xlsx"))
}

ex_2019 <- readxl::read_excel("2021/2021-02-23/bls-2019.xlsx")

2015:2019 %>% 
  walk(get_bls_report)

# 2020 has no year in front of it
download.file(
  "https://www.bls.gov/cps/cpsaat17.xlsx", 
  destfile = "2021/2021-02-23/bls-2020.xlsx"
  )

# Raw BLS -----------------------------------------------------------------

raw_2020 <- readxl::read_excel("2021/2021-02-23/bls-2020.xlsx", skip = 3) %>% 
  slice(1:(n()-2))

major_grp <- raw_2020 %>% 
  slice(1) %>% 
  select(3:last_col()) %>% 
  set_names(nm = glue::glue("...{1:ncol(.)}")) %>% 
  pivot_longer(cols = everything(), values_to = "major_grp") 

minor_grp <- raw_2020 %>% 
  slice(2) %>% 
  select(3:last_col()) %>% 
  set_names(nm = glue::glue("...{1:ncol(.)}")) %>% 
  pivot_longer(cols = everything(), values_to = "minor_grp") 

combo_grp <- left_join(major_grp, minor_grp, by = "name") %>% 
  mutate(across(.fns = ~str_replace_all(.x, "\n", " "))) %>% 
  mutate(across(.fns = ~str_remove_all(.x, "\r"))) %>% 
  mutate(across(.fns = ~str_replace_all(.x, "- ", ""))) %>% 
  tidyr::fill(major_grp)

name_fill <- c("race_gender", "category", "total", glue("...{1:11}"))

clean_2020 <- raw_2020 %>% 
  rename(category = 1) %>% 
  mutate(
    race_gender = if_else(
      str_detect(category, "Agriculture and related"),
      lag(category),
      NA_character_
      ),
    .before = category
    ) %>% 
  fill(race_gender) %>% 
  slice(5:n()) %>% 
  set_names(nm = name_fill) %>% 
  pivot_longer(cols = contains("..."), names_to = "name", values_to = "employ_n") %>% 
  left_join(combo_grp, by = "name") %>% 
  mutate(year = 2020) %>% 
  select(category, major_grp, minor_grp, race_gender, cat_total = total, employ_n)

# Make a function!

clean_bls <- function(year){
  
  raw_df <- readxl::read_excel(glue("2021/2021-02-23/bls-{year}.xlsx"), skip = 3) %>% 
    slice(1:(n()-2))
  
  major_grp <- raw_df %>% 
    slice(1) %>% 
    select(3:last_col()) %>% 
    set_names(nm = glue::glue("...{1:ncol(.)}")) %>% 
    pivot_longer(cols = everything(), values_to = "major_grp") 
  
  minor_grp <- raw_df %>% 
    slice(2) %>% 
    select(3:last_col()) %>% 
    set_names(nm = glue::glue("...{1:ncol(.)}")) %>% 
    pivot_longer(cols = everything(), values_to = "minor_grp") 
  
  combo_grp <- left_join(major_grp, minor_grp, by = "name") %>% 
    mutate(across(.fns = ~str_replace_all(.x, "\n", " "))) %>% 
    mutate(across(.fns = ~str_remove_all(.x, "\r"))) %>% 
    mutate(across(.fns = ~str_replace_all(.x, "- ", ""))) %>% 
    tidyr::fill(major_grp)
  
  name_fill <- c("race_gender", "category", "total", glue("...{1:11}"))
  
  clean_df <- raw_df %>% 
    rename(category = 1) %>% 
    mutate(
      race_gender = if_else(
        str_detect(category, "Agriculture and related"),
        lag(category),
        NA_character_
      ),
      .before = category
    ) %>% 
    fill(race_gender) %>% 
    slice(5:n()) %>% 
    set_names(nm = name_fill) %>% 
    pivot_longer(cols = contains("..."), names_to = "name", values_to = "employ_n") %>% 
    left_join(combo_grp, by = "name") %>% 
    select(industry = category, major_occupation = major_grp, minor_occupation = minor_grp, race_gender, industry_total = total, employ_n) %>% 
    mutate(year = year)
   
  clean_df
  
}

# combine the data

all_bls <- 2015:2020 %>% 
  map_dfr(clean_bls) %>% 
  arrange(desc(year)) %>% 
  mutate(
    industry_total = as.integer(industry_total) * 1000,
    employ_n = as.integer(employ_n) * 1000
    )

# sanity check plot

all_bls %>% 
  filter(race_gender == "Black or African American") %>% 
  filter(minor_occupation == "Sales and related occupations") %>% 
  ggplot(aes(x = year, y = employ_n, group = industry)) +
  geom_line()

all_bls %>% 
  write_csv("2021/2021-02-23/employed.csv")
