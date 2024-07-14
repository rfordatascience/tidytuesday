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


