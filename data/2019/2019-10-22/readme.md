# Horror movie metadata

This week's data is from the [IMDB](https://www.kaggle.com/PromptCloudHQ/imdb-horror-movie-dataset) by way of Kaggle.

H/t to [Georgios Karamanis](https://twitter.com/geokaramanis) for sharing the data this week.

Thrillist did a [75 Best Horror Movies of all Time article](https://www.thrillist.com/entertainment/nation/best-horror-movies-ever). There's also a [Stephen Follows article](https://stephenfollows.com/what-the-data-says-about-producing-low-budget-horror-films/) about horror movies exploring data around profit, popularity and ratings.

Last year for Halloween we focused on Horror Movie Profit - feel free to take a peek at that data as well on [our GitHub](https://github.com/rfordatascience/tidytuesday/tree/master/data/2018/2018-10-23).

# Get the data!

```
horror_movies <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-22/horror_movies.csv")
```

# Data Dictionary

## `horror_movies.csv`

|variable          |class     |description |
|:-----------------|:---------|:-----------|
|title             |character | Title of the movie |
|genres            |character | Movie Generes |
|release_date      |character | Movie release date - day-month-year |
|release_country   |character | Release country |
|movie_rating      |character | MPAA Rating |
|review_rating     |double    | Movie rating (0 - 10) |
|movie_run_time    |character | Movie run time (minutes) |
|plot              |character | Short plot description (raw text) |
|cast              |character | Cast|
|language          |character | Language |
|filming_locations |character | Filming location |
|budget            |character | Budget (US Dollars) |
