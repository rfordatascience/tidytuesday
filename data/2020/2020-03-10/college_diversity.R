library(rvest)
library(tidyverse)
library(here)
library(glue)
library(furrr)

# I didn't want to repeatedly scrape this so I just downloaded it locally.
raw_html <- read_html(here("2020","2020-03-10","Tuition and Fees, 1998-99 Through 2018-19 - The Chronicle of Higher Education.htm"))


get_id <- function(number){

  raw_html %>% 
    html_nodes(xpath = glue::glue('/html/body/div[1]/div[3]/div/div/article/div/div[2]/div[3]/table/tbody/tr[{number}]')) %>% 
    html_attrs() %>% pluck(1,"id")
}

get_college <- function(id, .pb = NULL){
  
  if ((!is.null(.pb)) && inherits(.pb, "Progress") && (.pb$i < .pb$n)) .pb$tick()$print()
  
  
  suppressWarnings(tibble(
    name = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[1]/text()')) %>% 
      html_text(),
    state = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[2]')) %>% 
      html_text(),
    type = html_node(raw_html, xpath = '//*[@id="180203"]/td[1]/span') %>% 
      html_text(),
    room_board = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[3]')) %>% 
      html_text(),
    tuition_in_state = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[4]')) %>% 
      html_text(),
    total_in_state = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[5]')) %>% 
      html_text(),
    tuition_out_of_state = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[6]')) %>% 
      html_text(),
    total_out_of_state = html_node(raw_html, xpath = glue('//*[@id="{id}"]/td[7]')) %>% 
      html_text() 
  ) %>% 
    mutate_at(vars(room_board:total_out_of_state), parse_number))
  
  }



raw_html %>% 
  html_nodes("tr") %>% 
  length()

all_college_ids <- tibble(number = 1:5946) %>% 
  mutate(id = map_chr(number, get_id)) %>% 
  filter(!str_detect(id, "overtime"))

# Testing
get_college("180203") %>% select(type) %>% pull()
 separate(type, into = c("type", "degree_length"), sep = " ")

# Did some furrr instead of read_table()
# It's a lot of data, so I'd recommend going with reading the HTML file.
# Dont use this for now :)
 
plan(multiprocess)

test_df3 <- all_college_ids %>%
  mutate(data = furrr::future_map(id, get_college, .progress = TRUE)) %>% 
  select(data)


clean_tuition <- test_df3 %>% flatten_dfr() %>% 
  rename(state_code = state) %>% 
  separate(type, into = c("type", "degree_length"), sep = " ") %>% 
  left_join(tibble(state_code = state.abb, state = state.name), by = "state_code") %>% 
  select(name, state_code, state, everything())


raw_table <- raw_html %>% 
  html_table(fill = TRUE) %>% 
  chuck(1) %>% 
  janitor::clean_names() %>% 
  as_tibble() %>% 
  filter(str_length(institution_type) > 1)


clean_cost_table <- raw_table %>% 
  mutate_at(vars(room_and_board:out_of_state_total), parse_number) %>% 
  rename(name = institution_type) %>% 
  mutate(
    degree_length = case_when(
      str_detect(name, "2-year") ~ "2 Year",
      str_detect(name, "4-year") ~ "4 Year",
      TRUE ~ "Other"
  ),
  type = case_when(
    str_detect(name, "Public") ~ "Public",
    str_detect(name, "Private") ~ "Private",
    str_detect(name, "For-profit") ~ "For Profit",
    TRUE ~ "Other")
  ) %>% 
  mutate(name = str_sub(name, 1, -6),
         name = str_remove(name, " 2-year| 4-year"),
         name = str_remove(name, "Public|Private|For-profit")) %>% 
  select(name, state_code = state, type, degree_length, everything()) %>% 
  left_join(tibble(state_code = state.abb, state = state.name), by = "state_code") %>% 
  select(name, state, state_code, everything())

clean_cost_table %>% 
  write_csv(here::here("2020", "2020-03-10", "tuition_cost.csv"))


# Add diversity data ------------------------------------------------------

raw_diversity <- read_html(here::here("2020","2020-03-10","Student Diversity at More Than 4,600 Institutions - The Chronicle of Higher Education.htm"))

raw_table_div <- raw_diversity %>% 
  html_table(fill = TRUE) %>% 
  .[[1]] %>% 
  janitor::clean_names() %>% 
  as_tibble()

diversity_tab <- read_csv(here::here("2020","2020-03-10","student_diversity.csv"))

clean_div_table <- diversity_tab %>% 
  rename(name = "INSTITUTION", total_enrollment = ENROLLMENT) %>% 
  mutate(name = str_replace(name, "U.", "University "),
         state = str_extract(name, paste0(state.name, collapse = "|")),
         state_length = (str_count(state) + 1) * -1,
         name = str_sub(name, 1, state_length),
         name = str_squish(name),
         name = str_trim(name)) %>% 
  select(-state_length) %>% 
  pivot_longer(names_to = "category", values_to = "enrollment", cols = WOMEN:`TOTAL MINORITY`) %>% 
  mutate(category = str_to_title(category),
         category = str_remove(category, "\n"))

final_table <- left_join(clean_cost_table, clean_div_table, by = c("name", "state")) %>% 
  filter(category %in% c("Black", "Hispanic", "Asian", "Two Or More Races", "Non-Resident Foreign")) %>% 
  filter(degree_length == "4 Year", total_enrollment > 1000) %>% 
  filter(type != "For Profit") %>% 
  group_by(name, state_code, type, category, total_enrollment, in_state_total) %>% 
  summarize(enrollment = sum(enrollment)) %>% ungroup() %>% 
  rowwise() %>% 
  mutate(minority_enroll = enrollment/total_enrollment) %>% 
  ungroup() %>% 
  filter(in_state_total > 10000) %>% 
  select(name, state_code, type, category, in_state_total, minority_enroll) 

final_table %>% 
  write_csv(here::here("2020","2020-03-10", "college_diversity.csv"))
  
final_table %>% 
  ggplot(aes(x = in_state_total, y = minority_enroll)) +
  geom_point() +
  geom_smooth() +
  facet_grid(category ~ type) +
  geom_hline(yintercept = .50) +
  scale_y_continuous(limits = c(0, 1.05), labels = scales::percent_format()) +
  labs(x = "Total Cost of Enrollment", y = "Minority Enrollment")


# Total Enrollment --------------------------------------------------------



left_join(clean_cost_table, clean_div_table, by = c("name", "state")) %>%
  distinct(name, state_code, .keep_all = TRUE) %>% 
  filter(total_enrollment >= 1000, in_state_total >= 5000) %>% 
  ggplot(aes(x = in_state_total, y = total_enrollment)) +
  geom_point() +
  # scale_y_log10() +
  scale_y_continuous(limits = c(0, 21000)) +
  facet_wrap(~type, ncol = 1) +
  geom_smooth()


clean_cost_table %>% 
  write_csv(here::here("2020","2020-03-10","total_school_cost.csv"))

clean_div_table %>% 
  write_csv(here::here("2020","2020-03-10","diversity_school.csv"))
