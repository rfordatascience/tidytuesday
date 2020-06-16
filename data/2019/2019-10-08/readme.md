# International Powerlifting

This week's data is from [Open Powerlifting](https://openpowerlifting.org/data).

[Wikipedia](https://en.wikipedia.org/wiki/Powerlifting) has many details around the sport itself, as well as more details around the 3 lifts (squat, bench, and deadlift).

Credit to [Nichole Monhait](https://twitter.com/nrmonhait) for sharing this fantastic open dataset. Please note this is a small subset of the data limited to IPF (International Powerlifting Federation) events, the full dataset with many more columns and alternative events can be found as a .csv at https://openpowerlifting.org/data. The full dataset has many more federations, ages, and meet types but is >250 MB.

A nice analysis of this dataset for age-effects in R can be found at [Elias Oziolor's Blog](https://oziolor.wordpress.com/2018/05/19/part-i-getting-old-you-can-still-lift/)

# Get the data!

```
ipf_lifts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-08/ipf_lifts.csv")
```

# Data Dictionary

## `ipf_lifts.csv`


|variable         |class     |description |
|:---|:---|:-----------|
|name|character | Individual lifter name |
|sex|character | Binary gender (M/F) |
|event|character | The type of competition that the lifter entered.<br><br>Values are as follows:<br>- SBD: Squat-Bench-Deadlift, also commonly called "Full Power".<br>- BD: Bench-Deadlift, also commonly called "Ironman" or "Push-Pull"<br>- SD: Squat-Deadlift, very uncommon.<br>- SB: Squat-Bench, very uncommon.<br>- S: Squat-only.<br>- B: Bench-only.<br>- D: Deadlift-only. |
|equipment |character | The equipment category under which the lifts were performed.<br><br>Values are as follows:<br>- Raw: Bare knees or knee sleeves.<br>- Wraps: Knee wraps were allowed.<br>- Single-ply: Equipped, single-ply suits.<br>- Multi-ply: Equipped, multi-ply suits (includes Double-ply).<br>- Straps: Allowed straps on the deadlift (used mostly for exhibitions, not real meets). |
|age |double    | The age of the lifter on the start date of the meet, if known. |
|age_class |character | The age class in which the filter falls, for example `40-45` |
|division |character | Free-form UTF-8 text describing the division of competition, like `Open` or `Juniors 20-23` or `Professional`. |
|bodyweight_kg    |double    | The recorded bodyweight of the lifter at the time of competition, to two decimal places. |
|weight_class_kg  |character | The weight class in which the lifter competed, to two decimal places.<br>Weight classes can be specified as a maximum or as a minimum. Maximums are specified by just the number, for example `90` means "up to (and including) 90kg." minimums are specified by a `+` to the right of the number, for example `90+` means "above (and excluding) 90kg."|
|best3squat_kg    |double    | Maximum of the first three successful attempts for the lift.<br>Rarely may be negative: that is used by some federations to report the lowest weight the lifter attempted and failed. |
|best3bench_kg    |double    | Maximum of the first three successful attempts for the lift.<br>Rarely may be negative: that is used by some federations to report the lowest weight the lifter attempted and failed. |
|best3deadlift_kg |double    | Maximum of the first three successful attempts for the lift.<br>Rarely may be negative: that is used by some federations to report the lowest weight the lifter attempted and failed. |
|place |character | The recorded place of the lifter in the given division at the end of the meet.<br><br>Values are as follows:<br>- Positive number: the place the lifter came in.<br>- G: Guest lifter. The lifter succeeded, but wasn't eligible for awards.<br>- DQ: Disqualified. Note that DQ could be for procedural reasons, not just failed attempts.<br>- DD: Doping Disqualification. The lifter failed a drug test.<br>- NS: No-Show. The lifter did not show up on the meet day.|
|date |double    | ISO 8601 Date of the event |
|federation       |character | The federation that hosted the meet. (limited to IPF for this data subset) |
|meet_name        |character | The name of the meet.<br>The name is defined to never include the year or the federation. For example, the meet officially called `2019 USAPL Raw National Championships` would have the MeetName `Raw National Championshps`. |


# Cleaning Script

```
library(tidyverse)

df <- read_csv(here::here("openpowerlifting-2019-09-20", "openpowerlifting-2019-09-20.csv"))

df_clean <- df %>% 
  janitor::clean_names()

df_clean %>% 
  group_by(federation) %>% 
  count(sort = TRUE)

size_df <- df_clean %>% 
  select(name:weight_class_kg, starts_with("best"), place, date, federation, meet_name)  %>% 
  filter(!is.na(date)) %>% 
  filter(federation == "IPF") %>% 
  object.size()

ipf_data <- df_clean %>% 
  select(name:weight_class_kg, starts_with("best"), place, date, federation, meet_name)  %>% 
  filter(!is.na(date)) %>% 
  filter(federation == "IPF")

print(size_df, units = "MB")

ipf_data %>% 
  write_csv(here::here("2019", "2019-10-08","ipf_lifts.csv"))

```