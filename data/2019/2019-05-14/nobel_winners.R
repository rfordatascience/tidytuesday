library(tidyverse)
library(here)
library(janitor)

# read in the specific category/field datasets and the overall winners

nobel_winners <- read_csv(here("2019", "2019-05-14", "archive.csv")) %>% 
  janitor::clean_names() %>% 
  rename("prize_year" = year,
         "gender" = sex)

chem_pubs <- read_csv(here("2019", "2019-05-14", "Chemistry publication record.csv")) %>% 
  janitor::clean_names() %>% 
  mutate(category = "chemistry")

med_pubs <- read_csv(here("2019", "2019-05-14", "Medicine publication record.csv")) %>% 
  janitor::clean_names() %>% 
  mutate(category = "medicine")

physics_pubs <- read_csv(here("2019", "2019-05-14", "Physics publication record.csv")) %>% 
  janitor::clean_names() %>% 
  mutate(category = "physics")

all_pubs <- bind_rows(chem_pubs, med_pubs, physics_pubs)

all_pubs %>% 
  write_csv(here("2019", "2019-05-14", "nobel_winner_all_pubs.csv"))

nobel_winners %>% 
  write_csv(here("2019", "2019-05-14", "nobel_winners.csv"))




nobel_winner_all_pubs <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winner_all_pubs.csv")

nobel_winner_all_pubs %>% 
  distinct(category)