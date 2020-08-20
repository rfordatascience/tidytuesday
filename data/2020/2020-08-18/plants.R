library(tidyverse)
library(tidytext)

plants_wide <- read_csv("https://raw.githubusercontent.com/Z3tt/TidyTuesday/master/data/raw_plants/plants_extinct_wide.csv")

plants_wide %>% 
  write_csv(here::here("2020", "2020-08-18", "plants.csv"))

threats <- plants_wide %>% 
  select(-contains("action")) %>% 
  pivot_longer(cols = contains("threat"), names_to = "threat_type", 
               values_to = "threatened", names_prefix = "threat_") %>% 
  mutate(threat_type = case_when(
    threat_type == "AA" ~ "Agriculture & Aquaculture",
    threat_type == "BRU" ~ "Biological Resource Use",
    threat_type == "RCD" ~ "Commercial Development",
    threat_type == "ISGD" ~ "Invasive Species",
    threat_type == "EPM" ~ "Energy Production & Mining",
    threat_type == "CC" ~ "Climate Change",
    threat_type == "HID" ~ "Human Intrusions",
    threat_type == "P" ~ "Pollution",
    threat_type == "TS" ~ "Transportation Corridor",
    threat_type == "NSM" ~ "Natural System Modifications",
    threat_type == "GE" ~ "Geological Events",
    threat_type == "NA" ~ "Unknown",
    TRUE ~ NA_character_
  )) 

threats %>% 
  write_csv(here::here("2020", "2020-08-18", "threats.csv"))

threat_filtered <- threats %>% 
  filter(threatened == 1) 

threat_filtered %>% 
  janitor::tabyl(threat_type, threatened)

actions <- plants %>% 
      select(-contains("threat")) %>% 
      pivot_longer(cols = contains("action"), names_to = "action_type", 
                   values_to = "action_taken", names_prefix = "action_") %>% 
      mutate(action_type = case_when(
        action_type == "LWP" ~ "Land & Water Protection",
        action_type == "SM" ~ "Species Management",
        action_type == "LP" ~ "Law & Policy",
        action_type == "RM" ~ "Research & Monitoring",
        action_type == "EA" ~ "Education & Awareness",
        action_type == "NA" ~ "Unknown",
        TRUE ~ NA_character_
      )) 

actions %>% 
  write_csv(here::here("2020", "2020-08-18", "actions.csv"))

action_filtered <- actions %>% 
  filter(action_taken == 1) 

action_filtered %>% 
  janitor::tabyl(action_type, action_taken)

threat_filtered %>% 
  count(continent, group, threat_type) %>% 
  ggplot(aes(y = tidytext::reorder_within(threat_type, n, continent), x = n, fill = group)) +
  geom_col() +
  tidytext::scale_y_reordered() +
  facet_wrap(~continent, scales = "free_y", ncol = 1)


