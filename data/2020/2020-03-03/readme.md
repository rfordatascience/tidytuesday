![Hockey net on ice](https://images.unsplash.com/photo-1515703407324-5f753afd8be8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2167&q=80)

# Hockey Goals

The data this week comes from [HockeyReference.com](https://www.hockey-reference.com/leaders/goals_career.html). We have overall career goals (`top_250.csv`), season level goals (`season_goals.csv`), game level goals (`game_goals.csv`).

If you'd like to go beyond season or game-level data, check out [MoneyPuck.com](http://moneypuck.com/data.htm) for shot-level data or additional game/season level data from 2007-current. 

This week's data visualization and article come from the [Washington Post](https://www.washingtonpost.com/graphics/2020/sports/capitals/ovechkin-700-goals/?utm_campaign=wp_graphics&utm_medium=social&utm_source=twitter). They examined Alex Ovechkin's career as he broke the 700 career goals mark. "Alexendar the Great" is already top 8 in goals all-time, and is only 34 years old. If he can keep his pace for a few more years, he has a shot at becoming the overall record holder for most goals in a career, potentially breaking Wayne Gretzky's long-standing career goals record of 894.

### Get the data here

```{r}
# Get the Data

game_goals <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/game_goals.csv')

top_250 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/top_250.csv')

season_goals <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/season_goals.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version ? from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-03-03')
tuesdata <- tidytuesdayR::tt_load(2020, week = 10)


game_goals <- tuesdata$game_goals
```
### Data Dictionary

# `top_250.csv`

Please note this is the top 250 goal scorers as found [here](https://www.hockey-reference.com/leaders/goals_career.html).

|variable    |class     |description |
|:-----------|:---------|:-----------|
|raw_rank    |double    | Rank of goals (blank if duplicate) |
|player      |character | Player Name |
|years       |character | Years active (start - end) |
|total_goals |double    | Total goals scored in the NHL |
|url_number  |double    | Number for URL |
|raw_link    |character | Raw player ID |
|link        |character | Link to player details on hockeyreference.com |
|active      |character | Status: If still playing = Active, if retired = retired|
|yr_start    |double    |First year in the NHL |

# `game_goals.csv`

Goals for each player and each game (only for players who started at or after 1979-80 season). This is due to limited game-level data prior to 1980.

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|player            |character | Player name |
|season            |double    | Season year |
|rank              |double    | Rank equivalent to game_num for most |
|date              |double    | Date of game (ISO format) |
|game_num          |double    | Game number within each season|
|age               |character | Age in year-days|
|team              |character | NHL team |
|at                |character | At: blank if at home, @ if at the opponent arena |
|opp               |character | Opponent |
|location          |character | Location = location of game (home or away) |
|outcome           |character | Outcome = Won, Loss, Tie |
|goals             |double    | Goals Scored by player|
|assists           |double    | Assists - helped with goal for other player |
|points            |double    | Points - Sum of goals + assists |
|plus_minus        |double    | Plus Minus - Team points minus opponents points scored while on ice|
|penalty_min       |double    | Penalty minutes - minutes spent in penalty box |
|goals_even        |double    | Goals scored while even-strength |
|goals_powerplay   |double    | Goals scored on powerplay |
|goals_short       |double    | Goals scored while short-handed|
|goals_gamewinner  |double    | Goals that were gamewinner|
|assists_even      |double    | Assists while even strength|
|assists_powerplay |double    | Assists on powerplay|
|assists_short     |double    | Assists on shorthanded|
|shots             |double    | Shots|
|shot_percent      |double    | Shot percent (goals/shots)|

# `season_goals.csv`

|variable           |class     |description |
|:------------------|:---------|:-----------|
|rank               |double    |Overall goals ranking (1 - 250)|
|position           |character | Position = player position (C = center, RW = Right Wing, LW = left Wing)|
|hand               |character |Dominant hand (left or right) |
|player             |character | Player name|
|years              |character | Season years (year-yr)|
|total_goals        |double    | Total goals scored in career |
|status             |character |Status = retired or active|
|yr_start           |double    | year started in NHL|
|season             |character | Specific season for the player|
|age                |double    |Age during season|
|team               |character | Team during season |
|league             |character |League during season|
|season_games       |double    |Games played in the season|
|goals              |double    |Goals scored in the season|
|assists            |double    |Assists in the season|
|points             |double    |Points in the season|
|plus_minus         |double    | Plus Minus in the season - Team points minus opponents points scored while on ice|
|penalty_min        |double    |Penalty Minutes in the season |
|goals_even         |double    |Goals scored while even strength in a season|
|goals_power_play   |double    |Goals scored on powerplay in a season|
|goals_short_handed |double    |Goals short handed in a season|
|goals_game_winner  |double    |Goals that were game winner in a season|
|headshot           |character | Player headshot (URL to image of their head) |

### Cleaning Script

