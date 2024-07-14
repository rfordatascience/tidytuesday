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
