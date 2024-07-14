|variable               |class      |description            |
|:----------------------|:----------|:----------------------|
| season_id             |character  |The unique ID for the season. Has the format `S-####-####-#-S`, where the first number is the year in which the season started, the second number is the year in which the season ended, and the third number is the tier.|
| season                |character  | The year(s) that the season started and ended. Has the format `####-####`, where the first number is the year in which the season started and the second number is the year in which the season ended.|
| tier                  |integer    | The division's tier in English football. Possible values are `1` or `2`.|
| division              |character  | The division name in English football.|
| match_id              |character  | The unique ID for the match. Has the format `M-####-####-#-###-M`, where the first number is the year in which the season started, the second number is the year in which the season ended, the third number is the tier, and the fourth number is a counter that is assigned to the data when sorted by the match's date, then by the name of the home team, and then by the name of the away team.|
| match_name            |character  | The name of the match, where the name of the home team and the name of the away team is separated by ' vs '.|
| date                  |date  | The date of the match, in `yyyy-mm-dd` format.|
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
