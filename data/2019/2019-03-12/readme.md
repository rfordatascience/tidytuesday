### Board Games Database

This week's data comes from the [Board Game Geek](http://boardgamegeek.com/) database. The site's database has more than 90,000 games, with crowd-sourced ratings. There is also an R package with the fulldataset ([`bggAnalysis`](https://github.com/9thcirclegames/bgg-analysis)) but it hasn't been updated in ~2 years.

To follow along with a [fivethirtyeight article](https://fivethirtyeight.com/features/designing-the-best-board-game-on-the-planet/), I limited to only games with at least 50 ratings and for games between 1950 and 2016. This still leaves us with 10,532 games!

```{r}
board_games <- readr::read_csv()
```

### Data Dictionary

|variable       |class     |description |
|:--------------|:---------|:-----------|
|game_id        |character | Unique game identifier         |
|description    |character | A paragraph of text describing the game       |
|image          |character | URL image of the game            |
|max_players    |integer   | Maximum recommended players           |
|max_playtime   |integer   | Maximum recommended playtime (min)           |
|min_age        |integer   | Minimum recommended age          |
|min_players    |integer   | Minimum recommended players         |
|min_playtime   |integer   | Minimum recommended playtime (min)           |
|name           |character | Name of the game           |
|playing_time   |integer   | Average playtime           |
|thumbnail      |character | URL thumbnail of the game           |
|year_published |integer   | Year game was published           |
|artist         |character | Artist for game art           |
|category       |character | Categories for the game (separated by commas)           |
|compilation    |character | If part of a multi-compilation - name of compilation           |
|designer       |character | Game designer           |
|expansion      |character | If there is an expansion pack - name of expansion           |
|family         |character | Family of game - equivalent to a publisher          |
|mechanic       |character | Game mechanic - how game is played, separated by comma         |
|publisher      |character | Comoany/person who published the game, separated by comma        |
|average_rating |double    | Average rating on Board Games Geek (1-10)        |
|users_rated    |double    | Number of users that rated the game           |  