library(rvest)

raw_html <- read_html("2021/2021-02-23/bls-all.htm")

raw_html %>% 
  html_nodes("table.catalog") %>% 
  html_table()

all_catalog_raw <- raw_html %>% 
  html_nodes("table.catalog") %>% 
  html_table() 


all_catalog_clean <- all_catalog_raw %>% 
  map(clean_catalog)

clean_catalog <- function(table){
  
  table %>% 
    pivot_wider(names_from = X1, values_from = X2) %>% 
    janitor::clean_names()
  
}

clean_catalog(all_catalog_raw[[2]])


all_table_raw <- raw_html %>% 
  html_nodes("table.regular-data")%>% 
  html_table() 

all_table_clean <- all_table_raw %>% 
  map_dfr(clean_table, .id = "id") %>% 
  mutate(id = as.integer(id))

clean_table <- function(table){
  
  table %>% 
    filter(str_detect(Year, "Corrected", negate = TRUE)) %>% 
    mutate(across(everything(), ~str_remove(.x, "\\(C\\)"))) %>% 
    pivot_longer(Qtr1:Qtr4, names_to = "quarter", values_to = "value") %>% 
    rename(year = Year)
  
}

combine_tables <- bind_rows(all_table_clean) %>% 
  mutate(id = 1:n())

combined_data <- all_catalog_clean %>% 
  bind_rows() %>% 
  mutate(id = row_number()) %>% 
  left_join(all_table_clean, by = "id") %>% 
  mutate(
    year = as.integer(year), 
    quarter = str_remove(quarter, "Qtr") %>% as.integer(),
    value = as.integer(value)
  ) 

data_earn <- combined_data %>% 
  filter(earnings != "Person counts (number in thousands)") %>% 
  rename(median_weekly_earn = value) %>% 
  select(industry:last_col(), -id)

data_earn 

final_bls_earn <- combined_data %>%
  filter(earnings == "Person counts (number in thousands)") %>%
  rename(n_persons = value) %>%
  mutate(n_persons = n_persons * 1000) %>%
  select(industry:quarter, n_persons, -id) %>%
  left_join(
    data_earn,
    by = c(
      "industry", "occupation", "sex", "race", "ethnic_origin", "age", 
      "education", "class_of_worker", "labor_force_status", "year", "quarter"
      )
  ) %>% 
  select(sex, race, ethnic_origin, age, year:median_weekly_earn)

final_bls_earn %>% 
  write_csv("2021/2021-02-23/earn.csv")

# sanity check
final_bls_earn %>% 
  filter(quarter == 2, sex == "Both Sexes", race != "All Races") %>% 
  ggplot(aes(x = year, y = median_weekly_earn, color = race)) +
  geom_line() +
  facet_wrap(~age)
  distinct(quarter)

