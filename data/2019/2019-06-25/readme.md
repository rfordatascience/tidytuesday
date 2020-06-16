# UFO Sightings around the world

This data includes >80,000 recorded UFO "sightings" around the world, including the UFO shape, lat/long and state/country of where the sighting occurred, duration of the "event" and the data_time when it occurred.

Data comes originally from [NUFORC](http://www.nuforc.org/), was cleaned and uploaded to Github by [Sigmond Axel](https://github.com/planetsig/ufo-reports), and some exploratory plots were created by [Jonathan Bouchet](https://www.kaggle.com/jonathanbouchet/e-t-phone-home-but-mostly-after-8-00pm) a few years back.

H/t to [Georgios Karamanis](https://github.com/rfordatascience/tidytuesday/issues/83) for sharing the data as an issue on Github. If you want to submit a dataset of your own interest, please do so as an [Issue](https://github.com/rfordatascience/tidytuesday/issues) on our GitHub! If you do submit a dataset, please drop a link and some context as an issue. Thanks!

# Get the data!

```
ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")
```

# Data Dictionary


### `ufo_sightings.csv`

|variable                   |class     |description |
|:---|:---|:-----------|
|date_time                  |datetime (mdy h:m) | Date time sighting occurred |
|city_area                  |character | City or area of sighting |
|state                      |character | state/region of sighting |
|country                    |character | Country of sighting |
|ufo_shape                  |character | UFO Shape |
|encounter_length           |double    | Encounter length in seconds |
|described_encounter_length |character | Encounter length as described (eg 1 hour, etc|
|description                |character | Description of encounter |
|date_documented            |character | Date documented |
|latitude                   |double    | Latitude |
|longitude                  |double    | Longitude |