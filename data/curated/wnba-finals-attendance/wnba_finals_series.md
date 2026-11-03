|variable             |class    |description                                                                                           |
|:--------------------|:--------|:-----------------------------------------------------------------------------------------------------|
|year                 |integer  |Finals year.                                                                                          |
|teams                |character|The two Finals teams by abbreviation, in alphabetical order.                                          |
|champion             |character|Abbreviation of the team that won the series.                                                         |
|runner_up            |character|Abbreviation of the team that lost the series.                                                        |
|series_result        |character|Series wins for the champion and the runner-up, for example 3-2.                                      |
|games                |integer  |Number of games played in the series.                                                                 |
|games_with_attendance|integer  |Number of games in the series with a published attendance figure.                                     |
|total_attendance     |integer  |Sum of published attendance across the series (people).                                               |
|avg_per_game         |integer  |Total attendance divided by games with attendance, rounded to the nearest whole number (.5 rounds up).|
|max_game_attendance  |integer  |Largest single-game attendance in the series (people).                                                |
|min_game_attendance  |integer  |Smallest single-game attendance in the series (people).                                               |
|game_attendance      |character|Attendance for each game in game order (Game 1 first), separated by semicolons.                       |
|overtime_games       |integer  |Number of games in the series that went to overtime.                                                  |
|arenas               |character|Arenas used in the series, separated by semicolons.                                                   |
|notes                |character|Context for the series, if any.                                                                       |
|source_note          |character|How the row was compiled.                                                                             |
