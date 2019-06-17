# Christmas Bird Counts

Every year around Christmas time, since 1921, birdwatchers in the Hamilton area of Ontario have gone out and counted all the birds they see or hear in a day.

They have been carefully recording this data, and the raw data is available through the website of [Bird Studies Canada](https://www.birdscanada.org/index.jsp) (twitter handle: @BirdsCanada).

[Sharleen](https://twitter.com/_sharleen_w) has been a part of this data collection for the past two years, and decided to do some citizen data science with it! She went through and cleaned this data and made it much more ready for analysis! She detailed her data journey in a 5 part blog series as seen [here](https://sharleenw.rbind.io/post/hamilton_cbc_part_1/hamilton-christmas-bird-count-part-1/). Many thanks to her for cleaning, visualizing, and then sharing it!

# Get the data!

```
bird_counts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-18/bird_counts.csv")
```

# Data Dictionary


### `bird_counts.csv`

|variable                 |class     |description |
|:------------------------|:---------|:-----------|
|year                     | integer    | year |
|species                  |character | The species name in English and the scientific name|
|species_latin            |character | The species name in latin |
|how_many_counted         |double    | Actual raw bird count observed |
|total_hours              |double    | Total hours spent observing |
|how_many_counted_by_hour |double    | How many birds were counted divided by the number of person-hours that year |
