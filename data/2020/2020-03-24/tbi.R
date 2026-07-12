library(tidyverse)
library(rvest)
library(pdftools)

# Hospital TBI data -------------------------------------------------------

all_years <- read_html("https://www.cdc.gov/traumaticbraininjury/data/tbi-edhd.html") %>% 
  html_node(xpath = '//*[@id="acc-panel-1"]/div/div/table/thead/tr') %>% 
  html_text() %>% 
  str_split("\\\n") %>% 
  str_extract_all("[0-9]+") %>% 
  simplify()

hospital_url <- "https://www.cdc.gov/traumaticbraininjury/data/tbi-edhd.html"
  
raw_html_hospital <- read_html(url) 

get_table_row <- function(input_html, tab_num){
  
  node <- html_node(input_html, xpath = glue::glue('//*[@id="acc-panel-1"]/div/div/table/tbody/tr[{tab_num}]'))
  
  html_text(node)
}

tbi_hospital <- tibble(
  input_html = list(raw_html_hospital),
  tab_num = 1:4
) %>% 
  mutate(raw_data = map2_chr(input_html, tab_num, get_table_row)) %>% 
  separate(raw_data, into = c("type", all_years), sep = "\\\n") %>% 
  select(-tab_num,-input_html) %>% 
  pivot_longer(cols = -type, values_to = "value", names_to = "year") %>% 
  mutate(value = parse_number(value),
         year = as.double(year))



# TBI Deaths --------------------------------------------------------------



url_deaths <- "https://www.cdc.gov/traumaticbraininjury/data/tbi-deaths.html"

raw_html_deaths <- read_html(url_deaths)

tbi_deaths <- tibble(
  tab_num = 1:7,
  input_html = list(raw_html_deaths)
) %>% 
  mutate(raw_data = map2_chr(input_html, tab_num, get_table_row)) %>% 
  separate(raw_data, into = c("type", all_years), sep = "\\\n") %>% 
  select(-tab_num,-input_html) %>% 
  mutate(type = str_remove(type, "††|‡‡|§§")) %>% 
  pivot_longer(cols = -type, values_to = "value", names_to = "year") %>% 
  mutate(value = parse_number(value),
         year = as.double(year))



# ED Visits ---------------------------------------------------------------

url_ed <- "https://www.cdc.gov/traumaticbraininjury/data/tbi-ed-visits.html"

raw_html_ed <- read_html(url_ed)

tbi_ed_visits <- tibble(
  tab_num = 1:7,
  input_html = list(raw_html_ed)
) %>% 
  mutate(raw_data = map2_chr(input_html, tab_num, get_table_row)) %>% 
  separate(raw_data, into = c("type", all_years), sep = "\\\n") %>% 
  select(-tab_num,-input_html) %>% 
  mutate(type = str_remove(type, "††|‡‡|§§")) %>% 
  pivot_longer(cols = -type, values_to = "value", names_to = "year") %>% 
  mutate(value = parse_number(value),
         year = as.double(year))


# Hospitalizations --------------------------------------------------------

url_hosp <- "https://www.cdc.gov/traumaticbraininjury/data/tbi-hospitalizations.html"

raw_html_hosp <- read_html(url_hosp)

tbi_hosp <- tibble(
  tab_num = 1:7,
  input_html = list(raw_html_hosp)
) %>% 
  mutate(raw_data = map2_chr(input_html, tab_num, get_table_row)) %>% 
  separate(raw_data, into = c("type", all_years), sep = "\\\n") %>% 
  select(-tab_num,-input_html) %>% 
  mutate(type = str_remove(type, "††|‡‡|§§")) %>% 
  pivot_longer(cols = -type, values_to = "value", names_to = "year") %>% 
  mutate(value = parse_number(value),
         year = as.double(year))


# PDF report --------------------------------------------------------------

pdf_url <- "https://www.cdc.gov/traumaticbraininjury/pdf/TBI-Surveillance-Report-FINAL_508.pdf"

raw_pdf_text <- pdftools::pdf_text(pdf_url)


# General table scraping function -----------------------------------------

clean_pdf_table <- function(table_number){
  
  input_text <- chuck(raw_pdf_text, table_number)
  
  raw_table_text <- str_split(raw_pdf_text[[table_number]], 
                              "\\)\\\n|\\*\\\n", simplify = TRUE)
  
  vec_length <- c("0-1", "0-4", "5-1", "15-", "25-", "35-", "45-", "55-", "65-",
                  "75+", "Tot") %>% paste(collapse = "|")
  
  vec_subset <- str_detect(str_sub(raw_table_text, 1, 4), vec_length)
  
  small_tab <- raw_table_text[vec_subset]
  
  if(length(small_tab) <= 2) stop("No table found!")
  
  pre_tab <- small_tab %>% 
    str_squish() %>% 
    str_replace_all(" \\(", "_(") %>% 
    str_replace_all("\\s", "|") %>% 
    str_replace_all(",", "")
  
  text_con <- textConnection(pre_tab)
  
  output_df <- read.csv(text_con, header = FALSE, sep = "|", stringsAsFactors = FALSE)
  
  tibble_df <- output_df %>% 
    as_tibble() %>% 
    mutate_all(str_replace, "##|¶¶", "")
  
  tibble_fixed <- tibble_df %>% 
    mutate_at(.vars = vars(2:last_col()),
              str_extract, "[^_]+")
  
  tibble_typed <- suppressMessages(type_convert(tibble_fixed))
  
  tibble_typed
}

# PDF Tab 1 ---------------------------------------------------------------

# This was a first attempt before moving to a function

raw_pdf_text[[9]]

raw_table_text <- str_split(raw_pdf_text[[9]], "\\\n", simplify = TRUE)

pre_table <- raw_table %>% 
  .[9:19] %>% 
  str_squish() %>% 
  str_replace_all(" \\(", "_(") %>% 
  str_replace_all("\\s", "|")

text_con <- textConnection(pre_table)
data_table <- read.csv(text_con, sep = "|", header = FALSE, stringsAsFactors = FALSE)

tab_1 <- data_table %>% 
  set_names(nm = c("age_group", "ed_visit", "ed_visit_rate", "hospitilizations",
                   "hospitilization_rate", "death_no", "death_rate", "total_edhd", 
                   "total_edhd_rate")) %>%
  as_tibble() %>% 
  mutate_all(as.character) %>% 
  mutate_at(vars(contains("rate")), str_extract, "[^_]+") %>% 
  mutate_at(vars(ed_visit:total_edhd_rate), parse_number) %>% 
  add_column(type = "ED Visits, Hospitalizations, and deaths", .after = "age_group")

tab_1


# PDF Tab 2 ---------------------------------------------------------------

clean_pdf_table(10)

tab_2 <- clean_pdf_table(10) %>% 
  set_names(nm = c("age_group", "num_crash", "rate_crash", "num_falls",
                   "rate_falls", "num_struck", "rate_struck", "num_inj_unspecified", 
                   "rate_inj_unspecified", "num_self_harm", "rate_self_harm",
                   "num_assault", "rate_assault", "num_other", "rate_other")) %>% 
  add_column(type = "Emergency Department Visit", .after = "age_group")

tab_2
  

# PDF Tab 3 ---------------------------------------------------------------

tab_3 <- clean_pdf_table(11) %>% 
  set_names(nm = c("age_group", "num_crash", "rate_crash", "num_falls",
                   "rate_falls", "num_struck", "rate_struck", "num_inj_unspecified", 
                   "rate_inj_unspecified", "num_self_harm", "rate_self_harm",
                   "num_assault", "rate_assault", "num_other", "rate_other")) %>% 
  add_column(type = "Hospitalizations", .after = "age_group")

tab_3


# PDF Tab 4 ---------------------------------------------------------------

tab_4 <- clean_pdf_table(12) %>% 
  set_names(nm = c("age_group", "num_crash", "rate_crash", "num_falls",
                   "rate_falls", "num_struck", "rate_struck", "num_inj_unspecified", 
                   "rate_inj_unspecified", "num_self_harm", "rate_self_harm",
                   "num_assault", "rate_assault", "num_other", "rate_other")) %>% 
  add_column(type = "Deaths", .after = "age_group")

tab_4


# PDF Combo Table ---------------------------------------------------------

combo_tab <- bind_rows(tab_2, tab_3, tab_4)

view(combo_tab)

combo_tab

num_df <- combo_tab %>% 
  pivot_longer(cols = contains("num"), names_to = "injury_mechanism",
               values_to = "number_est") %>% 
  select(-contains("rate")) %>% 
  separate(injury_mechanism, into = c("count_type", "injury_mechanism"), 
           sep = "_", extra = "merge")

rate_df <- combo_tab %>% 
  pivot_longer(cols = contains("rate"), names_to = "injury_mechanism",
               values_to = "rate_est") %>% 
  select(-contains("num")) %>% 
  separate(injury_mechanism, into = c("count_type", "injury_mechanism"), 
           sep = "_", extra = "merge")

long_combo_df <- left_join(num_df, rate_df, 
                           by = c("age_group", "type", "injury_mechanism")) %>% 
  select(-contains("count_type")) %>% 
  mutate(
    injury_mechanism = factor(
      injury_mechanism,
      levels = c( "crash", "falls", "struck", "inj_unspecified","self_harm",
                  "assault", "other"),
      labels = c("Motor Vehicle Crashes", "Unintentional Falls", 
                 "Unintentionally struck by or against an object",
                 "Other unintentional injury, mechanism unspecified",
                 "Intentional self-harm", "Assault", "Other or no mechanism specified"
                 )
      ),
    injury_mechanism = as.character(injury_mechanism)
    )


# Other PDF Tables --------------------------------------------------------


get_graph_table <- function(page_number){
  
  titles <- c(
    "Motor vehicle crashes", "Unintentional falls", "Unintentionally struck by or against an object",
    "Other unintentional injury, mechanism unspecified","Intentional self-harm",
    "Assault", "Other or no mechanism specified", "Total"
  ) 
  
  titles_collapse <- titles %>% paste0(collapse = "|")

  
  raw_table_text <- raw_pdf_text[[page_number]] %>% 
    str_remove_all("††\\\n|§§|‡‡\\\n|††|‡‡") %>% 
    str_split("\\\n", simplify = TRUE) %>% 
    str_squish() %>% 
    str_replace_all(titles_collapse, "type") %>% 
    str_remove_all(",") %>% 
    str_squish() %>% 
    str_replace_all("\\s", "|")
  
  vec_subset <- str_detect(str_sub(raw_table_text, 1, 4), "type")
  
  
  small_tab <- raw_table_text[vec_subset]
  
  if(length(small_tab) <= 2) stop("No table found!")
  
  text_con <- textConnection(small_tab)
  
  output_df <- read.csv(text_con, header = FALSE, sep = "|", stringsAsFactors = FALSE)
  
  tibble_df <- output_df %>% 
    as_tibble()
  
  tibble_typed <- suppressMessages(type_convert(tibble_df))
  
  type_measure <- raw_table_text[str_detect(str_sub(raw_table_text, 1, 6), "FIGURE")] %>% 
    str_detect("RATE")
  
  measure_label <- if_else(type_measure == TRUE, "rate_est", "number_est")
  
  tibble_typed %>% 
    set_names(nm = c("injury_mechanism", as.character(2006:2014))) %>% 
    mutate(injury_mechanism = titles[1:nrow(tibble_typed)],
           type = case_when(
             page_number %in% c(15,16) ~ "Emergency Department Visit",
             page_number %in% c(17,18) ~ "Hospitalizations",
             page_number %in% c(19,20) ~ "Deaths",
           )) %>% 
    pivot_longer(cols = c(-type, -injury_mechanism), 
                 names_to = "year", values_to = measure_label)
}

ed_time <- 15:16 %>% 
  map(get_graph_table) %>% 
  reduce(left_join, by = c("injury_mechanism", "type", "year"))

hosp_time <- 17:18 %>% 
  map(get_graph_table) %>% 
  reduce(left_join, by = c("injury_mechanism", "type", "year"))

death_time <- 19:20 %>% 
  map(get_graph_table) %>% 
  reduce(left_join, by = c("injury_mechanism", "type", "year"))

long_time_df <- bind_rows(ed_time, hosp_time, death_time)


# Saving Tables -----------------------------------------------------------

long_combo_df %>% write_csv(here::here("2020", "2020-03-24", "tbi_age.csv"))

long_time_df %>% write_csv(here::here("2020", "2020-03-24", "tbi_year.csv"))



# Military TBI ------------------------------------------------------------

url <- "https://dvbic.dcoe.mil/dod-worldwide-numbers-tbi"

download_pdf <- function(year){
  url <- glue::glue("https://dvbic.dcoe.mil/sites/default/files/tbi-numbers/worldwide-totals-{year}_jun-21-2018_v1.0_2018-07-26_0.pdf")
  download.file(url = url, destfile = here::here("2020","2020-03-24", glue::glue("dod_tbi_{year}.pdf")))
}

2006:2014 %>% 
  walk(download_pdf)


get_dod_tbi <- function(year, page_number){
  
  dod_file <- here::here("2020","2020-03-24", glue::glue("dod_tbi_{year}.pdf"))
  
  raw_dod_text <- pdftools::pdf_text(dod_file)
  
  text_df <- raw_dod_text[[page_number]] %>% 
    str_remove_all(",") %>% 
    str_split("\\\n", simplify = F) %>% 
    as.data.frame()
  
  text_df %>% 
    rename("col1" = 1) %>% 
    as_tibble() %>% 
    slice(-1) %>% 
    mutate(service = case_when(
      str_detect(col1, "Army") ~ "Army",
      str_detect(col1, "Navy") ~ "Navy",
      str_detect(col1, "Air Force") ~ "Air Force",
      str_detect(col1, "Marines") ~ "Marines"
    ),
    component = case_when(
      str_detect(col1, "Active") ~ "Active",
      str_detect(col1, "Guard") ~ "Guard",
      str_detect(col1, "Reserve") ~ "Reserve"
    ),
    severity = case_when(
      str_detect(col1, "Penetrating") ~ "Penetrating",
      str_detect(col1, "Severe") ~ "Severe",
      str_detect(col1, "Moderate") ~ "Moderate",
      str_detect(col1, "Mild") ~ "Mild",
      str_detect(col1, "Not Classifiable") ~ "Not Classifiable",
    ),
    diagnosed = str_extract(col1, "[:digit:]+"),
    diagnosed = as.double(diagnosed)) %>% 
    mutate_at(vars(service:severity), str_squish) %>% 
    select(-col1) %>% 
    group_by(severity) %>% 
    mutate(group_n = row_number()) %>% 
    group_by(group_n) %>% 
    fill(component, .direction = "downup") %>% 
    ungroup() %>% 
    fill(service, .direction = "downup") %>% 
    filter(!is.na(severity)) %>% 
    select(-group_n) %>% 
    mutate(year = year)
  
  
}

test_df <- get_dod_tbi(2006, 2)

test_df

all_years <- crossing(
  year = 2006:2014, 
  page_number = 2:5
) %>% 
  mutate(data = map2(.x = year, .y = page_number, .f = get_dod_tbi)) %>% 
  select(data) %>% 
  unnest()
   
all_years %>% 
  ggplot(aes(x = year, y = diagnosed, color = severity)) +
  geom_point() +
  geom_line() + 
  facet_grid(service ~ component)

all_years %>% 
  write_csv(here::here("2020", "2020-03-24", "tbi_military.csv"))


