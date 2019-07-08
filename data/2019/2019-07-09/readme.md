# Women's World Cup Results

This dataset seemed appropriate for a lot of reasons - `useR2019` is in France this year, the Women's World Cup was in France this year and the tournament just ended! Congrats to all the teams for qualifying and participating in the world stage!

This data comes from [data.world](https://data.world/sportsvizsunday/womens-world-cup-data) and includes final score and win/loss status data from 1991-2019. Additionally the 2019 rosters for each team are included. The data was uploaded to `data.world` as part of the `#SportsVizSunday` Twitter project courtesy of [Simon Beaumont](https://twitter.com/SimonBeaumont04?lang=en). There's a lot more data at [Wikipedia](https://en.wikipedia.org/wiki/FIFA_Women%27s_World_Cup), including Attendance, Host/Results, and conference-level data. Additionally, there are lots of other fun sports-related datasets from `#SportsVizSunday`as seen [at `data.world`](https://data.world/sportsvizsunday).

I cleaned up the data and have attached the final and original dataset. I also added the 2019 match data by hand through the Finals!

Country codes are on [Wikipedia](https://simple.wikipedia.org/wiki/List_of_FIFA_country_codes).

I have included my script in this repo so you can take a peek at how we got here.

Additional datasets of interest:
- [Free play-by-play data](https://github.com/statsbomb/StatsBombR)
- [538 Predictions article](https://fivethirtyeight.com/features/how-our-2019-womens-world-cup-predictions-work/)
- [538 Predictions data](https://github.com/fivethirtyeight/data/tree/master/womens-world-cup-2019)

# Get the data!

```
wwc_outcomes <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-09/wwc_outcomes.csv")
squads <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-09/squads.csv")
codes <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-09/codes.csv")
```

If you want to get full country names try out this code:
```
dplyr::left_join(wwc_outcomes, codes, by = "team")
```

# Data Dictionary

### `wwc_outcomes.csv`

|variable       |class     |description |
|:---|:---|:-----------|
|year           |double    | Year of tournament |
|team           |character | Abbreviated team |
|score          |double    | Score by team |
|round          |character | Round of the tournament |
|yearly_game_id |integer   | Grouping variable - pairs team 1 and team 2 by round/year |
|team_num       |double    | team num (1 or 2) |
|win_status     |character | Win Status = win/lose or tie (group only)|

### `squads.csv`

|variable |class     |description |
|:---|:---|:-----------|
|squad_no |double    | Squad number (1 through 23) |
|country  |character | Country |
|pos      |character | position |
|player   |character | Player name |
|dob      |date    |date of birth|
|age      |double    |age (years) |
|caps     |double    | caps - international games played |
|goals    |double    | Goals - international goals scored |
|club     |character | Professional Club |



## Cleaning script

```{r}
library(tidyverse)
library(here)
library(rvest)

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

url <- "https://simple.wikipedia.org/wiki/List_of_FIFA_country_codes"

html_content <- url %>% 
  read_html()

code_df <- html_content %>% 
  html_table(fill = TRUE) %>% .[[1]] %>% 
  select(1,2) %>% 
  slice(-1, -2) %>% 
  set_names(nm = c("country", "team"))

# output to csv
df_tidy %>% 
  write_csv(here("2019", "2019-07-09", "wwc_outcomes.csv"))

squads %>% 
  write_csv(here("2019", "2019-07-09", "squads.csv"))

code_df %>% 
  write_csv(here("2019", "2019-07-09", "codes.csv"))

# data dictionaries for TidyTuesday
tomtom::create_dictionary(df_tidy)
tomtom::create_dictionary(squads)


```