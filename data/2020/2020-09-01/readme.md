![Harvest picture credit to: https://unsplash.com/@scottagoodwill](https://images.unsplash.com/photo-1507662228758-08d030c4820b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80)

# Global Crop Yields

The data this week comes from [Our World in Data](https://ourworldindata.org/crop-yields). Note that there is a lot of data on that site, we're looking at some subsets but feel free to use whatever data from there you find interesting! It's all pretty clean and ready to go.

Also note that there are cases where the long data includes both continent (eg Africa, Americas), countries (USA, Afghanistan, etc) and regions (North Asia, East Asia, etc). You'll need to be careful making assumptions when grouping and/or excluding specific groups.

> Our data on agricultural yields across crop types and by country are much more extensive from 1960 onwards. The UN Food and Agricultural Organization (FAO) publish yield estimates across a range of crop commodities by country over this period. The FAO report yield values as the national average for any given year; this is calculated by diving total crop output (in kilograms or tonnes) by the area of land used to grow a given crop (in hectares). There are likely to be certain regional and seasonal differences in yield within a given country, however, reported average yields still provide a useful indication of changes in productivity over time and geographical region.

We've also included data on the trade off between higher yields and land use, so there are some interesting changes to track beyond raw production.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-01')
tuesdata <- tidytuesdayR::tt_load(2020, week = 36)

key_crop_yields <- tuesdata$key_crop_yields

# Or read in the data manually

key_crop_yields <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-01/key_crop_yields.csv')
fertilizer <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-01/cereal_crop_yield_vs_fertilizer_application.csv')
tractors <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-01/cereal_yields_vs_tractor_inputs_in_agriculture.csv')
land_use <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-01/land_use_vs_yield_change_in_cereal_production.csv')
arable_land <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-01/arable_land_pin.csv')

```
### Data Dictionary

# `key_crop_yields.csv`

|variable                         |class     |description |
|:--------------------------------|:---------|:-----------|
|Entity                           |character | Country or Region Name |
|Code                             |character | Country Code (note is NA for regions/continents) |
|Year                             |double    | Year |
|Wheat (tonnes per hectare)       |double    | Wheat yield |
|Rice (tonnes per hectare)        |double    | Rice Yield |
|Maize (tonnes per hectare)       |double    | Maize yield |
|Soybeans (tonnes per hectare)    |double    | Soybeans yield |
|Potatoes (tonnes per hectare)    |double    | Potato yield |
|Beans (tonnes per hectare)       |double    | Beans yield|
|Peas (tonnes per hectare)        |double    | Peas yield |
|Cassava (tonnes per hectare)     |double    | Cassava (yuca) yield|
|Barley (tonnes per hectare)      |double    | Barley|
|Cocoa beans (tonnes per hectare) |double    | Cocoa |
|Bananas (tonnes per hectare)     |double    | Bananas |

# `arable_land`

|variable                                                               |class     |description |
|:----------------------------------------------------------------------|:---------|:-----------|
|Entity                           |character | Country or Region Name |
|Code                             |character | Country Code (note is NA for regions/continents) |
|Year                             |double    | Year |
|Arable land needed to produce a fixed quantity of crops ((1.0 = 1961)) |double    | Arable land normalized to 1961 |


# `fertilizer`

|variable                                        |class     |description |
|:-----------------------------------------------|:---------|:-----------|
|Entity                           |character | Country or Region Name |
|Code                             |character | Country Code (note is NA for regions/continents) |
|Year                             |double    | Year |
|Cereal yield (tonnes per hectare)               |double    | Cereal yield in tonnes per hectare |
|Nitrogen fertilizer use (kilograms per hectare) |double    | Nitrogen fertilizer use kg per hectare |

# `land_use`

|variable                                                  |class     |description |
|:---------------------------------------------------------|:---------|:-----------|
|Entity                           |character | Country or Region Name |
|Code                             |character | Country Code (note is NA for regions/continents) |
|Year                             |double    | Year |
|cereal yield index                                        |double    | Cereal yield index |
|change to land area used for cereal production since 1961 |double    | Change to land area use for cereal production relative since 1961|
|total population (gapminder)                              |double    | Total population from gapminder data |

# `tractor`

|variable                                              |class     |description |
|:---------------------------------------------------------|:---------|:-----------|
|Entity                           |character | Country or Region Name |
|Code                             |character | Country Code (note is NA for regions/continents) |
|Year                             |double    | Year |
|Tractors per 100 sq km arable land                    |double    | Number of tractors per 100 sq km of arable land |
|Cereal yield (kilograms per hectare) (kg per hectare) |double    | Cereal yield in kg per hectare |
|Total population (Gapminder)                          |double    | Total population from gapminder |

### Cleaning Script

No real cleaning script today, but here's an example of how to pivot the data wider to longer.

```{r}
library(tidyverse)

key_crops <- read_csv("2020/2020-09-01/key_crop_yields.csv")

long_crops <- key_crops %>% 
  pivot_longer(cols = 4:last_col(),
               names_to = "crop", 
               values_to = "crop_production") %>% 
  mutate(crop = str_remove_all(crop, " \\(tonnes per hectare\\)")) %>% 
  set_names(nm = names(.) %>% tolower())


long_crops
```
