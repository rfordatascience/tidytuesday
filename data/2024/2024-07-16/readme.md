# English Women's Football

<!-- 
1. Describe the dataset. See previous weeks for the general format
of the DESCRIPTION. The description is the part of the readme.md file above "The
Data"; everything else will be filled in from the other md files in this
directory + automatic scripts. We usually include brief introduction along the lines of "This week we're exploring DATASET" or "The dataset this week comes from SOURCE", then a quote starting with ">", then a few questions participants might seek to answer using the data.
2. Delete this comment block.
--> 

Thanks to [Rob Clapp](https://github.com/probjects) for the [The English Women's Football (EWF) Database, May 2024](https://github.com/probjects/ewf-database) dataset this week, and h/t [Data is Plural](https://www.data-is-plural.com/archive/2024-06-12-edition/). The dataset lists the date, teams, score, attendance, division, tier, and season of each match, as well as each season’s final standings. Rob took inspiration from the [Fjelstul English Football Database](https://github.com/jfjelstul/englishfootball), a similarly structured dataset that covers men's professional football since 1888.

> The English Women's Football (EWF) Database is an open database of matches played in the top tiers of women's football in England. It covers all matches played since the 2011 season for the highest division (the Women's Super League) and since the 2014 season for the second-highest division (the Women's Championship).

The dataset contains three datasets:

- ewf_matches contains all matches that have been played and has one observation per match per season.
- ewf_appearances contains all appearances by a team and has one observation per team per match per season.
- ewf_standings contains all end-of-the-season division tables and has one observation per team per season.

> The data in the English Women's Football (EWF) Database has been collected from multiple online sources and has been cross-referenced to confirm its accuracy. Information in the database is also cross-referenced with itself to ensure consistency. For example, that a team's goals_for at the end of the season in ewf_standings is equal to the number of goals they have scored across all games played in ewf_matches.

> Each team has been given a unique ID in the format of T-###-T. This is to enable the tracking of team performance across multiple seasons, as most teams have changed their name over time. For example, Arsenal Ladies became Arsenal Women before the start of the 2017-2018 season, but the same ID is used for them throughout the database (T-001-T). The name of the team in each dataset is the name of the team at the time. Any generic terms such as 'Football Club' or 'F.C.' have been removed. Reference to 'Women' or 'Ladies' is included in the team name, where applicable, to indicate changes that have occurred. However, most teams do not explicitly reference 'Women' or 'Ladies' in their name unless it is to distinguish between the male and female teams.



## The Data

```r
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-07-16')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 29)

ewf_appearances <- tuesdata$ewf_appearances
ewf_matches <- tuesdata$ewf_matches
ewf_standings <- tuesdata$ewf_standings

# Option 2: Read directly from GitHub

ewf_appearances <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_appearances.csv')
ewf_matches <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_matches.csv')
ewf_standings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-16/ewf_standings.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `ewf_appearances.csv`

|variable         |class      |description     |
|:----------------|:----------|:---------------|
| season_id       |character  | The unique ID for the season. Has the format `S-####-####-#-S`, where the first number is the year in which the season started, the second number is the year in which the season ended, and the third number is the tier.|
| season          |character  | The year(s) that the season started and ended. Has the format `####-####`, where the first number is the year in which the season started and the second number is the year in which the season ended.|
| tier            |integer    | The division's tier in English football. Possible values are `1` or `2`.|
| division        |character  | The division name in English football.|
| match_id        |character  | The unique ID for the match. Has the format `M-####-####-#-###-M`, where the first number is the year in which the season started, the second number is the year in which the season ended, the third number is the tier, and the fourth number is a counter that is assigned to the data when sorted by the match's date, then by the name of the home team, and then by the name of the away team. References `match_id` in the `ewf_matches` dataset.|
| match_name      |character  | The name of the match, where the name of the home team and the name of the away team is separated by ' vs '.|
| date            |date  | The date of the match, in `yyyy-mm-dd` format.|
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

# `ewf_matches.csv`

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

### Cleaning Script

```r
# Clean data provided by the [English Womens Football (EWF)
# Database](https://github.com/probjects/ewf-database). No cleaning was
# necessary, but the files were resaved to simplify the csvs.
ewf_appearances <- readr::read_csv(
  "https://raw.githubusercontent.com/probjects/ewf-database/main/data/ewf_appearances.csv"
)
ewf_matches <- readr::read_csv(
  "https://raw.githubusercontent.com/probjects/ewf-database/main/data/ewf_matches.csv"
)
ewf_standings <- readr::read_csv(
  "https://raw.githubusercontent.com/probjects/ewf-database/main/data/ewf_standings.csv"
)
```
