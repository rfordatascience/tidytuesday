# Rap Artists

The data this week comes from [BBC Music](http://www.bbc.com/culture/story/20191007-the-greatest-hip-hop-songs-of-all-time-who-voted) by way of [Simon Jockers at Datawrapper](https://blog.datawrapper.de/best-hip-hop-songs-of-all-time-visualized/).

The raw data can be found on his [Github](https://github.com/sjockers/bbc-best-rapmusic). Album covers were retrived from Spotify, and you can access them via the Spotify API.

> Earlier this year, BBC Music asked more than 100 critics, artists, and other music industry folks from 15 countries for their five favorite hip-hop tracks. Then they broke down the results of the poll into one definitive list. But BBC Music didn't just publish a best-of list, they also published the complete poll results and a description of the simple algorithm they ranked the songs with. - Simon Jockers

> We awarded 10 points for first ranked track, eight points for second ranked track, and so on down to two points for fifth place. The song with the most points won. We split ties by the total number of votes: songs with more votes ranked higher. Any ties remaining after this were split by first place votes, followed by second place votes and so on: songs with more critics placing them at higher up the lists up ranked higher. -- BBC Music

### Get the data here

```{r}
# Get the Data

polls <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-14/polls.csv')
rankings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-14/rankings.csv')

# Or read in with tidytuesdayR package (https://github.com/dslc-io/tidytuesdayR)
# PLEASE NOTE TO USE 2020 DATA YOU NEED TO USE tidytuesdayR version from GitHub

# Either ISO-8601 date or year/week works!

# Install via pak::pak("dslc-io/tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2020-04-14')
tuesdata <- tidytuesdayR::tt_load(2020, week = 16)


polls <- tuesdata$polls
```
### Data Dictionary

# `polls.csv`

|variable        |class     |description |
|:---------------|:---------|:-----------|
|rank            |double    | Rank given by voter (1-5) |
|title           |character | Title of song|
|artist          |character | Artist |
|gender          |character | Gender of artist |
|year            |double    | Year song released |
|critic_name     |character | Name of critic|
|critic_rols     |character | Critic's role |
|critic_country  |character | Critic's primary country|
|critic_country2 |character | Critic's secondary country |

# `rankings.csv`

|variable |class     |description |
|:--------|:---------|:-----------|
|ID       |double    |ID of song |
|title    |character | Title of song  |
|artist   |character | Artist's name |
|year     |double    | Year song released |
|gender   |character | Gender of artist/group |
|points   |double    | Total points awarded |
|n        |double    |Total votes (regardless of position) |
|n1       |double    | Number of votes as #1 |
|n2       |double    |Number of votes as #2 |
|n3       |double    |Number of votes as #3 |
|n4       |double    |Number of votes as #4 |
|n5       |double    |Number of votes as #5 |

### Cleaning Script

[Simon Jocker's GitHub](https://github.com/sjockers/bbc-best-rapmusic)
