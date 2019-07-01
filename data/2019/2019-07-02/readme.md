# Media Franchise Powerhouses

This data comes from [Wikipedia](https://en.wikipedia.org/wiki/List_of_highest-grossing_media_franchises) and includes franchises that have grossed at least $4 billion usd. How do different media franchises stack up with their revenue streams?

I took a stab at cleaning up the data in R directly from the source - I made some opinionated decisions about how to group categories (there were > 60 distinct categories), if you'd like a deeper dive on data cleaning try working with the data purely from the [source](https://en.wikipedia.org/wiki/List_of_highest-grossing_media_franchises).

I have included my script in this repo so you can take a peek at how we got here.

A popular [reddit/dataisbeautiful post](https://www.reddit.com/r/dataisbeautiful/comments/c53540/highest_grossing_media_franchises_oc/) examined this data with `ggplot2`. 

# Get the data!

```
media_franchises <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-02/media_franchises.csv")
```

# Data Dictionary


### `media_franchises.csv`

|variable         |class     |description |
|:---|:---|:-----------|
|franchise        |character | Franchise name |
|revenue_category |character | Revenue category|
|revenue          |double    | Revenue generated per category (in billions) |
|year_created     |integer/date   | Year created |
|original_media   |character | Original source of the franchise |
|creators         |character | Creators of the franchise |
|owners           |character | Current owners of the franchise |