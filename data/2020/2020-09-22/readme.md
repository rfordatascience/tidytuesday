![Picture of the Himalayas from Wikipedia](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg/1920px-Mount_Everest_as_seen_from_Drukair2_PLW_edit.jpg)

# Himalayan Climbing Expeditions

The data this week comes from [The Himalayan Database](https://www.himalayandatabase.com/).

>The Himalayan Database is a compilation of records for all expeditions that have climbed in the Nepal Himalaya. The database is based on the expedition archives of Elizabeth Hawley, a longtime journalist based in Kathmandu, and it is supplemented by information gathered from books, alpine journals and correspondence with Himalayan climbers.
>
>The data cover all expeditions from 1905 through Spring 2019 to more than 465 significant peaks in Nepal. Also included are expeditions to both sides of border peaks such as Everest, Cho Oyu, Makalu and Kangchenjunga as well as to some smaller border peaks. Data on expeditions to trekking peaks are included for early attempts, first ascents and major accidents.

h/t to [Alex Cookson](https://twitter.com/alexcookson) for sharing and cleaning this data!

This [blog post](https://www.alexcookson.com/post/analyzing-himalayan-peaks-first-ascents/) by [Alex Cookson](https://twitter.com/alexcookson) explores the data in greater detail.

I don't want to underplay that there are some positives and some awful negatives for native Sherpa climbers. [One-third of Everest deaths are Sherpa Climbers](https://www.npr.org/sections/parallels/2018/04/14/599417489/one-third-of-everest-deaths-are-sherpa-climbers).  

Also National Geographic has [5 Ways to help the Sherpas of Everest](https://www.nationalgeographic.com/news/2014/4/140424-sherpas-avalanche-help-donations/).

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-22')
tuesdata <- tidytuesdayR::tt_load(2020, week = 39)

climbers <- tuesdata$climbers

# Or read in the data manually

members <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-22/members.csv')
expeditions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-22/expeditions.csv')
peaks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-22/peaks.csv')
```
# Data Dictionary

### `peaks.csv`

| variable                   | class     | description                                                  |
| :------------------------- | :-------- | :----------------------------------------------------------- |
| peak_id                    | character | Unique identifier for peak                                   |
| peak_name                  | character | Common name of peak                                          |
| peak_alternative_name      | character | Alternative name of peak (for example, the "Mount Everest" is "Sagarmatha" in Nepalese) |
| height_metres              | double    | Height of peak in metres                                     |
| climbing_status            | character | Whether the peak has been climbed                            |
| first_ascent_year          | double    | Year of first successful ascent, if applicable               |
| first_ascent_country       | character | Country name(s) of expedition members part of the first ascent. Can have multiple values if members were from different countries. Country name is as of date of ascent (for example, "W Germany" for ascents before 1990). |
| first_ascent_expedition_id | character | Unique identifier for expedition. Can be linked to `expeditions` or `members` tables. |



### `expeditions.csv`

| variable           | class     | description                                                  |
| :----------------- | :-------- | :----------------------------------------------------------- |
| expedition_id      | character | Unique identifier for expedition. Can be linked to `peaks` or `members` tables. |
| peak_id            | character | Unique identifier for peak. Can be linked to `peaks` table.  |
| peak_name          | character | Common name for peak                                         |
| year               | double    | Year of expedition                                           |
| season             | character | Season of expedition (Spring, Summer, etc.)                  |
| basecamp_date      | date      | Date of expedition arrival at basecamp                       |
| highpoint_date        | date      | Date of expedition summiting the peak for the first time or, if peak wasn't reached, date of reaching its highpoint |
| termination_date   | date      | Date the expedition was terminated                           |
| termination_reason | character | Primary reason the expedition was terminated. There are two possibilities for a successful expeditions, depending on whether the main peak or a sub-peak was summitted. |
| highpoint_metres   | double    | Elevation highpoint of the expedition                        |
| members            | double    | Number of expedition members. For expeditions in Nepal, this is usually the number of foreigners listed on the expedition permit. For expeditions in China, this is usually the number of non-hired members. |
| member_deaths      | double    | Number of expeditions members who died                       |
| hired_staff        | double    | Number of hired staff who went above basecamp                |
| hired_staff_deaths | double    | Number of hired staff who died                               |
| oxygen_used        | logical   | Whether oxygen was used by at least one member of the expedition |
| trekking_agency    | character | Name of the trekking agency                                  |



### `members.csv`

| variable             | class     | description                                                  |
| :------------------- | :-------- | :----------------------------------------------------------- |
| expedition_id        | character | Unique identifier for expedition. Can be linked to `peaks` or `members` tables. |
| member_id            | character | Unique identifier for the person. This is *not* consistent across expeditions, so you cannot use a single `member_id` to look up all expeditions a person was part of. |
| peak_id              | character | Unique identifier for peak. Can be linked to `peaks` table.  |
| peak_name            | character | Common name for peak                                         |
| year                 | double    | Year of expedition                                           |
| season               | character | Season of expedition (Spring, Summer, etc.)                  |
| sex                  | character | Sex of the person                                            |
| age                  | double    | Age of the person. Depending on the best available data, this could be as of the summit date, the date of death, or the date of arrival at basecamp. |
| citizenship          | character | Citizenship of the person                                    |
| expedition_role      | character | Role of the person on the expedition                         |
| hired                | logical   | Whether the person was hired by the expedition               |
| highpoint_metres     | double    | Elevation highpoint of the person                            |
| success              | logical   | Whether the person was successful in summitting a main peak or sub-peak, depending on the goal of expedition |
| solo                 | logical   | Whether the person attempted a solo ascent                   |
| oxygen_used          | logical   | Whether the person used oxygen                               |
| died                 | logical   | Whether the person died                                      |
| death_cause          | character | Primary cause of death                                       |
| death_height_metres  | double    | Height at which the person died                              |
| injured              | logical   | Whether the person was injured                               |
| injury_type          | character | Primary cause of injury                                      |
| injury_height_metres | double    | Height at which the injury occurred                          |


### Cleaning Script

```{r}
# Libraries
library(tidyverse)
library(janitor)


# Peaks
peaks <- read_csv("./himalayan-expeditions/raw/peaks.csv") %>%
  transmute(
    peak_id = PEAKID,
    peak_name = PKNAME,
    peak_alternative_name = PKNAME2,
    height_metres = HEIGHTM,
    climbing_status = PSTATUS,
    first_ascent_year = PYEAR,
    first_ascent_country = PCOUNTRY,
    first_ascent_expedition_id = PEXPID
  ) %>%
  mutate(
    climbing_status = case_when(
      climbing_status == 0 ~ "Unknown",
      climbing_status == 1 ~ "Unclimbed",
      climbing_status == 2 ~ "Climbed"
    )
  )

# Create small dataframe of peak names to join to other dataframes
peak_names <- peaks %>%
  select(peak_id, peak_name)

# Expeditions
expeditions <- read_csv("./himalayan-expeditions/raw/exped.csv") %>%
  left_join(peak_names, by = c("PEAKID" = "peak_id")) %>%
  transmute(
    expedition_id = EXPID,
    peak_id = PEAKID,
    peak_name,
    year = YEAR,
    season = SEASON,
    basecamp_date = BCDATE,
    highpoint_date = SMTDATE,
    termination_date = TERMDATE,
    termination_reason = TERMREASON,
    # Highpoint of 0 is most likely missing value
    highpoint_metres = ifelse(HIGHPOINT == 0, NA, HIGHPOINT),
    members = TOTMEMBERS,
    member_deaths = MDEATHS,
    hired_staff = TOTHIRED,
    hired_staff_deaths = HDEATHS,
    oxygen_used = O2USED,
    trekking_agency = AGENCY
  ) %>%
  mutate(
    termination_reason = case_when(
      termination_reason == 0 ~ "Unknown",
      termination_reason == 1 ~ "Success (main peak)",
      termination_reason == 2 ~ "Success (subpeak)",
      termination_reason == 3 ~ "Success (claimed)",
      termination_reason == 4 ~ "Bad weather (storms, high winds)",
      termination_reason == 5 ~ "Bad conditions (deep snow, avalanching, falling ice, or rock)",
      termination_reason == 6 ~ "Accident (death or serious injury)",
      termination_reason == 7 ~ "Illness, AMS, exhaustion, or frostbite",
      termination_reason == 8 ~ "Lack (or loss) of supplies or equipment",
      termination_reason == 9 ~ "Lack of time",
      termination_reason == 10 ~ "Route technically too difficult, lack of experience, strength, or motivation",
      termination_reason == 11 ~ "Did not reach base camp",
      termination_reason == 12 ~ "Did not attempt climb",
      termination_reason == 13 ~ "Attempt rumoured",
      termination_reason == 14 ~ "Other"
    ),
    season = case_when(
      season == 0 ~ "Unknown",
      season == 1 ~ "Spring",
      season == 2 ~ "Summer",
      season == 3 ~ "Autumn",
      season == 4 ~ "Winter"
    )
  )

members <-
  read_csv("./himalayan-expeditions/raw/members.csv", guess_max = 100000) %>%
  left_join(peak_names, by = c("PEAKID" = "peak_id")) %>%
  transmute(
    expedition_id = EXPID,
    member_id = paste(EXPID, MEMBID, sep = "-"),
    peak_id = PEAKID,
    peak_name,
    year = MYEAR,
    season = MSEASON,
    sex = SEX,
    age = CALCAGE,
    citizenship = CITIZEN,
    expedition_role = STATUS,
    hired = HIRED,
    # Highpoint of 0 is most likely missing value
    highpoint_metres = ifelse(MPERHIGHPT == 0, NA, MPERHIGHPT),
    success = MSUCCESS,
    solo = MSOLO,
    oxygen_used = MO2USED,
    died = DEATH,
    death_cause = DEATHTYPE,
    # Height of 0 is most likely missing value
    death_height_metres = ifelse(DEATHHGTM == 0, NA, DEATHHGTM),
    injured = INJURY,
    injury_type = INJURYTYPE,
    # Height of 0 is most likely missing value
    injury_height_metres = ifelse(INJURYHGTM == 0, NA, INJURYHGTM)
  ) %>%
  mutate(
    season = case_when(
      season == 0 ~ "Unknown",
      season == 1 ~ "Spring",
      season == 2 ~ "Summer",
      season == 3 ~ "Autumn",
      season == 4 ~ "Winter"
    ),
    age = ifelse(age == 0, NA, age),
    death_cause = case_when(
      death_cause == 0 ~ "Unspecified",
      death_cause == 1 ~ "AMS",
      death_cause == 2 ~ "Exhaustion",
      death_cause == 3 ~ "Exposure / frostbite",
      death_cause == 4 ~ "Fall",
      death_cause == 5 ~ "Crevasse",
      death_cause == 6 ~ "Icefall collapse",
      death_cause == 7 ~ "Avalanche",
      death_cause == 8 ~ "Falling rock / ice",
      death_cause == 9 ~ "Disappearance (unexplained)",
      death_cause == 10 ~ "Illness (non-AMS)",
      death_cause == 11 ~ "Other",
      death_cause == 12 ~ "Unknown"
    ),
    injury_type = case_when(
      injury_type == 0 ~ "Unspecified",
      injury_type == 1 ~ "AMS",
      injury_type == 2 ~ "Exhaustion",
      injury_type == 3 ~ "Exposure / frostbite",
      injury_type == 4 ~ "Fall",
      injury_type == 5 ~ "Crevasse",
      injury_type == 6 ~ "Icefall collapse",
      injury_type == 7 ~ "Avalanche",
      injury_type == 8 ~ "Falling rock / ice",
      injury_type == 9 ~ "Disappearance (unexplained)",
      injury_type == 10 ~ "Illness (non-AMS)",
      injury_type == 11 ~ "Other",
      injury_type == 12 ~ "Unknown"
    ),
    death_cause = ifelse(died, death_cause, NA_character_),
    death_height_metres = ifelse(died, death_height_metres, NA),
    injury_type = ifelse(injured, injury_type, NA_character_),
    injury_height_metres = ifelse(injured, injury_height_metres, NA)
  )


### Write to CSV
write_csv(expeditions, "./himalayan-expeditions/expeditions.csv")
write_csv(members, "./himalayan-expeditions/members.csv")
write_csv(peaks, "./himalayan-expeditions/peaks.csv")

```