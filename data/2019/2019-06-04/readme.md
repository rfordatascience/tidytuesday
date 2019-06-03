# Ramen ratings

This week's dataset is a ramen ratings dataset from [The Ramen Rater](https://www.theramenrater.com/resources-2/the-list/). H/t to [Data is Plural](https://tinyletter.com/data-is-plural).

If you want to submit a dataset please do so as an [Issue](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub! If you do submit a dataset, please drop a link and some context as an issue. Thanks!

# Get the data!

```
ramen_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-04/ramen_ratings.csv")
```

# Data Dictionary


### `ramen_ratings.csv`

|variable      |class     |description |
|:---|:---|:----------|
|review_number |integer   | Ramen review number, increasing from 1 |
|brand         |character | Brand of the ramen |
|variety       |character | The ramen variety, eg a flavor, style, ingredient |
|style         |character | Style of container (cup, pack, tray, |bowl, box, restaurant, can, bar)
|country       |character | Origin country of the ramen brand |
|stars         |double    | 0-5 rating of the ramen, 5 is best, 0 is worst |

