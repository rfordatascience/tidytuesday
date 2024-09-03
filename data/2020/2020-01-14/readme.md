![https://xkcd.com/936/](https://imgs.xkcd.com/comics/password_strength.png)
### [XKCD Source for Comic](https://xkcd.com/936/)


# Passwords

This week's data is all about passwords. Data is sourced from [Information is Beautiful](https://docs.google.com/spreadsheets/d/1cz7TDhm0ebVpySqbTvrHrD3WpxeyE4hLZtifWSnoNTQ/edit#gid=21), with the graphic coming from the same group [here](https://twitter.com/infobeautiful/status/1216765612439019521?s=20).

There's lots of additional information about password quality & strength in the source [Doc](https://docs.google.com/spreadsheets/d/1cz7TDhm0ebVpySqbTvrHrD3WpxeyE4hLZtifWSnoNTQ/edit#gid=21). Please note that the "strength" column in this dataset is relative to these common aka "bad" passwords and YOU SHOULDN'T USE ANY OF THEM!

[Wikipedia](https://en.wikipedia.org/wiki/Password_strength) has a nice article on password strength as well.

### Get the data here

```{r}
# Get the Data

passwords <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-14/passwords.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO UPDATE tidytuesdayR from GitHub

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-01-14') 
tuesdata <- tidytuesdayR::tt_load(2020, week = 3)


passwords <- tuesdata$passwords
```
### Data Dictionary

# `passwords.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|rank              |double    | popularity in their database of released passwords |
|password          |character | Actual text of the password |
|category          |character | What category does the password fall in to?|
|value             |double    | Time to crack by online guessing |
|time_unit         |character | Time unit to match with value |
|offline_crack_sec |double    | Time to crack offline in seconds |
|rank_alt          |double    | Rank 2 |
|strength          |double    | Strength = quality of password where 10 is highest, 1 is lowest, please note that these are relative to these generally bad passwords |
|font_size         |double    | Used to create the graphic for KIB |
