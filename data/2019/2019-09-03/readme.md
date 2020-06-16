# Moore's Law

This week's data is from [Wikipedia](https://en.wikipedia.org/wiki/Transistor_count) - by way of the [Data Is Beautiful Subreddit](https://www.reddit.com/r/dataisbeautiful/comments/cynql1/moores_law_graphed_vs_real_cpus_gpus_1965_2019_oc/).

Additional info and graphics can be found at [Our World in Data](https://ourworldindata.org/technological-progress).

**Moore's Law: Transistors per microprocessor**

* The observation that the number of transistors in a dense integrated circuit doubles approximately every two years.


# Get the data!

```
cpu <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/cpu.csv")

gpu <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/gpu.csv")

ram <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-03/ram.csv")

```

# Data Dictionary

## `cpu.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|processor            |character | Processor name |
|transistor_count     |double    | Number of transitors |
|date_of_introduction |double    | year introduced |
|designer             |character | Designer |
|process              |double    | Size of manufacturing process (in nanometers)|
|area                 |double    | Area of chip in square millimeters |

## `gpu.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|processor            |character |Processor name |
|transistor_count     |double    | Transistor count|
|date_of_introduction |double    | year introduced|
|designer_s           |character | designer |
|manufacturer_s       |character | manufacturer |
|process              |double    | size of manufacturing process (nanometers)|
|area                 |double    | area of chip in square millimeters |
|ref                  |character | reference |

## `ram.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|chip_name            |character | Chip name |
|capacity_bits        |character | capacity bits - essentially how many units of information it can work on, units in next column |
|bit_units            |character | Units for bit capacity (bits < kb < Mb < Gb)|
|ram_type             |character | Ram type |
|transistor_count     |double    | Transistor count |
|date_of_introduction |double    | Year introduced|
|manufacturer_s       |character | Manufactured |
|process              |double    | Size of manufacturing process (nanometers) |
|area                 |double    | Area of chip in square millimeters |
|ref                  |character | reference |


# Cleaning Script

```
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

```