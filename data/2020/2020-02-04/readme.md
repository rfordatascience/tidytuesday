![Empty NFL Stadium](https://images.unsplash.com/photo-1567459168600-af170863ed5e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1349&q=80)

# NFL Stadium Attendance

The data this week comes from Pro Football Reference [team standings](https://www.pro-football-reference.com/years/2019/index.htm). Additional data on attendance also comes from Pro Football Reference [here](https://www.pro-football-reference.com/years/2019/attendance.htm).


### Get the data here

```{r}
# Get the Data

attendance <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/attendance.csv')
standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/standings.csv')
games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-04/games.csv')

# Or read in with tidytuesdayR package (https://github.com/thebioengineer/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO UPDATE tidytuesdayR from GitHub

# Either ISO-8601 date or year/week works!

# Install via devtools::install_github("thebioengineer/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-02-04') 
tuesdata <- tidytuesdayR::tt_load(2020, week = 6)


attendance <- tuesdata$attendance
```
### Data Dictionary

These can be joined relatively nicely with `dplyr::left_join(by = c("year", "team_name", "team"))`

# `attendance.csv`


|variable          |class     |description |
|:-----------------|:---------|:-----------|
|team              |character | Team City |
|team_name         |character | Team name |
|year              |integer   | Season year|
|total             |double    | total attendance across 17 weeks (1 week = no game) |
|home              |double    | Home attendance |
|away              |double    | Away attendance |
|week              |character | Week number (1-17)|
|weekly_attendance |double    | Weekly attendance number |

# `standings.csv`

|variable             |class     |description |
|:--------------------|:---------|:-----------|
|team                 |character | Team city |
|team_name            |character | Team name|
|year                 |integer   | season year |
|wins                 |double    | Wins (0 to 16)|
|loss                 |double    | Losses (0 to 16) |
|points_for           |double    | points for (offensive performance) |
|points_against       |double    | points for (defensive performance) |
|points_differential  |double    | Point differential (points_for - points_against) |
|margin_of_victory    |double    | (Points Scored - Points Allowed)/ Games Played |
|strength_of_schedule |double    | Average quality of opponent as measured by SRS (Simple Rating System) |
|simple_rating        |double    |Team quality relative to average (0.0) as measured by SRS (Simple Rating System) <br> SRS = MoV + SoS = OSRS + DSRS |
|offensive_ranking    |double    | Team offense quality relative to average (0.0) as measured by SRS (Simple Rating System)|
|defensive_ranking    |double    | Team defense quality relative to average (0.0) as measured by SRS (Simple Rating System) |
|playoffs             |character | Made playoffs or not |
|sb_winner            |character | Won superbowl or not |

# `games.csv`

|variable       |class     |description |
|:--------------|:---------|:-----------|
|year           |integer   | season year, note that playoff games will still be in the previous season |
|week           |character | week number (1-17, plus playoffs) |
|home_team      |character | Home team |
|away_team      |character | Away team|
|winner         |character | Winning team |
|tie            |character | If a tie, the "losing" team as well |
|day            |character | Day of week |
|date           |character | Date minus year |
|time           |character | Time of game start |
|pts_win        |double    | Points by winning team |
|pts_loss       |double    |Points by losing team |
|yds_win        |double    | Yards by winning team |
|turnovers_win  |double    | Turnovers by winning team |
|yds_loss       |double    | Yards by losing team |
|turnovers_loss |double    | Turnovers by losing team |
|home_team_name |character | Home team name |
|home_team_city |character | Home team city |
|away_team_name |character | Away team name |
|away_team_city |character | Away team city |
