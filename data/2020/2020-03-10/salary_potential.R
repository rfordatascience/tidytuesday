library(tidyverse)
library(rvest)

scrape_salary <- function(state_name){
  
  message(glue::glue("Scraping {state_name}!"))
  
  Sys.sleep(5)
  
  url <- glue::glue("https://www.payscale.com/college-salary-report/best-schools-by-state/bachelors/{state_name}")

  raw_table <- url %>% 
    read_html() %>% 
    html_table(fill = TRUE) %>% 
    .[[1]]
  

  raw_table %>% 
    set_names(nm = c("rank", "name", "type", "early_career_pay", "mid_career_pay",
                     "make_world_better_percent", "stem_percent")) %>% 
    as_tibble() %>% 
    mutate(rank = str_remove(rank, "Rank:"),
           name = str_remove(name, "School Name:"),
           type = str_remove(type, "School Type:"),
           early_career_pay = parse_number(early_career_pay),
           mid_career_pay = str_remove(mid_career_pay, "Mid-Career Pay:"),
           mid_career_pay = parse_number(mid_career_pay),
           make_world_better_percent = parse_number(make_world_better_percent),
           stem_percent = parse_number(stem_percent),
           state_name = str_to_title(state_name)
    ) %>% 
    select(rank, name, state_name, everything(), -type)
}
  
all_states <- tolower(state.name) %>%
  str_replace(" ", "-") %>% 
  map(scrape_salary) %>% 
  bind_rows() %>% 
  mutate(name = str_replace(name, "A & M", "A&M"))

all_states %>% 
  write_csv(here::here("2020", "2020-03-10", "salary_potential.csv"))

