# Bob Ross - painting by the numbers

This week's [**DATA**](bob-ross.csv) is from 538, and can either be read in directly from this repo or from the [538 R package](https://github.com/rudeboybert/fivethirtyeight) which was recently updated to include more data from 538!

The 538 article can be found [here](https://fivethirtyeight.com/features/a-statistical-analysis-of-the-work-of-bob-ross/).

# Get the data!

```
bob_ross <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-06/bob-ross.csv")

```

# Code tips & Hints

The `stringr::str_to_title()` [function](https://stringr.tidyverse.org/reference/case.html) could help with the variable names.

Try `dplyr::gather()` on the painting elements if you want to go to a tall/tidy format. Be aware there are frame AND painting elements in the columns, `dplyr::contains()` could be useful here with a `"frame"` argument. This only applies if you wanted to separate the columns into a frame and painting elements column. Otherwise, you could just do a straight `gather`/`pivot_longer` with all elements but season, title, episode.

```r
# to clean up the episode information
bob_ross %>% 
  janitor::clean_names() %>% 
  separate(episode, into = c("season", "episode"), sep = "E") %>% 
  mutate(season = str_extract(season, "[:digit:]+")) %>% 
  mutate_at(vars(season, episode), as.integer)
```


# Data Dictionary

## `bob-ross.csv`

* Each of the columns after episode/title correspond to the binary presence (0 or 1) of that element in the painting.

|variable           |class     |description |
|:------------------|:---------|:-----------|
|EPISODE            |character | Episode Number |
|TITLE              |character | Episode title |
|APPLE_FRAME        |double    |.           |
|AURORA_BOREALIS    |double    |.           |
|BARN               |double    |.           |
|BEACH              |double    |.           |
|BOAT               |double    |.           |
|BRIDGE             |double    |.           |
|BUILDING           |double    |.           |
|BUSHES             |double    |.           |
|CABIN              |double    |.           |
|CACTUS             |double    |.           |
|CIRCLE_FRAME       |double    |.           |
|CIRRUS             |double    |.           |
|CLIFF              |double    |.           |
|CLOUDS             |double    |.           |
|CONIFER            |double    |.           |
|CUMULUS            |double    |.           |
|DECIDUOUS          |double    |.           |
|DIANE_ANDRE        |double    |.           |
|DOCK               |double    |.           |
|DOUBLE_OVAL_FRAME  |double    |.           |
|FARM               |double    |.           |
|FENCE              |double    |.           |
|FIRE               |double    |.           |
|FLORIDA_FRAME      |double    |.           |
|FLOWERS            |double    |.           |
|FOG                |double    |.           |
|FRAMED             |double    |.           |
|GRASS              |double    |.           |
|GUEST              |double    |.           |
|HALF_CIRCLE_FRAME  |double    |.           |
|HALF_OVAL_FRAME    |double    |.           |
|HILLS              |double    |.           |
|LAKE               |double    |.           |
|LAKES              |double    |.           |
|LIGHTHOUSE         |double    |.           |
|MILL               |double    |.           |
|MOON               |double    |.           |
|MOUNTAIN           |double    |.           |
|MOUNTAINS          |double    |.           |
|NIGHT              |double    |.           |
|OCEAN              |double    |.           |
|OVAL_FRAME         |double    |.           |
|PALM_TREES         |double    |.           |
|PATH               |double    |.           |
|PERSON             |double    |.           |
|PORTRAIT           |double    |.           |
|RECTANGLE_3D_FRAME |double    |.           |
|RECTANGULAR_FRAME  |double    |.           |
|RIVER              |double    |.           |
|ROCKS              |double    |.           |
|SEASHELL_FRAME     |double    |.           |
|SNOW               |double    |.           |
|SNOWY_MOUNTAIN     |double    |.           |
|SPLIT_FRAME        |double    |.           |
|STEVE_ROSS         |double    |.           |
|STRUCTURE          |double    |.           |
|SUN                |double    |.           |
|TOMB_FRAME         |double    |.           |
|TREE               |double    |.           |
|TREES              |double    |.           |
|TRIPLE_FRAME       |double    |.           |
|WATERFALL          |double    |.           |
|WAVES              |double    |.           |
|WINDMILL           |double    |.           |
|WINDOW_FRAME       |double    |.           |
|WINTER             |double    |.           |
|WOOD_FRAMED        |double    |.           |