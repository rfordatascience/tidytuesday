# NCAA Men's March Madness 

March is NCAA basketball March Madness! This week's data is [NCAA Men's March Madness data](https://www.kaggle.com/datasets/nishaanamin/march-madness-data) from Nishaan Amin's Kaggle dataset and analysis [Bracketology: predicting March Madness](https://www.kaggle.com/code/nishaanamin/bracketology-predicting-march-madness). 

[March Madness](https://en.wikipedia.org/wiki/NCAA_Division_I_men%27s_basketball_tournament) is the NCAA Division I basketball tournament for women and men. It's a single-elimination tournament of 68 teams that compete in six rounds for the national championship. (The "March Madness" branding and logo was only [extended to women in 2022](https://www.ncaa.com/news/basketball-women/article/2021-09-29/march-madness-brand-will-be-used-di-womens-basketball-championship).) 

Each round of the tournament has a name:

* First round: Round of 64
* Second round: Round of 32
* Third round: Sweet 16
* Fourth round: Elite 8
* Fifth round: Final 4
* Sixth round: Finals


>The data is from 2008 - 2024 for the men's teams. The year 2020 is not included because the tournament was canceled due to Covid. The first column of almost every dataset displays the year the data is from. 

Nishaan Amin's dataset contains many different sets of data. For TidyTuesday we're using past team results and the predictions the public has for this year's tournament. How have teams done in past years? What teams are people predicting will do well this year? How does past performance correlate with expectations for this year?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-03-26')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 13)

team_results <- tuesdata$`team-results`
public_picks <- tuesdata$`public-picks`


# Option 2: Read directly from GitHub

team_results <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/team-results.csv')
public_picks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-03-26/public-picks.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `team-results.csv`

|variable  |class     |description |
|:---------|:---------|:-----------|
|TEAMID   |integer   |Unique identifier for the team.     |
|TEAM      |character |Division I college basketball team name.        |
|PAKE      |double    |Performance against Komputer Expectations.        |
|PAKERANK |integer   |Rank of PAKE from all teams.   |
|PASE      |double    |Performance Against Seed Expectations.        |
|PASERANK |integer   |Rank of PASE from all teams.   |
|GAMES     |integer   |The total amount of tournament games the team has played.       |
|W         |integer   |The total amount of tournament game wins.           |
|L         |integer   |The total amount of tournament game losses.           |
|WINPERCENT      |double    |The winning percent of the team.        |
|R64       |integer   |Amount of times the team made it to the Round of 64.         |
|R32       |integer   |Amount of times the team made it to the Round of 32.       |
|S16       |integer   |Amount of times the team made it to the Sweet 16.         |
|E8        |integer   |Amount of times the team made it to the Elite 8.          |
|F4        |integer   |Amount of times the team made it to the Final 4.          |
|F2        |integer   |Amount of times the team made it to the Finals.        |
|CHAMP     |integer   |Amount of times the team was a Champion.       |
|TOP2      |integer   |Amount of times the team was awarded a 1 or 2 seed.        |
|F4PERCENT       |character |Likelihood of a team getting to at least 1 Final Four.         |
|CHAMPPERCENT    |character |Likelihood of a team winning at least 1 Championship (per efficiency rating).      |


# `public-picks.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|YEAR     |integer   |Ending year of the team's season        |
|TEAMNO  |integer   |Unique identifier for the team and the year they played in     |
|TEAM     |character |Division I college basketball team name.        |
|R64      |character |The percent of people who picked the team to win the game in the Round of 64.         |
|R32      |character |The percent of people who picked the team to win the game in the Round of 32.         |
|S16      |character |The percent of people who picked the team to win the game in the Sweet 16.       |
|E8       |character |The percent of people who picked the team to win the game in the Elite 8.     |
|F4       |character |The percent of people who picked the team to win the game in the Final 4.          |
|FINALS   |character |The percent of people who picked the team to win the game in the Finals.      |


### Cleaning Script

No cleaning. The files from [March Madness Data](https://www.kaggle.com/datasets/nishaanamin/march-madness-data) are `Team Results.csv` and `Public Picks.csv`.
