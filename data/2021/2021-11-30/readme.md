### Please add alt text to your posts

Please add alt text (alternative text) to all of your posted graphics for `#TidyTuesday`. 

Twitter provides [guidelines](https://help.twitter.com/en/using-twitter/picture-descriptions) for how to add alt text to your images.

The DataViz Society/Nightingale by way of Amy Cesal has an [article](https://medium.com/nightingale/writing-alt-text-for-data-visualization-2a218ef43f81) on writing _good_ alt text for plots/graphs.

[Cricket from Wikipedia](https://en.wikipedia.org/wiki/Cricket)

> Here’s a simple formula for writing alt text for data visualization:
> ### Chart type
> It’s helpful for people with partial sight to know what chart type it is and gives context for understanding the rest of the visual.
> Example: Line graph
> ### Type of data
> What data is included in the chart? The x and y axis labels may help you figure this out.
> Example: number of bananas sold per day in the last year
> ### Reason for including the chart
> Think about why you’re including this visual. What does it show that’s meaningful. There should be a point to every visual and you should tell people what to look for.
> Example: the winter months have more banana sales
> ### Link to data or source
> Don’t include this in your alt text, but it should be included somewhere in the surrounding text. People should be able to click on a link to view the source data or dig further into the visual. This provides transparency about your source and lets people explore the data.
> Example: Data from the USDA

Penn State has an [article](https://accessibility.psu.edu/images/charts/) on writing alt text descriptions for charts and tables.

> Charts, graphs and maps use visuals to convey complex images to users. But since they are images, these media provide serious accessibility issues to colorblind users and users of screen readers. See the [examples on this page](https://accessibility.psu.edu/images/charts/) for details on how to make charts more accessible.

The `{rtweet}` package includes the [ability to post tweets](https://docs.ropensci.org/rtweet/reference/post_tweet.html) with alt text programatically.

Need a **reminder**? There are [extensions](https://chrome.google.com/webstore/detail/twitter-required-alt-text/fpjlpckbikddocimpfcgaldjghimjiik/related) that force you to remember to add Alt Text to Tweets with media.

# Cricket

The data this week comes from [ESPN Cricinfo](https://www.espncricinfo.com/) by way of [Hassanasir](https://github.com/hassannasir).

> Cricket is a bat-and-ball game played between two teams of eleven players on a field at the centre of which is a 22-yard (20-metre) pitch with a wicket at each end, each comprising two bails balanced on three stumps. The game proceeds when a player on the fielding team, called the bowler, "bowls" (propels) the ball from one end of the pitch towards the wicket at the other end. The batting side's players score runs by striking the bowled ball with a bat and running between the wickets, while the bowling side tries to prevent this by keeping the ball within the field and getting it to either wicket, and dismiss each batter (so they are "out"). Means of dismissal include being bowled, when the ball hits the stumps and dislodges the bails, and by the fielding side either catching a hit ball before it touches the ground, or hitting a wicket with the ball before a batter can cross the crease line in front of the wicket to complete a run. When ten batters have been dismissed, the innings ends and the teams swap roles. The game is adjudicated by two umpires, aided by a third umpire and match referee in international matches.

> A One Day International (ODI) is a form of limited overs cricket, played between two teams with international status, in which each team faces a fixed number of overs, currently 50, with the game lasting up to 9 hours.[1][2] The Cricket World Cup, generally held every four years, is played in this format. One Day International matches are also called Limited Overs Internationals (LOI), although this generic term may also refer to Twenty20 International matches. They are major matches and considered the highest standard of List A, limited-overs competition.

> The Cricket World Cup (officially known as ICC Men's Cricket World Cup)[2] is the international championship of One Day International (ODI) cricket. The event is organised by the sport's governing body, the International Cricket Council (ICC), every four years, with preliminary qualification rounds leading up to a finals tournament. The tournament is one of the world's most viewed sporting events and is considered the "flagship event of the international cricket calendar" by the ICC

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-11-30')
tuesdata <- tidytuesdayR::tt_load(2021, week = 49)

matches <- tuesdata$matches

# Or read in the data manually

matches <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-11-30/matches.csv')

```
### Data Dictionary

# `matches.csv`

|Field                |Type      |Description                                                                                                                                                                                              |
|:--------------------|:---------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|match_id             |Character |Match ID as per ESPN Cric Info                                                                                                                                                                           |
|team1                |Character |Team playing first                                                                                                                                                                                       |
|team2                |Character |Team playing second                                                                                                                                                                                      |
|score_team1          |Number    |Team one score                                                                                                                                                                                           |
|score_team2          |Number    |team one score                                                                                                                                                                                           |
|wickets_team2        |Number    |wickets fallen for team one; if 10 it means all out.                                                                                                                                                     |
|wickets_team         |Number    |wickets fallen for team one; if 10 it means all out.                                                                                                                                                     |
|team1_away_or_home   |Character |Whether team 1 was playing at home or away                                                                                                                                                               |
|team2_home_away      |Character |Whether team 2 was playing at                                                                                                                                                                            |
|winner               |Character |who won the match/match result                                                                                                                                                                           |
|margin               |Number    |what was the margin of the victory.                                                                                                                                                                      |
|margin_type          |Character |what was the type of margin of victory; if team playing first one, then it's recorded as runs by which it one, if team playing second won, they it's number of wickets they won by.                      |
|time_of_day          |Character |Day or Day and Night. (Day matches start in the morning and finish by/before sunset. Day and night matches start in the afternoon continue late in the evening; flood lights are used after the sunset). |
|series               |Character |Name of the series.                                                                                                                                                                                      |
|player_of_match      |Character |Who was given player of the match.                                                                                                                                                                       |
|player_of_match_team |Character |Which team did the player of match belong. Mostly player of the match belongs to the winning team; but rarely it's given to a player from the loosing team, if his performance was outstanding).         |
|venue                |Character |What was ground name.                                                                                                                                                                                    |
|toss                 |Character |Who won the toss.                                                                                                                                                                                        |
|toss_decision        |Character |What decision did the toss winning team made.                                                                                                                                                            |
|ball_remaining       |Character |how many balls were remaining.                                                                                                                                                                           |
|ground               |Character |What was the name of the ground (Cricinfo has both ground and venue details so I kept them here).                                                                                                        |
|ground_city          |Character |City of the Ground.                                                                                                                                                                                      |
|ground_country       |Character |Country of the ground.                                                                                                                                                                                   |
|match_date           |Character |Match date - some matches were played over two days so dates are included for both dates; for analysis either of the date can be taken).                                                                 |

### Cleaning Script

