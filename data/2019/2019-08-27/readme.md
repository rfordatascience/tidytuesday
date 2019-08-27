# Simpsons Guest Stars

This week's [**data**](simpsons-guests.csv) is from [Wikipedia](https://en.wikipedia.org/wiki/List_of_The_Simpsons_guest_stars_(seasons_1%E2%80%9320)), by way of [Andrew Collier](https://github.com/rfordatascience/tidytuesday/issues/103).


# Get the data!

```
simpsons <- readr::read_delim("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-27/simpsons-guests.csv", delim = "|", quote = "")

```

# Data Dictionary

## `simpsons-guests.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|season          | integer | Season of the show |
|number          | character | Episode number |
|production_code |character | Production code for the episode |
|episode_title   |character | Episode Title |
|guest_star      |character | Guest star (actual name) |
|role            |character | Role in the show, either a character or themself |