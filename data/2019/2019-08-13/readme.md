# Roman Emperors

This week's [**data**](emperors.csv) is from [Wikipedia](https://en.wikipedia.org/wiki/List_of_Roman_emperors), with credit to [Georgios Karamanis](https://twitter.com/geokaramanis) for sharing the dataset.

A Reddit [/r/dataisbeautiful post](https://www.reddit.com/r/dataisbeautiful/comments/8tzfgz/roman_emperors_by_year_oc/) covers this data.

# Get the data!

```
emperors <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-13/emperors.csv")

```


# Data Dictionary

## `emperors.csv`

|variable    |class     |description |
|:-----------|:---------|:-----------|
|index       |double    | Numerical Index |
|name        |character | Name |
|name_full   |character | Full Name|
|birth       |date    | Birth date|
|death       |date    | Death date|
|birth_cty   |character | Birth city|
|birth_prv   |character | Birth Province |
|rise        |character | How did they come to power |
|reign_start |date    | Date of start of reign |
|reign_end   |date    | Date of end of reign|
|cause       |character | Cause of death |
|killer      |character | Killer|
|dynasty     |character | Dynasty name |
|era         |character | Era|
|notes       |character | Notes |
|verif_who   |character | If verified, by whom |