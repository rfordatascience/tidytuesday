# Meteorite Impacts

This week's dataset is a dataset all about meteorites, where they fell and when they fell! Data comes from the Meteoritical Society by way of [NASA](https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh/data). H/t to `#TidyTuesday` community member [Malin Axelsson](https://twitter.com/malinfax?lang=en) for sharing this data as an issue on GitHub!

If you want to find out more about meteorite classifications, Malin was kind enough to share a [wikipedia article](https://en.wikipedia.org/wiki/Meteorite_classification) as well!

If you want to submit a dataset of your own interest, please do so as an [Issue](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub! If you do submit a dataset, please drop a link and some context as an issue. Thanks!

# Get the data!

```
meteorites <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-11/meteorites.csv")
```

# Data Dictionary


### `meteorites.csv`

|variable    |class     |description |
|:---|:---|:-----------|
|name        |character | Meteorite name |
|id          |double    | Meteorite numerical ID|
|name_type   |character | Name type either valid or relict, where relict = a meteorite that cannot be assigned easily to a class |
|class       |character | Class of the meteorite, please see [Wikipedia](https://en.wikipedia.org/wiki/Meteorite_classification) for full context |
|mass        |double    | Mass in grams |
|fall        |character | Fell or Found meteorite |
|year        |integer   | Year found |
|lat         |double    | Latitude |
|long        |double    | Longitude |
|geolocation |character | Geolocation |
