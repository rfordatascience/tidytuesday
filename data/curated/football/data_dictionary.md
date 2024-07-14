### Data Dictionary

# `ewf_matches.csv`

|variable               |class      |description            |
|:----------------------|:----------|:----------------------|
| season_id             |character  |The unique ID for the season. Has the format `S-####-####-#-S`, where the first number is the year in which the season started, the second number is the year in which the season ended, and the third number is the tier.|
| season                |character  | The year(s) that the season started and ended. Has the format `####-####`, where the first number is the year in which the season started and the second number is the year in which the season ended.|
| tier                  |integer    | The division's tier in English football. Possible values are `1` or `2`.|
| division              |character  | The division name in English football.|
| match_id              |character  | The unique ID for the match. Has the format `M-####-####-#-###-M`, where the first number is the year in which the season started, the second number is the year in which the season ended, the third number is the tier, and the fourth number is a counter that is assigned to the data when sorted by the match's date, then by the name of the home team, and then by the name of the away team.|
| match_name            |character  | The name of the match, where the name of the home team and the name of the away team is separated by ' vs '.|
| date                  |character  | The date of the match, in ``dd/mm/yyyy`` format.|
| attendance            |character  | The total crowd attendance at the match. Note that this information is not available for some matches.|
| home_team_id          |character  | The unique ID for the home team. Has the format `T-###-T`.|
| home_team_name        |character  | The name of the home team at the match.|
| away_team_id          |character  | The unique ID for the away team. Has the format `T-###-T`.|
| away_team_name        |character  | The name of the away team at the match.|
| score                 |integer    | The score of the match. Has the format `# -- #`, where the first number is the score of the home team and the second number is the score of the away team.|
| home_team_score       |integer    | The score of the home team.|
| away_team_score       |integer    | The score of the away team.|
| home_team_score_margin|integer    | The score margin for the home team, equal to home_team_score minus away_team_score.|
| away_team_score_margin|integer    | The score margin for the away team, equal to away_team_score minus home_team_score.|
| home_team_win         |integer    | Whether the home team won the match. Possible values are `1` if the home team won the match and `0` otherwise.|
| away_team_win         |integer    | Whether the away team won the match. Possible values are `1` if the away team won the match and `0` otherwise.|
| draw                  |integer    | Whether the match ended in a draw. Possible values are `1` if the match ended in a draw and `0` otherwise.|
| result                |character  | The result of the match. Possible values are `Home team win`, `Away team win`, and `Draw`.|
| note                  |character  | A description of any mitigating circumstances. For example, if the match was not played and the win was instead awarded to the home or away team.|


# `ewf_appearances.csv`

|variable         |class      |description     |
|:----------------|:----------|:---------------|
| season_id       |character  | The unique ID for the season. Has the format `S-####-####-#-S`, where the first number is the year in which the season started, the second number is the year in which the season ended, and the third number is the tier.|
| season          |character  | The year(s) that the season started and ended. Has the format `####-####`, where the first number is the year in which the season started and the second number is the year in which the season ended.|
| tier            |integer    | The division's tier in English football. Possible values are `1` or `2`.|
| division        |character  | The division name in English football.|
| match_id        |character  | The unique ID for the match. Has the format `M-####-####-#-###-M`, where the first number is the year in which the season started, the second number is the year in which the season ended, the third number is the tier, and the fourth number is a counter that is assigned to the data when sorted by the match's date, then by the name of the home team, and then by the name of the away team. References `match_id` in the `ewf_matches` dataset.|
| match_name      |character  | The name of the match, where the name of the home team and the name of the away team is separated by ' vs '.|
| date            |character  | The date of the match, in ``dd/mm/yyyy`` format.|
| attendance      |character  | The total crowd attendance at the match. Note that this information is not available for some matches.|
| team_id         |character  | The unique ID for the team. Has the format `T-###-T`.|
| team_name       |character  | The name of the team at the match.|
| opponent_id| The unique ID for the team’s opponent. Has the format `T-###-T`.|
| opponent_name   |character  | The name of the team’s opponent at the match.|
| home_team       |integer    | Whether the team was the home team. Possible value are `1` if the team was the home team and `0` otherwise.|
| away_team       |integer    | Whether the team was the away team. Possible value are `1` if the team was the away team and `0` otherwise.|
| goals_for       |integer    | The number of goals scored by the team.|
| goals_against   |integer    | The number of goals scored against the team.|
| goal_difference |integer    | The number of goals scored by the team minus the number of goals scored against the team.|
| result          |character  | The result of the match. Possible values are `Win`, `Loss`, and `Draw`.|
| win             |integer    | Whether the team won the match. The possible values are `1` if the team won the match and `0` otherwise.|
| loss            |integer    | Whether the team lost the match. The possible values are `1` if the team lost the match and `0` otherwise.|
| draw            |integer    | Whether the match ended in a draw. The possible values are `1` if the match ended in a draw and `0` otherwise.|
| note            |character  | A description of any mitigating circumstances. For example, if the match was not played and the win was instead awarded to the home or away team.|
| points          |integer    | The number of points the team earned from the match. A team earns `0` points for a loss, `1` point for a draw, or `3` points for a win.|

# `ewf_standings.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
| season_id       |character | The unique ID for the season. Has the format `S-####-####-#-S`, where the first number is the year in which the season started, the second number is the year in which the season ended, and the third number is the tier.|
| season          |character | The year(s) that the season started and ended. Has the format `####-####`, where the first number is the year in which the season started and the second number is the year in which the season ended.|
| tier            |integer   | The division's tier in English football. Possible values are `1` or `2`.|
| division        |character | The division name in English football.|
| position        |integer   | The team's final position in the season.|
| team_id         |character | The unique ID for the team. Has the format `T-###-T`.|
| team_name       |character | The name of the team during the season.|
| played          |integer   | The number of matches that the team played.|
| wins            |integer   | The number of matches that the team won.|
| draws           |integer   | The number of matches that the team drew.|
| losses          |integer   | The number of matches that the team lost.|
| goals_for       |integer   | The number of goals scored by the team.|
| goals_against   |integer   | The number of goals scored against the team.|
| goal_difference |integer   | The number of goals scored by the team minus the number of goals scored against the team.|
| points          |integer   | The number of points that the team earned over the whole season (after applying `point_adjustment`).|
| point_adjustment|integer   | The number of points that were deducted by the league due to violations of rules or added by the league due to forfeits.|
| season_outcome  |character | The outcome for the team following the season. This variable is included to track the movement of teams across seasons more easily. Possible values are `Club folded`, `No change` for when the team remains in their current tier, `Promoted to tier 1` for when the team moves into tier 1 from a lower tier, `Relegated to tier 2` for when the team moves into tier 2 from a higher tier, and `Relegated to tier 3` for when the team moves into tier 3 from a higher tier, and `Relegated to tier 5` for when the team moves into tier 5 from a higher tier.|