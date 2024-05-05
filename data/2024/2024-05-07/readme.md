# Rolling Stone Album Rankings

This week we're looking at album rankings from Rolling Stone. h/t [Data is plural](https://www.data-is-plural.com/archive/2024-03-27-edition/). A visual essay from The Pudding looks at [what makes an album the greatest of all time](https://pudding.cool/2024/03/greatest-music/), and shares [the data](https://docs.google.com/spreadsheets/d/1c_Tdnm7S1oo8R9UNtdCVIY7bYASmf_cvMynOJTpKuHA/edit#gid=0) they put together for the essay. 

> A new visual essay from The Pudding compares Rolling Stone’s “500 Greatest Albums of All Time” lists from 2003, 2012, and 2020. A methodology note says the project began with a spreadsheet by Chris Eckert and eventually led the authors to develop a dataset of their own. Theirs lists every album in the rankings — its name, genre, release year, 2003/2012/2020 rank, the artist’s name, birth year, gender, and more — plus each year’s voters. [h/t Jason Kottke]

What are the characteristics of artists and genres popular at different times? 

## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2024-05-07')
## OR
tuesdata <- tidytuesdayR::tt_load(2024, week = 19)

rolling_stone <- tuesdata$rolling_stone


# Option 2: Read directly from GitHub

rolling_stone <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-05-07/rolling_stone.csv')
```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.

### Data Dictionary

# `rolling_stone.csv`

|variable                 |class     |description              |
|:------------------------|:---------|:------------------------|
|sort_name                |character |Name used for sorting                |
|clean_name               |character |Clean name               |
|album                    |character |Album name                    |
|rank_2003                |double    |Rank in 2003. NA if album not released yet or not in top 500.               |
|rank_2012                |double    |Rank in 2012. NA if album not released yet or not in top 500.                |
|rank_2020                |double    |Rank in 2020. NA if not in top 500.                |
|differential             |double    |2020-2003 Differential. Negative value if it went down in the chart. Positive value if it went up.     |
|release_year             |double    |Release Year             |
|genre                    |character |Album Genre                    |
|type                     |character |Album Type                     |
|weeks_on_billboard       |double    |Weeks on Billboard       |
|peak_billboard_position  |double    |Peak Billboard Position  |
|spotify_popularity       |double    |Spotify Popularity. NA if not on Spotify.      |
|spotify_url              |character |Spotify URL. NA if not on Spotify.              |
|artist_member_count      |double    |Number of artists in the group      |
|artist_gender            |character |Gender of the artist(s). Male/Female if it's a mixed-gender group.            |
|artist_birth_year_sum    |double    |Sum of the artists birth year. e.g. for a 2 member group, with one person born 1945 and another 1950, the value is 3895.    |
|debut_album_release_year |double    |Debut Album Release Year |
|ave_age_at_top_500       |double    |Average age at top 500 Album      |
|years_between            |double    |Years Between Debut and Top 500 Album        |
|album_id                 |character |Album ID. NOS at the beginning of the ID if not on Spotify.             |



### Cleaning Script

Downloaded from [Rolling Stone 500 (public)](https://docs.google.com/spreadsheets/d/1c_Tdnm7S1oo8R9UNtdCVIY7bYASmf_cvMynOJTpKuHA/edit#gid=0).

Changed column names, replacing white space with underscores, and making all letters lowercase. 

Removed Chartmetric Link and Album ID Quoted columns. 

Removed "N/A" and "Not on Spotify" and "-" characters, replacing with empty cells.


