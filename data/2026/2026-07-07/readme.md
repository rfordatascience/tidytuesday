# UFC Athletes and Fight Data

This week we're stepping into the Octagon to explore Ultimate Fighting Championship (UFC) data! 

The data this week comes from the [`{fightr}` R package](https://github.com/benyamindsmith/fightr), which compiles a collection of datasets from UFC athlete profiles, [UFCStats](http://ufcstats.com/), [Kaggle](https://www.kaggle.com/datasets/mdabbert/ultimate-ufc-dataset), and the [Octagon API](https://www.octagon-api.com/). 

> The `fightr` package provides a comprehensive, historical dataset of Ultimate Fighting Championship (UFC) bouts and athlete-level profile information. It tracks divisional and pound-for-pound rankings over time, career records, physical attributes, fighting styles, gym affiliations, and summarized performance statistics, offering a longitudinal view of a fighter's status and performance within the promotion.

Here are a few questions you might want to try and answer with this week's data:

- How do physical attribute advantages such as height, reach, or age differences (`reach_dif`, `age_dif`) correlate with the likelihood of winning a bout?
- How has the distribution of fight finishes (KO/TKO vs. Submission vs. Decision) evolved over the history of the UFC?
- Is there a discernible relationship between a fighter's historical striking/takedown accuracy and their peak divisional ranking?
- How accurate are the betting odds (`r_ev`, `b_ev`) at predicting the actual winner of a title bout?

Thank you to [Benjamin Smith](https://github.com/benyamindsmith) for curating this week's dataset.

## The Data

```r
# Using R
# Option 1: tidytuesdayR R package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2026-07-07')
## OR
tuesdata <- tidytuesdayR::tt_load(2026, week = 27)

ufc_athletes <- tuesdata$ufc_athletes
ufc_fights <- tuesdata$ufc_fights
ufc_rankings_dataset <- tuesdata$ufc_rankings_dataset
ufcstats_data <- tuesdata$ufcstats_data
ultimate_ufc_dataset <- tuesdata$ultimate_ufc_dataset

# Option 2: Read directly from GitHub

ufc_athletes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_athletes.csv')
ufc_fights <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_fights.csv')
ufc_rankings_dataset <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_rankings_dataset.csv')
ufcstats_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufcstats_data.csv')
ultimate_ufc_dataset <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ultimate_ufc_dataset.csv')
```

```python
# Using Python
# Option 1: pydytuesday python library
## pip install pydytuesday

import pydytuesday

# Download files from the week, which you can then read in locally
pydytuesday.get_date('2026-07-07')

# Option 2: Read directly from GitHub and assign to an object

ufc_athletes = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_athletes.csv')
ufc_fights = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_fights.csv')
ufc_rankings_dataset = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_rankings_dataset.csv')
ufcstats_data = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufcstats_data.csv')
ultimate_ufc_dataset = pandas.read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ultimate_ufc_dataset.csv')
```

```julia
# Using Julia
# Option 1: TidierTuesday.jl library
## Pkg.add(url="https://github.com/TidierOrg/TidierTuesday.jl")

using TidierTuesday

# Download datasets for the week, and load them as a NamedTuple of DataFrames
data = tt_load("2026-07-07")

# Option 2: Read directly from GitHub and assign to an object with TidierFiles

ufc_athletes = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_athletes.csv")
ufc_fights = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_fights.csv")
ufc_rankings_dataset = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_rankings_dataset.csv")
ufcstats_data = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufcstats_data.csv")
ultimate_ufc_dataset = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ultimate_ufc_dataset.csv")

# Option 3: Read directly from Github and assign without Tidier dependencies
ufc_athletes = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_athletes.csv", DataFrame)
ufc_fights = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_fights.csv", DataFrame)
ufc_rankings_dataset = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufc_rankings_dataset.csv", DataFrame)
ufcstats_data = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ufcstats_data.csv", DataFrame)
ultimate_ufc_dataset = CSV.read("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-07-07/ultimate_ufc_dataset.csv", DataFrame)
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [Quarto](https://quarto.org/) report, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R, Python, or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.
- [Submit your own dataset!](../../../pr_instructions.md)

### PydyTuesday: A Posit collaboration with TidyTuesday

- Exploring the TidyTuesday data in Python? Posit has some extra resources for you! Have you tried making a [Quarto dashboard](https://quarto.org/docs/dashboards/)? Find videos and other resources in [Posit's PydyTuesday repo](https://github.com/posit-dev/python-tidytuesday-challenge).
- Share your work with the world using the hashtags #TidyTuesday and #PydyTuesday so that Posit has the chance to highlight your work, too!
- Deploy or share your work however you want! If you'd like a super easy way to publish your work, give [Connect Cloud](https://connect.posit.cloud/) a try.

## Data Dictionary

### `ufc_athletes.csv`

|variable              |class     |description                           |
|:---------------------|:---------|:-------------------------------------|
|name                  |character |Athlete name as listed in the dataset.|
|nickname              |character |Athlete nickname, where available. |
|weight_class          |character |Athlete's listed UFC weight class. |
|url                   |character |URL for the athlete's UFC profile page. |
|profile_name          |character |Athlete name as shown on the UFC profile page. |
|profile_nickname      |character |Athlete nickname as shown on the UFC profile page, where available. |
|status                |character |Athlete status, such as '"Active"' or '"Not Fighting"'. |
|place_of_birth        |character |Athlete's listed place of birth. |
|age                   |double    |Athlete age in years, where available. |
|height                |double    |Athlete height in inches, where available. |
|weight                |double    |Athlete listed weight in pounds, where available. |
|octagon_debut         |date      |Date of the athlete's UFC debut, where available. |
|sig_strikes_landed    |double    |Total significant strikes landed in UFC competition. |
|sig_strikes_attempted |double    |Total significant strikes attempted in UFC competition. |
|sig_str_landed        |double    |Significant strikes landed per minute. |
|sig_str_absorbed      |double    |Significant strikes absorbed per minute. |
|takedown_avg          |double    |Average takedowns landed per 15 minutes. |
|submission_avg        |double    |Average submission attempts per 15 minutes. |
|sig_str_defense       |double    |Significant strike defense rate, expressed as a proportion. |
|takedown_defense      |double    |Takedown defense rate, expressed as a proportion. |
|knockdown_avg         |double    |Average knockdowns landed per 15 minutes. |
|average_fight_time    |Period    |Athlete's average UFC fight time, where available. |
|takedowns_attempted   |double    |Total takedown attempts in UFC competition, where available. |
|fighting_style        |character |Athlete's listed fighting style, where available. |
|reach                 |double    |Athlete reach in inches, where available. |
|leg_reach             |double    |Athlete leg reach in inches, where available. |
|takedowns_landed      |double    |Total takedowns landed in UFC competition, where available. |
|trains_at             |character |Athlete's listed gym or training affiliation, where available. |
|wins                  |character |Athlete's listed career wins. |
|losses                |character |Athlete's listed career losses. |
|draws                 |character |Athlete's listed career draws. |
|standing_count        |double    |Number of significant strikes landed at distance. |
|standing_pct          |double    |Proportion of significant strikes landed at distance. |
|clinch_count          |double    |Number of significant strikes landed in the clinch. |
|clinch_percent        |double    |Proportion of significant strikes landed in the clinch. |
|ground_count          |double    |Number of significant strikes landed on the ground. |
|ground_percent        |double    |Proportion of significant strikes landed on the ground. |
|ko_tko_win            |double    |Number of wins by knockout or technical knockout. |
|ko_tko_percent        |double    |Proportion of wins by knockout or technical knockout. |
|dec_wins              |double    |Number of wins by decision. |
|dec_percent           |double    |Proportion of wins by decision. |
|sub_wins              |double    |Number of wins by submission. |
|sub_percent           |double    |Proportion of wins by submission. |

### `ufc_fights.csv`

|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|fight_url            |character |URL for the fight details page on [http://ufcstats.com/](http://ufcstats.com/) |
|event_name           |character |Event Name |
|date                 |date      |Date of the UFC event. |
|location             |character |Event location, usually formatted as city and country or city and state. |
|f1_name              |character |Name of the first listed fighter. |
|f1_result            |character |Result for the first listed fighter, typically "W" for win or "L" for loss. Missing for scheduled or incomplete bouts. |
|f2_name              |character |Name of the second listed fighter. |
|f2_result            |character |Result for the second listed fighter, typically "W" for win or "L" for loss. Missing for scheduled or incomplete bouts. |
|weight_class         |character | Weight class or bout category, such as "Bantamweight Bout" or "Heavyweight Bout". |
|method               |character |Method of victory, such as "Decision - Unanimous", "KO/TKO", or "Submission". Missing for scheduled or incomplete bouts. |
|round                |double    |Round in which the fight ended. Missing for scheduled or incomplete bouts. |
|time                 |Period    |Time elapsed in the final round when the fight ended. Missing for scheduled or incomplete bouts. |
|time_format          |character |Scheduled fight format, such as "3 Rnd (5-5-5)" or "5 Rnd (5-5-5-5-5)". |
|referee              |character |Name of the referee. Missing for scheduled or incomplete bouts. |
|judging_details      |character | Judges' score card details; If fight ends with a KO, TKO or Submission, details are provided|

### `ufc_rankings_dataset.csv`

|variable    |class     |description                           |
|:-----------|:---------|:-------------------------------------|
|date        |character |The date the ranking was published (YYYY-MM-DD). |
|weightclass |character |The weight division or ranking category (e.g., "Pound-for-Pound", "Heavyweight", "Women's Strawweight"). |
|fighter     |character |The name of the fighter. |
|rank        |double    |The fighter's numerical rank in the specified weight class on that date. A rank of '0' typically designates the reigning Champion. |

### `ufcstats_data.csv`

|variable |class     |description                           |
|:--------|:---------|:-------------------------------------|
|name     |character |Fighter name as listed on [http://ufcstats.com/](http://ufcstats.com/). |
|wins     |double    |Number of career wins listed for the fighter. |
|losses   |double    |Number of career losses listed for the fighter. |
|draws    |double    |Number of career draws listed for the fighter. |
|nc       |double    |Number of no-contest results listed for the fighter. |
|height   |double    |Fighter height in inches, where available. |
|weight   |double    |Fighter listed weight in pounds, where available. |
|reach    |double    |Fighter reach in inches, where available. |
|stance   |character |Fighter stance, such as "Orthodox", "Southpaw", or "Switch", where available. |
|dob      |date      |Fighter date of birth, where available. |
|s_lp_m   |double    |Significant strikes landed per minute. |
|str_acc  |double    |Significant striking accuracy, expressed as a proportion. |
|s_ap_m   |double    |Significant strikes absorbed per minute. |
|str_def  |double    |Significant strike defense, expressed as a proportion. |
|td_avg   |double    |Average takedowns landed per 15 minutes. |
|td_acc   |double    |Takedown accuracy, expressed as a proportion. |
|td_def   |double    |Takedown defense, expressed as a proportion. |
|sub_avg  |double    |Average submission attempts per 15 minutes. |

### `ultimate_ufc_dataset.csv`

|variable |class |description |
|:----------------------------|:---------|:-------------------------------------|
|r_fighter |character |The name of the fighter in the Red corner. |
|b_fighter |character |The name of the fighter in the Blue corner. |
|r_odds |double |Moneyline betting odds (American format) for the Red fighter. |
|b_odds |double |Moneyline betting odds (American format) for the Blue fighter. |
|r_ev |double |Expected value for a $100 wager on the Red fighter. |
|b_ev |double |Expected value for a $100 wager on the Blue fighter. |
|date |character |The date the bout took place (YYYY-MM-DD). |
|location |character |The city, state/province, and country where the event was held. |
|country |character |The country where the event was held. |
|winner |character |The corner that won the bout ("Red" or "Blue"). |
|title_bout |logical |Logical indicator if the bout was for a championship title. |
|weight_class |character |The weight division the bout was contested in. |
|gender |character |The gender category of the bout (MALE or FEMALE). |
|no_of_rounds |double |The scheduled number of rounds for the bout (typically 3 or 5). |
|b_current_lose_streak |double |Current consecutive losing streak prior to the bout for the Blue fighter. |
|b_current_win_streak |double |Current consecutive winning streak prior to the bout for the Blue fighter. |
|b_draw |double |Total historical UFC draws strictly prior to the current bout for the Blue fighter. |
|b_avg_sig_str_landed |double |Average significant strikes landed per minute by the Blue fighter. |
|b_avg_sig_str_pct |double |Historical significant strike accuracy percentage for the Blue fighter. |
|b_avg_sub_att |double |Average submission attempts per 15 minutes by the Blue fighter. |
|b_avg_td_landed |double |Average takedowns landed per 15 minutes by the Blue fighter. |
|b_avg_td_pct |double |Historical takedown accuracy percentage for the Blue fighter. |
|b_longest_win_streak |double |Longest winning streak in the Blue fighter's UFC career. |
|b_losses |double |Total historical UFC losses strictly prior to the current bout for the Blue fighter. |
|b_total_rounds_fought |double |Total number of rounds fought in the UFC prior to the bout by the Blue fighter. |
|b_total_title_bouts |double |Total number of title bouts the Blue fighter has competed in. |
|b_win_by_decision_majority |double |Career wins by majority decision for the Blue fighter. |
|b_win_by_decision_split |double |Career wins by split decision for the Blue fighter. |
|b_win_by_decision_unanimous |double |Career wins by unanimous decision for the Blue fighter. |
|b_win_by_ko_tko |double |Career wins by knockout or technical knockout for the Blue fighter. |
|b_win_by_submission |double |Career wins by submission for the Blue fighter. |
|b_win_by_tko_doctor_stoppage |double |Career wins by doctor stoppage for the Blue fighter. |
|b_wins |double |Total historical UFC wins strictly prior to the current bout for the Blue fighter. |
|b_stance |character |The fighting stance of the Blue fighter (e.g., Orthodox, Southpaw, Switch). |
|b_height_cms |double |Blue fighter height in centimeters. |
|b_reach_cms |double |Blue fighter reach in centimeters. |
|b_weight_lbs |double |Blue fighter weigh-in weight in pounds. |
|r_current_lose_streak |double |Current consecutive losing streak prior to the bout for the Red fighter. |
|r_current_win_streak |double |Current consecutive winning streak prior to the bout for the Red fighter. |
|r_draw |double |Total historical UFC draws strictly prior to the current bout for the Red fighter. |
|r_avg_sig_str_landed |double |Average significant strikes landed per minute by the Red fighter. |
|r_avg_sig_str_pct |double |Historical significant strike accuracy percentage for the Red fighter. |
|r_avg_sub_att |double |Average submission attempts per 15 minutes by the Red fighter. |
|r_avg_td_landed |double |Average takedowns landed per 15 minutes by the Red fighter. |
|r_avg_td_pct |double |Historical takedown accuracy percentage for the Red fighter. |
|r_longest_win_streak |double |Longest winning streak in the Red fighter's UFC career. |
|r_losses |double |Total historical UFC losses strictly prior to the current bout for the Red fighter. |
|r_total_rounds_fought |double |Total number of rounds fought in the UFC prior to the bout by the Red fighter. |
|r_total_title_bouts |double |Total number of title bouts the Red fighter has competed in. |
|r_win_by_decision_majority |double |Career wins by majority decision for the Red fighter. |
|r_win_by_decision_split |double |Career wins by split decision for the Red fighter. |
|r_win_by_decision_unanimous |double |Career wins by unanimous decision for the Red fighter. |
|r_win_by_ko_tko |double |Career wins by knockout or technical knockout for the Red fighter. |
|r_win_by_submission |double |Career wins by submission for the Red fighter. |
|r_win_by_tko_doctor_stoppage |double |Career wins by doctor stoppage for the Red fighter. |
|r_wins |double |Total historical UFC wins strictly prior to the current bout for the Red fighter. |
|r_stance |character |The fighting stance of the Red fighter (e.g., Orthodox, Southpaw, Switch). |
|r_height_cms |double |Red fighter height in centimeters. |
|r_reach_cms |double |Red fighter reach in centimeters. |
|r_weight_lbs |double |Red fighter weigh-in weight in pounds. |
|r_age |double |The age of the Red fighter at the time of the bout. |
|b_age |double |The age of the Blue fighter at the time of the bout. |
|lose_streak_dif |double |Difference in losing streaks (Red minus Blue). |
|win_streak_dif |double |Difference in winning streaks (Red minus Blue). |
|longest_win_streak_dif |double |Difference in longest winning streaks (Red minus Blue). |
|win_dif |double |Difference in total wins (Red minus Blue). |
|loss_dif |double |Difference in total losses (Red minus Blue). |
|total_round_dif |double |Difference in total rounds fought (Red minus Blue). |
|total_title_bout_dif |double |Difference in total title bouts fought (Red minus Blue). |
|ko_dif |double |Difference in career KO/TKO wins (Red minus Blue). |
|sub_dif |double |Difference in career submission wins (Red minus Blue). |
|height_dif |double |Difference in height in centimeters (Red minus Blue). |
|reach_dif |double |Difference in reach in centimeters (Red minus Blue). |
|age_dif |double |Difference in age (Red minus Blue). |
|sig_str_dif |double |Difference in average significant strikes landed (Red minus Blue). |
|avg_sub_att_dif |double |Difference in average submission attempts (Red minus Blue). |
|avg_td_dif |double |Difference in average takedowns landed (Red minus Blue). |
|empty_arena |double |Numeric or logical indicator for fights that took place without an audience. |
|b_match_weightclass_rank |double |Blue fighter's rank in the division of the current bout. |
|r_match_weightclass_rank |double |Red fighter's rank in the division of the current bout. |
|r_womens_flyweight_rank |double |Red fighter's rank in the Women's Flyweight division. |
|r_womens_featherweight_rank |double |Red fighter's rank in the Women's Featherweight division. |
|r_womens_strawweight_rank |double |Red fighter's rank in the Women's Strawweight division. |
|r_womens_bantamweight_rank |double |Red fighter's rank in the Women's Bantamweight division. |
|r_heavyweight_rank |double |Red fighter's rank in the Heavyweight division. |
|r_light_heavyweight_rank |double |Red fighter's rank in the Light Heavyweight division. |
|r_middleweight_rank |double |Red fighter's rank in the Middleweight division. |
|r_welterweight_rank |double |Red fighter's rank in the Welterweight division. |
|r_lightweight_rank |double |Red fighter's rank in the Lightweight division. |
|r_featherweight_rank |double |Red fighter's rank in the Featherweight division. |
|r_bantamweight_rank |double |Red fighter's rank in the Bantamweight division. |
|r_flyweight_rank |double |Red fighter's rank in the Flyweight division. |
|r_pound_for_pound_rank |double |Red fighter's rank in the Pound-for-Pound rankings. |
|b_womens_flyweight_rank |double |Blue fighter's rank in the Women's Flyweight division. |
|b_womens_featherweight_rank |double |Blue fighter's rank in the Women's Featherweight division. |
|b_womens_strawweight_rank |double |Blue fighter's rank in the Women's Strawweight division. |
|b_womens_bantamweight_rank |double |Blue fighter's rank in the Women's Bantamweight division. |
|b_heavyweight_rank |double |Blue fighter's rank in the Heavyweight division. |
|b_light_heavyweight_rank |double |Blue fighter's rank in the Light Heavyweight division. |
|b_middleweight_rank |double |Blue fighter's rank in the Middleweight division. |
|b_welterweight_rank |double |Blue fighter's rank in the Welterweight division. |
|b_lightweight_rank |double |Blue fighter's rank in the Lightweight division. |
|b_featherweight_rank |double |Blue fighter's rank in the Featherweight division. |
|b_bantamweight_rank |double |Blue fighter's rank in the Bantamweight division. |
|b_flyweight_rank |double |Blue fighter's rank in the Flyweight division. |
|b_pound_for_pound_rank |double |Blue fighter's rank in the Pound-for-Pound rankings. |
|better_rank |character |Indicates which corner held the superior ranking ("Red", "Blue", or "neither"). |
|finish |character |The method of the bout's conclusion (e.g., KO/TKO, SUB, U-DEC). |
|finish_details |character |Specifics on the finishing sequence (e.g., "Punches", "Rear Naked Choke"). |
|finish_round |double |The round in which the bout ended. |
|finish_round_time |character |The exact time on the clock when the fight was stopped (MM:SS). |
|total_fight_time_secs |double |The cumulative duration of the bout in seconds. |
|r_dec_odds |double |Prop bet odds for the Red fighter to win by decision. |
|b_dec_odds |double |Prop bet odds for the Blue fighter to win by decision. |
|r_sub_odds |double |Prop bet odds for the Red fighter to win by submission. |
|b_sub_odds |double |Prop bet odds for the Blue fighter to win by submission. |
|r_ko_odds |double |Prop bet odds for the Red fighter to win by KO/TKO. |
|b_ko_odds |double |Prop bet odds for the Blue fighter to win by KO/TKO. |

## Cleaning Script

```r
# install.packages("pak")
pak::pak("benyamindsmith/fightr")

library(fightr)
library(dplyr)
library(janitor)

fightr::update_all_ufc_data()

ufc_athletes <- fightr::get_ufc_data("ufc_athletes") |> 
  janitor::clean_names()

# Removing Events that do not have results
ufc_fights <- fightr::get_ufc_data("ufc_fights")|>
  dplyr::filter(!is.na(f1_result)) |> 
    janitor::clean_names()

ufcstats_data <- fightr::get_ufc_data("ufcstats_data") |> 
  janitor::clean_names()
ultimate_ufc_dataset<- fightr::get_ufc_data("ultimate_ufc_dataset") |> 
  janitor::clean_names()
ufc_rankings_dataset <- fightr::get_ufc_data("ufc_rankings_dataset") |> 
  janitor::clean_names()

```
