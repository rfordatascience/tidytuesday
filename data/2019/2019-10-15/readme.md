# Big `mtcars`

This week's data is from the [EPA](https://openpowerlifting.org/data). The full data dictionary can be found at [fueleconomy.gov](https://www.fueleconomy.gov/feg/ws/index.shtml#fuelType1). 

It's essentially a much much larger and updated dataset covering `mtcars`, the dataset we all know a bit too well!

H/t to Ellis Hughes who had a recent [blogpost](https://thebioengineer.github.io/thebioengineer.github.io/2019/09/10/big-mtcars/) covering this dataset.


# Get the data!

```
big_epa_cars <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-15/big_epa_cars.csv")
```

# Data Dictionary

## `big_epa_cars.csv`

I left in ALL the data so people could look at various different things besides the classical `mtcars`!

Full data dictionary can be found at [fueleconomy.gov](https://www.fueleconomy.gov/feg/ws/index.shtml#fuelType1)