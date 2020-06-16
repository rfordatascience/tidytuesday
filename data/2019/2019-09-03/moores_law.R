library(tidyverse)
library(rvest)

url <- "https://en.wikipedia.org/wiki/Transistor_count"

tables <- url %>% 
  read_html() %>% 
  html_table(fill = TRUE)

df1 <- tables %>% chuck(1) %>% 
  janitor::clean_names() %>% 
  as_tibble()

df1_clean <- df1 %>% 
  mutate(
    # transistor_count = gsub("\\[[^\\]]*\\]", "", transistor_count, perl=TRUE),
    transistor_count = str_remove(transistor_count, "\\[[^\\]]*\\]"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_remove(transistor_count, "\\[[^\\]]*\\]"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_extract(transistor_count, "[:digit:]+"),
    date_of_introduction = str_sub(date_of_introduction, 1, 4),
    process = str_remove(process, ","),
    process = str_extract(process, "[:digit:]+"),
    area = str_extract(area, "[:digit:]+")
    ) %>% 
  mutate_at(.vars = vars(transistor_count:date_of_introduction, process:area), as.double)


df1_clean %>%
  mutate() 
df2 <- tables %>% chuck(2) %>% 
  janitor::clean_names() %>% 
  as_tibble()

df2_clean <- df2 %>% 
  mutate(
    # transistor_count = gsub("\\[[^\\]]*\\]", "", transistor_count, perl=TRUE),
    transistor_count = str_remove(transistor_count, "\\[[^\\]]*\\]"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_remove(transistor_count, "\\[[^\\]]*\\]"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_extract(transistor_count, "[:digit:]+"),
    process = str_remove(process, ","),
    process = str_extract(process, "[:digit:]+"),
    area = str_extract(area, "[:digit:]+")
  ) %>% 
  mutate_at(.vars = vars(transistor_count:date_of_introduction, process:area), as.double)

df3 <- tables %>% chuck(4) %>% 
  janitor::clean_names() %>% 
  as_tibble()

df3

df3_clean <- df3 %>% 
  mutate(
    # transistor_count = gsub("\\[[^\\]]*\\]", "", transistor_count, perl=TRUE),
    transistor_count = str_remove(transistor_count, "\\[[^\\]]*\\]"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_remove(transistor_count, "\\[[^\\]]*\\]"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_remove(transistor_count, "[:punct:]+"),
    transistor_count = str_extract(transistor_count, "[:digit:]+"),
    date_of_introduction = if_else(
      str_length(date_of_introduction) >= 5,
      str_sub(date_of_introduction, -4),
      str_sub(date_of_introduction, 1, 4)),
    process = str_remove(process, ","),
    process = str_extract(process, "[:digit:]+"),
    area = str_extract(area, "[:digit:]+"),
    bit_units = case_when(
      str_detect(capacity_bits, "bit") ~ "Bits",
      str_detect(capacity_bits, "kb") ~ "kb",
      str_detect(capacity_bits, "Mb") ~ "Mb",
      str_detect(capacity_bits, "Gb") ~ "Gb",
      TRUE ~ ""
                 )
  ) %>% 
  mutate_at(.vars = vars(transistor_count:date_of_introduction, process:area), as.double) %>% 
  select(chip_name, capacity_bits, bit_units, everything()) %>% 
  mutate(capacity_bits = str_extract(capacity_bits, "[:digit:]+"))

df3_clean

write_csv(df1_clean, here::here("2019", "2019-09-03", "cpu.csv"))
write_csv(df2_clean, here::here("2019", "2019-09-03", "gpu.csv"))
write_csv(df3_clean, here::here("2019", "2019-09-03", "ram.csv"))

tomtom::create_dictionary(df1_clean)

cpu <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/cpu.csv")
gpu <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/gpu.csv")
ram <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/ram.csv")

