library(tidyverse)
library(here)

# read in the datasets
df <- readxl::read_xlsx(here("2019", "2019-07-09", "wwc_results.xlsx")) %>% 
  mutate(Year = as.integer(Year))

df_2019 <- read_csv(here("2019", "2019-07-09", "wwc_2019.csv"))

squads <- readxl::read_xlsx(here("2019", "2019-07-09", "Womens Squads.xlsx")) %>% 
  janitor::clean_names()

# bind datasets to include 2019
df_all <- bind_rows(df, df_2019) %>% 
  janitor::clean_names()

# add win, tie status
df_both <- df_all %>% 
  group_by(year) %>% 
  mutate(yearly_game_id = row_number(),
         winner = case_when(score_1 > score_2 ~ "Team 1 Win",
                   score_2 > score_1 ~ "Team 2 Win",
                   score_1 == score_2 ~ "Tie",
                   TRUE ~ NA_character_)) 

# grab team 1/score 1
df_team_1 <- df_both %>% 
  select(year:score_1, round, yearly_game_id, winner) %>% 
  set_names(nm = c("year", "team", "score", "round", "yearly_game_id", "winner")) %>% 
  mutate(team_num = 1)

# grab team2/score 2
df_team_2 <- df_both %>% 
  select(year, team_2:yearly_game_id, winner) %>% 
  set_names(nm = c("year", "team", "score", "round", "yearly_game_id", "winner")) %>% 
  mutate(team_num = 2)

# attach team1/team2 datasets together
# Assign winner, loser, tie,
# Correct for shootout wins in knockout stages

df_tidy <- bind_rows(df_team_1, df_team_2) %>% 
  arrange(year, yearly_game_id) %>% 
  mutate(win_status = case_when(team_num == as.integer(str_extract(winner, "[:digit:]")) ~ "Won",
                            team == "USA" & round == "Final" & year == 1999 ~ "Won",
                            team == "NOR" & round == "Round of 16" & year == 2019 ~ "Won",
                            team == "JPN" & round == "Final" & year == 2011 ~ "Won",
                            team == "CHN" & round == "Quarter Final" & year == 1995 ~ "Won",
                            team == "FRA" & round == "Quarter Final" & year == 2011 ~ "Won",
                            team == "USA" & round == "Quarter Final" & year == 2011 ~ "Won",
                            team == "GER" & round == "Quarter Final" & year == 2015 ~ "Won",
                            team == "BRA" & round == "Third Place Playoff" & year == 1999 ~ "Won",
                            round == "Group" & winner == "Tie" ~ "Tie",
                            TRUE ~ "Lost")) %>% 
  select(-winner)

# confirm no double winners/losers
df_tidy %>% 
  filter(round != "Group") %>% 
  group_by(year, round, yearly_game_id) %>% 
  count(win_status, sort = TRUE) %>% 
  filter(n >1)

# output to csv
df_tidy %>% 
  write_csv(here("2019", "2019-07-09", "wwc_outcomes.csv"))

squads %>% 
  write_csv(here("2019", "2019-07-09", "squads.csv"))


# data dictionaries for TidyTuesday
tomtom::create_dictionary(df_tidy)
tomtom::create_dictionary(squads)
