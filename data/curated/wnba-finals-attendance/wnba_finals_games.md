|variable        |class    |description                                                                                                |
|:---------------|:--------|:----------------------------------------------------------------------------------------------------------|
|season          |integer  |Finals year.                                                                                               |
|game            |integer  |Game number within the series.                                                                             |
|date            |date     |Game date.                                                                                                 |
|away            |character|Away team abbreviation as shown on the official WNBA.com game record.                                      |
|away_score      |integer  |Away team final score in points.                                                                           |
|home            |character|Home team abbreviation as shown on the official WNBA.com game record.                                      |
|home_score      |integer  |Home team final score in points.                                                                           |
|winner          |character|Abbreviation of the team that won the game.                                                                |
|margin          |integer  |Winning margin in points.                                                                                  |
|overtime_periods|integer  |Number of overtime periods (0 for a game decided in regulation).                                           |
|arena           |character|Arena named on the game record.                                                                            |
|attendance      |integer  |Published attendance for the game (people); NA for the three 2020 bubble games, when no fans were admitted.|
|source_url      |character|URL of the official WNBA.com game record the row was taken from.                                           |
|note            |character|Context for the game, if any.                                                                              |
