# The Great American Coffee Taste Test

In October 2023, ["world champion barista" James Hoffmann](https://www.youtube.com/watch?v=bMOOQfeloH0) and [coffee company Cometeer](https://cometeer.com/pages/the-great-american-coffee-taste-test) held the "Great American Coffee Taste Test" on YouTube, during which viewers were asked to fill out a survey about 4 coffees they ordered from Cometeer for the tasting. [Data blogger Robert McKeon Aloe analyzed the data the following month](https://rmckeon.medium.com/great-american-coffee-taste-test-breakdown-7f3fdcc3c41d).

Do you think participants in this survey are representative of Americans in general?

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-05-14')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 20)

coffee_survey <- tuesdata$coffee_survey


# Option 2: Read directly from GitHub

coffee_survey <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-14/coffee_survey.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `coffee_survey.csv`

|variable                     |class     |description                  |
|:----------------------------|:---------|:----------------------------|
|submission_id                |character |Submission ID                |
|age                          |character |What is your age? |
|cups                         |character |How many cups of coffee do you typically drink per day? |
|where_drink                  |character |Where do you typically drink coffee? |
|brew                         |character |How do you brew coffee at home? |
|brew_other                   |character |How else do you brew coffee at home? |
|purchase                     |character |On the go, where do you typically purchase coffee? |
|purchase_other               |character |Where else do you purchase coffee? |
|favorite                     |character |What is your favorite coffee drink? |
|favorite_specify             |character |Please specify what your favorite coffee drink is |
|additions                    |character |Do you usually add anything to your coffee? |
|additions_other              |character |What else do you add to your coffee? |
|dairy                        |character |What kind of dairy do you add? |
|sweetener                    |character |What kind of sugar or sweetener do you add? |
|style                        |character |Before today's tasting, which of the following best described what kind of coffee you like? |
|strength                     |character |How strong do you like your coffee? |
|roast_level                  |character |What roast level of coffee do you prefer? |
|caffeine                     |character |How much caffeine do you like in your coffee? |
|expertise                    |numeric   |Lastly, how would you rate your own coffee expertise? |
|coffee_a_bitterness          |numeric   |Coffee A - Bitterness|
|coffee_a_acidity             |numeric   |Coffee A - Acidity |
|coffee_a_personal_preference |numeric   |Coffee A - Personal Preference |
|coffee_a_notes               |character |Coffee A - Notes |
|coffee_b_bitterness          |numeric   |Coffee B - Bitterness |
|coffee_b_acidity             |numeric   |Coffee B - Acidity |
|coffee_b_personal_preference |numeric   |Coffee B - Personal Preference |
|coffee_b_notes               |character |Coffee B - Notes |
|coffee_c_bitterness          |numeric   |Coffee C - Bitterness |
|coffee_c_acidity             |numeric   |Coffee C - Acidity |
|coffee_c_personal_preference |numeric   |Coffee C - Personal Preference |
|coffee_c_notes               |character |Coffee C - Notes |
|coffee_d_bitterness          |numeric   |Coffee D - Bitterness |
|coffee_d_acidity             |numeric   |Coffee D - Acidity |
|coffee_d_personal_preference |numeric   |Coffee D - Personal Preference |
|coffee_d_notes               |character |Coffee D - Notes |
|prefer_abc                   |character |Between Coffee A, Coffee B, and Coffee C which did you prefer? |
|prefer_ad                    |character |Between Coffee A and Coffee D, which did you prefer? |
|prefer_overall               |character |Lastly, what was your favorite overall coffee? |
|wfh                          |character |Do you work from home or in person? |
|total_spend                  |character |In total, much money do you typically spend on coffee in a month? |
|why_drink                    |character |Why do you drink coffee? |
|why_drink_other              |character |Other reason for drinking coffee |
|taste                        |character |Do you like the taste of coffee? |
|know_source                  |character |Do you know where your coffee comes from? |
|most_paid                    |character |What is the most you've ever paid for a cup of coffee? |
|most_willing                 |character |What is the most you'd ever be willing to pay for a cup of coffee? |
|value_cafe                   |character |Do you feel like you’re getting good value for your money when you buy coffee at a cafe? |
|spent_equipment              |character |Approximately how much have you spent on coffee equipment in the past 5 years? |
|value_equipment              |character |Do you feel like you’re getting good value for your money when you buy coffee at a cafe? |
|gender                       |character |Gender                       |
|gender_specify               |character |Gender (please specify) |
|education_level              |character |Education Level |
|ethnicity_race               |character |Ethnicity/Race |
|ethnicity_race_specify       |character |Ethnicity/Race (please specify) |
|employment_status            |character |Employment Status |
|number_children              |character |Number of Children |
|political_affiliation        |character |Political Affiliation |


### Cleaning Script

```{r}
library(tidyverse)
library(janitor)
library(here)
library(fs)

working_dir <- here::here("data", "2024", "2024-05-14")

url <- "https://bit.ly/gacttCSV"

coffee_survey_raw <- readr::read_csv(url)

# Grab the raw questions for the dictionary.
coffee_survey_raw |> 
  colnames() |> 
  cat(sep = "\n")

coffee_survey <- coffee_survey_raw |> 
  janitor::clean_names() |> 
  # Get rid of one-hot encoding; users can do that if they'd like. Also,
  # "flavorings" columns are empty.
  dplyr::select(
    submission_id,
    age = what_is_your_age,
    cups = how_many_cups_of_coffee_do_you_typically_drink_per_day,
    where_drink = where_do_you_typically_drink_coffee,
    brew = how_do_you_brew_coffee_at_home,
    brew_other = how_else_do_you_brew_coffee_at_home,
    purchase = on_the_go_where_do_you_typically_purchase_coffee,
    purchase_other = where_else_do_you_purchase_coffee,
    favorite = what_is_your_favorite_coffee_drink,
    favorite_specify = please_specify_what_your_favorite_coffee_drink_is,
    additions = do_you_usually_add_anything_to_your_coffee,
    additions_other = what_else_do_you_add_to_your_coffee,
    dairy = what_kind_of_dairy_do_you_add,
    sweetener = what_kind_of_sugar_or_sweetener_do_you_add,
    style = before_todays_tasting_which_of_the_following_best_described_what_kind_of_coffee_you_like,
    strength = how_strong_do_you_like_your_coffee,
    roast_level = what_roast_level_of_coffee_do_you_prefer,
    caffeine = how_much_caffeine_do_you_like_in_your_coffee,
    expertise = lastly_how_would_you_rate_your_own_coffee_expertise,
    starts_with("coffee"),
    prefer_abc = between_coffee_a_coffee_b_and_coffee_c_which_did_you_prefer,
    prefer_ad = between_coffee_a_and_coffee_d_which_did_you_prefer,
    prefer_overall = lastly_what_was_your_favorite_overall_coffee,
    wfh = do_you_work_from_home_or_in_person,
    total_spend = in_total_much_money_do_you_typically_spend_on_coffee_in_a_month,
    why_drink = why_do_you_drink_coffee,
    why_drink_other = other_reason_for_drinking_coffee,
    taste = do_you_like_the_taste_of_coffee,
    know_source = do_you_know_where_your_coffee_comes_from,
    most_paid = what_is_the_most_youve_ever_paid_for_a_cup_of_coffee,
    most_willing = what_is_the_most_youd_ever_be_willing_to_pay_for_a_cup_of_coffee,
    value_cafe = do_you_feel_like_you_re_getting_good_value_for_your_money_when_you_buy_coffee_at_a_cafe,
    spent_equipment = approximately_how_much_have_you_spent_on_coffee_equipment_in_the_past_5_years,
    value_equipment = do_you_feel_like_you_re_getting_good_value_for_your_money_with_regards_to_your_coffee_equipment,
    gender,
    gender_specify = gender_please_specify,
    education_level,
    ethnicity_race,
    ethnicity_race_specify = ethnicity_race_please_specify,
    employment_status,
    number_children = number_of_children,
    political_affiliation
  )

readr::write_csv(
  coffee_survey,
  fs::path(working_dir, "coffee_survey.csv")
)
```
